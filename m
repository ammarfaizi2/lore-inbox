Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVCSLkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVCSLkv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 06:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVCSLkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 06:40:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25520 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262451AbVCSLkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 06:40:36 -0500
Date: Sat, 19 Mar 2005 12:40:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp: small updates
Message-ID: <20050319114021.GA1594@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills unused macro and write-only variable, and adds messages
where something goes wrong with suspending devices. Please apply,

							Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>


--- clean/include/linux/suspend.h	2005-03-19 00:32:25.000000000 +0100
+++ linux/include/linux/suspend.h	2005-03-19 00:48:46.000000000 +0100
@@ -34,8 +34,6 @@
 #define SWAP_FILENAME_MAXLENGTH	32
 
 
-#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
-
 extern dev_t swsusp_resume_device;
    
 /* mm/vmscan.c */
--- clean/kernel/power/main.c	2005-03-19 00:32:32.000000000 +0100
+++ linux/kernel/power/main.c	2005-03-19 00:35:27.000000000 +0100
@@ -65,8 +65,10 @@
 			goto Thaw;
 	}
 
-	if ((error = device_suspend(PMSG_SUSPEND)))
+	if ((error = device_suspend(PMSG_SUSPEND))) {
+		printk(KERN_ERR "Some devices failed to suspend\n");
 		goto Finish;
+	}
 	return 0;
  Finish:
 	if (pm_ops->finish)
@@ -85,8 +87,10 @@
 
 	local_irq_save(flags);
 
-	if ((error = device_power_down(PMSG_SUSPEND)))
+	if ((error = device_power_down(PMSG_SUSPEND))) {
+		printk(KERN_ERR "Some devices failed to power down\n");		
 		goto Done;
+	}
 	error = pm_ops->enter(state);
 	device_power_up();
  Done:
--- clean/kernel/power/swsusp.c	2005-03-19 00:32:32.000000000 +0100
+++ linux/kernel/power/swsusp.c	2005-03-19 00:52:45.000000000 +0100
@@ -98,7 +98,6 @@
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
 static suspend_pagedir_t *pagedir_save;
-static int pagedir_order __nosavedata = 0;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -920,7 +919,8 @@
 {
 	int error;
 	local_irq_disable();
-	device_power_down(PMSG_FREEZE);
+	if (device_power_down(PMSG_FREEZE))
+		printk(KERN_ERR "Some devices failed to power down, very bad\n");
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = swsusp_arch_resume();
@@ -1219,7 +1219,6 @@
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
-	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
@@ -1238,7 +1237,7 @@
 		 */
 		error = bio_write_page(0, &swsusp_header);
 	} else { 
-		pr_debug(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
+		printk(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
 		return -EINVAL;
 	}
 	if (!error)

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
