Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVDYXRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVDYXRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVDYXRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:17:38 -0400
Received: from groover.houseafrikarecords.com ([12.162.17.52]:9017 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261184AbVDYXRR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:17:17 -0400
Date: Mon, 25 Apr 2005 16:17:13 -0700
From: Libor Michalek <libor@topspin.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Timur Tabi <timur.tabi@ammasso.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050425161713.A9002@topspin.com>
References: <20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com> <52is2bvvz5.fsf@topspin.com> <20050425135401.65376ce0.akpm@osdl.org> <521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org> <426D6DFA.4090908@ammasso.com> <20050425153542.70197e6a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050425153542.70197e6a.akpm@osdl.org>; from akpm@osdl.org on Mon, Apr 25, 2005 at 03:35:42PM -0700
X-OriginalArrivalTime: 25 Apr 2005 23:17:15.0590 (UTC) FILETIME=[EB21D660:01C549EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 03:35:42PM -0700, Andrew Morton wrote:
> Timur Tabi <timur.tabi@ammasso.com> wrote:
> >
> > Andrew Morton wrote:
> > 
> > > The way we expect get_user_pages() to be used is that the kernel will use
> > > get_user_pages() once per application I/O request.
> > 
> > Are you saying that the mapping obtained by get_user_pages() is valid only within the 
> > context of the IOCtl call?  That once the driver returns from the IOCtl, the mapping 
> > should no longer be used?
> 
> Yes, we expect that all the pages which get_user_pages() pinned will become
> unpinned within the context of the syscall which pinned the pages.  Or
> shortly after, in the case of async I/O.

  When a network protocol is making use of async I/O the amount of time
between posting the read request and getting the completion for that
request is unbounded since it depends on the other half of the connection
sending some data. In this case the buffer that was pinned during the
io_submit() may be pinned, and holding the pages, for a long time. During
this time the process might fork, at this point any data received will be
placed into the wrong spot. 

> This is because there is no file descriptor or anything else associated
> with the pages which permits the kernel to clean stuff up on unclean
> application exit.  Also there are the obvious issues with permitting
> pinning of unbounded amounts of memory.

  Correct, the driver must be able to determine that the process has died
and clean up after it, so the pinned region in most implementations is
associated with an open file descriptor.

-Libor
