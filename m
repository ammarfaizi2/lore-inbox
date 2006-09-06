Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWIFMHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWIFMHX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 08:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWIFMHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 08:07:23 -0400
Received: from main.gmane.org ([80.91.229.2]:31969 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750767AbWIFMHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 08:07:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Damon LaCrosse <arid@inbox.ru>
Subject: Re: 2.6.17 odd hd slow down
Date: Wed, 06 Sep 2006 14:06:29 +0200
Organization: Julian Assange Memorial Society
Message-ID: <87k64hp5bu.fsf@inbox.ru>
References: <87r6ypuy3v.fsf@inbox.ru> <20060906105755.GZ14565@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 62-101-126-227.ip.fastwebnet.it
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Cancel-Lock: sha1:3R+BgNCpGtxURAE+A08TJ3zBo24=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

   On Wed, Sep 06 2006, Damon LaCrosse wrote:
   > 
   > Hi all,
   > experimenting a little the 2.6 block device layer I detected under
   > some circumstances a net slowness in the disk throughput. Strangely
   > enough, in fact, my IDE disk reported a significant performance drop
   > off in correspondence of certain access patterns.
   > 
   > Following further investigations I was able to simulate this ill
   > behavior in the following piece of code, clearly showing a non
   > negligible hard-disk slow down when the step value is set greater than
   > 8. These result in fact far below the hard-disk real speed
   > (30~70MB/sec), as correctly measured instead in correspondence of low
   > STEP values (<8). In particular, with step of 512 or above, the
   > overall performance scored by the disk results below 2MB/sec.

   You are effectively approaching seeky writes, I bet it's just the drive
   firmware biting you. Repeat the test on a different drive, and see if
   you see an identical pattern.

Hi, thank you for your prompt answer! 

Unfortunately I have only a bunch of maxtors at moment, but I'll do it ASAP.

   > At first I thought to a side-effect of the queue plug/unplug
   > mechanism: the scattered accesses involve the unplug timeout to each
   > bio. So, I added the BIO_RW_SYNC flag that - AFAIK - should force the
   > queue unplugging. Unfortunately nothing changes.
   > 
   > Now, as it is quite possible that I'm missing something, the question
   > is: is there an effective way of doing scattered disk accesses using
   > bios? In other words, how can I fix the following program in order to
   > get disk full speed for steps > 8?

   I don't think the io path has anything to do with this. Why are you
   expecting non-sequential writes to continue to be fast? They wont be.

Well, as already said, probably I'm missing something so don't blame me ;-)

First, because of the performance holes among 1, 2, 4 and 8 steps. If you look
carefully below I'll find a performance drop in correspondence of step 5, 6, 7
but not for step 8; in my experiments, step == sector (512B) and block_size ==
page_size (4096B), so you actually write only the even blocks when step=8. If
this would really a seeky problem, shouldn't performance go down linearly with
the step size (i.e. without holes)?

Second, at the end of the submit_bio() loop nearly every bi_end_io() has been
already been serviced: AFAIK submit_bio() is asynchronous so IMHO there are
chances that it stalls on the request queue prior to submit the bio to the
driver.

Third, the disk doesn't look stressed: it blinks idly and no significant head
movements can be noticed. It is really much more stressed during DVDs
projection than in this case.

Bye
Damon

ANTICIPATORY SCHEDULER

STEP (hs)	CYCLES		WRITTEN (MB)	ELAPSED (s)	SPEED (MB/s)
4		52482		205		3		62.3135 <-----
5		14448		56		3		18.1951
6		13617		53		3		17.1732
7		12849		50		3		16.1695
8		47874		187		3		56.2823 <-----
9		2569		10		3		3.468
10		2608		10		3		3.716

