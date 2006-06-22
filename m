Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWFVVk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWFVVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWFVVkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:40:55 -0400
Received: from 1wt.eu ([62.212.114.60]:14345 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932652AbWFVVkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:40:55 -0400
Date: Thu, 22 Jun 2006 23:33:13 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: marcelo@kvack.org, linux-kernel@vger.kernel.org, pageexec@freemail.hu
Subject: Re: [PATCH] x86_64: another fix for canonical RIPs during signal handling
Message-ID: <20060622213313.GA22611@1wt.eu>
References: <20060622210657.GA1221@1wt.eu> <200606222326.22133.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606222326.22133.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 11:26:22PM +0200, Andi Kleen wrote:
> On Thursday 22 June 2006 23:06, Willy Tarreau wrote:
> > 
> > I've been reported by the PaX Team that the following fix left a
> > small hole :
> > 
> > [PATCH] Always check that RIPs are canonical during signal handling
> > 
> > +	if (regs->rip >= TASK_SIZE && regs->rip < VSYSCALL_START) {
> > +		regs->rip = 0;
> > +		return -EFAULT;
> > +	}
> > 
> > ...
> > 
> > +	if (regs->rip >= TASK_SIZE) {
> > +		if (sig == SIGSEGV)
> > +			ka->sa.sa_handler = SIG_DFL;
> > +		regs->rip = 0;
> > +	}
> > 
> > "the wrong part is regs->rip=0, i guess the intention was to cause a
> >  SIGSEGV upon returning to userland, but 0 is a valid userland address,
> >  an application may very well have something mapped there. the correct
> >  value would be ~0UL as it's guaranteed to fault on linux."
> > 
> > This explanation makes sense, so here's the patch. Andi, would you please
> > review and confirm ? Thanks in advance.
> 
> I don't think it's a real problem.
> 
> The patch is not wrong, but also doesn't fix something that needs
> to be fixed.

What I understand from this is if code is mapped at 0 (eg by mmap(PROT_EXEC)),
it would get executed instead of the program being killed. Although I don't
see how this could be exploited to gain any privileges, I wonder if it can
cause a process to loop indefinitely instead of being killed or nasty things
like this. May be this is a stupid analysis from me, so I hope that PaX Team
will have more precise info.

> -Andi

Regards,
Willy

