Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131807AbQLRNd6>; Mon, 18 Dec 2000 08:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132088AbQLRNdr>; Mon, 18 Dec 2000 08:33:47 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:25473 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131807AbQLRNdn>; Mon, 18 Dec 2000 08:33:43 -0500
Date: Mon, 18 Dec 2000 13:58:59 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Linus Torvalds <torvalds@transmeta.com>,
        Ingo Molnar <mingo@chiara.elte.hu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre3
In-Reply-To: <Pine.LNX.4.10.10012171353270.2052-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.3.96.1001218110407.16075B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 What is this change about?

diff -u --recursive --new-file v2.4.0-test12/linux/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- v2.4.0-test12/linux/arch/i386/kernel/smpboot.c      Mon Dec 11 17:59:43 2000
+++ linux/arch/i386/kernel/smpboot.c    Thu Dec 14 14:54:40 2000
@@ -694,6 +694,11 @@
 		apic_write_around(APIC_ICR, APIC_DM_STARTUP
 					| (start_eip >> 12));
 
+		/*
+		 * Give the other CPU some time to accept the IPI.
+		 */
+		udelay(300);
+
 		Dprintk("Startup point 1.\n");
 
 		Dprintk("Waiting for send to finish...\n");

There is the following code is just after it, making the above change
just useless garbage:

		timeout = 0;
		do {
			Dprintk("+");
			udelay(100);
			send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
		} while (send_status && (timeout++ < 1000));

		/*
		 * Give the other CPU some time to accept the IPI.
		 */
		udelay(200);

If we need 600usecs of delay for certain systems, then why not just make
it like below?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.0.4-test13-pre3-startup_ipi-0
diff -up --recursive --new-file linux-2.4.0-test13-pre3.macro/arch/i386/kernel/smpboot.c linux-2.4.0-test13-pre3/arch/i386/kernel/smpboot.c
--- linux-2.4.0-test13-pre3.macro/arch/i386/kernel/smpboot.c	Mon Dec 18 12:14:10 2000
+++ linux-2.4.0-test13-pre3/arch/i386/kernel/smpboot.c	Mon Dec 18 12:15:49 2000
@@ -694,11 +694,6 @@ static void __init do_boot_cpu (int apic
 		apic_write_around(APIC_ICR, APIC_DM_STARTUP
 					| (start_eip >> 12));
 
-		/*
-		 * Give the other CPU some time to accept the IPI.
-		 */
-		udelay(300);
-
 		Dprintk("Startup point 1.\n");
 
 		Dprintk("Waiting for send to finish...\n");
@@ -712,7 +707,7 @@ static void __init do_boot_cpu (int apic
 		/*
 		 * Give the other CPU some time to accept the IPI.
 		 */
-		udelay(200);
+		udelay(500);
 		/*
 		 * Due to the Pentium erratum 3AP.
 		 */

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
