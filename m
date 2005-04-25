Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVDYXZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVDYXZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVDYXZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:25:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:48600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261209AbVDYXZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:25:09 -0400
Date: Mon, 25 Apr 2005 16:24:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Libor Michalek <libor@topspin.com>
Cc: timur.tabi@ammasso.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
Message-Id: <20050425162405.0889093e.akpm@osdl.org>
In-Reply-To: <20050425161713.A9002@topspin.com>
References: <20050418164316.GA27697@infradead.org>
	<4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org>
	<426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com>
	<20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
	<20050425151459.1f5fb378.akpm@osdl.org>
	<426D6DFA.4090908@ammasso.com>
	<20050425153542.70197e6a.akpm@osdl.org>
	<20050425161713.A9002@topspin.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Libor Michalek <libor@topspin.com> wrote:
>
> On Mon, Apr 25, 2005 at 03:35:42PM -0700, Andrew Morton wrote:
> > Timur Tabi <timur.tabi@ammasso.com> wrote:
> > >
> > > Andrew Morton wrote:
> > > 
> > > > The way we expect get_user_pages() to be used is that the kernel will use
> > > > get_user_pages() once per application I/O request.
> > > 
> > > Are you saying that the mapping obtained by get_user_pages() is valid only within the 
> > > context of the IOCtl call?  That once the driver returns from the IOCtl, the mapping 
> > > should no longer be used?
> > 
> > Yes, we expect that all the pages which get_user_pages() pinned will become
> > unpinned within the context of the syscall which pinned the pages.  Or
> > shortly after, in the case of async I/O.
> 
>   When a network protocol is making use of async I/O the amount of time
> between posting the read request and getting the completion for that
> request is unbounded since it depends on the other half of the connection
> sending some data. In this case the buffer that was pinned during the
> io_submit() may be pinned, and holding the pages, for a long time.

Sure.

> During
> this time the process might fork, at this point any data received will be
> placed into the wrong spot. 

Well the data is placed in _a_ spot.  That's only the "wrong" spot because
you've defined it to be wrong!

IOW: what behaviour are you actually looking for here, and why, and does it
matter?

> > This is because there is no file descriptor or anything else associated
> > with the pages which permits the kernel to clean stuff up on unclean
> > application exit.  Also there are the obvious issues with permitting
> > pinning of unbounded amounts of memory.
> 
>   Correct, the driver must be able to determine that the process has died
> and clean up after it, so the pinned region in most implementations is
> associated with an open file descriptor.

How is that association created?
