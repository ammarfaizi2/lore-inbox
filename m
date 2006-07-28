Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWG1IvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWG1IvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWG1IvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:51:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:65410 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932596AbWG1IvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:51:08 -0400
Message-ID: <44C9CFF8.2080503@garzik.org>
Date: Fri, 28 Jul 2006 04:51:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Zed 0xff <zed.0xff@gmail.com>
CC: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix common mistake in polling loops
References: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com>
In-Reply-To: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zed 0xff wrote:
> b/drivers/block/sx8.c
> --- a/drivers/block/sx8.c    2006-07-27 21:56:05.000000000 +0600
> +++ b/drivers/block/sx8.c    2006-07-28 00:52:33.000000000 +0600
> @@ -550,21 +550,23 @@ static struct carm_request *carm_get_spe
>     unsigned long flags;
>     struct carm_request *crq = NULL;
>     struct request *rq;
> -    int tries = 5000;
> +    unsigned long timeout= jiffies + msecs_to_jiffies(50000);
> 
> -    while (tries-- > 0) {
> +    for(;;) {
>         spin_lock_irqsave(&host->lock, flags);
>         crq = carm_get_request(host);
>         spin_unlock_irqrestore(&host->lock, flags);
> 
>         if (crq)
>             break;
> +
> +        if (time_after(timeout, jiffies)) {
> +            return NULL;
> +        }
> +       
>         msleep(10);
>     }
> 
> -    if (!crq)
> -        return NULL;
> -


NAK:
* [minor] broken whitespace
* [minor] adding braces to singleton C statements
* [major] makes a simple loop much more annoying to read

There is no critical hard deadline for this loop, as with most error 
handling loops.

Since error handling code is exercised much less frequently than regular 
code, I would rather KISS.

	Jeff


