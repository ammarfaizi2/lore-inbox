Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVDZACn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVDZACn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVDZACn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:02:43 -0400
Received: from webmail.houseafrika.com ([12.162.17.52]:20299 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261187AbVDZACl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:02:41 -0400
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
	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 25 Apr 2005 17:02:36 -0700
In-Reply-To: <20050425151459.1f5fb378.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 25 Apr 2005 15:14:59 -0700")
Message-ID: <52r7gytnfn.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Apr 2005 00:02:36.0655 (UTC) FILETIME=[410367F0:01C549F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> Whoa, hang on.

    Andrew> The way we expect get_user_pages() to be used is that the
    Andrew> kernel will use get_user_pages() once per application I/O
    Andrew> request.

    Andrew> Are you saying that RDMA clients will semi-permanently own
    Andrew> pages which were pinned by get_user_pages()?  That those
    Andrew> pages will be used for multiple separate I/O operations?

    Andrew> If so, then that's a significant design departure and it
    Andrew> would be good to hear why it is necessary.

The idea is that applications manage the lifetime of pinned memory
regions.  They can do things like post multiple I/O operations without
any page-walking overhead, or pass a buffer descriptor to a remote
host who will send data at some indeterminate time in the future.  In
addition, InfiniBand has the notion of atomic operations, so a cluster
application may be using some memory region to implement a global lock.

This might not be the most kernel-friendly design but it is pretty
deeply ingrained in the design of RDMA transports like InfiniBand and
iWARP (RDMA over IP).

I'm also not opposed to implementing some other mechanism to make this
work, but the combiniation of get_user_pages() in the kernel and
extending mprotect() to allow setting VM_DONTCOPY seems to work fine.

 - R.
