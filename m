Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbTCQR2t>; Mon, 17 Mar 2003 12:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbTCQR2t>; Mon, 17 Mar 2003 12:28:49 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63536 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261805AbTCQR2s>; Mon, 17 Mar 2003 12:28:48 -0500
Date: Mon, 17 Mar 2003 12:39:39 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is get_current() not const function?
Message-ID: <20030317123939.H13397@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20030313061926.S3910@devserv.devel.redhat.com.suse.lists.linux.kernel> <b53pqi$ud9$1@penguin.transmeta.com.suse.lists.linux.kernel> <m3u1e1ykeq.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3u1e1ykeq.fsf@averell.firstfloor.org>; from ak@muc.de on Mon, Mar 17, 2003 at 06:26:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 06:26:05PM +0100, Andi Kleen wrote:
> torvalds@transmeta.com (Linus Torvalds) writes:
> 
> >>					 and why on x86-64
> >>the movq %%gs:0, %0 inline asm is volatile with "memory" clobber?
> >
> > Can't help you on that one, but it looks like it uses various helper
> > functions for doing the x86-64 per-processor data structures, and I bet
> > those helper functions are shared by _other_ users who definitely want
> > to have their data properly re-read. Ie "current()" may be constant in
> > process context, but that sure isn't true about a lot of other things in
> > the per-processor data structures.
> 
> Yes, that's the big issue. const current requires non volatile read_pda()
> and making read_pda non volatile breaks lots of code currently and probably
> needs an audit over all users.

Well, that's one that is not particularly hard to fix.
Either a new set of pda access macros without volatile and memory clobber
can be written, or just get_current can use its own asm, ie.
static inline struct task_struct *get_current(void)
{
	struct task_struct *t;
	asm ("movq %%gs:%c1,%0" : "=r" (t) : "i"(pda_offset(pcurrent)));
	return t;
}

	Jakub
