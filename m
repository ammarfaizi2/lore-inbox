Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030735AbWKUFiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030735AbWKUFiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 00:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030734AbWKUFiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 00:38:54 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:12446 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1030727AbWKUFix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 00:38:53 -0500
X-AuditID: d80ac21c-ad538bb000002cca-e3-456290ec9ed1 
Date: Tue, 21 Nov 2006 05:39:06 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mingming Cao <cmm@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
In-Reply-To: <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>  <20061114184919.GA16020@skynet.ie>
  <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com> 
 <20061114113120.d4c22b02.akpm@osdl.org>  <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
  <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com> 
 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com> 
 <20061115232228.afaf42f2.akpm@osdl.org>  <1163666960.4310.40.camel@localhost.localdomain>
  <20061116011351.1401a00f.akpm@osdl.org>  <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
  <20061116132724.1882b122.akpm@osdl.org>  <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
 <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Nov 2006 05:38:52.0297 (UTC) FILETIME=[53BE8F90:01C70D2F]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006, Mingming Cao wrote:
> 
> So there is only one writer at the moment the hang was happening? 

I expect there were multiple writers when the task which hangs
first entered its ext2_prepare_write (it's a make -j20 build on
that ext2 filesystem); but by the time I come to look at the hang,
there's only that one writer active - everything else would be waiting
on that part of the build to complete (well, your question makes me
realize that I didn't look down the whole "ps" listing to see what
was waiting; but the hanging task is the only one I see running on
on any cpu, each time I break in).

> 
> hmm, is the filesystem relatively all being used or reserved, i.e, the
> free bits are all being reserved?  There is one extreme case that may
> cause starvation. If filesystem free blocks are all being reserved, when
> a  new writer need a free block, it has to go through the entire
> filesystems, try to reserve a space, which will repeatly calling
> rsv_window_add and rsv_window_remove, since. Finally give up and fall
> back to allocation without reservation. But this is all theory, not sure
> fits your case here.

I can understand that there may be a worst case like that: but I hope
it wouldn't take 20 hours to find a free block on a default 340MB ext2
filesystem!  And unless something else has gone wrong, this build would
not be filling the filesystem to that extent: it's probably around 80%
full at this stage, and shouldn't get fuller than 98% in the end.

Any suggestions for what I might check, next time it happens?

Hugh
