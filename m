Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVBWSmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVBWSmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 13:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVBWSmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 13:42:14 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41957 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261530AbVBWSlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 13:41:52 -0500
Date: Wed, 23 Feb 2005 12:37:41 -0600
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Joe Korty <joe.korty@ccur.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, arjan@infradead.org
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050223183740.GA12182@austin.ibm.com>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org> <20050223144940.GA880@tsunami.ccur.com> <Pine.LNX.4.58.0502230751140.2378@ppc970.osdl.org> <20050223171015.GD10256@austin.ibm.com> <20050223182203.GA10931@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223182203.GA10931@mail.shareable.org>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 06:22:04PM +0000, Jamie Lokier wrote:
> Olof Johansson wrote:
> > On Wed, Feb 23, 2005 at 07:54:06AM -0800, Linus Torvalds wrote:
> > 
> > > > Otherwise, a preempt attempt in get_user would not be seen
> > > > until some future preempt_enable was executed.
> > > 
> > > True. I guess we should have a "preempt_check_resched()" there too. That's 
> > > what "kunmap_atomic()" does too (which is what we rely on in the other 
> > > case we do this..)
> > 
> > Ok, this is getting complex enough to warrant get_user_inatomic(),
> > which means adding it to every arch's uaccess.h.
> > 
> > Below patch does so. Unfortunately I don't have a Viro setup with cross
> > compilers for nearly every arch, so I can't make sure it doesn't break
> > anything. But since I pasted the same code everywhere it shouldn't.
> 
> My turn to say uglee.

Yeah, I wasn't entirely happy about it, but it seems that suggestions
are coming in on how to do it better. :-)

> Firstly, get_user_inatomic is the wrong name.
> 
> "inatomic" in __copy_from_user_inatomic means it's called inside a
> non-premptable region (in atomic...).
> 
> Your macro get_user_inatomic is _not_ called inside a
> non-preemptable region, so it shouldn't be called "inatomic".
> 
> (A better name is get_user_no_paging).
>
> Secondly, does this _one_ use (it's not likely to be used elsewhere)
> justify copying & pasting the same code into every asm-*/uaccess,
> especially when the code is not in any way arch-specific?

Arjan suggested creating a linux/uaccess.h that includes asm/uaccess.h,
and start moving the users over since that's where the trend is moving
anyway (avoiding including asm/* from common code). futex.c would be
the first user, and could be followed by more later as a janitorial
patch. That'd mean only one addition of the common function instead of
having to add it to every arch.

> I suggest putting it into futex.c, and make it an inline function
> which takes "u32 __user *".

Sure, for now that's good enough. Above janitorial work could be done
later, if more users get introduced.


-Olof
