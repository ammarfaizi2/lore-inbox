Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268524AbTANCqT>; Mon, 13 Jan 2003 21:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268533AbTANCqM>; Mon, 13 Jan 2003 21:46:12 -0500
Received: from dp.samba.org ([66.70.73.150]:27276 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268525AbTANCqA>;
	Mon, 13 Jan 2003 21:46:00 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Joerg Reuter DL1BKE <jreuter@yaina.de>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: [TRIVIAL] cli_sti in drivers_net_hamradio_bpqether.c
Date: Tue, 14 Jan 2003 13:34:22 +1100
Message-Id: <20030114025452.5FB632C37E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Guys, this has been sitting in my Trivial queue for a while, with
  several others.  The patch *looks* ok: apply it and wait for someone
  to whine, or discard it?

  If someonw with this card wants to test this and verify it works on
  an SMP kernel, even if not an SMP box, I'd be happier.

  I guess it depends on when we are going to rip out save_flags et al
  entirely.  Linus? ]

From:  Chris Wilson <chris@qwirx.com>

  As part of the Linux Kernel Janitors project, I would like to submit my
  patch for bpqether.c.
  
  The document Documentation/cli-sti-removal.txt says that cli() should no
  longer be used to disable interrupts. This patch removes all references to 
  cli() and {save,restore}_flags.
  
  - added a static spinlock to protect bpq_devices
  - changed cli/sti and {save,restore}_flags to taking the spinlock and 
    disabling interrupts with spin_lock_irqsave
  - included my previous patch for proc_net_create, but as a separate hunk, 
    so if you've already applied then just ignore the rejected hunk.
  
  I have verified that the patched driver compiles without warnings, but 
  since I don't have the hardware I can't test it. Please treat with 
  caution.
  
  Perhaps there is another mailing list which I should send this to, in
  order to try and find kind souls to test it?
  
  Cheers, Chris.
  -- 
  _ ___ __     _
   / __/ / ,__(_)_  | Chris Wilson <0000 at qwirx.com> - Cambs UK |
  / (_/ ,/ _/ /_  | Security/C/C++/Java/Perl/SQL/HTML Developer |
   _/_/_/_//_/___/ | We are GNU-free your mind-and your software |
  

--- trivial-2.5.57/drivers/net/hamradio/bpqether.c.orig	2003-01-14 12:12:03.000000000 +1100
+++ trivial-2.5.57/drivers/net/hamradio/bpqether.c	2003-01-14 12:12:03.000000000 +1100
@@ -159,6 +159,8 @@
 	);
 }
 
+static spinlock_t bpq_lock = SPIN_LOCK_UNLOCKED;
+
 /*
  *	Sanity check: remove all devices that ceased to exists and
  *	return '1' if the given BPQ device was affected.
@@ -169,8 +171,7 @@
 	int result = 0;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&bpq_lock, flags);
 
 	bpq_prev = NULL;
 
@@ -196,7 +197,7 @@
 			bpq_prev = bpq;
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bpq_lock, flags);
 
 	return result;
 }
@@ -446,8 +447,9 @@
 	int len     = 0;
 	off_t pos   = 0;
 	off_t begin = 0;
+	unsigned long flags;
 
-	cli();
+	spin_lock_irqsave(&bpq_lock, flags);
 
 	len += sprintf(buffer, "dev   ether      destination        accept from\n");
 
@@ -470,7 +472,7 @@
 			break;
 	}
 
-	sti();
+	spin_unlock_irqrestore(&bpq_lock, flags);
 
 	*start = buffer + (offset - begin);
 	len   -= (offset - begin);
@@ -491,6 +493,7 @@
 {
 	int k;
 	struct bpqdev *bpq, *bpq2;
+	unsigned long flags;
 
 	if ((bpq = kmalloc(sizeof(struct bpqdev), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
@@ -553,7 +556,7 @@
 	dev->mtu             = AX25_DEF_PACLEN;
 	dev->addr_len        = AX25_ADDR_LEN;
 
-	cli();
+	spin_lock_irqsave(&bpq_lock, flags);
 
 	if (bpq_devices == NULL) {
 		bpq_devices = bpq;
@@ -562,7 +565,7 @@
 		bpq2->next = bpq;
 	}
 
-	sti();
+	spin_unlock_irqrestore(&bpq_lock, flags);
 
 	return 0;
 }
@@ -615,7 +618,13 @@
 
 	printk(banner);
 
-	proc_net_create("bpqether", 0, bpq_get_info);
+	if (!proc_net_create("bpqether", 0, bpq_get_info)) {
+		printk(KERN_ERR
+			"bpq: cannot create /proc/net/bpqether entry.\n");
+		unregister_netdevice_notifier(&bpq_dev_notifier);
+		dev_remove_pack(&bpq_packet_type);
+		return -ENOENT;
+	}
 
 	read_lock_bh(&dev_base_lock);
 	for (dev = dev_base; dev != NULL; dev = dev->next) {
-- 
  Don't blame me: the Monkey is driving
  File: Chris Wilson <chris@qwirx.com>: [PATCH] cli_sti in drivers_net_hamradio_bpqether.c
