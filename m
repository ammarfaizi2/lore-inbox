Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132671AbQLNS77>; Thu, 14 Dec 2000 13:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132672AbQLNS7t>; Thu, 14 Dec 2000 13:59:49 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:33287 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132671AbQLNS7d>;
	Thu, 14 Dec 2000 13:59:33 -0500
Date: Thu, 14 Dec 2000 19:28:41 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH] 2.4.0-test13-pre1 and booting on VIA based SMP
Message-ID: <20001214192841.C3079@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
  I sent this patch yesterday to linux-kernel, and as nobody answered...
I was trying to discuss it with mingo@redhat.com before, when I was tracking
problem down, but he apparently does not read this email address :-(

  Could you apply this patch, either with comment, or without? Without
additional udelay(300) before first printk my GA-6VXD7 board (with
Via VT82C694X host bridge) dies in couple of spectacular ways somewhere
after first message is printed to screen, but before second one is
displayed. I asked VIA for datasheets/errata, but they did not bothered
with answer yet. But it looks like that either r-m-w in spinlock code,
or cursor postitioning code in vgacon, causes lockup. Without some HW
analyser it is hard to tell...
  					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

diff -urdN linux/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux/arch/i386/kernel/smpboot.c	Mon Dec  4 01:48:19 2000
+++ linux/arch/i386/kernel/smpboot.c	Thu Dec 14 17:44:26 2000
@@ -694,9 +694,21 @@
 		apic_write_around(APIC_ICR, APIC_DM_STARTUP
 					| (start_eip >> 12));
 
+		/*
+		 * Petr Vandrovec:
+		 *
+		 * We must wait for at least 200us, otherwise
+		 * printk kills my VT82C694X based SMP board.
+		 * 
+		 * 100us is not enough, 200us is enough,
+		 * so I use 300us for additional safety.
+		 */
+
+		udelay(300);
+
 		Dprintk("Startup point 1.\n");
 
 		Dprintk("Waiting for send to finish...\n");
 		timeout = 0;
 		do {
 			Dprintk("+");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
