Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319334AbSIFSzE>; Fri, 6 Sep 2002 14:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319336AbSIFSzE>; Fri, 6 Sep 2002 14:55:04 -0400
Received: from packet.digeo.com ([12.110.80.53]:27374 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319334AbSIFSyH>;
	Fri, 6 Sep 2002 14:54:07 -0400
Message-ID: <3D78FAD6.269EF2FB@digeo.com>
Date: Fri, 06 Sep 2002 11:58:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Larson <plars@austin.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: 0-order allocation failures in LTP run of Last nights bk tree
References: <1031322426.30394.4.camel@plars.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Sep 2002 18:58:38.0553 (UTC) FILETIME=[68DE6490:01C255D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> 
> In the nightly ltp run against the bk 2.5 tree last night I saw this
> show up in the logs.
> 
> It happened on the 2-way PIII-550, 2gb physical ram, but not on the
> smaller UP box I test on.
> 
> mtest01: page allocation failure. order:0, mode:0x50

scsi, I assume?

This will be failed bounce buffer allocation attempts.

That's fine, normal.  block will fall back to the mempool
and will wait.

Of course, your shouldn't be bounce buffering at all.  This
is happening because of the block-highmem problem.  There's
a workaround at 
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.33/2.5.33-mm4/broken-out/scsi_hack.patch

But please bear in mind, this "page allocation failure" message
is purely a developer diagnostic thing.  The reason it is there
is so that if some random toaster driver oopses over a failure
to handle an allocation failure, the person who reports the bug
can say "I saw an allocation failure and then your driver crashed".
Which tells the driver developer where to look.

Under heavy load, page allocation attempts _will_ fail, and
that's OK.  The mempool-backed memory will become available.

It's a bit CPU-inefficient, and I have code under test which
changes GFP_NOFS mempool allocators to not even bother trying
to enter page reclaim if the nonblocking allocation attempt
failed.
