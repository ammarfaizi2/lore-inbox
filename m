Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbSLSXDN>; Thu, 19 Dec 2002 18:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbSLSXDL>; Thu, 19 Dec 2002 18:03:11 -0500
Received: from air-2.osdl.org ([65.172.181.6]:14047 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267732AbSLSXBm>;
	Thu, 19 Dec 2002 18:01:42 -0500
Subject: [PATCH] (5/5) improved notifier callback mechanism -- remove old
	locking V2
From: Stephen Hemminger <shemminger@osdl.org>
To: vamsi@in.ibm.com, John Levon <levon@movementarian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021219181929.A5265@in.ibm.com>
References: <1040249652.14364.192.camel@dell_ss3.pdx.osdl.net>
	 <20021219181929.A5265@in.ibm.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1040339373.1079.9.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 15:09:33 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous patches, the notifier interface now has it's own
locking.  Therefore the existing locking done by the oprofile interface
is superfluous.
diff -Nru a/arch/i386/kernel/profile.c b/arch/i386/kernel/profile.c
--- a/arch/i386/kernel/profile.c	Tue Dec 17 11:25:47 2002
+++ b/arch/i386/kernel/profile.c	Tue Dec 17 11:25:47 2002
@@ -6,40 +6,25 @@
  */
 
 #include <linux/profile.h>
-#include <linux/spinlock.h>
 #include <linux/notifier.h>
 #include <linux/irq.h>
 #include <asm/hw_irq.h> 
  
 static LIST_HEAD(profile_listeners);
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
  
 int register_profile_notifier(struct notifier_block * nb)
 {
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_register(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
+	return notifier_chain_register(&profile_listeners, nb);
 }
 
 
 int unregister_profile_notifier(struct notifier_block * nb)
 {
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_unregister(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
+	return notifier_chain_unregister(&profile_listeners, nb);
 }
 
 
 void x86_profile_hook(struct pt_regs * regs)
 {
-	/* we would not even need this lock if
-	 * we had a global cli() on register/unregister
-	 */ 
-	read_lock(&profile_lock);
 	notifier_call_chain(&profile_listeners, 0, regs);
-	read_unlock(&profile_lock);
 }



