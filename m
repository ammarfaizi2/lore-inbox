Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966031AbWKTQTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966031AbWKTQTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966111AbWKTQTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:19:25 -0500
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:12008 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S966031AbWKTQTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:19:23 -0500
X-AuditID: c606310c-aae73bb000006f35-ce-4561d5f23fb3 
Date: Mon, 20 Nov 2006 16:19:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: cmm@us.ibm.com, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <20061116132724.1882b122.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie>
 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
 <20061114113120.d4c22b02.akpm@osdl.org> <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
 <20061115232228.afaf42f2.akpm@osdl.org> <1163666960.4310.40.camel@localhost.localdomain>
 <20061116011351.1401a00f.akpm@osdl.org> <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
 <20061116132724.1882b122.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Nov 2006 16:19:20.0881 (UTC) FILETIME=[A28D6210:01C70CBF]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006, Andrew Morton wrote:
> On Thu, 16 Nov 2006 12:15:16 -0800
> Mingming Cao <cmm@us.ibm.com> wrote:
> > On Thu, 2006-11-16 at 01:13 -0800, Andrew Morton wrote:
> > > 
> > > I assume that the while (1) loop in ext3_try_to_allocate_with_rsv() has
> > > gone infinite.  I don't see why, but more staring is needed.
> > 
> > The loop should not go forever, it will stops when there is no window
> > with free bit to reserve in the given block group.
> 
> It seems to have done so in Hugh's testing, but there's some question there
> now.  Although I didn't check to see if there's a significant difference
> between Hugh's patch and mine.

After four days of running, the EM64T has at last reproduced the same
hang as it did in an hour before: stuck in ext2_try_to_allocate_with_rsv,
repeatedly ext2_rsv_window_add, ext2_try_to_allocate, rsv_window_remove
(perhaps not in that order).

But somehow I've screwed up, and before I'd extracted any new info,
kdb was spinning on its own kdb_printf_lock, and then the box completely
frozen: nothing for it but to reboot.

Grrrr.

Well: at least this resolves the doubt I raised earlier, whether
I'd been testing with the right ext2 patch.  This time was definitely
with your patch not my two-liner: your original patch from Tuesday 14 Nov,
ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3-fix

Various other patches have come into -mm (one gone) since then, but I've
been running just with that: so far as I can see, none of the later ones
should be important in my case - the filesystem is too small for the
difference between int and ext2_fsblk_t to become important, and
neither "ld" nor "as" (the writer this time) does MAP_SHARED pageout.

I'll do a little staring at the code myself: I'm unlikely to notice
anything you've missed, but there's just a chance staring at it will
direct me to some detail I've jotted down from before.

Hugh
