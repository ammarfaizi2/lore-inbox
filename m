Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbULAXOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbULAXOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbULAXOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:14:35 -0500
Received: from fmr05.intel.com ([134.134.136.6]:18833 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261486AbULAXOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:14:07 -0500
Subject: Re: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20041112174248.GA4267@openzaurus.ucw.cz>
References: <1099986428.6090.53.camel@d845pe>
	 <20041112174248.GA4267@openzaurus.ucw.cz>
Content-Type: multipart/mixed; boundary="=-cvFD6uMtkNPTT4xr4IjX"
Organization: 
Message-Id: <1101942828.8028.371.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Dec 2004 18:13:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cvFD6uMtkNPTT4xr4IjX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-11-12 at 12:42, Pavel Machek wrote:

> > <len.brown@intel.com> (04/11/05 1.1803.163.1)
> >    [ACPI] Allow limiting idle C-States.
> >   
> >    Useful to workaround C3 ipw2100 packet loss,
> >    reducing noise or boot issues on some models.
> >    http://bugme.osdl.org/show_bug.cgi?id=3549
> >   
> >    For static processor driver, boot cmdline:
> >    processor.acpi_cstate_limit=2
> 
> You certainly win "ugliest parameter of the month" contest :-).
> 
> What about processor.max_cstate= or something?

I agree, this is better.

> > <len.brown@intel.com> (04/10/18 1.1803.119.24)
> >    [ACPI] add module parameters: processor.c2=[0,1]
> processor.c3=[0,1]
> >    to disable/enable C2 or C3
> >    blacklist entries for R40e and Medion 41700
> 
> So we have two independend ways to disable C states?

With the addition of the dynamic method, the
static method can go away.  patch attached.

-Len


--=-cvFD6uMtkNPTT4xr4IjX
Content-Disposition: attachment; filename=max_cstate.patch
Content-Type: text/plain; name=max_cstate.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== Documentation/kernel-parameters.txt 1.51 vs edited =====
--- 1.51/Documentation/kernel-parameters.txt	2004-11-10 15:50:17 -05:00
+++ edited/Documentation/kernel-parameters.txt	2004-12-01 18:11:18 -05:00
@@ -960,10 +960,9 @@
 			(param: profile step/bucket size as a power of 2 for
 				statistical time based profiling)
 
-	processor.c2=	[HW, ACPI]
-	processor.c3=	[HW, ACPI]
-			0 - disable C2 or C3 idle power saving state.
-			1 - enable C2 or C3 (default unless DMI blacklist entry)
+	processor.max_cstate=   [HW, ACPI]
+			Limit processor to maximum C-state
+			max_cstate=9 overrides any DMI blacklist limit.
 
 	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
 			before loading.
===== drivers/acpi/osl.c 1.59 vs edited =====
--- 1.59/drivers/acpi/osl.c	2004-11-12 00:25:31 -05:00
+++ edited/drivers/acpi/osl.c	2004-12-01 14:36:24 -05:00
@@ -1152,10 +1152,10 @@
 __setup("acpi_wake_gpes_always_on", acpi_wake_gpes_always_on_setup);
 
 /*
- * acpi_cstate_limit is defined in the base kernel so modules can
+ * max_cstate is defined in the base kernel so modules can
  * change it w/o depending on the state of the processor module.
  */
-unsigned int acpi_cstate_limit = ACPI_C_STATES_MAX;
+unsigned int max_cstate = ACPI_C_STATES_MAX;
 
 
-EXPORT_SYMBOL(acpi_cstate_limit);
+EXPORT_SYMBOL(max_cstate);
===== drivers/acpi/processor.c 1.63 vs edited =====
--- 1.63/drivers/acpi/processor.c	2004-11-10 15:40:29 -05:00
+++ edited/drivers/acpi/processor.c	2004-12-01 18:06:51 -05:00
@@ -101,8 +101,6 @@
 			},
 };
 
-static int c2 = -1;
-static int c3 = -1;
 
 struct acpi_processor_errata {
 	u8			smp;
@@ -144,8 +142,6 @@
 
 static struct acpi_processor	*processors[NR_CPUS];
 static struct acpi_processor_errata errata;
-module_param_named(c2, c2, bool, 0);
-module_param_named(c3, c3, bool, 0);
 static void (*pm_idle_save)(void);
 
 
@@ -338,8 +334,8 @@
 {
 	struct acpi_processor	*pr = NULL;
 	struct acpi_processor_cx *cx = NULL;
-	int			next_state = 0;
-	int			sleep_ticks = 0;
+	unsigned int			next_state = 0;
+	unsigned int		sleep_ticks = 0;
 	u32			t1, t2 = 0;
 
 	pr = processors[smp_processor_id()];
@@ -475,9 +471,9 @@
 	 * Track the number of longs (time asleep is greater than threshold)
 	 * and promote when the count threshold is reached.  Note that bus
 	 * mastering activity may prevent promotions.
-	 * Do not promote above acpi_cstate_limit.
+	 * Do not promote above max_cstate.
 	 */
-	if (cx->promotion.state && (cx->promotion.state <= acpi_cstate_limit)) {
+	if (cx->promotion.state && (cx->promotion.state <= max_cstate)) {
 		if (sleep_ticks > cx->promotion.threshold.ticks) {
 			cx->promotion.count++;
  			cx->demotion.count = 0;
@@ -515,10 +511,10 @@
 
 end:
 	/*
-	 * Demote if current state exceeds acpi_cstate_limit
+	 * Demote if current state exceeds max_cstate
 	 */
-	if (pr->power.state > acpi_cstate_limit) {
-		next_state = acpi_cstate_limit;
+	if (pr->power.state > max_cstate) {
+		next_state = max_cstate;
 	}
 
 	/*
@@ -672,11 +668,6 @@
 		else if (errata.smp)
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				"C2 not supported in SMP mode\n"));
-
-
-		else if (!c2) 
-			printk(KERN_INFO "C2 disabled\n");
-
 		/*
 		 * Otherwise we've met all of our C2 requirements.
 		 * Normalize the C2 latency to expidite policy.
@@ -732,9 +723,6 @@
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				"C3 not supported on PIIX4 with Type-F DMA\n"));
 		}
-		else if (!c3)
-			printk(KERN_INFO "C3 disabled\n");
-
 		/*
 		 * Otherwise we've met all of our C3 requirements.  
 		 * Normalize the C2 latency to expidite policy.  Enable
@@ -995,7 +983,7 @@
 	struct acpi_buffer	format = {sizeof("NNNNNN"), "NNNNNN"};
 	struct acpi_buffer	state = {0, NULL};
 	union acpi_object 	*pss = NULL;
-	int			i = 0;
+	unsigned int		i;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_states");
 
@@ -1117,7 +1105,7 @@
 static int acpi_processor_perf_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_processor	*pr = (struct acpi_processor *)seq->private;
-	int			i = 0;
+	unsigned int		i;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_perf_seq_show");
 
@@ -1880,7 +1868,7 @@
 static int acpi_processor_power_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_processor	*pr = (struct acpi_processor *)seq->private;
-	int			i = 0;
+	unsigned int		i;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_power_seq_show");
 
@@ -1889,9 +1877,11 @@
 
 	seq_printf(seq, "active state:            C%d\n"
 			"default state:           C%d\n"
+			"max_cstate:              C%d\n"
 			"bus master activity:     %08x\n",
 			pr->power.state,
 			pr->power.default_state,
+			max_cstate,
 			pr->power.bm_activity);
 
 	seq_puts(seq, "states:\n");
@@ -2478,17 +2468,22 @@
 	return_VALUE(0);
 }
 
-/* IBM ThinkPad R40e crashes mysteriously when going into C2 or C3. 
-   For now disable this. Probably a bug somewhere else. */
+/*
+ * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3. 
+ * For now disable this. Probably a bug somewhere else.
+ *
+ * To skip this limit, boot/load with a large max_cstate limit.
+ */
 static int no_c2c3(struct dmi_system_id *id)
 {
-	printk(KERN_INFO 
-	       "%s detected - C2,C3 disabled. Overwrite with \"processor.c2=1 processor.c3=1\n\"",
-	       id->ident);
-	if (c2 == -1) 
-		c2 = 0;
-	if (c3 == -1) 
-		c3 = 0; 
+	if (max_cstate > ACPI_C_STATES_MAX)
+		return 0;
+
+	printk(KERN_NOTICE PREFIX "%s detected - C2,C3 disabled."
+		" Override with \"processor.max_cstate=9\"\n", id->ident);
+
+	max_cstate = 1;
+
 	return 0;
 }
 
@@ -2533,6 +2528,9 @@
 
 	dmi_check_system(processor_dmi_table); 
 
+	if (max_cstate < ACPI_C_STATES_MAX)
+		printk(KERN_NOTICE "ACPI: processor limited to max C-state %d\n", max_cstate);
+
 	return_VALUE(0);
 }
 
@@ -2556,6 +2554,6 @@
 
 module_init(acpi_processor_init);
 module_exit(acpi_processor_exit);
-module_param_named(acpi_cstate_limit, acpi_cstate_limit, uint, 0);
+module_param_named(max_cstate, max_cstate, uint, 0);
 
 EXPORT_SYMBOL(acpi_processor_set_thermal_limit);
===== include/acpi/processor.h 1.8 vs edited =====
--- 1.8/include/acpi/processor.h	2004-01-29 04:57:52 -05:00
+++ edited/include/acpi/processor.h	2004-12-01 17:45:39 -05:00
@@ -17,7 +17,7 @@
 
 struct acpi_processor_cx_policy {
 	u32			count;
-	int			state;
+	u32			state;
 	struct {
 		u32			time;
 		u32			ticks;
@@ -38,8 +38,8 @@
 };
 
 struct acpi_processor_power {
-	int			state;
-	int			default_state;
+	u32			state;
+	u32			default_state;
 	u32			bm_activity;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 };
===== include/linux/acpi.h 1.39 vs edited =====
--- 1.39/include/linux/acpi.h	2004-11-05 21:42:25 -05:00
+++ edited/include/linux/acpi.h	2004-12-01 14:36:25 -05:00
@@ -483,15 +483,15 @@
  * 2: C2 okay, but not C3 etc.
  */
 
-extern unsigned int acpi_cstate_limit;
+extern unsigned int max_cstate;
 
 static inline unsigned int acpi_get_cstate_limit(void)
 {
-	return acpi_cstate_limit;
+	return max_cstate;
 }
 static inline void acpi_set_cstate_limit(unsigned int new_limit)
 {
-	acpi_cstate_limit = new_limit;
+	max_cstate = new_limit;
 	return;
 }
 #else

--=-cvFD6uMtkNPTT4xr4IjX--

