Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269291AbUJQTry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbUJQTry (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269335AbUJQTrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:47:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17369 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269291AbUJQTqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:46:52 -0400
To: linux-kernel@vger.kernel.org
Subject: K8 Errata #93: adjusting address to a fixup block
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 17 Oct 2004 16:46:49 -0300
Message-ID: <orr7nxyvo6.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

While I investigated the problem of probing the touchpad on a Compaq
Presario r3004, I'd sometimes get the K8 Errata #93 warning.  One of
my theories was that we might be missing some fix up because of the
Errata, or adjusting an address that wasn't the current-instruction
address, so I came up with this patch.  It turned out to make no
difference, but it still feels like an improvement to me, since some
day we might be resuming from halt into a fix-up block.  Thoughts?


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=linux-2.6.9-k8errata93.patch

--- arch/x86_64/mm/fault.c.k8errata93	2004-10-17 08:49:45.000000000 -0300
+++ arch/x86_64/mm/fault.c	2004-10-17 11:14:40.000000000 -0300
@@ -188,9 +188,12 @@
    Try to work around it here.
    Note we only handle faults in kernel here. */
 
-static int is_errata93(struct pt_regs *regs, unsigned long address) 
+static int is_errata93(struct pt_regs *regs, unsigned long address,
+		       unsigned long error_code)
 {
 	static int warned;
+	if ((error_code & 16) == 0)
+		return 0;
 	if (address != regs->rip)
 		return 0;
 	if ((address >> 32) != 0) 
@@ -202,6 +205,8 @@
 			printk(errata93_warning); 		
 			warned = 1;
 		}
+		printk(KERN_DEBUG "is_errata93 adjusted %lx to %lx\n",
+		       regs->rip, address);
 		regs->rip = address;
 		return 1;
 	}
@@ -253,6 +258,7 @@
 	const struct exception_table_entry *fixup;
 	int write;
 	siginfo_t info;
+	int errata93_return = 0;
 
 #ifdef CONFIG_CHECKING
 	{ 
@@ -463,8 +469,11 @@
  	if (is_prefetch(regs, address, error_code))
  		return;
 
-	if (is_errata93(regs, address))
-		return; 
+	if (is_errata93(regs, address, error_code)) {
+		errata93_return = 1;
+		goto no_context;
+	} else if (errata93_return)
+		return;
 
 /*
  * Oops. The kernel tried to access some bad page. We'll have to

--=-=-=


-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

--=-=-=--
