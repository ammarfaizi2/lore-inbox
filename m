Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbTGMNVL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 09:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbTGMNVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 09:21:11 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:41865 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S266141AbTGMNVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 09:21:07 -0400
Date: Sun, 13 Jul 2003 15:35:40 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, ak@muc.de, mingo@redhat.com
Subject: [PATCH] new sysctl checking accesses userspace directly
Message-ID: <20030713133540.GB11051@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
  recent change from Andi breaks here: tmp.name is pointer, not
array in __sysctl_args, and so it is better to access it through
copy_from_user instead of directly.

  With patch below it does not crash with unhandled kernel paging
request anymore.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


--- linux/kernel/sysctl.c	2003-07-13 01:37:39.000000000 +0200
+++ linux/kernel/sysctl.c	2003-07-13 15:15:06.000000000 +0200
@@ -848,17 +848,25 @@
 asmlinkage long sys_sysctl(struct __sysctl_args __user *args)
 {
 	struct __sysctl_args tmp;
+	int name[2];
 	int error;
 
 	if (copy_from_user(&tmp, args, sizeof(tmp)))
 		return -EFAULT;
 	
-	if (tmp.nlen != 2 || tmp.name[0] != CTL_KERN ||
-	    tmp.name[1] != KERN_VERSION) { 
+	if (tmp.nlen != 2 || copy_from_user(name, tmp.name, sizeof(name)) ||
+	    name[0] != CTL_KERN || name[1] != KERN_VERSION) { 
 		int i;
 		printk(KERN_INFO "%s: numerical sysctl ", current->comm); 
-		for (i = 0; i < tmp.nlen; i++) 
-			printk("%d ", tmp.name[i]); 
+		for (i = 0; i < tmp.nlen; i++) {
+			int n;
+			
+			if (get_user(n, tmp.name+i)) {
+				printk("? ");
+			} else {
+				printk("%d ", n);
+			}
+		}
 		printk("is obsolete.\n");
 	} 
 

