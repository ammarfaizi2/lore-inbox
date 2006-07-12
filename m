Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWGLWr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWGLWr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWGLWr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:47:26 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:25557
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S932368AbWGLWr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:47:26 -0400
Date: Thu, 13 Jul 2006 00:48:14 +0200
From: andrea@cpushare.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       andrea <andrea@cpushare.com>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060712224814.GD24367@opteron.random>
References: <200607121739_MC3-1-C4D3-28B9@compuserve.com> <Pine.LNX.4.64.0607121453230.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607121453230.5623@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 12 Jul 2006, Chuck Ebbert wrote:
> >
> > We can just fold the TSC disable stuff into the new thread_flags test
> > at context-switch time:

Great idea Chunk! We already use them in the syscall, it sounds a
perfect fit ;).

On Wed, Jul 12, 2006 at 02:55:38PM -0700, Linus Torvalds wrote:
> 
> I really think that this should be cleaned up to _not_ confuse the issue 
> of TSC with any "secure computing" issue.
> 
> The two have nothing to do with each other from a technical standpoint. 
> 
> Just make the flag be called "TIF_NOTSC", and then any random usage 
> (whether it be seccomp or anything else) can just set that flag, the same 
> way ioperm() sets TIF_IO_BITMAP.
> 
> Much cleaner. 
> 
> There's no point in mixing up an implementation detail like SECCOMP with a 
> feature like this.

The only single advantage I can see in remaining purely in function of
seccomp instead of going in function of _TIF_NOTSC, is that the below
block would be completely optimized away at compile time when
CONFIG_SECCOMP is set to N. This now become a slow-path, but then I'm
unsure if the anti-seccomp advocates can live with this block in the
slow path given that seccomp will be the only user of the feature. I
suspect they won't like it but then I could be wrong.

I like it either ways.

	/*
	 * Context switch may need to tweak the TSC disable bit in CR4.
	 * The optimizer should remove this code when !CONFIG_SECCOMP.
	 */
	if (has_secure_computing(task_thread_info(prev_p)) ^
	    has_secure_computing(task_thread_info(next_p))) {
		/* prev and next are different */
		if (has_secure_computing(task_thread_info(next_p)))
			write_cr4(read_cr4() | X86_CR4_TSD);
		else
			write_cr4(read_cr4() & ~X86_CR4_TSD);
	}
