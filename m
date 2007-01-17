Return-Path: <linux-kernel-owner+w=401wt.eu-S932371AbXAQP0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbXAQP0i (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 10:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbXAQP0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 10:26:38 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:4349 "HELO pxy2nd.nifty.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932371AbXAQP0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 10:26:37 -0500
Date: Thu, 18 Jan 2007 00:26:00 +0900 (JST)
Message-Id: <20070118.002600.92591144.takada@mbf.nifty.com>
To: linux-kernel@vger.kernel.org
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       takada <takada@mbf.nifty.com>
Subject: Re: fix typo in geode_configre()@cyrix.c
From: takada <takada@mbf.nifty.com>
References: <20070109.184156.260789378.takada@mbf.nifty.com>
 <20070109173348.GF17269@csclub.uwaterloo.ca>
In-Reply-To: <20070109173348.GF17269@csclub.uwaterloo.ca>
User-Agent: KMail/1.9.4
X-Mailer: Mew version 5.1 on Emacs 22.0.92 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Thanks Sorensen and Juergen.

I overlooked the restored to CCR3.
The bit4(0x10, MAPEN) of CCR3 is necessary to access advanced configuration registers.
I'll repost patch.

  - restore CCR3
  - fix use 0x30 instead of 0x38.

--- linux-2.6.19.orig/arch/i386/kernel/cpu/cyrix.c	2006-11-30 06:57:37.000000000 +0900
+++ linux-2.6.19/arch/i386/kernel/cpu/cyrix.c	2007-01-17 16:15:40.000000000 +0900
@@ -161,19 +161,18 @@ static void __cpuinit set_cx86_inc(void)
 static void __cpuinit geode_configure(void)
 {
 	unsigned long flags;
-	u8 ccr3, ccr4;
+	u8 ccr3;
 	local_irq_save(flags);
 
 	/* Suspend on halt power saving and enable #SUSP pin */
 	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
 
 	ccr3 = getCx86(CX86_CCR3);
-	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* Enable */
+	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* enable  MAPEN */
 	
-	ccr4 = getCx86(CX86_CCR4);
-	ccr4 |= 0x38;		/* FPU fast, DTE cache, Mem bypass */
-	
-	setCx86(CX86_CCR3, ccr3);
+	/* FPU fast, DTE cache, Mem bypass */
+	setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x38);
+	setCx86(CX86_CCR3, ccr3);			/* disable MAPEN */
 	
 	set_cx86_memwb();
 	set_cx86_reorder();	
@@ -415,15 +414,14 @@ static void __cpuinit cyrix_identify(str
 		
    	        if (dir0 == 5 || dir0 == 3)
    	        {
-			unsigned char ccr3, ccr4;
+			unsigned char ccr3;
 			unsigned long flags;
 			printk(KERN_INFO "Enabling CPUID on Cyrix processor.\n");
 			local_irq_save(flags);
 			ccr3 = getCx86(CX86_CCR3);
-			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
-			ccr4 = getCx86(CX86_CCR4);
-			setCx86(CX86_CCR4, ccr4 | 0x80);          /* enable cpuid  */
-			setCx86(CX86_CCR3, ccr3);                 /* disable MAPEN */
+			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);      /* enable MAPEN  */
+			setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x80); /* enable cpuid  */
+			setCx86(CX86_CCR3, ccr3);                      /* disable MAPEN */
 			local_irq_restore(flags);
 		}
 	}
