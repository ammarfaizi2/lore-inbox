Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756935AbWK1U17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbWK1U17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757085AbWK1U17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:27:59 -0500
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:22245 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1756961AbWK1U15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:27:57 -0500
X-AuditID: c6063117-9e7b8bb000005266-a0-456c7422027c 
Date: Tue, 28 Nov 2006 17:38:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mingming Cao <cmm@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>  <20061114184919.GA16020@skynet.ie>
  <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com> 
 <20061114113120.d4c22b02.akpm@osdl.org>  <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
  <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com> 
 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com> 
 <20061115232228.afaf42f2.akpm@osdl.org>  <1163666960.4310.40.camel@localhost.localdomain>
  <20061116011351.1401a00f.akpm@osdl.org>  <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
  <20061116132724.1882b122.akpm@osdl.org>  <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
  <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com> 
 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
 <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Nov 2006 17:38:42.0593 (UTC) FILETIME=[0C0EF910:01C71314]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Mingming Cao wrote:
> On Mon, 2006-11-20 at 16:19 +0000, Hugh Dickins wrote:
> > After four days of running, the EM64T has at last reproduced the same
> > hang as it did in an hour before: stuck in
> > ext2_try_to_allocate_with_rsv,
> > repeatedly ext2_rsv_window_add, ext2_try_to_allocate,
> > rsv_window_remove
> > (perhaps not in that order).
> > 

At last it did happen again, on both x86_64 and ppc64.

> 
> Don't have much clue, still...:(

Don't worry, KDB helped me work it out, patch follows in a moment.

> 
> The logic of the while loop in ext2_try_to_allocate_with_rsv() looks
> like:

Thanks for your clarifications and tips.

> > 
> A bit confused, did the whole system hang or just the "ld" writer hang
> in ext2 block allocation? And what other writers were waiting for? Were
> they trying to write to the same file?

The system was pingable, but couldn't do much else.  Only the one
"ld" was active on the ext2 filesystem by this time, other tasks of
the make just waiting on it, nothing else was trying to write there.

4 cpus, well, 2*HT: why couldn't I ssh or login?  I don't know,
something else to investigate, but that can be quite separate: very
unlikely to be related to the particular ext2 bug which showed it
(that filesystem was just for the test, it's not my root).
Probably stupidly obvious once I've worked it out.

> 
> It might be helpful to check the return value of ext2_try_to_allocate(),
> to see if it fails. It would be nice if you could check if there any
> free bit inside the reservation window.

After screwing up last time, I was ultra-paranoid this time, and did
not dare to set any breakpoints: proceeded by repeatedly breaking in
from the keyboard, and the time I happened to catch it on return from
memscan() was revealing.

> 
> And could you check the start and end block for every rsv_window_add and
> rsv_window_remove, to see if it was keep creating and removing the same
> window in the same block group?

The same every time it settled on a usable reservation, but a lot of
wasted adds and removes as it works across a fully allocated area of
the bitmap.  Not very efficient, all those rb_tree insertions and
removals until it gets to a free area; but I can't judge from this
example how common that would be, may not be worth bothering about.

> 
> And it might be useful to dump the whole filesystem block reservation
> tree as well.

Not necessary, I've put just the relevant numbers in the patch comment,
it helped me a lot to see the actual numbers and work it out from there.

> 
> Not sure if it worth the effort to test it on ext3.  The ext2 block
> reservation code in 2.6.19-rc5-mm2 looks pretty much the same as ext3/4,
> except the missing truncate_mutex. I understand this might take a few
> days to reproduce, so this might not needed now.

Turns out vanilla-ext2 and ext3 and ext4 are safe:
ext3 and ext4 slightly wrong in the same way, but safe.

I'll continue this thread with the bugfix patch 1/6; and five more
(roughly descending order of importance, the latter just cosmetic)
little fs/ext2/balloc.c patches to things I noticed on the way.
Nothing very worrying.  Easier to send patches than ask questions:
please check, perhaps my "off-by-one" accusations are wrong, for
example.  If you're satisfied they're right, please apply the
same to ext3 and ext4.
 
Although 1/6 does (I believe: too early for my tests to tell)
fix the bug in a minimal way, I rather think that area needs
cleanup - further comments below my Signed-off-by in 1/6.

Hugh
