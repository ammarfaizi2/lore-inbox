Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTJTRE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 13:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbTJTRE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 13:04:58 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:5092 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262610AbTJTRE4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 13:04:56 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Date: Mon, 20 Oct 2003 19:10:48 +0200
User-Agent: KMail/1.5.3
References: <20031013140858.GU1107@suse.de>
In-Reply-To: <20031013140858.GU1107@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200310201910.48837.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Monday 13 October 2003 16:08, Jens Axboe wrote:
> Forward ported and tested today (with the dummy ext3 patch included),
> works for me. Some todo's left, but I thought I'd send it out to gauge
> interest.

This is highly interesting of course, but is it suitable for submission during 
the stability freeze?  There is no correctness issue so long as no filesystem 
in mainline sets the BIO_RW_BARRIER bit, which appears to be the case.  
Therefore this is really a performance patch that introduces a new internal 
API.

It seems to me there are a few unresolved issues with the barrier API.  It 
needs to be clearly stated that only write barriers are supported, not read 
or read/write barriers, if that is in fact the intention.  Assuming it is, 
then BIOs with read barriers need to be failed.

The current BIO API provides no way to express a rw barrier, only read 
barriers and write barriers (the combination of direction bit and barrier bit 
indicates the barrier type).  This is minor but it but how nice it would be 
if the API was either orthogonal or there was a clear explanation of why RW 
barriers never make sense.  And if they don't, why read barriers do make 
sense.  Another possible wart is that the API doesn't allow for a read 
barrier carried by a write BIO or a write barrier carried by a read BIO.
>From a practical point of view the only immediate use we have for barriers is 
to accelerate journal writes and everything else comes under the heading of 
R&D.  It would help if the code clearly reflected that modest goal.

The BIO barrier scheme doesn't mesh properly with your proposed 
QUEUE_ORDERED_* scheme.  It seems to me that what you want is just 
QUEUE_ORDERED_NONE and QUEUE_ORDERED_WRITE.  Is there any case where the 
distinction between a tag based implemenation versus a flush matters to high 
level code?

Also, the blk_queue_ordered function isn't a sufficient interface to enable 
the functionality at a high level, a filesystem also needs a way to know 
whether barriers are supported or not, short of just submitting a barrier 
request and seeing if it fails.

The high level interface needs to be able to handled stacked devices, i.e., 
device mapper, but not just device mapper.  Barriers have to be supported by 
all the devices in the stack, not just the top or bottom one.  I don't have a 
concrete suggestion on what the interface should be just now.

The point of this is, there still remain a number of open issues with this 
patch, no doubt more than just the ones I touched on.  Though it is clearly 
headed in the right direction, I'd suggest holding off during the stability 
freeze and taking the needed time to get it right.

Regards,

Daniel

