Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKUQT5>; Tue, 21 Nov 2000 11:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQKUQTr>; Tue, 21 Nov 2000 11:19:47 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:57861 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129091AbQKUQTd>; Tue, 21 Nov 2000 11:19:33 -0500
Date: Tue, 21 Nov 2000 18:46:09 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>,
        linux-kernel@vger.kernel.org, axp-list@redhat.com
Subject: ux164 (ruffian) fixes
Message-ID: <20001121184609.A2889@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two issues preventing ruffians from booting 2.4 (with bridges patch)
were found and fixed.
 - rather trivial one: someone decided that interrupt 4
   (irq 20 from builtin scsi) is 'bogus' ;-)
 - another issue is way not trivial and cost Michal and me a
   lot of sweat. Type 1 PCI configuration space accesses (and to
   some degree type 0 accesses to the bridge itself) were subtly
   broken. In other words, these accesses were failing randomly
   causing all sorts of havoc. At some point I managed to break
   them completely just by adding one extra mb()...
   Copying the code from 2.2 solved the problem - but it's a kind
   of magic.
   Interesting, other pyxis machines do not seem to be so sensitive,
   so I guess some design problems with ux164 motherboard - all this
   looks pretty much like timing issues.

Many thanks to Michal for that painful and time consuming testing
he has done.

Ivan.

--- 2.4.0t11/arch/alpha/kernel/core_cia.c	Fri Oct 27 21:55:01 2000
+++ linux/arch/alpha/kernel/core_cia.c	Thu Nov 16 17:46:54 2000
@@ -119,6 +119,7 @@ conf_read(unsigned long addr, unsigned c
 	stat0 = *(vip)CIA_IOC_CIA_ERR;
 	*(vip)CIA_IOC_CIA_ERR = stat0;
 	mb();
+	*(vip)CIA_IOC_CIA_ERR; /* re-read to force write */
 
 	/* If Type1 access, must set CIA CFG. */
 	if (type1) {
@@ -128,6 +129,7 @@ conf_read(unsigned long addr, unsigned c
 		*(vip)CIA_IOC_CFG;
 	}
 
+	mb();
 	draina();
 	mcheck_expected(0) = 1;
 	mcheck_taken(0) = 0;
@@ -171,6 +173,7 @@ conf_write(unsigned long addr, unsigned 
 	stat0 = *(vip)CIA_IOC_CIA_ERR;
 	*(vip)CIA_IOC_CIA_ERR = stat0;
 	mb();
+	*(vip)CIA_IOC_CIA_ERR; /* re-read to force write */
 
 	/* If Type1 access, must set CIA CFG.  */
 	if (type1) {
@@ -180,6 +183,7 @@ conf_write(unsigned long addr, unsigned 
 		*(vip)CIA_IOC_CFG;
 	}
 
+	mb();
 	draina();
 	mcheck_expected(0) = 1;
 	mcheck_taken(0) = 0;
@@ -188,7 +192,7 @@ conf_write(unsigned long addr, unsigned 
 	/* Access configuration space.  */
 	*(vip)addr = value;
 	mb();
-	mb();  /* magic */
+	*(vip)addr; /* read back to force the write */
 
 	mcheck_expected(0) = 0;
 	mb();
@@ -606,7 +610,8 @@ do_init_arch(int is_pyxis)
 	*(vip)CIA_IOC_ERR_MASK = temp;
 
 	/* Clear all currently pending errors.  */
-	*(vip)CIA_IOC_CIA_ERR = 0;
+	temp = *(vip)CIA_IOC_CIA_ERR;
+	*(vip)CIA_IOC_CIA_ERR = temp;
 
 	/* Turn on mchecks.  */
 	temp = *(vip)CIA_IOC_CIA_CTRL;
--- 2.4.0t11/arch/alpha/kernel/sys_ruffian.c	Sun Nov  5 16:16:43 2000
+++ linux/arch/alpha/kernel/sys_ruffian.c	Tue Nov 21 00:25:42 2000
@@ -56,9 +56,9 @@ ruffian_init_irq(void)
 	
 	init_i8259a_irqs();
 
-	/* Not interested in the bogus interrupts (0,3,4,6), 
+	/* Not interested in the bogus interrupts (0,3,6),
 	   NMI (1), HALT (2), flash (5), or 21142 (8).  */
-	init_pyxis_irqs(0x17f0000);
+	init_pyxis_irqs(0x16f0000);
 
 	common_init_isa_dma();
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
