Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbUL2UFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUL2UFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 15:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUL2UFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 15:05:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:39047 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261417AbUL2UFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 15:05:37 -0500
Date: Wed, 29 Dec 2004 12:04:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesse Allen <the3dfxdude@gmail.com>
cc: Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <53046857041229114077eb4d1d@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <20041119212327.GA8121@nevyn.them.org>  <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
  <20041120214915.GA6100@tesore.ph.cox.net>  <41A251A6.2030205@wanadoo.fr> 
 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>  <1101161953.13273.7.camel@littlegreen>
  <1104286459.7640.54.camel@gamecube.scs.ch>  <1104332559.3393.16.camel@littlegreen>
  <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org> <53046857041229114077eb4d1d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Dec 2004, Jesse Allen wrote:
> 
> > 
> > So does removing the conditional TF clear make everything work again?
> > 
> 
> Yes, as long as TIF_SINGLESTEP is not set in set_singlestep(). 

That may be a clue, if only because that makes absolutely _zero_ sense. 

Setting TIF_SINGLESTEP shouldn't actually matter in this case, since we
set the TRAP_FLAG in eflags by hand anyway (and that's what TIF_SINGESTEP
will just re-do when returning to user space).

What TIF_SINGLESTEP _does_ do, however, is change how some other issues
are reported to user space. In particular, it causes system call tracing
(see arch/i386/kernel/ptrace.c: do_syscall_trace), and maybe it is _that_ 
that messes up Wine.

So instead of removing the setting of TIF_SINGLESTEP in set_singlestep(), 
can you test whether removing the _testing_ of it in do_syscall_trace() 
makes things happier for you? Hmm?

(Also, looking at the code, I get the feeling that set_singlestep() should 
_only_ set TIF_SINGLESTEP, and not set the TRAP_FLAG by hand at all, since 
TIF_SINGESTEP should take care of that detail regardless).

		Linus
