Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbSKAL1v>; Fri, 1 Nov 2002 06:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264861AbSKAL1v>; Fri, 1 Nov 2002 06:27:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39605 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262868AbSKAL1t>;
	Fri, 1 Nov 2002 06:27:49 -0500
Date: Fri, 1 Nov 2002 12:34:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, William Lee Irwin III <wli@holomorphy.com>
Subject: rbtree scores (was Re: [patch] deadline-ioscheduler rb-tree sort)
Message-ID: <20021101113401.GE8428@suse.de>
References: <20021031134315.GC6549@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031134315.GC6549@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31 2002, Jens Axboe wrote:
> Hi,
> 
> This is something I whipped together the other day for testing the over
> head of the O(N) insert scan that the deadline io scheduler does. So
> instead of using a plain linked list, I adapted it to use an rb tree
> since that was already available with the generic implementation in the
> kernel.
> 
> Results are quite promising, overhead is down a lot. I'm not pushing
> this for inclusion, just sending it out so others can test etc. Patch is
> against 2.5.45.

I completed a couple of runs of tiobench, and thought I would share a
few notes. The test was a 128 thread tiobench, using varying queue
sizes: ranging from 128 per list (the default), 512 per list, and 4096
per list. IO performance generally increased with bigger queues, for now
lets just look at profiles though.

Testing was done on a 9GB SCSI drive, SMP machine, 512megs of RAM. File
system used was ext2. Kernel used was 2.5.45-vanilla with and without
the deadline-rbtree patch.

With 128 requests per list, the stock kernel has the following relevant
oprofile results:

c0236000 1972     0.0233741   deadline_merge
c0232cd0 683      0.00809559  __make_request
c0235f30 315      0.00373369  deadline_find_hash
c02364a0 283      0.0033544   deadline_add_request
c0236310 248      0.00293954  deadline_move_requests
c02363b0 196      0.00232319  deadline_next_request

rbtree version has the following highscore list:

c0232cd0 560      0.00680737  __make_request
c02361d0 267      0.00324566  deadline_rb_find
c0235f80 234      0.00284451  deadline_hash_add
c0235fe0 225      0.0027351   deadline_hash_find
c0236100 204      0.00247983  deadline_rb_add
c0236660 157      0.00190849  deadline_next_request

No regression when compared to the stock settings, in fact it looks
pretty darn good.

With 512 requests per list, stock kernel scores:

c0236000 6094     0.0860452   deadline_merge
c0232cd0 714      0.0100814   __make_request
c0235f30 545      0.00769521  deadline_find_hash
c02364a0 307      0.00433474  deadline_add_request
c0236310 234      0.003304    deadline_move_requests
c02363b0 163      0.0023015   deadline_next_request

and rbtree version:

c0232cd0 665      0.00950867  __make_request
c0235fe0 350      0.00500456  deadline_hash_find
c02361d0 287      0.00410374  deadline_rb_find
c0235f80 236      0.0033745   deadline_hash_add
c0236100 197      0.00281685  deadline_rb_add
c0236660 121      0.00173015  deadline_next_request

stock kernel shows worse behaviour with 512 requests vs 128, rbtree
version is basically the same. Final test was with 4096 requests per
list. stock kernel highscore:

c0236000 11753    0.228824    deadline_merge
c0232cd0 707      0.0137649   __make_request
c0235f30 625      0.0121684   deadline_find_hash
c02364a0 309      0.00601604  deadline_add_request
c02363b0 134      0.0026089   deadline_next_request

and rbtree for 4096 requests:

c0232cd0 1152     0.0163495   __make_request
c0235fe0 931      0.013213    deadline_hash_find
c02361d0 523      0.00742254  deadline_rb_find
c0235f80 424      0.00601751  deadline_hash_add
c0236100 293      0.00415832  deadline_rb_add
c0236660 166      0.00235591  deadline_next_request

Now the back merge hash table is getting too small, obviously. It's
worth nothing that with 4096 requests, deadline_merge in the stock
kernel is the biggest cpu user in the kernel apart from
copy_to/from_user and mark_offset_tsc.

As expected, the stock version O(N) insertion scan really hurts. Even
with 128 requests per list, rbtree version is far superior. Once bigger
lists are used, there's just no comparison whatsoever.

Full profile numbers are available from:

http://www.kernel.org/pub/linux/kernel/people/axboe/misc/

-- 
Jens Axboe

