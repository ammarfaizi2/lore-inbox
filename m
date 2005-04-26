Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVDZVXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVDZVXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 17:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVDZVXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 17:23:41 -0400
Received: from vanguard.topspin.com ([12.162.17.52]:35753 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261795AbVDZVXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 17:23:32 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: libor@topspin.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, timur.tabi@ammasso.com
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com> <20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com> <20050425171145.2f0fd7f8.akpm@osdl.org>
	<52acnmtmh6.fsf@topspin.com> <20050425173757.1dbab90b.akpm@osdl.org>
	<52wtqpsgff.fsf@topspin.com> <20050426084234.A10366@topspin.com>
	<52mzrlsflu.fsf@topspin.com> <20050426122850.44d06fa6.akpm@osdl.org>
	<5264y9s3bs.fsf@topspin.com> <20050426133229.416a5e66.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 26 Apr 2005 14:23:28 -0700
In-Reply-To: <20050426133229.416a5e66.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 26 Apr 2005 13:32:29 -0700")
Message-ID: <521x8xs04v.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Apr 2005 21:23:28.0389 (UTC) FILETIME=[30376350:01C54AA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> Well I was vaguely proposing that the userspace library
    Andrew> keep track of the byteranges and the underlying page
    Andrew> states.  So in the above scenario userspace would leave
    Andrew> the page at 0x1000 registered until all registrations
    Andrew> against that page have been undone.

OK, I already have code in userspace that keeps reference counts for
overlapping regions, etc.  However I'm not sure how to tie this in
with reliable accounting of pinned memory -- we don't want malicious
userspace code to be able fool the accounting, right?

So I'm still trying to puzzle out what to do.  I don't want to keep a
complicated data structure in the kernel keeping track of what memory
has been registered.  Right now, I just keep a list of structs, one
for each region, and when a process dies, I just go through region by
region and do a put_page() to balance off the get_user_pages().

However I don't see how to make it work if I put the reference
counting for overlapping regions in userspace but when I want mlock()
accounting in the kernel.  If a buggy/malicious app does:

    a) register from 0x0000 to 0x2fff
    b) register from 0x1000 to 0x1fff
    c) unregister from 0x0000 to 0x2fff

then it seems the kernel is screwed unless it counts how many times a
vma has been pinned.  And adding a pin_count member to vm_struct seems
like a pretty damn major step.

We definitely have to make sure that userspace is never able to either
unpin a page that is still registered with RDMA hardware, because that
can lead to DMA to into memory that someone else owns.  On the other
hand, we don't want userspace to be able to defeat resource accounting
by tricking the kernel into keeping page_count elevated after it
credits the memory back to a process's limit on locked pages.

The limit on the number of locked pages seems like a natural thing to
check against, but perhaps we need a different limit for the number of
pages pinned for use by RDMA hardware.  Sort of the same way that
there's a separate limit on the number of in-flight aios.

 - R.

