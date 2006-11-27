Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758543AbWK0T41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543AbWK0T41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758544AbWK0T41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:56:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:30279 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1758543AbWK0T4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:56:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pVACEpfNOMCbXlf8A5CTOQm/t2aVGSM2sva5r+6EZ/hVt8tpfC7Q4rozl3wwrKPDQiqElg5S5PLZSty/yZPJqvxHEBeIErOEduukciHHFOF0dTzn2FZKOMRfDg5+OmLMggOVgPHbHN1e8iqijPASCU+dNKHN7C0vR/OnjOuYW3U=
Date: Mon, 27 Nov 2006 22:56:16 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kyle McMartin <kyle@parisc-linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Build breakage ...
Message-ID: <20061127195616.GA5038@martell.zuzino.mipt.ru>
References: <20061126224928.GA22285@linux-mips.org> <Pine.LNX.4.64.0611261459010.3483@woody.osdl.org> <Pine.LNX.4.64.0611261509330.3483@woody.osdl.org> <20061126232128.GC30767@flint.arm.linux.org.uk> <Pine.LNX.4.64.0611261627260.30076@woody.osdl.org> <20061127164332.GA26389@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127164332.GA26389@linux-mips.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 04:43:32PM +0000, Ralf Baechle wrote:
> On Sun, Nov 26, 2006 at 04:29:00PM -0800, Linus Torvalds wrote:
> > > > Ralf, Russell, does this work for you guys?
> > >
> > > Not at all.  It creates even more problems for me, with this circular
> > > dependency:
> >
> > Ok. I just reverted it then.
> >
> > Pls verify that this is all good, and I didn't mess anything up due to the
> > manual conflict resolution.
>
> Thanks, 2ea5814472c3c910aed5c5b60f1f3b1000e353f1 builds again for MIPS.
>
> If you deciede to put the patch back in after 2.6.19 I'm considering to
> replace the local_irq_{save,restore} calls in the various atomic operations
> in <asm/{atomic,bitops,system}.h with their raw_* equivalents.
>
> What I dislike about Alexey's patch is that is finally tries to cast
> unsigned long as the data type for the flags into stone.  The natural
> data type to use on MIPS and several other architectures is a 32-bit
> integer - or just a single bit on a stingy day ;-).  Time for flags_t
> maybe?

Hey, I've even posted RFC about that! IMO, flags_t is way too generic.

I can do

1) typedef unsigned long __bitwise__ irq_flags_t;
2) very core locking functions switched to irq_flags_t +
   additional small patch to keep level of compiler warnings the same
2) conversion to irq_flags_t: can be done slowly, only sparse sees new
   warnigns
3) irq_flags_t forked and became arch specific type
4) arch maintatiners choose better than "unsigned long" type if they want

