Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274545AbRITPxS>; Thu, 20 Sep 2001 11:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274547AbRITPxI>; Thu, 20 Sep 2001 11:53:08 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:62469 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S274545AbRITPw6>; Thu, 20 Sep 2001 11:52:58 -0400
Message-ID: <3BAA107E.4F2FDEE2@osdlab.org>
Date: Thu, 20 Sep 2001 08:51:26 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>, Linus <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
        crutcher+kernel@datastacks.com
Subject: [PATCH] fix register_sysrq() in 2.4.9++
Content-Type: multipart/mixed;
 boundary="------------E72DB4ADC1844C52CDF40932"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E72DB4ADC1844C52CDF40932
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus, Alan-

register_sysrq_key() is typed #ifdef CONFIG_MAGIC_SYSRQ,
but untyped if it's not defined, causing problems for callers
when CONFIG_MAGIC_SYSRQ is not defined.
This patch fixes that problem.

arch/i386/kernel/apm.c calls [un]register_sysrq_key() with
a pointer to a sysrq_poweroff_op data structure that is
only declared #ifdef CONFIG_MAGIC_SYSRQ.
This patch also wraps the register/unregister calls with
#ifdef CONFIG_MAGIC_SYSRQ.

~Randy
--------------E72DB4ADC1844C52CDF40932
Content-Type: text/plain; charset=us-ascii;
 name="sysrq-if.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrq-if.patch"

--- linux/include/linux/sysrq.h.org	Mon Sep 17 10:21:07 2001
+++ linux/include/linux/sysrq.h	Thu Sep 20 08:29:15 2001
@@ -87,8 +87,17 @@
 }
 
 #else
-#define register_sysrq_key(a,b)		do {} while(0)
-#define unregister_sysrq_key(a,b)	do {} while(0)
+
+static inline int register_sysrq_key(int key, struct sysrq_key_op *op_p)
+{
+	return -1;
+}
+
+static inline int unregister_sysrq_key(int key, struct sysrq_key_op *op_p)
+{
+	return 0;
+}
+
 #endif
 
 /* Deferred actions */
--- linux/arch/i386/kernel/apm.c.org	Mon Sep 17 10:15:45 2001
+++ linux/arch/i386/kernel/apm.c	Thu Sep 20 08:34:44 2001
@@ -1564,7 +1564,10 @@
 	/* Install our power off handler.. */
 	if (power_off)
 		pm_power_off = apm_power_off;
-	register_sysrq_key('o',&sysrq_poweroff_op);
+#ifdef CONFIG_MAGIC_SYSRQ
+	if (register_sysrq_key('o',&sysrq_poweroff_op))
+		printk (KERN_ERR "Error: cannot register APM PowerOff SysRq key\n");
+#endif
 
 	if (smp_num_cpus == 1) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
@@ -1780,7 +1783,9 @@
 	}
 	misc_deregister(&apm_device);
 	remove_proc_entry("apm", NULL);
+#ifdef CONFIG_MAGIC_SYSRQ
 	unregister_sysrq_key('o',&sysrq_poweroff_op);
+#endif
 	if (power_off)
 		pm_power_off = NULL;
 	exit_kapmd = 1;

--------------E72DB4ADC1844C52CDF40932--

