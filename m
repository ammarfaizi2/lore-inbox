Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTJDKNo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 06:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbTJDKNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 06:13:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19473 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261973AbTJDKNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 06:13:42 -0400
Date: Sat, 4 Oct 2003 11:13:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Andi Kleen <ak@muc.de>, Joe Korty <joe.korty@ccur.com>,
       linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
Message-ID: <20031004111336.C18928@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Oeser <ioe-lkml@rameria.de>, Andi Kleen <ak@muc.de>,
	Joe Korty <joe.korty@ccur.com>, linux-kernel@vger.kernel.org
References: <CFYv.787.23@gated-at.bofh.it> <20031004091703.GB23306@colin2.muc.de> <20031004102221.A18928@flint.arm.linux.org.uk> <200310041202.08742.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200310041202.08742.ioe-lkml@rameria.de>; from ioe-lkml@rameria.de on Sat, Oct 04, 2003 at 12:02:08PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 12:02:08PM +0200, Ingo Oeser wrote:
> On Saturday 04 October 2003 11:22, you wrote:
> > On Sat, Oct 04, 2003 at 11:17:03AM +0200, Andi Kleen wrote:
> > > > This check is only done, if it is a valid pfn (pfn_valid()) of a
> > > > present pte.
> > >
> > > pfn_valid is useless, it doesn't handle all IO holes on x86 for examples.
> >
> > Sounds like pfn_valid() is buggy on x86.  It's supposed to definitively
> > indicate whether the PFN is a valid page of ram (and has a valid struct
> > page entry.)  If it doesn't do that, the architecture implementation is
> > wrong.
> 
> Looks like it. But it also has to be fast (see include/asm-i386/mmzone.h) 
> and doesn't even hide the holes in NUMA machines. 

It has to be correct.  We do the following in a hell of a lot of places:

	pfn = pte_pfn(pte);
	if (pfn_valid(pfn)) {
		struct page *page = pfn_to_page(pfn);
		/* do something with page */
	}

basically this type of thing happens in any of the PTE manipulation
functions (eg, copy_page_range, zap_pte_range, etc.)

If pfn_valid is returning false positives, and you happen to mmap() an
area which gives false positives from a user space application, your
kernel will either oops or will corrupt RAM when that application exits.

I believe the comment in mmzone.h therefore is an opinion, and indicates
a concern for performance rather than correctness and stability.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
