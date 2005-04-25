Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVDYWQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVDYWQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVDYWQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:16:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:26815 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261246AbVDYWPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:15:44 -0400
Date: Mon, 25 Apr 2005 15:14:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: timur.tabi@ammasso.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050425151459.1f5fb378.akpm@osdl.org>
In-Reply-To: <521x8yv9vb.fsf@topspin.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
	<5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
	<52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org>
	<4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org>
	<4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org>
	<426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com>
	<20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
>     Andrew> Do we care about that?  A straightforward scenario under
>     Andrew> which this can happen is:
> 
>     Andrew> a) app starts some read I/O in an asynchronous manner
>     Andrew> b) app forks
>     Andrew> c) child writes to one of the pages which is still under read I/O
>     Andrew> d) the read I/O completes
>     Andrew> e) the child is left with the old data plus the child's modification instead
>     Andrew>    of the new data
> 
>     Andrew> which is a very silly application which is giving itself
>     Andrew> unpredictable memory contents anyway.
> 
>     Andrew> I assume there's a more sensible scenario?
> 
> You're right, that is a silly scenario ;)  In fact if we mark vmas
> with VM_DONTCOPY, then the child just crashes with a seg fault.
> 
> The type of thing I'm worried about is something like, for example:
> 
> a) app registers memory region with RDMA hardware -- in other words,
>    loads the device's translation table for future I/O

Whoa, hang on.

The way we expect get_user_pages() to be used is that the kernel will use
get_user_pages() once per application I/O request.

Are you saying that RDMA clients will semi-permanently own pages which were
pinned by get_user_pages()?  That those pages will be used for multiple
separate I/O operations?

If so, then that's a significant design departure and it would be good to
hear why it is necessary.

> b) app forks
> c) app writes to the registered memory region, and the kernel breaks
>    the COW for the (now read-only) page by mapping a new page
> d) app starts an I/O that will do a DMA read from the region
> e) device reads using the wrong, old mapping

Sure.  But such an app could be declared to be buggy...

> This can be pretty insiduous because for example fork() + immediate
> exec() or just using system() still leaves the parent with PTEs marked
> read-only.  If an application does overlapping memory registrations so
> get_user_pages() is called a lot, then as far as I can see
> can_share_swap_page() will always return 0 and the COW will happen
> even if the child process has thrown out its original vmas.
> 
> Or if the counts are in the correct range, then there's a small window
> between fork() and exec() where the parent process can screw itself
> up, so most of the time the app works, until it doesn't.
> 
>  - R.
