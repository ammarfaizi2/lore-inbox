Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWKNLwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWKNLwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWKNLwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:52:06 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:5014 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S964857AbWKNLwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:52:04 -0500
Message-ID: <4559ADEE.90209@drzeus.cx>
Date: Tue, 14 Nov 2006 12:52:14 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk> <45598462.80605@drzeus.cx> <20061114104844.GA15340@flint.arm.linux.org.uk> <4559A99B.6070207@drzeus.cx> <20061114114120.GC22178@kernel.dk>
In-Reply-To: <20061114114120.GC22178@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> I think you are making this way too complicated, it's actually pretty
> simple: you call blk_put_queue() or blk_cleanup_queue() (same thing)
> when _you_ drop your reference to the queue. That's just normal cleanup.
> When a device goes away, you make sure that you know about this. I said
> that SCSI clears q->queuedata, so it knows that when ->request_fn is
> invoked with a NULL q->queuedata (where it stores the device pointer),
> the device is not there and the request should just be flushed to
> heaven.
>   

What about the gendisk object? Since I assigned the queue pointer to it,
it didn't naturally get a chance to increase the reference count. When
can I safely drop my reference without the gendisk getting upset?

> Don't make any assumptions about when request_fn will be called or not.
> That's bound to be racy anyway.
>
>   

Things get a bit muddy by the fact that the mmc layer has a thread that
handles the queue. So I guess we need to have a way to shut down that
thread, but still be able to throw away any stray requests from the
block layer?

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

