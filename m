Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbWJ3GWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbWJ3GWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 01:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWJ3GWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 01:22:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:63203 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161136AbWJ3GWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 01:22:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ipyZ1gqMFhAz2tuGS96JzX/6cWw6CZfdcO6C5ruAGnjZMxUeaeajCRKzYI0fEoOYcrZC97GbFoRuGcpMe6MNWP6rjpf78U2p2QTR0jpOFyhNQPK+A4s5eXxfjU68cVomx+MyBA3qbQEVbSvoNrzQW1Bx6RkwPLeZWRW6/+9VtMs=
Message-ID: <45459A26.9050409@gmail.com>
Date: Mon, 30 Oct 2006 15:22:30 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Ravi Krishnamurthy <Ravi_Krishnamurthy@adaptec.com>
CC: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Block driver freezes when using CFQ
References: <4542FF94.4090005@adaptec.com>
In-Reply-To: <4542FF94.4090005@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ravi.

First of all, it usually attracts more people if you include full source 
code of something runnable.

Ravi Krishnamurthy wrote:
[--snip--]
> Several times during the test run, the while() loop in the request
> function comes out without dequeuing any request even though the
> elevator queue is not empty. (Confirmed by printing the return value of
> elv_queue_empty(), and the values of q->rq.count[] outside the loop).

Yeap, both cfq and anticipatory pause queue processing to improve 
performance.  This is a bit counter-intuitive at first but the loooong 
seek time justifies such pauses if they can reduce seeks.

> After one such occurrence, the request function is not called at all
> and the device becomes unresponsive.
> I added some code that lets me trigger the request function from userspace.
> If I nudge the driver this way, I/Os continue for a short while and stop
> again.
> 
> Since CFQ is the default I/O scheduler in current kernels, it has been
> widely used and tested. So I suspect I am not doing something right in my
> driver. Since the driver works well with the other schedulers, is there
> something CFQ-specific that I should take care of?

After such pauses, cfq does the needed 'nudging' by itself.  cfq has 
changed quite a bit so I might be mistaken but such 'nudging' ends up 
calling blk_start_queueing() which either runs request_fn directly or 
unplug the queue if plugged.  So, does your driver's queue have proper 
unplug function?  How is your queue initialized?  (you can see why it's 
much better to post full working source.)

-- 
tejun
