Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUHTCib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUHTCib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 22:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUHTCib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 22:38:31 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:6019 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S266115AbUHTCiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 22:38:24 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Thu, 19 Aug 2004 22:38:19 -0400
User-Agent: KMail/1.6.82
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408190541.14131.gene.heskett@verizon.net> <20040819183643.GA5278@logos.cnet>
In-Reply-To: <20040819183643.GA5278@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408192238.19567.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.62.54] at Thu, 19 Aug 2004 21:38:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 14:36, Marcelo Tosatti wrote:
>Gene,
>
>That is:
>
>/*
> * The buffer's backing address_space's private_lock must be held
> */
>static inline void __remove_assoc_queue(struct buffer_head *bh)
>{
>        BUG_ON(bh->b_assoc_buffers.next == NULL); 			<----------
>        BUG_ON(bh->b_assoc_buffers.prev == NULL);
>        list_del_init(&bh->b_assoc_buffers);
>}
>
>Viro, Linus, Andrew, dont you have any idea what could cause such
> mapping->b_assoc_mapping corruption?
>
>I can't see how that could be caused by flaky hardware.

There is still that possibility Marcelo.  Someone recommended I get 
cpuburn and memburn, and before fixing the scanf statement (it was 
broken) in memburn, I had compiled it for a 512 meg test the first 
time, and a 768 meg test the next couple of runs.

All exited with errors like this:
Passed round 133, elapsed 4827.19.
FAILED at round 134/14208927: got ff00, expected 0!!!

REREAD: ff00, ff00, ff00!!!

[root@coyote memburn]# vim memburn.c
[root@coyote memburn]# gcc -o memburn memburn.c
[root@coyote memburn]# ./memburn
Starting test with size 768 megs..

Passed round 0, elapsed 44.36.
Passed round 1, elapsed 74.13.
Passed round 2, elapsed 105.12.
FAILED at round 3/25777183: got 2b00, expected 0!!!

REREAD: 2b00, 2b00, 2b00!!!

I've now rebuilt it with a better printf format string, and its 
running over 768 megs again.  But this time the round counter is up 
to 90 and still going...

Interesting too is that memburn has now allocated a 768 meg wide block 
5 times, and still no Oops.  Over a hundred megs in swap, but its 
still running.

I lost the BUG_ON patches in fs/buffer.c, this is now 2.6.8.1-mm2 (but 
I can go back if this fails of course)

Or can I just copy that 2.6.8-rc4/fs/buffer.c file over this one?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
