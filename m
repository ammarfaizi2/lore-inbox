Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTJZVAq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 16:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTJZVAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 16:00:46 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:10672 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S263662AbTJZVAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 16:00:45 -0500
From: Daniel Phillips <phillips@arcor.de>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] ide write barrier support
Date: Sun, 26 Oct 2003 23:06:53 +0200
User-Agent: KMail/1.5.3
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031013140858.GU1107@suse.de> <200310231920.39888.phillips@arcor.de> <3F986276.4010409@cyberone.com.au>
In-Reply-To: <3F986276.4010409@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310262206.53904.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 October 2003 01:21, Nick Piggin wrote:
> Daniel Phillips wrote:
> > To keep the downstream queues full, we must submit write barriers to all
> > the downstream devices and not wait for completion.  That is, as soon as
> > a barrier is issued to a given downstream device we can start passing
> > through post-barrier writes to it.
> >
> > Assuming this is worth doing, how do we issue N barriers to the downstream
> > devices when we have only one incoming barrier write?
>
> You would do this in the multipath code, wouldn't you?

Not entirely within the multipath virtual device, that's the problem.  If it 
could stay somehow all within one device driver then ok, but since we want to 
build this modularly, as a device mapper target, there are API issues.

> Anyway, I might be missing something, but I don't think draining the
> queue will guarantee that writeback caches will go to permanent storage.

We moved on from the IDE writeback problem a while back, this is about SCSI 
multipath, and the idea is to keep the SCSI device queues full so that 
barrier requests can flow through instead of stalling.

To be honest, after poring through the SCSI docs I'm not sure whether SCSI 
supports the behavior I want, which is for dma transfers on post-barrier 
requests to run in parallel with media transfers of pre-barrier requests.

With SCSI there are two mechanisms that could be used to implement barriers, 
ordered commands and task lists; patches posted to date use the first method.  
The ordered method sets an attribute on a SCSI write command that says "must 
be executed in order submitted" implying that all previously submitted 
commands have to finish before the ordered command begins to execute.  (Note, 
this is not necessarily optimal if the barrier is just supposed to separate 
two groups of writes and the order within the second group doesn't matter.  
Also, it implements a stronger barrier than just read/write, so reads will be 
blocked as well.)  What is not clear to me is whether or not the drive is 
allowed to read the buffer into its cache before the ordered command becomes 
active.  I'd appreciate comments from any SCSI gurus that happen to be 
reading.

Regards,

Daniel

