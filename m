Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266914AbSIRPDo>; Wed, 18 Sep 2002 11:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266950AbSIRPDo>; Wed, 18 Sep 2002 11:03:44 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:50135 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S266914AbSIRPDm>;
	Wed, 18 Sep 2002 11:03:42 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 18 Sep 2002 09:06:46 -0600
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [BK PATCH] Fix APM on Sony Vaio Laptops for 2.5
Message-ID: <20020918090646.F14918@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 2.5 version of the patch I sent earlier for 2.4.

Message that went with the 2.4 version and applies to this one as well:

This patch fixes a problem with Sony Vaio laptops where they don't notify
the kernel of power source change events.  That means apmd is never told
and many of the apmd features can't be used.

The Sony Vaio doesn't send APM events to the kernel telling it
about 'going on battery' or 'going on AC power' events.  It will register
them correctly if they're queried but it won't asynchronously send an event
so the kernel never tells apmd about it.

This patch fixes the situation by checking against the last known power
state (and power source) in the check_status() call.

This was tested on a Sony Vaio z505js, model PCG-5201 and it works
beautifully.  I'm told other Vaio notebooks have this same problem and this
fixes it as well.  Now, Vaio users can setup apmd to aggressively try to
save power when on battery or perform other crazy tasks.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.566, 2002-09-18 08:25:05-06:00, cort@host110.fsmlabs.com
  Work around the Sony Vaio APM on-AC/on-battery problem.
    
  Sony Vaios won't send asynchronous notifies to the kernel
  of on-battery/on-AC events so we have to track the last known
  power source and send events when it changes.
    
  apmd now functions properly on the Vaio.


 apm.c      |   28 ++++++++++++++++++++++++++++
 dmi_scan.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)


diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	Wed Sep 18 08:26:06 2002
+++ b/arch/i386/kernel/apm.c	Wed Sep 18 08:26:06 2002
@@ -227,6 +227,7 @@
 extern spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
+extern int apm_bios_power_change_bug;
 
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 extern int (*console_blank_hook)(int);
@@ -1361,6 +1362,33 @@
 			 */
 			(void) suspend(0);
 			break;
+		}
+	}
+
+
+	/*
+	 * The Sony Vaio doesn't seem to want to send us a notify
+	 * about AC line power status changes.  So, we have to keep track
+	 * of it by hand and emulate it here.
+	 *   -- Cort <cort@fsmlabs.com>
+	 */
+	if ( apm_bios_power_change_bug ) {
+		static int last_status = 0;
+		u_short status, bat, life;
+
+		/* get the current power state */
+		if ( apm_get_power_status(&status, &bat, &life) !=
+		     APM_SUCCESS ) {
+			printk("%s:%s error checking power status\n",
+			       __FILE__,__FUNCTION__);
+		}
+		
+		/* has the status changed since we were last here? */
+		if (((status >> 8) & 0xff) != last_status) {
+			last_status = (status >> 8) & 0xff;
+			
+			/* fake a APM_POWER_STATUS_CHANGE event */
+			queue_event(APM_POWER_STATUS_CHANGE, NULL);
 		}
 	}
 }
diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	Wed Sep 18 08:26:06 2002
+++ b/arch/i386/kernel/dmi_scan.c	Wed Sep 18 08:26:06 2002
@@ -12,6 +12,7 @@
 
 unsigned long dmi_broken;
 int is_sony_vaio_laptop;
+int apm_bios_power_change_bug;
 int is_unsafe_smbus;
 
 struct dmi_header
@@ -344,6 +345,24 @@
 }
 
 /*
+ * Some Vaio laptops don't notify the kernel of a power status change
+ * such as on-AC/on-battery.  This detects some of the faulty machines
+ * and sets a variable that lets arch/i386/kernel/apm.c deal with it.
+ *
+ * I've seen this with the Vaio z505js PCG-5201 and PCG-SR33:
+ * model PCG-Z505JS(UC), bios Phoenix Technologies LTD version R0121Z1
+ * model PCG-SR33(UC), bios Phoenix Technologies LTD version R0211D1
+ *   -- Cort <cort@fsmlabs.com>
+ */ 
+static __init int sony_vaio_apm_change(struct dmi_blacklist *d)
+{
+	apm_bios_power_change_bug = 1;
+	printk(KERN_WARNING "%s detected: APM power status change workaround enabled\n",
+	       d->ident);
+	return 0;
+}
+
+/*
  * The Intel 440GX hall of shame. 
  *
  * On many (all we have checked) of these boxes the $PIRQ table is wrong.
@@ -755,6 +774,15 @@
 			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
 
+	/*
+	 *	Sony Vaio Asynchronous powerstate notify emulation
+	 */
+	
+	{ sony_vaio_apm_change, "Sony Vaio", {	/* APM won't send power change events */
+			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			NO_MATCH, NO_MATCH
+ 			} },
 	{ NULL, }
 };
 	

===================================================================


This BitKeeper patch contains the following changesets:
1.566
## Wrapped with gzip_uu ##


begin 664 bkpatch31594
`
end
