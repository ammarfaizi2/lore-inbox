Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbTKMK7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 05:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTKMK7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 05:59:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27300 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263873AbTKMK7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 05:59:03 -0500
Date: Thu, 13 Nov 2003 11:59:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: AS spin lock bugs
Message-ID: <20031113105901.GD4441@suse.de>
References: <20031113103823.GB4441@suse.de> <3FB36266.7050103@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB36266.7050103@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13 2003, Nick Piggin wrote:
> 
> 
> Jens Axboe wrote:
> 
> >Hi,
> >
> >Was looking at io tracking for cfq, and I think I found some spin lock
> >bugs in current as (current BK). as_update_iohist() runs from
> >add_request which is typically in process context. It could be run with
> >interrupts disabled though, either driver private stuff or using the
> >generic block layer tagging.
> >
> >Anyways, as_update_iohist() grabs aic->lock without disabling
> >interrupts, while as_completed_request() typically runs at interrupt
> >time and grabs the same lock. Deadlock.
> >
> >To be safe, both need to use the flags saving lock variants.
> >
> 
> Hi Jens,
> I was hoping everything ran under the queue lock which should always
> have interrupts off on the local CPU. The lock in question is to prevent
> a as_completed_request on one queue from racing with as_update_iohist
> on another. Each would be on a different CPU.

Ah yes you are right. The queue lock will be held in both places.

> Maybe I'm wrong, did you actually see misbehaviour?

Nope, just looking over the code. What about the second lock, why is
that needed? I don't see that protecting anything.

-- 
Jens Axboe

