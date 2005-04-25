Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVDYVQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVDYVQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVDYVPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:15:01 -0400
Received: from vanguard.topspin.com ([12.162.17.52]:6151 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261201AbVDYVMn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:12:43 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: timur.tabi@ammasso.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com> <20050425135401.65376ce0.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 25 Apr 2005 14:12:40 -0700
In-Reply-To: <20050425135401.65376ce0.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 25 Apr 2005 13:54:01 -0700")
Message-ID: <521x8yv9vb.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Apr 2005 21:12:40.0964 (UTC) FILETIME=[83E86C40:01C549DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> Do we care about that?  A straightforward scenario under
    Andrew> which this can happen is:

    Andrew> a) app starts some read I/O in an asynchronous manner
    Andrew> b) app forks
    Andrew> c) child writes to one of the pages which is still under read I/O
    Andrew> d) the read I/O completes
    Andrew> e) the child is left with the old data plus the child's modification instead
    Andrew>    of the new data

    Andrew> which is a very silly application which is giving itself
    Andrew> unpredictable memory contents anyway.

    Andrew> I assume there's a more sensible scenario?

You're right, that is a silly scenario ;)  In fact if we mark vmas
with VM_DONTCOPY, then the child just crashes with a seg fault.

The type of thing I'm worried about is something like, for example:

a) app registers memory region with RDMA hardware -- in other words,
   loads the device's translation table for future I/O
b) app forks
c) app writes to the registered memory region, and the kernel breaks
   the COW for the (now read-only) page by mapping a new page
d) app starts an I/O that will do a DMA read from the region
e) device reads using the wrong, old mapping

This can be pretty insiduous because for example fork() + immediate
exec() or just using system() still leaves the parent with PTEs marked
read-only.  If an application does overlapping memory registrations so
get_user_pages() is called a lot, then as far as I can see
can_share_swap_page() will always return 0 and the COW will happen
even if the child process has thrown out its original vmas.

Or if the counts are in the correct range, then there's a small window
between fork() and exec() where the parent process can screw itself
up, so most of the time the app works, until it doesn't.

 - R.
