Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319758AbSIMTaC>; Fri, 13 Sep 2002 15:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319760AbSIMTaC>; Fri, 13 Sep 2002 15:30:02 -0400
Received: from packet.digeo.com ([12.110.80.53]:64484 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319758AbSIMTaB>;
	Fri, 13 Sep 2002 15:30:01 -0400
Message-ID: <3D823DCC.3E303941@digeo.com>
Date: Fri, 13 Sep 2002 12:34:36 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Suparna Bhattacharya <suparna@in.ibm.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Shailabh Nagar <nagar@watson.ibm.com>, Linux Aio <linux-aio@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 port of aio-20020619 for raw devices
References: <3D80DB14.2040809@watson.ibm.com> <20020912143540.J18217@redhat.com> <20020913184652.C2758@in.ibm.com> <20020913134404.GG935@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 19:34:40.0983 (UTC) FILETIME=[9AAB4670:01C25B5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> ...
> alloc_bio non-blocking can be done by caller himself, submit_bio
> non-blocking can be assured with BIO_RW_AHEAD.

I haven't really found that to be usable - by the time you've
called submit_bio() it's just waaaay too late to back out and
undo everything.  Mark pages dirty again, unlock them, clear the
writeback bits, tell the caller that we really didn't write these
many pages, tell the caller that things aren't working out, stop
sending us pages, etc.

It's made harder by the fact that submit_bio() always returns "1".  So
you need to work out what happened in the bi_end_io() handler and
pass all that back again.  And somehow work out whether it was a failed
WRITEA and not an IO error...

That's why I added the ability to ask "is this mapping's queue congested".
It is much simpler to use and test from the perspective of the upper layers.

It has the disadvantage that we may have some data which is mergeable,
and would in fact nonblockingly fit into a "congested" queue.  Don't
know if that makes a lot of difference in practice.

But there are some more things we can do to improve IO scheduling from the
top layer.  The most prominent of these is to write back the blockdev
mapping's dirty pages in pgoff_t order (ie: LBA order) rather than in
chronological mapping->dirty_pages order.  That's happening, slowly, but
involves significant surgery on radix_tree_brains.
