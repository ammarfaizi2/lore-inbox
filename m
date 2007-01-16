Return-Path: <linux-kernel-owner+w=401wt.eu-S1751294AbXAPQid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXAPQid (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbXAPQid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:38:33 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:63741 "HELO pxy2nd.nifty.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751294AbXAPQic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:38:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=mbf.nifty.com;
  b=B/H0OZgJXsmi69s0IWApiYTVngsbcUTI1Lob0+6ZN27PzYCudGcZSPMw1G/dstQ6kgqZ27yoW9GgomgEQSjoXQ==  ;
Date: Wed, 17 Jan 2007 01:38:35 +0900 (JST)
Message-Id: <20070117.013835.51856830.takada@mbf.nifty.com>
To: lsorense@csclub.uwaterloo.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: fix typo in geode_configre()@cyrix.c
From: takada <takada@mbf.nifty.com>
In-Reply-To: <20070109173348.GF17269@csclub.uwaterloo.ca>
References: <20070109.184156.260789378.takada@mbf.nifty.com>
	<20070109173348.GF17269@csclub.uwaterloo.ca>
X-Mailer: Mew version 5.1 on Emacs 22.0.92 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: fix typo in geode_configre()@cyrix.c
Date: Tue, 9 Jan 2007 12:33:48 -0500

Thank you for comments.

> On Tue, Jan 09, 2007 at 06:41:56PM +0900, takada wrote:
> > In kernel 2.6, write back wrong register when configure Geode processor.
> > Instead of storing to CCR4, it stores to CCR3.
> > 
> > --- linux-2.6.19/arch/i386/kernel/cpu/cyrix.c.orig	2007-01-09 16:45:21.000000000 +0900
> > +++ linux-2.6.19/arch/i386/kernel/cpu/cyrix.c	2007-01-09 17:10:13.000000000 +0900
> > @@ -173,7 +173,7 @@ static void __cpuinit geode_configure(vo
> >  	ccr4 = getCx86(CX86_CCR4);
> >  	ccr4 |= 0x38;		/* FPU fast, DTE cache, Mem bypass */
> >  	
> > -	setCx86(CX86_CCR3, ccr3);
> > +	setCx86(CX86_CCR4, ccr4);
> >  	
> >  	set_cx86_memwb();
> >  	set_cx86_reorder();	
> > -
> 
> One more comment on this:
> 
> Why is this function using 3 different styles to do the same thing to 3
> different registers?
> 
> First it does CCR2 by doing:
> setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
> 
> Nice, no temp values, and it is obvious this is a permanent change.
> 
> Then for the next one it does:
> ccr3 = GetCx86(CX86_CCR3);
> setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);
> 
> Couldn't that have been:
> setCx86(CX86_CCR3, (getCx86(CX86_CCR3) & 0x0f) | 0x10);
> 
> No temp variable, and again it clearly does not intend to restore the
> value again later (even though the bug actually did cause the value to
> be restored by accident).
> 
> Then the last case does:
> ccr4 = GetCx86(CX86_CCR4);
> ccr4 |= 0x38;
> setCx86(CX86_CCR4, ccr4); (after fixing the typo you found of course).
> 
> Why did this one have to modify the variable first before using it?
> Maybe the ccr3 and ccr4 cases would have made the line too long and
> needed wrapping, but at least those two cases should be done the same
> way.  It makes it look like it was written by 3 different people who
> didn't look at the lines around the changes they were making.

You are right. I agree to your comment. These variables are needless.
I made a patch again.

diff -Narup linux-2.6.19.orig/arch/i386/kernel/cpu/cyrix.c linux-2.6.19/arch/i386/kernel/cpu/cyrix.c
--- linux-2.6.19.orig/arch/i386/kernel/cpu/cyrix.c	2006-11-30 06:57:37.000000000 +0900
+++ linux-2.6.19/arch/i386/kernel/cpu/cyrix.c	2007-01-16 19:55:05.000000000 +0900
@@ -161,19 +161,15 @@ static void __cpuinit set_cx86_inc(void)
 static void __cpuinit geode_configure(void)
 {
 	unsigned long flags;
-	u8 ccr3, ccr4;
 	local_irq_save(flags);
 
 	/* Suspend on halt power saving and enable #SUSP pin */
 	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
 
-	ccr3 = getCx86(CX86_CCR3);
-	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* Enable */
+	setCx86(CX86_CCR3, (getCx86(CX86_CCR3) & 0x0f) | 0x10);	/* Enable */
 	
-	ccr4 = getCx86(CX86_CCR4);
-	ccr4 |= 0x38;		/* FPU fast, DTE cache, Mem bypass */
-	
-	setCx86(CX86_CCR3, ccr3);
+	/* FPU fast, DTE cache, Mem bypass */
+	setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x30);
 	
 	set_cx86_memwb();
 	set_cx86_reorder();	
@@ -415,15 +411,14 @@ static void __cpuinit cyrix_identify(str
 		
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



> 
> --
> Len Sorensen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
