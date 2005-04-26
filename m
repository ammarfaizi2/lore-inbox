Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVDZD4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVDZD4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 23:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVDZD4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 23:56:00 -0400
Received: from groover.houseafrikarecords.com ([12.162.17.52]:13225 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261302AbVDZDzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 23:55:20 -0400
Date: Mon, 25 Apr 2005 20:55:12 -0700
From: Libor Michalek <libor@topspin.com>
To: Andrew Morton <akpm@osdl.org>
Cc: timur.tabi@ammasso.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050425205512.B9729@topspin.com>
References: <20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com> <52is2bvvz5.fsf@topspin.com> <20050425135401.65376ce0.akpm@osdl.org> <521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org> <426D6DFA.4090908@ammasso.com> <20050425153542.70197e6a.akpm@osdl.org> <20050425161713.A9002@topspin.com> <20050425162405.0889093e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050425162405.0889093e.akpm@osdl.org>; from akpm@osdl.org on Mon, Apr 25, 2005 at 04:24:05PM -0700
X-OriginalArrivalTime: 26 Apr 2005 03:55:16.0572 (UTC) FILETIME=[C1C5B1C0:01C54A13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 04:24:05PM -0700, Andrew Morton wrote:
> Libor Michalek <libor@topspin.com> wrote:
> > On Mon, Apr 25, 2005 at 03:35:42PM -0700, Andrew Morton wrote:
> >
> > > Yes, we expect that all the pages which get_user_pages() pinned 
> > > will become unpinned within the context of the syscall which pinned
> > > the pages.  Or shortly after, in the case of async I/O.
> > 
> >   When a network protocol is making use of async I/O the amount of time
> > between posting the read request and getting the completion for that
> > request is unbounded since it depends on the other half of the connection
> > sending some data. In this case the buffer that was pinned during the
> > io_submit() may be pinned, and holding the pages, for a long time.
> 
> Sure.
> 
> > During
> > this time the process might fork, at this point any data received will be
> > placed into the wrong spot. 
> 
> Well the data is placed in _a_ spot.  That's only the "wrong" spot because
> you've defined it to be wrong!
> 
> IOW: what behaviour are you actually looking for here, and why, and does it
> matter?

  For example a network server app has an open connection on which it
uses async IO to submit two buffers for a read operation. Both buffers
are pinned using get_user_pages() and the connection waits for data to
arrive. The connection received data, it is written into the first buffer,
the app is notified using async IO, and it retreives the async IO
completion. The app reads the buffer which happens to contain a command
to spawn a child, the app forks a child. Now there is still a buffer
posted for read and if more data arrives on the connection that data is
copied to the pages which were saved when the buffer was pinned. The app
is notified, retrieves the async IO completion, but when it goes to read
that buffer it will not have the new data.
  
> > > This is because there is no file descriptor or anything else associated
> > > with the pages which permits the kernel to clean stuff up on unclean
> > > application exit.  Also there are the obvious issues with permitting
> > > pinning of unbounded amounts of memory.
> > 
> >   Correct, the driver must be able to determine that the process has died
> > and clean up after it, so the pinned region in most implementations is
> > associated with an open file descriptor.
> 
> How is that association created?

  The kernel module which pinned the memory is responsible for unpinning
it if the file descriptor, which was used to deliver the command that
resulted in the pinning, is closed.

-Libor

