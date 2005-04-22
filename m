Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVDVRBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVDVRBo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 13:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVDVRBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 13:01:44 -0400
Received: from host238.infiniconsys.com ([65.219.193.238]:20387 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S262067AbVDVRBl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 13:01:41 -0400
From: "Fab Tillier" <ftillier@infiniconsys.com>
To: "'Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>'" 
	<7eggert@gmx.de>,
       "Andy Isaacson" <adi@hexapodia.org>,
       "Timur Tabi" <timur.tabi@ammasso.com>,
       "Troy Benjegerdes" <hozer@hozed.org>, "Bernhard Fischer" <blist@aon.at>,
       "Arjan van de Ven" <arjan@infradead.org>,
       <linux-kernel@vger.kernel.org>, <openib-general@openib.org>
Subject: RE: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbsimplementation
Date: Fri, 22 Apr 2005 10:01:55 -0700
Message-ID: <000101c5475c$fe3c5fa0$8d5aa8c0@infiniconsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <E1DOxv9-0000pc-Pe@be1.7eggert.dyndns.org>
Importance: Normal
X-OriginalArrivalTime: 22 Apr 2005 17:01:38.0878 (UTC) FILETIME=[F2F73DE0:01C5475C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
> Sent: Friday, April 22, 2005 6:10 AM
> 
> All userspace hardware drivers with DMA will require pinned pages (and
> some of them will require continuous memory). Since this memory may be
> scheduled to be accessed by DMA, reclaiming those pages may (aka. will)
> result in "random" memory corruption unless done by the driver itself.

Any reclaim must involve the driver.  That doesn't mean that it must involve
the application.  That said this isn't trivial to implement.

> 
> You can't even set a time limit, the driver may have allocated all DMA
> memory to queued transfers, and some media needs to get plugged in by
> the lazy robot. As soon as the robot arrives - boom. (For the same reason,
> this memory MUST NOT be freed if the application terminates abnormally,
> e.g. killed by OOM).

InfiniBand provides support for deregistering memory that might be
referenced at some future time by an RDMA operation.  The only side effect
this has is that the QP on both sides of the connection transition to an
error state.

Upon abnormal termination, all registrations must be undone and the memory
unpinned.  This must be synchronized with the hardware so that there are no
races.  The IB deregistration semantics provide such synchronization.  I'd
venture that any HW design that does not do this is broken.

Requiring the memory to never be freed upon abnormal termination equates to
a serious memory leak, in that physical memory is leaked, not virtual.

- Fab

