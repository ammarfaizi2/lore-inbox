Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTBJEvS>; Sun, 9 Feb 2003 23:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTBJEvR>; Sun, 9 Feb 2003 23:51:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:25298 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261660AbTBJEvP>;
	Sun, 9 Feb 2003 23:51:15 -0500
Date: Sun, 9 Feb 2003 21:01:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: david.lang@digitalinsight.com, riel@conectiva.com.br, andrea@suse.de,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
Message-Id: <20030209210105.00f4e4b5.akpm@digeo.com>
In-Reply-To: <20030210045107.GD1109@unthought.net>
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>
	<Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
	<20030209203343.06608eb3.akpm@digeo.com>
	<20030210045107.GD1109@unthought.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 05:00:53.0688 (UTC) FILETIME=[63876B80:01C2D0C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard <jakob@unthought.net> wrote:
>
> On Sun, Feb 09, 2003 at 08:33:43PM -0800, Andrew Morton wrote:
> > David Lang <david.lang@digitalinsight.com> wrote:
> > >
> > > note that issuing a fsync should change all pending writes to 'syncronous'
> > > as should writes to any partition mounted with the sync option, or writes
> > > to a directory with the S flag set.
> > 
> > We know, at I/O submission time, whether a write is to be waited upon. 
> > That's in writeback_control.sync_mode.
> > 
> > That, combined with an assumption that "all reads are synchronous" would
> > allow the outgoing BIOs to be appropriately tagged.
> 
> This may be a terribly stupid question, if so pls. just tell me  :)
> 
> I assume read-ahead requests go elsewhere?  Or do we assume that someone
> is waiting for them as well?

Yes, they are treated the same.  If any part of the request is to be waited
upon then the whole request should be treated as synchronous.

And if no part of a readahead request is waited upon, we should never have
submited it anyway.

> If we assume they are synchronous, that would be rather unfair
> especially on multi-user systems - and the 90% accuracy that Rik
> suggested would seem exaggerated to say the least (accuracy would be
> more like 10% on a good day).

The simplified assumption that "reads are waited upon and writes are not" is
highly accurate.

I want to see the Linux I/O scheduler work as well as possible with workloads
which make that assumption 100% true.  Once we have done that, then we can
start worrying about corner cases like AIO, O_SYNC, truncate, etc.


