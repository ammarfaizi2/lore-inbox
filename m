Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVILJfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVILJfT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVILJfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:35:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47312 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751262AbVILJfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:35:17 -0400
Date: Mon, 12 Sep 2005 11:34:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Cc: vojtech@suse.cz, dwmw2@infradead.org, netdev@vger.kernel.org,
       benjamin_kong@ali.com.tw, dagb@cs.uit.no, jgarzik@pobox.com,
       davidm@snapgear.com, twoller@crystal.cirrus.com, alan@redhat.com,
       mm@caldera.de, scott@spiteful.org, jsimmons@transvirtual.com
Subject: pm_register should die
Message-ID: <20050912093456.GA29205@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

pm_register has been obsoleted by driver model, and it was deprecated
quite long time ago. There are only 13 users left.

Attached is a patch that makes pm_register config-option, so that we
don't get the warnings on sane systems. Pretty please, remove usage of
pm_register from your subsystem.

IRDA has no usefull MAINTAINER entry; it would be nice if that could
be fixed. Alan is best contact I could find for ad1848... does someone
care about that driver, anyway? nm256_audio is written by
anonymous. Wonderfull...

Okay, it seems to me only users that matter are mtdcore, 3c509 and
maybe h3600_ts_input. After those are fixed, it should be okay to just
config it out/remove pm_register completely.
								Pavel



./drivers/input/touchscreen/h3600_ts_input.c:   ts->pm_dev = pm_register(PM_ILLUMINATION_DEV, PM_SYS_LIGHT,
./drivers/mtd/mtdcore.c:        mtd_pm_dev = pm_register(PM_UNKNOWN_DEV, 0, mtd_pm_callback);
./drivers/net/irda/ali-ircc.c:        pmdev = pm_register(PM_SYS_DEV, PM_SYS_IRDA, ali_ircc_pmproc);
./drivers/net/irda/nsc-ircc.c:        pmdev = pm_register(PM_SYS_DEV, PM_SYS_IRDA, nsc_ircc_pmproc);
./drivers/net/3c509.c:  lp->pmdev = pm_register(PM_ISA_DEV, card_idx, el3_pm_callback);
./drivers/serial/68328serial.c:     serial_pm[i] = pm_register(PM_SYS_DEV, PM_SYS_COM, serial_pm_callback);
./sound/oss/cs4281/cs4281m.c:   pmdev = cs_pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev), cs4281_pm_callback);
./sound/oss/cs4281/cs4281pm-24.c:#define cs_pm_register(a, b, c) pm_register((a), (b), (c));
./sound/oss/ad1848.c:   devc->pmdev = pm_register(PM_ISA_DEV, my_dev, ad1848_pm_callback);
./sound/oss/cs46xx.c:   pmdev = cs_pm_register(PM_PCI_DEV, PM_PCI_ID(pci_dev), cs46xx_pm_callback);
./sound/oss/maestro.c:  pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev),
./sound/oss/nm256_audio.c:    pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev), handle_pm_event);
./sound/oss/opl3sa2.c:          opl3sa2_state[card].pmdev = pm_register(PM_ISA_DEV, card, opl3sa2_pm_callback);


Make pm_register stuff dependend on CONFIG_OLD_PM, so it can be removed.

---
commit fff4171d1a447da54f757e2ff0bd9739d995680c
tree 75b53f93650101814da506bfc435e8f415233672
parent 6c7cd9958aa0edfb01e04bac7fc670e485a1600f
author <pavel@amd.(none)> Sun, 11 Sep 2005 23:04:34 +0200
committer <pavel@amd.(none)> Sun, 11 Sep 2005 23:04:34 +0200

 arch/i386/kernel/apm.c |    6 ++++++
 include/linux/pm.h     |   14 ++++++++++----
 kernel/power/pm.c      |    3 ++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -1180,6 +1180,7 @@ static int suspend(int vetoable)
 	int		err;
 	struct apm_user	*as;
 
+#ifdef CONFIG_OLD_PM
 	if (pm_send_all(PM_SUSPEND, (void *)3)) {
 		/* Vetoed */
 		if (vetoable) {
@@ -1192,6 +1193,7 @@ static int suspend(int vetoable)
 		}
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
+#endif
 
 	device_suspend(PMSG_SUSPEND);
 	local_irq_disable();
@@ -1234,7 +1236,9 @@ static int suspend(int vetoable)
 	device_power_up();
 	local_irq_enable();
 	device_resume();
+#ifdef CONFIG_OLD_PM
 	pm_send_all(PM_RESUME, (void *)0);
+#endif
 	queue_event(APM_NORMAL_RESUME, NULL);
  out:
 	spin_lock(&user_list_lock);
@@ -1355,7 +1359,9 @@ static void check_events(void)
 				set_time();
 				write_sequnlock_irq(&xtime_lock);
 				device_resume();
+#ifdef CONFIG_OLD_PM
 				pm_send_all(PM_RESUME, (void *)0);
+#endif
 				queue_event(event, NULL);
 			}
 			ignore_normal_resume = 0;
diff --git a/include/linux/pm.h b/include/linux/pm.h
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -27,6 +27,15 @@
 #include <linux/list.h>
 #include <asm/atomic.h>
 
+#ifdef CONFIG_PM
+extern int pm_active;
+
+#define PM_IS_ACTIVE() (pm_active != 0)
+#else
+#define PM_IS_ACTIVE() (0)
+#endif
+
+#ifdef CONFIG_OLD_PM
 /*
  * Power management requests... these are passed to pm_send_all() and friends.
  *
@@ -96,10 +105,6 @@ struct pm_dev
 
 #ifdef CONFIG_PM
 
-extern int pm_active;
-
-#define PM_IS_ACTIVE() (pm_active != 0)
-
 /*
  * Register a device with power management
  */
@@ -145,6 +150,7 @@ static inline int pm_send_all(pm_request
 
 /* Functions above this comment are list-based old-style power
  * managment. Please avoid using them.  */
+#endif
 
 /*
  * Callbacks for platform drivers to implement.
diff --git a/kernel/power/pm.c b/kernel/power/pm.c
--- a/kernel/power/pm.c
+++ b/kernel/power/pm.c
@@ -27,6 +27,7 @@
 
 int pm_active;
 
+#ifdef CONFIG_OLD_PM
 /*
  *	Locking notes:
  *		pm_devs_lock can be a semaphore providing pm ops are not called
@@ -261,4 +262,4 @@ EXPORT_SYMBOL(pm_unregister_all);
 EXPORT_SYMBOL(pm_send_all);
 EXPORT_SYMBOL(pm_active);
 
-
+#endif

-- 
if you have sharp zaurus hardware you don't need... you know my address
