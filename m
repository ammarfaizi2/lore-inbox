Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265907AbRGEQKm>; Thu, 5 Jul 2001 12:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265904AbRGEQKd>; Thu, 5 Jul 2001 12:10:33 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:40875 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265908AbRGEQKW>; Thu, 5 Jul 2001 12:10:22 -0400
Message-ID: <3B4491AB.E49CCFD3@uow.edu.au>
Date: Fri, 06 Jul 2001 02:11:23 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Arjan van de Ven <arjanv@redhat.com>,
        Thibaut Laurent <thibaut@celestix.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
In-Reply-To: <3B448E33.120DF382@uow.edu.au> from "Andrew Morton" at Jul 06, 2001 01:56:35 AM <E15IBc8-0002r3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > My money is on the unconditional sti()'s in the cyrix code.
> 
> Possibly but the diff is wrong

But it'll still work :)

--- linux-2.4.6/init/main.c	Wed Jul  4 18:21:32 2001
+++ lk-ext3/init/main.c	Fri Jul  6 02:06:12 2001
@@ -523,8 +523,8 @@ asmlinkage void __init start_kernel(void
 	trap_init();
 	init_IRQ();
 	sched_init();
-	time_init();
 	softirq_init();
+	time_init();
 
 	/*
 	 * HACK ALERT! This is early. We're enabling the console before
--- linux-2.4.6/arch/i386/kernel/setup.c	Mon May 28 13:31:46 2001
+++ lk-ext3/arch/i386/kernel/setup.c	Fri Jul  6 01:59:37 2001
@@ -1243,11 +1255,13 @@ static int __init init_amd(struct cpuinf
 /*
  * Read Cyrix DEVID registers (DIR) to get more detailed info. about the CPU
  */
-static inline void do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
+static void do_cyrix_devid(unsigned char *dir0, unsigned char *dir1)
 {
 	unsigned char ccr2, ccr3;
+	unsigned long flags;
 
 	/* we test for DEVID by checking whether CCR3 is writable */
+	save_flags(flags);
 	cli();
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, ccr3 ^ 0x80);
@@ -1272,7 +1286,7 @@ static inline void do_cyrix_devid(unsign
 		*dir0 = getCx86(CX86_DIR0);
 		*dir1 = getCx86(CX86_DIR1);
 	}
-	sti();
+	restore_flags(flags);
 }
 
 /*
@@ -1316,7 +1330,9 @@ static void __init check_cx686_slop(stru
 {
 	if (Cx86_dir0_msb == 3) {
 		unsigned char ccr3, ccr5;
+		unsigned long flags;
 
+		save_flags(flags);
 		cli();
 		ccr3 = getCx86(CX86_CCR3);
 		setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
@@ -1324,7 +1340,7 @@ static void __init check_cx686_slop(stru
 		if (ccr5 & 2)
 			setCx86(CX86_CCR5, ccr5 & 0xfd);  /* reset SLOP */
 		setCx86(CX86_CCR3, ccr3);                 /* disable MAPEN */
-		sti();
+		restore_flags(flags);
 
 		if (ccr5 & 2) { /* possible wrong calibration done */
 			printk(KERN_INFO "Recalibrating delay loop with SLOP bit reset\n");
@@ -2092,15 +2108,17 @@ static int __init id_and_try_enable_cpui
    	        if (dir0 == 5 || dir0 == 3)
    	        {
 			unsigned char ccr3, ccr4;
+			unsigned long flags;
 
 			printk(KERN_INFO "Enabling CPUID on Cyrix processor.\n");
+			save_flags(flags);
 			cli();
 			ccr3 = getCx86(CX86_CCR3);
 			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
 			ccr4 = getCx86(CX86_CCR4);
 			setCx86(CX86_CCR4, ccr4 | 0x80);          /* enable cpuid  */
 			setCx86(CX86_CCR3, ccr3);                 /* disable MAPEN */
-			sti();
+			restore_flags(flags);
 		}
 	} else
