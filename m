Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbVKBJLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbVKBJLq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbVKBJLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:11:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58123 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932683AbVKBJL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:11:26 -0500
Date: Wed, 2 Nov 2005 10:11:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Corey Minyard <minyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix IPMI compile errors with PROC_FS=n
Message-ID: <20051102091121.GH8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile errors with CONFIG_PROC_FS=n:

<--  snip  -->

...
  CC [M]  drivers/char/ipmi/ipmi_msghandler.o
drivers/char/ipmi/ipmi_msghandler.c:3301: `proc_ipmi_root' undeclared here (not in a function)
drivers/char/ipmi/ipmi_msghandler.c:3301: initializer element is not constant
drivers/char/ipmi/ipmi_msghandler.c:3301: (near initialization for `__ksymtab_proc_ipmi_root.value')
drivers/char/ipmi/ipmi_msghandler.c:1535: warning: `ipmb_file_read_proc' defined but not used
drivers/char/ipmi/ipmi_msghandler.c:1551: warning: `version_file_read_proc' defined but not used
drivers/char/ipmi/ipmi_msghandler.c:1561: warning: `stat_file_read_proc' defined but not used
...
  CC [M]  drivers/char/ipmi/ipmi_poweroff.o
drivers/char/ipmi/ipmi_poweroff.c: In function `ipmi_poweroff_init':
drivers/char/ipmi/ipmi_poweroff.c:616: warning: implicit declaration of function `unregister_sysctl_table'
drivers/char/ipmi/ipmi_poweroff.c:616: `ipmi_table_header' undeclared (first use in this function)
drivers/char/ipmi/ipmi_poweroff.c:616: (Each undeclared identifier is reported only once
drivers/char/ipmi/ipmi_poweroff.c:616: for each function it appears in.)

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-modular-2.95/drivers/char/ipmi/ipmi_msghandler.c.old	2005-11-02 02:23:04.000000000 +0100
+++ linux-2.6.14-rc5-mm1-modular-2.95/drivers/char/ipmi/ipmi_msghandler.c	2005-11-02 02:23:26.000000000 +0100
@@ -57,6 +57,7 @@
 
 #ifdef CONFIG_PROC_FS
 struct proc_dir_entry *proc_ipmi_root = NULL;
+EXPORT_SYMBOL(proc_ipmi_root);
 #endif /* CONFIG_PROC_FS */
 
 #define MAX_EVENTS_IN_QUEUE	25
@@ -3298,6 +3299,5 @@
 EXPORT_SYMBOL(ipmi_set_my_LUN);
 EXPORT_SYMBOL(ipmi_get_my_LUN);
 EXPORT_SYMBOL(ipmi_smi_add_proc_entry);
-EXPORT_SYMBOL(proc_ipmi_root);
 EXPORT_SYMBOL(ipmi_user_set_run_to_completion);
 EXPORT_SYMBOL(ipmi_free_recv_msg);
--- linux-2.6.14-rc5-mm1-modular-2.95/drivers/char/ipmi/ipmi_poweroff.c.old	2005-11-02 02:31:09.000000000 +0100
+++ linux-2.6.14-rc5-mm1-modular-2.95/drivers/char/ipmi/ipmi_poweroff.c	2005-11-02 02:31:43.000000000 +0100
@@ -612,11 +612,14 @@
 #endif
 
 	rv = ipmi_smi_watcher_register(&smi_watcher);
+
+#ifdef CONFIG_PROC_FS
 	if (rv) {
 		unregister_sysctl_table(ipmi_table_header);
 		printk(KERN_ERR PFX "Unable to register SMI watcher: %d\n", rv);
 		goto out_err;
 	}
+#endif
 
  out_err:
 	return rv;
