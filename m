Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161441AbWKVAnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbWKVAnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 19:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031390AbWKVAnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 19:43:17 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:47810 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1031385AbWKVAnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 19:43:15 -0500
Subject: Re: Boot failure with ext2 and initrds
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
	 <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	 <20061115232228.afaf42f2.akpm@osdl.org>
	 <1163666960.4310.40.camel@localhost.localdomain>
	 <20061116011351.1401a00f.akpm@osdl.org>
	 <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
	 <20061116132724.1882b122.akpm@osdl.org>
	 <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
	 <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 21 Nov 2006 16:43:12 -0800
Message-Id: <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 16:19 +0000, Hugh Dickins wrote:
> After four days of running, the EM64T has at last reproduced the same
> hang as it did in an hour before: stuck in
> ext2_try_to_allocate_with_rsv,
> repeatedly ext2_rsv_window_add, ext2_try_to_allocate,
> rsv_window_remove
> (perhaps not in that order).
> 

Don't have much clue, still...:(

The logic of the while loop in ext2_try_to_allocate_with_rsv() looks
like:

while (1) {
	/*make a new reservation window*/
	ret = allocate_new_reservation();
	if (ret < 0)
		break /*fail*/
	/*allocate a block from the reservation window */
	ret = ext2_try_to_allocate_with_rsv()
	if (ret > 0) {
		...
		break;	/*success*/
	}
}
If it stucks in the loop, that means next two things have to be true: 

1) ext2_try_to_allocate() keeps failing to allocate a bit from the
window just reserved, every time.  

2) we could endlessly create a new reservation window in this block
group.


For (1), when create a new reservation window, we do make sure there are
at least one free bit in the window, so that
ext2_try_to_allocate_with_rsv() could claim that bit. I haven't found
any thing wrong in that part yet;

For (2)the search for the next reservation window should start from the
end block of the old window, and should stop and fail if it reachs the
last block of the block group. 

Will continue looking at the code, but so far everything looks just fine
to me.:( 


On Tue, 2006-11-21 at 05:39 +0000, Hugh Dickins wrote:
> On Mon, 20 Nov 2006, Mingming Cao wrote:
> >
> > So there is only one writer at the moment the hang was happening?
> 
> I expect there were multiple writers when the task which hangs
> first entered its ext2_prepare_write (it's a make -j20 build on
> that ext2 filesystem); but by the time I come to look at the hang,
> there's only that one writer active - everything else would be waiting
> on that part of the build to complete
>  (well, your question makes me
> realize that I didn't look down the whole "ps" listing to see what
> was waiting; but the hanging task is the only one I see running on
> on any cpu, each time I break in).
> 
A bit confused, did the whole system hang or just the "ld" writer hang
in ext2 block allocation? And what other writers were waiting for? Were
they trying to write to the same file?

> >
> > hmm, is the filesystem relatively all being used or reserved, i.e, the
> > free bits are all being reserved?  There is one extreme case that may
> > cause starvation. If filesystem free blocks are all being reserved, when
> > a  new writer need a free block, it has to go through the entire
> > filesystems, try to reserve a space, which will repeatly calling
> > rsv_window_add and rsv_window_remove, since. Finally give up and fall
> > back to allocation without reservation. But this is all theory, not sure
> > fits your case here.
> 
> I can understand that there may be a worst case like that: but I hope
> it wouldn't take 20 hours to find a free block on a default 340MB ext2
> filesystem!  And unless something else has gone wrong, this build would
> not be filling the filesystem to that extent: it's probably around 80%
> full at this stage, and shouldn't get fuller than 98% in the end.
> 
> Any suggestions for what I might check, next time it happens?
> 

It might be helpful to check the return value of ext2_try_to_allocate(),
to see if it fails. It would be nice if you could check if there any
free bit inside the reservation window.

And could you check the start and end block for every rsv_window_add and
rsv_window_remove, to see if it was keep creating and removing the same
window in the same block group?

And it might be useful to dump the whole filesystem block reservation
tree as well.

Not sure if it worth the effort to test it on ext3.  The ext2 block
reservation code in 2.6.19-rc5-mm2 looks pretty much the same as ext3/4,
except the missing truncate_mutex. I understand this might take a few
days to reproduce, so this might not needed now.


Mingming
> Hugh
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ext4" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

