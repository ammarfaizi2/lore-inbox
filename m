Return-Path: <linux-kernel-owner+w=401wt.eu-S1751521AbXAPRMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbXAPRMk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbXAPRMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:12:40 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:11116 "HELO pxy2nd.nifty.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751528AbXAPRMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:12:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=mbf.nifty.com;
  b=o1xehat/UriMEelXgbp/C7uz6sWNMbURpi6bHciV5cVNxyxXV2PBs1ZG9bMVUF0esnmPW080N+Sbzt54U/Ulaw==  ;
Date: Wed, 17 Jan 2007 02:12:42 +0900 (JST)
Message-Id: <20070117.021242.227424452.takada@mbf.nifty.com>
To: lsorense@csclub.uwaterloo.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: fix typo in geode_configre()@cyrix.c
From: takada <takada@mbf.nifty.com>
In-Reply-To: <20070116165007.GZ17267@csclub.uwaterloo.ca>
References: <20070109173348.GF17269@csclub.uwaterloo.ca>
	<20070117.013835.51856830.takada@mbf.nifty.com>
	<20070116165007.GZ17267@csclub.uwaterloo.ca>
X-Mailer: Mew version 5.1 on Emacs 22.0.92 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: fix typo in geode_configre()@cyrix.c
Date: Tue, 16 Jan 2007 11:50:07 -0500

> On Wed, Jan 17, 2007 at 01:38:35AM +0900, takada wrote:
> > You are right. I agree to your comment. These variables are needless.
> > I made a patch again.
> 
> Of course there are also lots of "magic numbers" around, but I must
> admit I don't personally really feel like going through the data sheet
> and naming all of them.

Me too.

> 
> > diff -Narup linux-2.6.19.orig/arch/i386/kernel/cpu/cyrix.c linux-2.6.19/arch/i386/kernel/cpu/cyrix.c
> > --- linux-2.6.19.orig/arch/i386/kernel/cpu/cyrix.c	2006-11-30 06:57:37.000000000 +0900
> > +++ linux-2.6.19/arch/i386/kernel/cpu/cyrix.c	2007-01-16 19:55:05.000000000 +0900
> > @@ -161,19 +161,15 @@ static void __cpuinit set_cx86_inc(void)
> >  static void __cpuinit geode_configure(void)
> >  {
> >  	unsigned long flags;
> > -	u8 ccr3, ccr4;
> >  	local_irq_save(flags);
> >  
> >  	/* Suspend on halt power saving and enable #SUSP pin */
> >  	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
> >  
> > -	ccr3 = getCx86(CX86_CCR3);
> > -	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* Enable */
> > +	setCx86(CX86_CCR3, (getCx86(CX86_CCR3) & 0x0f) | 0x10);	/* Enable */
> >  	
> > -	ccr4 = getCx86(CX86_CCR4);
> > -	ccr4 |= 0x38;		/* FPU fast, DTE cache, Mem bypass */
> > -	
> > -	setCx86(CX86_CCR3, ccr3);
> > +	/* FPU fast, DTE cache, Mem bypass */
> > +	setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x30);
> 	
> Why did that change from 0x38 to 0x30?

ah... I made mistake. My eye is tired.
Correctry, 0x38.

> 
> >  	set_cx86_memwb();
> >  	set_cx86_reorder();	
> > @@ -415,15 +411,14 @@ static void __cpuinit cyrix_identify(str
> >  		
> >     	        if (dir0 == 5 || dir0 == 3)
> >     	        {
> > -			unsigned char ccr3, ccr4;
> > +			unsigned char ccr3;
> >  			unsigned long flags;
> >  			printk(KERN_INFO "Enabling CPUID on Cyrix processor.\n");
> >  			local_irq_save(flags);
> >  			ccr3 = getCx86(CX86_CCR3);
> > -			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
> > -			ccr4 = getCx86(CX86_CCR4);
> > -			setCx86(CX86_CCR4, ccr4 | 0x80);          /* enable cpuid  */
> > -			setCx86(CX86_CCR3, ccr3);                 /* disable MAPEN */
> > +			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);      /* enable MAPEN  */
> > +			setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x80); /* enable cpuid  */
> > +			setCx86(CX86_CCR3, ccr3);                      /* disable MAPEN */
> >  			local_irq_restore(flags);
> >  		}
> >  	}
> 
> --
> Len Sorensen
> 
