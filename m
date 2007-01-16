Return-Path: <linux-kernel-owner+w=401wt.eu-S1751872AbXAPQy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbXAPQy3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbXAPQtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:49:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45993 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbXAPQtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:49:24 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 11:49:23 EST
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       <netdev@vger.kernel.org>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       minyard@acm.org, openipmi-developer@lists.sourceforge.net,
       <tony.luck@intel.com>, linux-mips@linux-mips.org, ralf@linux-mips.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com,
       linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
       lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
       <ak@suse.de>, vojtech@suse.cz, clemens@ladisch.de, a.zummo@towertech.it,
       rtc-linux@googlegroups.com, linux-parport@lists.infradead.org,
       andrea@suse.de, tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
       coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 45/59] sysctl: C99 convert ctl_tables in drivers/parport/procfs.c
Date: Tue, 16 Jan 2007 09:39:50 -0700
Message-Id: <11689656733768-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/parport/procfs.c |  264 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 189 insertions(+), 75 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 2e744a2..5337789 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -233,12 +233,12 @@ static int do_hardware_modes (ctl_table *table, int write,
 	return copy_to_user(result, buffer, len) ? -EFAULT : 0;
 }
 
-#define PARPORT_PORT_DIR(child) { 0, NULL, NULL, 0, 0555, child }
-#define PARPORT_PARPORT_DIR(child) { DEV_PARPORT, "parport", \
-                                     NULL, 0, 0555, child }
-#define PARPORT_DEV_DIR(child) { CTL_DEV, "dev", NULL, 0, 0555, child }
-#define PARPORT_DEVICES_ROOT_DIR  { DEV_PARPORT_DEVICES, "devices", \
-                                    NULL, 0, 0555, NULL }
+#define PARPORT_PORT_DIR(CHILD) { .ctl_name = 0, .procname = NULL, .mode = 0555, .child = CHILD }
+#define PARPORT_PARPORT_DIR(CHILD) { .ctl_name = DEV_PARPORT, .procname = "parport", \
+                                     .mode = 0555, .child = CHILD }
+#define PARPORT_DEV_DIR(CHILD) { .ctl_name = CTL_DEV, .procname = "dev", .mode = 0555, .child = CHILD }
+#define PARPORT_DEVICES_ROOT_DIR  { .ctl_name = DEV_PARPORT_DEVICES, .procname = "devices", \
+                                    .mode = 0555, .child = NULL }
 
 static const unsigned long parport_min_timeslice_value =
 PARPORT_MIN_TIMESLICE_VALUE;
@@ -263,50 +263,118 @@ struct parport_sysctl_table {
 };
 
 static const struct parport_sysctl_table parport_sysctl_template = {
-	NULL,
+	.sysctl_header = NULL,
         {
-		{ DEV_PARPORT_SPINTIME, "spintime",
-		  NULL, sizeof(int), 0644, NULL,
-		  &proc_dointvec_minmax, NULL, NULL,
-		  (void*) &parport_min_spintime_value,
-		  (void*) &parport_max_spintime_value },
-		{ DEV_PARPORT_BASE_ADDR, "base-addr",
-		  NULL, 0, 0444, NULL,
-		  &do_hardware_base_addr },
-		{ DEV_PARPORT_IRQ, "irq",
-		  NULL, 0, 0444, NULL,
-		  &do_hardware_irq },
-		{ DEV_PARPORT_DMA, "dma",
-		  NULL, 0, 0444, NULL,
-		  &do_hardware_dma },
-		{ DEV_PARPORT_MODES, "modes",
-		  NULL, 0, 0444, NULL,
-		  &do_hardware_modes },
+		{
+			.ctl_name	= DEV_PARPORT_SPINTIME,
+			.procname	= "spintime",
+			.data		= NULL,
+			.maxlen		= sizeof(int),
+			.mode		= 0644,
+			.proc_handler	= &proc_dointvec_minmax,
+			.extra1		= (void*) &parport_min_spintime_value,
+			.extra2		= (void*) &parport_max_spintime_value
+		},
+		{
+			.ctl_name	= DEV_PARPORT_BASE_ADDR,
+			.procname	= "base-addr",
+			.data		= NULL,
+			.maxlen		= 0,
+			.mode		= 0444,
+			.proc_handler	= &do_hardware_base_addr
+		},
+		{
+			.ctl_name	= DEV_PARPORT_IRQ,
+			.procname	= "irq",
+			.data		= NULL,
+			.maxlen		= 0,
+			.mode		= 0444,
+			.proc_handler	= &do_hardware_irq
+		},
+		{
+			.ctl_name	= DEV_PARPORT_DMA,
+			.procname	= "dma",
+			.data		= NULL,
+			.maxlen		= 0,
+			.mode		= 0444,
+			.proc_handler	= &do_hardware_dma
+		},
+		{
+			.ctl_name	= DEV_PARPORT_MODES,
+			.procname	= "modes",
+			.data		= NULL,
+			.maxlen		= 0,
+			.mode		= 0444,
+			.proc_handler	= &do_hardware_modes
+		},
 		PARPORT_DEVICES_ROOT_DIR,
 #ifdef CONFIG_PARPORT_1284
-		{ DEV_PARPORT_AUTOPROBE, "autoprobe",
-		  NULL, 0, 0444, NULL,
-		  &do_autoprobe },
-		{ DEV_PARPORT_AUTOPROBE + 1, "autoprobe0",
-		 NULL, 0, 0444, NULL,
-		 &do_autoprobe },
-		{ DEV_PARPORT_AUTOPROBE + 2, "autoprobe1",
-		  NULL, 0, 0444, NULL,
-		  &do_autoprobe },
-		{ DEV_PARPORT_AUTOPROBE + 3, "autoprobe2",
-		  NULL, 0, 0444, NULL,
-		  &do_autoprobe },
-		{ DEV_PARPORT_AUTOPROBE + 4, "autoprobe3",
-		  NULL, 0, 0444, NULL,
-		  &do_autoprobe },
+		{
+			.ctl_name	= DEV_PARPORT_AUTOPROBE,
+			.procname	= "autoprobe",
+			.data		= NULL,
+			.maxlen		= 0,
+			.mode		= 0444,
+			.proc_handler	= &do_autoprobe
+		},
+		{
+			.ctl_name	= DEV_PARPORT_AUTOPROBE + 1,
+			.procname	= "autoprobe0",
+			.data		= NULL,
+			.maxlen		= 0,
+			.maxlen		= 0444,
+			.proc_handler	=  &do_autoprobe
+		},
+		{
+			.ctl_name	= DEV_PARPORT_AUTOPROBE + 2,
+			.procname	= "autoprobe1",
+			.data		= NULL,
+			.maxlen		= 0,
+			.mode		= 0444,
+			.proc_handler	= &do_autoprobe
+		},
+		{
+			.ctl_name	= DEV_PARPORT_AUTOPROBE + 3,
+			.procname	= "autoprobe2",
+			.data		= NULL,
+			.maxlen		= 0,
+			.mode		= 0444,
+			.proc_handler	= &do_autoprobe
+		},
+		{
+			.ctl_name	= DEV_PARPORT_AUTOPROBE + 4,
+			.procname	= "autoprobe3",
+			.data		= NULL,
+			.maxlen		= 0,
+			.mode		= 0444,
+			.proc_handler	= &do_autoprobe
+		},
 #endif /* IEEE 1284 support */
-		{0}
+		{}
 	},
-	{ {DEV_PARPORT_DEVICES_ACTIVE, "active", NULL, 0, 0444, NULL,
-	  &do_active_device }, {0}},
-	{ PARPORT_PORT_DIR(NULL), {0}},
-	{ PARPORT_PARPORT_DIR(NULL), {0}},
-	{ PARPORT_DEV_DIR(NULL), {0}}
+	{
+		{
+			.ctl_name	= DEV_PARPORT_DEVICES_ACTIVE,
+			.procname	= "active",
+			.data		= NULL,
+			.maxlen		= 0,
+			.mode		= 0444,
+			.proc_handler	= &do_active_device
+		},
+		{}
+	},
+	{
+		PARPORT_PORT_DIR(NULL),
+		{}
+	},
+	{
+		PARPORT_PARPORT_DIR(NULL),
+		{}
+	},
+	{
+		PARPORT_DEV_DIR(NULL),
+		{}
+	}
 };
 
 struct parport_device_sysctl_table
@@ -322,19 +390,46 @@ struct parport_device_sysctl_table
 
 static const struct parport_device_sysctl_table
 parport_device_sysctl_template = {
-	NULL,
+	.sysctl_header = NULL,
+	{
+		{
+			.ctl_name 	= DEV_PARPORT_DEVICE_TIMESLICE,
+			.procname 	= "timeslice",
+			.data		= NULL,
+			.maxlen		= sizeof(int),
+			.mode		= 0644,
+			.proc_handler	= &proc_doulongvec_ms_jiffies_minmax,
+			.extra1		= (void*) &parport_min_timeslice_value,
+			.extra2		= (void*) &parport_max_timeslice_value
+		},
+	},
+	{
+		{
+			.ctl_name	= 0,
+			.procname	= NULL,
+			.data		= NULL,
+			.maxlen		= 0,
+			.mode		= 0555,
+			.child		= NULL
+		},
+		{}
+	},
 	{
-		{ DEV_PARPORT_DEVICE_TIMESLICE, "timeslice",
-		  NULL, sizeof(int), 0644, NULL,
-		  &proc_doulongvec_ms_jiffies_minmax, NULL, NULL,
-		  (void*) &parport_min_timeslice_value,
-		  (void*) &parport_max_timeslice_value },
+		PARPORT_DEVICES_ROOT_DIR,
+		{}
+	},
+	{
+		PARPORT_PORT_DIR(NULL),
+		{}
 	},
-	{ {0, NULL, NULL, 0, 0555, NULL}, {0}},
-	{ PARPORT_DEVICES_ROOT_DIR, {0}},
-	{ PARPORT_PORT_DIR(NULL), {0}},
-	{ PARPORT_PARPORT_DIR(NULL), {0}},
-	{ PARPORT_DEV_DIR(NULL), {0}}
+	{
+		PARPORT_PARPORT_DIR(NULL),
+		{}
+	},
+	{
+		PARPORT_DEV_DIR(NULL),
+		{}
+	}
 };
 
 struct parport_default_sysctl_table
@@ -351,28 +446,47 @@ extern int parport_default_spintime;
 
 static struct parport_default_sysctl_table
 parport_default_sysctl_table = {
-	NULL,
+	.sysctl_header	= NULL,
+	{
+		{
+			.ctl_name	= DEV_PARPORT_DEFAULT_TIMESLICE,
+			.procname	= "timeslice",
+			.data		= &parport_default_timeslice,
+			.maxlen		= sizeof(parport_default_timeslice),
+			.mode		= 0644,
+			.proc_handler	= &proc_doulongvec_ms_jiffies_minmax,
+			.extra1		= (void*) &parport_min_timeslice_value,
+			.extra2		= (void*) &parport_max_timeslice_value
+		},
+		{
+			.ctl_name	= DEV_PARPORT_DEFAULT_SPINTIME,
+			.procname	= "spintime",
+			.data		= &parport_default_spintime,
+			.maxlen		= sizeof(parport_default_spintime),
+			.mode		= 0644,
+			.proc_handler	= &proc_dointvec_minmax,
+			.extra1		= (void*) &parport_min_spintime_value,
+			.extra2		= (void*) &parport_max_spintime_value
+		},
+		{}
+	},
 	{
-		{ DEV_PARPORT_DEFAULT_TIMESLICE, "timeslice",
-		  &parport_default_timeslice,
-		  sizeof(parport_default_timeslice), 0644, NULL,
-		  &proc_doulongvec_ms_jiffies_minmax, NULL, NULL,
-		  (void*) &parport_min_timeslice_value,
-		  (void*) &parport_max_timeslice_value },
-		{ DEV_PARPORT_DEFAULT_SPINTIME, "spintime",
-		  &parport_default_spintime,
-		  sizeof(parport_default_spintime), 0644, NULL,
-		  &proc_dointvec_minmax, NULL, NULL,
-		  (void*) &parport_min_spintime_value,
-		  (void*) &parport_max_spintime_value },
-		{0}
+		{
+			.ctl_name	= DEV_PARPORT_DEFAULT,
+			.procname	= "default",
+			.mode		= 0555,
+			.child		= parport_default_sysctl_table.vars
+		},
+		{}
 	},
-	{ { DEV_PARPORT_DEFAULT, "default", NULL, 0, 0555,
-	    parport_default_sysctl_table.vars },{0}},
 	{
-	PARPORT_PARPORT_DIR(parport_default_sysctl_table.default_dir), 
-	{0}},
-	{ PARPORT_DEV_DIR(parport_default_sysctl_table.parport_dir), {0}}
+		PARPORT_PARPORT_DIR(parport_default_sysctl_table.default_dir), 
+		{}
+	},
+	{
+		PARPORT_DEV_DIR(parport_default_sysctl_table.parport_dir), 
+		{}
+	}
 };
 
 
-- 
1.4.4.1.g278f

