Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265878AbRGEPzx>; Thu, 5 Jul 2001 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265841AbRGEPzn>; Thu, 5 Jul 2001 11:55:43 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:19870 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265806AbRGEPz0>; Thu, 5 Jul 2001 11:55:26 -0400
Message-ID: <3B448E33.120DF382@uow.edu.au>
Date: Fri, 06 Jul 2001 01:56:35 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Thibaut Laurent <thibaut@celestix.com>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
In-Reply-To: <20010704232816.B590@marvin.mahowi.de> <20010705162035.Q17051@athlon.random> <3B447B6D.C83E5FB9@redhat.com> <20010705164046.S17051@athlon.random> <20010705233200.7ead91d5.thibaut@celestix.com>,
		<20010705233200.7ead91d5.thibaut@celestix.com>; from thibaut@celestix.com on Thu, Jul 05, 2001 at 11:32:00PM +0800 <20010705114633.A1787@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> On Thu, Jul 05, 2001 at 11:32:00PM +0800, Thibaut Laurent wrote:
> > And the winner is... Andrea. Kudos to you, I've just applied these patches,
> > recompiled and it seems to work fine.
> > Too bad, this was the perfect excuse for getting rid of those good old Cyrix
> > boxen ;)
> 
> As Andrea's patches don't actually fix anything Cyrix related it's obvious
> that they just avoid the real bug instead of fixing it.
> It's a very useful datapoint though.

My money is on the unconditional sti()'s in the cyrix code.



--- linux-2.4.6/arch/i386/kernel/setup.c	Mon May 28 13:31:46 2001
+++ lk-ext3/arch/i386/kernel/setup.c	Fri Jul  6 01:37:39 2001
@@ -1243,12 +1255,13 @@ static int __init init_amd(struct cpuinf
 /*
  * Read Cyrix DEVID registers (DIR) to get more detailed info. about the CPU
  */
-static inline void do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
+static void do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
 {
 	unsigned char ccr2, ccr3;
+	unsigned long flags;
 
 	/* we test for DEVID by checking whether CCR3 is writable */
-	cli();
+	save_flags(flags);
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, ccr3 ^ 0x80);
 	getCx86(0xc0);   /* dummy to change bus */
@@ -1272,7 +1285,7 @@ static inline void do_cyrix_devid(unsign
 		*dir0 = getCx86(CX86_DIR0);
 		*dir1 = getCx86(CX86_DIR1);
 	}
-	sti();
+	restore_flags(flags);
 }
 
 /*
@@ -1316,15 +1329,16 @@ static void __init check_cx686_slop(stru
 {
 	if (Cx86_dir0_msb == 3) {
 		unsigned char ccr3, ccr5;
+		unsigned long flags;
 
-		cli();
+		save_flags(flags);
 		ccr3 = getCx86(CX86_CCR3);
 		setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
 		ccr5 = getCx86(CX86_CCR5);
 		if (ccr5 & 2)
 			setCx86(CX86_CCR5, ccr5 & 0xfd);  /* reset SLOP */
 		setCx86(CX86_CCR3, ccr3);                 /* disable MAPEN */
-		sti();
+		restore_flags(flags);
 
 		if (ccr5 & 2) { /* possible wrong calibration done */
 			printk(KERN_INFO "Recalibrating delay loop with SLOP bit reset\n");
@@ -2092,15 +2106,16 @@ static int __init id_and_try_enable_cpui
    	        if (dir0 == 5 || dir0 == 3)
    	        {
 			unsigned char ccr3, ccr4;
+			unsigned long flags;
 
 			printk(KERN_INFO "Enabling CPUID on Cyrix processor.\n");
-			cli();
+			save_flags(flags);
 			ccr3 = getCx86(CX86_CCR3);
 			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
 			ccr4 = getCx86(CX86_CCR4);
 			setCx86(CX86_CCR4, ccr4 | 0x80);          /* enable cpuid  */
 			setCx86(CX86_CCR3, ccr3);                 /* disable MAPEN */
-			sti();
+			restore_flags(flags);
 		}
 	} else
