Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129162AbRBBXPo>; Fri, 2 Feb 2001 18:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRBBXPe>; Fri, 2 Feb 2001 18:15:34 -0500
Received: from chiara.elte.hu ([157.181.150.200]:36103 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129162AbRBBXPQ>;
	Fri, 2 Feb 2001 18:15:16 -0500
Date: Sat, 3 Feb 2001 00:14:36 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [Kiobuf-io-devel] Re: 1st glance at kiobuf overhead in kernel
 aio vs pread vs user aio
In-Reply-To: <Pine.LNX.4.30.0102021523430.5491-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.30.0102030001140.8332-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Feb 2001, Benjamin LaHaise wrote:

> Thanks! Right now the code does the page cache lookup allocations and
> lookups in the caller's thread, [...]

(the killer is not the memory allocation(s), if there is enough RAM then
we can get a free page without having to block.)

The real problem is the implicit ->bmap() in readpage(). IMO this is the
tough part in AIO. There can be zillions of sub-IOs generated during
filesystem ->bmap(). Doing the data reads asynchronously is just about 30%
of the work, and as long as there is even a *single* inode-related
blocking point in the synchronous async IO path, the whole scheme remains
useless for practical applications. It does not matter that 90% of the IO
is asynchronous - if we are blocking on the remaining 10% then the whole
operation degrades to synchronous!

To make this work correctly, lowlevel filesystem code must be modified in
nontrivial ways. If this is easy then please give me a quick description
of how this is going to be done.

Plus there is the issue of not blocking in __wait_request() either.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
