Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSGUUsG>; Sun, 21 Jul 2002 16:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSGUUsG>; Sun, 21 Jul 2002 16:48:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29116 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S314546AbSGUUsC>;
	Sun, 21 Jul 2002 16:48:02 -0400
Date: Sun, 21 Jul 2002 22:50:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A5
In-Reply-To: <Pine.LNX.4.44.0207212237270.26342-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207212249070.26468-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fixed the arch/i386/kernel/mca.c hacks as well:
 
     http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-A6

while there cannot be many MCA SMP boxes in existence, it should be SMP
safe as well.

 	Ingo

--- linux/arch/i386/kernel/mca.c.orig	Sun Jun  9 07:27:54 2002
+++ linux/arch/i386/kernel/mca.c	Sun Jul 21 22:49:42 2002
@@ -102,6 +102,12 @@
 
 static struct MCA_info* mca_info = NULL;
 
+/*
+ * Motherboard register spinlock. Untested on SMP at the moment, but
+ * are there any MCA SMP boxes?
+ */
+static spinlock_t mca_lock = SPIN_LOCK_UNLOCKED;
+
 /* MCA registers */
 
 #define MCA_MOTHERBOARD_SETUP_REG	0x94
@@ -213,8 +219,11 @@
 	}
 	memset(mca_info, 0, sizeof(struct MCA_info));
 
-	save_flags(flags);
-	cli();
+	/*
+	 * We do not expect many MCA interrupts during initialization,
+	 * but let us be safe:
+	 */
+	spin_lock_irq(&mca_lock);
 
 	/* Make sure adapter setup is off */
 
@@ -300,8 +309,7 @@
 	outb_p(0, MCA_ADAPTER_SETUP_REG);
 
 	/* Enable interrupts and return memory start */
-
-	restore_flags(flags);
+	spin_unlock_irq(&mca_lock);
 
 	for (i = 0; i < MCA_STANDARD_RESOURCES; i++)
 		request_resource(&ioport_resource, mca_standard_resources + i);
@@ -514,8 +522,7 @@
 	if(slot < 0 || slot >= MCA_NUMADAPTERS || mca_info == NULL) return 0;
 	if(reg < 0 || reg >= 8) return 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&mca_lock, flags);
 
 	/* Make sure motherboard setup is off */
 
@@ -566,7 +573,7 @@
 
 	mca_info->slot[slot].pos[reg] = byte;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&mca_lock, flags);
 
 	return byte;
 } /* mca_read_pos() */
@@ -610,8 +617,7 @@
 	if(mca_info == NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&mca_lock, flags);
 
 	/* Make sure motherboard setup is off */
 
@@ -623,7 +629,7 @@
 	outb_p(byte, MCA_POS_REG(reg));
 	outb_p(0, MCA_ADAPTER_SETUP_REG);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&mca_lock, flags);
 
 	/* Update the global register list, while we have the byte */
 

