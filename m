Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVDVNLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVDVNLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 09:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVDVNLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 09:11:11 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:22193 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261178AbVDVNLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 09:11:03 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
To: Andy Isaacson <adi@hexapodia.org>, Timur Tabi <timur.tabi@ammasso.com>,
       Troy Benjegerdes <hozer@hozed.org>, Bernhard Fischer <blist@aon.at>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Reply-To: 7eggert@gmx.de
Date: Fri, 22 Apr 2005 15:10:09 +0200
References: <3VAeQ-1To-7@gated-at.bofh.it> <3VNYt-4M4-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DOxv9-0000pc-Pe@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:
> On Wed, Apr 20, 2005 at 10:07:45PM -0500, Timur Tabi wrote:

>> I don't know if VM_REGISTERED is a good idea or not, but it should be
>> absolutely impossible for the kernel to reclaim "registered" (aka pinned)
>> memory, no matter what. For RDMA services (such as Infiniband, iWARP, etc),
>> it's normal for non-root processes to pin hundreds of megabytes of memory,
>> and that memory better be locked to those physical pages until the
>> application deregisters them.
> 
> If you take the hardline position that "the app is the only thing that
> matters", your code is unlikely to get merged.  Linux is a
> general-purpose OS.

All userspace hardware drivers with DMA will require pinned pages (and some
of them will require continuous memory). Since this memory may be scheduled
to be accessed by DMA, reclaiming those pages may (aka. will) result in
"random" memory corruption unless done by the driver itself.

You can't even set a time limit, the driver may have allocated all DMA
memory to queued transfers, and some media needs to get plugged in by
the lazy robot. As soon as the robot arrives - boom. (For the same reason,
this memory MUST NOT be freed if the application terminates abnormally,
e.g. killed by OOM).

In other words, you need to make this memory as unaccessible as the
framebuffer on a graphic card. If that causes a lockup, you better had
prevented that while allocating.

> In a Linux context, I doubt that fullblown SA is necessary or
> appropriate.  Rather, I'd suggest two new signals, SIGMEMLOW and
> SIGMEMCRIT.  The userland comms library registers handlers for both.
> When the kernel decides that it needs to reclaim some memory from the
> app, it sends SIGMEMLOW.  The comms library then has the responsibility
> to un-reserve some memory in an orderly fashion.  If a reasonable [1]
> time has expired since SIGMEMLOW and the kernel is still hungry, the
> kernel sends SIGMEMCRIT.  At this point, the comms lib *must* unregister
> some memory [2] even if it has to drop state to do so; if it returns
> from the signal handler without having unregistered the memory, the
> kernel will SIGKILL.

Choosing Data loss vs. finitely stalled system may sometimes be a bad
decision.

If I designes an application that might get a "gimme memory or die",
I'd reserve an extra bunch of memory with the only purpose of being
released in this situation. If the kernel had done that instead, this
part of memory could have been used e.g. as a read-only disk cache in
the meantime (off cause provided somebody cared to implement that).

> [2] Is there a way for the kernel to pass down to userspace how many
>     pages it wants, maybe in the sigcontext?

Then you'd need only one signal.

I think this interface is usefull, it would e.g. allow a picture viewer
to cache as many decoded and scaled pictures as the RAM permits, freeing
them if the RAM gets full and the swap would have to be used.

-- 
"When the pin is pulled, Mr. Grenade is not our friend.
-U.S. Marine Corps

