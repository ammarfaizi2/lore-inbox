Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbTKMKzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 05:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbTKMKzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 05:55:24 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:6028 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263827AbTKMKzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 05:55:20 -0500
Message-ID: <3FB36266.7050103@cyberone.com.au>
Date: Thu, 13 Nov 2003 21:52:22 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: AS spin lock bugs
References: <20031113103823.GB4441@suse.de>
In-Reply-To: <20031113103823.GB4441@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

>Hi,
>
>Was looking at io tracking for cfq, and I think I found some spin lock
>bugs in current as (current BK). as_update_iohist() runs from
>add_request which is typically in process context. It could be run with
>interrupts disabled though, either driver private stuff or using the
>generic block layer tagging.
>
>Anyways, as_update_iohist() grabs aic->lock without disabling
>interrupts, while as_completed_request() typically runs at interrupt
>time and grabs the same lock. Deadlock.
>
>To be safe, both need to use the flags saving lock variants.
>

Hi Jens,
I was hoping everything ran under the queue lock which should always
have interrupts off on the local CPU. The lock in question is to prevent
a as_completed_request on one queue from racing with as_update_iohist
on another. Each would be on a different CPU.

Maybe I'm wrong, did you actually see misbehaviour?


