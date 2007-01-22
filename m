Return-Path: <linux-kernel-owner+w=401wt.eu-S1751950AbXAVQYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbXAVQYh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 11:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbXAVQYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 11:24:37 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:4881 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbXAVQYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 11:24:36 -0500
Date: Mon, 22 Jan 2007 11:24:06 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] select: fix sys_select to not leak ERESTARTNOHAND to userspace
Message-ID: <20070122162406.GC21059@hmsreliant.homelinux.net>
References: <20070116201332.GA28523@hmsreliant.homelinux.net> <20070122145956.4a68762d@localhost> <20070122145259.GB21059@hmsreliant.homelinux.net> <Pine.LNX.4.64.0701220758120.32200@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701220758120.32200@woody.linux-foundation.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2007 at 08:03:53AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 22 Jan 2007, Neil Horman wrote:
> 
> > On Mon, Jan 22, 2007 at 02:59:56PM +0100, Paolo Ornati wrote:
> > > 
> > > the ERESTARTNOHAND thing is handled in arch specific signal code,
> > 
> > In the signal handling path yes.
> 
> Right.
> 
> > Not always in the case of select, though.  Check core_sys_select:
> 
> No, even in the case of select().
> 
> > if (!ret) {
> >                 ret = -ERESTARTNOHAND;
> >                 if (signal_pending(current))
> >                         goto out;
> >                 ret = 0;
> 
> Since we have "signal_pending(current)" being true, we _know_ that the 
> signal handling path will be triggered, so the ERESTARTNOHAND will be 
> changed into the appropriate error return (or restart) by the signal 
> handling code.
> 
> > Its possible for core_sys_select to return ERESTARTNOHAND to sys_select, which
> > will in turn (as its currently written), return that value back to user space.
> 
> No. Exactly because sys_select() will always return through the system 
> call handling path, and that will turn the ERESTARTNOHAND into something 
> else.
> 
> NOTE! If you use "ptrace()", you may see the internal errors. But that's a 
> ptrace-only thing, and may have fooled you into thinking that the actual 
> _application_ sees those internal errors. It won't.
> 
> Of course, we could have some signal-handling bug here, but if so, it 
> would affect a lot more than just select(). Have you actually seen 
> ERESTARTNOINTR in the app (not just ptrace?)
> 
The error was reported to me second hand.  I'm expecting a reproducer (although
to date, I'm still waiting for it, so I may have jumped the gun here).  In fact,
I see what your saying now, down in the assembly glue for our arches (x86 in
this case) we jump to do_notify_resume since we have a pending signal, and
inside do_signal from there we fix up ERESTARTNOHAND to be something sane for
userspace.  Ok, I withdraw this patch.  I'll repost when/if I get my hands on
the reproducer and see that something is actually slipping through.

Neil

> 		Linus
