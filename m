Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbSLRWGh>; Wed, 18 Dec 2002 17:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbSLRWGh>; Wed, 18 Dec 2002 17:06:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56985 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267361AbSLRWGN>;
	Wed, 18 Dec 2002 17:06:13 -0500
Subject: [PATCH] (1/5) improved notifier callback mechanism - C99
	initializers
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1040249644.14358.186.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 14:14:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here a step in improving the notifier callback to be cleaner and safer.
Every time anyone submits a patch which adds a notifier, there is a
chorus of comments about the lack of locking.  Some developers choose to
build their own interface instead of fixing the underlying base
mechanism, others just wrap the unsafe interface with their own
mutex's.  Instead, this sequence of patches attempts to solve the
underlying problem.

This patch switches all the places that use notifier_block to use C99
style initializers and not initialize structure elements that are really
"private". There is no change in resulting functionality with this
patch, it just makes later changes cleaner.

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Mon Dec 16 11:48:16 2002
+++ b/drivers/input/serio/i8042.c	Mon Dec 16 11:48:16 2002
@@ -785,19 +785,16 @@
  * because otherwise BIOSes will be confused.
  */
 
-static int i8042_notify_sys(struct notifier_block *this, unsigned long
code,
-        		    void *unused)
+static int i8042_notify_sys(struct notifier_block *this, 
+			    unsigned long code, void *unused)
 {
         if (code==SYS_DOWN || code==SYS_HALT) 
         	i8042_controller_cleanup();
         return NOTIFY_DONE;
 }
 
-static struct notifier_block i8042_notifier=
-{
-        i8042_notify_sys,
-        NULL,
-        0
+static struct notifier_block i8042_notifier = {
+	.notifier_call = i8042_notify_sys,
 };
 
 static void __init i8042_init_mux_values(struct i8042_values *values,
struct serio *port, int index)
diff -Nru a/drivers/scsi/aic7xxx/aic7xxx_linux.c
b/drivers/scsi/aic7xxx/aic7xxx_linux.c
--- a/drivers/scsi/aic7xxx/aic7xxx_linux.c	Mon Dec 16 11:48:16 2002
+++ b/drivers/scsi/aic7xxx/aic7xxx_linux.c	Mon Dec 16 11:48:16 2002
@@ -664,7 +664,7 @@
 #include <linux/reboot.h>
 
 static struct notifier_block ahc_linux_notifier = {
-	ahc_linux_halt, NULL, 0
+	.notifier_call = ahc_linux_halt,
 };
 
 static int ahc_linux_halt(struct notifier_block *nb, u_long event, void
*buf)
diff -Nru a/drivers/scsi/ips.c b/drivers/scsi/ips.c
--- a/drivers/scsi/ips.c	Mon Dec 16 11:48:16 2002
+++ b/drivers/scsi/ips.c	Mon Dec 16 11:48:16 2002
@@ -364,7 +364,7 @@
 };
 
 static struct notifier_block ips_notifier = {
-   ips_halt, NULL, 0
+        .notifier_call = ips_halt, 
 };
 
 /*
diff -Nru a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
--- a/drivers/scsi/megaraid.c	Mon Dec 16 11:48:16 2002
+++ b/drivers/scsi/megaraid.c	Mon Dec 16 11:48:16 2002
@@ -747,9 +747,7 @@
 
 static mega_scb *pLastScb = NULL;
 static struct notifier_block mega_notifier = {
-	megaraid_reboot_notify,
-	NULL,
-	0
+	.notifier_call = megaraid_reboot_notify,
 };
 
 /* For controller re-ordering */
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Mon Dec 16 11:48:16 2002
+++ b/kernel/sched.c	Mon Dec 16 11:48:16 2002
@@ -2159,7 +2159,9 @@
 	return NOTIFY_OK;
 }
 
-static struct notifier_block migration_notifier = { &migration_call,
NULL, 0 };
+static struct notifier_block migration_notifier = { 
+	.notifier_call = &migration_call,
+};
 
 __init int migration_init(void)
 {
@@ -2208,7 +2210,6 @@
  
 static struct notifier_block __devinitdata kstat_nb = {
 	.notifier_call  = kstat_cpu_notify,
-	.next           = NULL,
 };
 
 __init static void init_kstat(void) {
diff -Nru a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	Mon Dec 16 11:48:16 2002
+++ b/mm/slab.c	Mon Dec 16 11:48:16 2002
@@ -577,7 +577,9 @@
 	return NOTIFY_BAD;
 }
 
-static struct notifier_block cpucache_notifier = { &cpuup_callback,
NULL, 0 };
+static struct notifier_block cpucache_notifier = { 
+	.notifier_call = cpuup_callback,
+};
 
 static inline void ** ac_entry(struct array_cache *ac)
 {
diff -Nru a/net/core/dst.c b/net/core/dst.c
--- a/net/core/dst.c	Mon Dec 16 11:48:16 2002
+++ b/net/core/dst.c	Mon Dec 16 11:48:16 2002
@@ -252,9 +252,7 @@
 }
 
 struct notifier_block dst_dev_notifier = {
-	dst_dev_event,
-	NULL,
-	0
+	.notifier_call = dst_dev_event,
 };
 
 void __init dst_init(void)
diff -Nru a/net/core/rtnetlink.c b/net/core/rtnetlink.c
--- a/net/core/rtnetlink.c	Mon Dec 16 11:48:16 2002
+++ b/net/core/rtnetlink.c	Mon Dec 16 11:48:16 2002
@@ -509,9 +509,7 @@
 }
 
 struct notifier_block rtnetlink_dev_notifier = {
-	rtnetlink_event,
-	NULL,
-	0
+	.notifier_call  = rtnetlink_event,
 };
 
 
diff -Nru a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
--- a/net/ipv4/ipmr.c	Mon Dec 16 11:48:16 2002
+++ b/net/ipv4/ipmr.c	Mon Dec 16 11:48:16 2002
@@ -1072,9 +1072,7 @@
 
 
 static struct notifier_block ip_mr_notifier={
-	ipmr_device_event,
-	NULL,
-	0
+	.notifier_call = ipmr_device_event,
 };
 
 /*
diff -Nru a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
--- a/net/ipv6/ipv6_sockglue.c	Mon Dec 16 16:06:25 2002
+++ b/net/ipv6/ipv6_sockglue.c	Mon Dec 16 16:06:25 2002
@@ -66,9 +66,7 @@
  *	addrconf module should be notifyed of a device going up
  */
 static struct notifier_block ipv6_dev_notf = {
-	addrconf_notify,
-	NULL,
-	0
+	.notifier_call = addrconf_notify,
 };
 
 struct ip6_ra_chain *ip6_ra_chain;
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Wed Dec 18 09:03:09 2002
+++ b/drivers/md/md.c	Wed Dec 18 09:03:09 2002
@@ -3072,7 +3072,6 @@
 
 struct notifier_block md_notifier = {
 	.notifier_call	= md_notify_reboot,
-	.next		= NULL,
 	.priority	= INT_MAX, /* before any real devices */
 };
 
diff -Nru a/drivers/net/e100/e100_main.c b/drivers/net/e100/e100_main.c
--- a/drivers/net/e100/e100_main.c	Wed Dec 18 09:03:09 2002
+++ b/drivers/net/e100/e100_main.c	Wed Dec 18 09:03:09 2002
@@ -146,7 +146,6 @@
 static int e100_resume(struct pci_dev *pcid);
 struct notifier_block e100_notifier_reboot = {
         .notifier_call  = e100_notify_reboot,
-        .next           = NULL,
         .priority       = 0
 };
 #endif
@@ -154,7 +153,6 @@
  
 struct notifier_block e100_notifier_netdev = {
 	.notifier_call  = e100_notify_netdev,
-	.next           = NULL,
 	.priority       = 0
 };
 
diff -Nru a/drivers/net/e1000/e1000_main.c
b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	Wed Dec 18 09:03:09 2002
+++ b/drivers/net/e1000/e1000_main.c	Wed Dec 18 09:03:09 2002
@@ -185,13 +185,11 @@
 
 struct notifier_block e1000_notifier_reboot = {
 	.notifier_call	= e1000_notify_reboot,
-	.next		= NULL,
 	.priority	= 0
 };
 
 struct notifier_block e1000_notifier_netdev = {
 	.notifier_call	= e1000_notify_netdev,
-	.next		= NULL,
 	.priority	= 0
 };
 
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Wed Dec 18 09:03:09 2002
+++ b/drivers/scsi/sd.c	Wed Dec 18 09:03:09 2002
@@ -97,7 +97,9 @@
 static int sd_synchronize_cache(struct scsi_disk *, int);
 static int sd_notifier(struct notifier_block *, unsigned long, void *);
 
-static struct notifier_block sd_notifier_block = {sd_notifier, NULL,
0}; 
+static struct notifier_block sd_notifier_block = {
+	.notifier_call = sd_notifier,
+};	
 
 static struct Scsi_Device_Template sd_template = {
 	.module		= THIS_MODULE,
diff -Nru a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	Wed Dec 18 09:03:09 2002
+++ b/kernel/softirq.c	Wed Dec 18 09:03:09 2002
@@ -284,7 +284,6 @@
 
 static struct notifier_block tasklet_nb = {
 	.notifier_call	= tasklet_cpu_notify,
-	.next		= NULL,
 };
 
 void __init softirq_init()
diff -Nru a/mm/page-writeback.c b/mm/page-writeback.c
--- a/mm/page-writeback.c	Wed Dec 18 09:03:09 2002
+++ b/mm/page-writeback.c	Wed Dec 18 09:03:09 2002
@@ -356,7 +356,6 @@
 
 static struct notifier_block ratelimit_nb = {
 	.notifier_call	= ratelimit_handler,
-	.next		= NULL,
 };
 
 /*



