Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129417AbRBBUqK>; Fri, 2 Feb 2001 15:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129261AbRBBUqB>; Fri, 2 Feb 2001 15:46:01 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:48549 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129713AbRBBUpq>; Fri, 2 Feb 2001 15:45:46 -0500
Date: Fri, 2 Feb 2001 15:45:08 -0500 (EST)
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [Kiobuf-io-devel] Re: 1st glance at kiobuf overhead in kernel
 aio vs pread vs user aio
In-Reply-To: <Pine.LNX.4.30.0102022101120.6394-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0102021523430.5491-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ingo,

On Fri, 2 Feb 2001, Ingo Molnar wrote:

> - first of all, great patch! I've got a conceptual question: exactly how
> does the AIO code prevent filesystem-related scheduling in the issuing
> process' context? I'd like to use (and test) your AIO code for TUX, but i
> do not see where it's guaranteed that the process that does the aio does
> not block - from the patch this is not yet clear to me. (Right now TUX
> uses separate 'async IO' kernel threads to avoid this problem.) Or if it's
> not yet possible, what are the plans to handle this?

Thanks!  Right now the code does the page cache lookup allocations and
lookups in the caller's thread, the write path then attempts to lock all
pages sequentially during io using the async page locking function
wtd_lock_page.  I've tried to get this close to some of the ideas proposed
by Jeff Merkey, and have implemented async page and buffer locking
mechanisms so far.  The down in the write path is still synchronous,
mostly because I want some feedback before going much further down this
path.  The read path verifies the up2date state of individual pages, and
if it encounters one which is not, then it queues the request for the
worker thread which calls readpage on all the pages that need updating.

> - another conceptual question. async IO doesnt have much use if many files
> are used and open() is synchronous. (which it is right now) Thus for TUX
> i've added ATOMICLOOKUP to the VFS - and 'missed' (ie. not yet
> dentry-cached) VFS lookups are passed to the async IO threads as well. Do
> you have any plans to add file-open() as an integral part of the async IO
> framework as well?

I hadn't thought of that, but I don't think it would be too hard to
implement.  We need to decide the degree to which state machine based code
should be used within the kernel.  For many things it can potentially have
a lower overhead than existing kernel code simply because the stack usage
is much flatter.

> once these issues are solved (or are they already?), i'd love to drop the
> ad-hoc kernel-thread based async IO implementation of TUX and 'use the
> real thing'. (which will also probably perform better) [Btw., context
> switches are not that much of an issue in kernel-space, due to lazy TLB
> switching. So basically in kernel-space the async IO threads are barely
> more than a function call.]

;-)  I still want to get the network glue done to merge with the zerocopy
patches as buffer management for things like large LDAP servers isn't
going to work that well with the close-to-posix aio_read.  Of course, this
depends on the aio sendfile code that's coming...

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
