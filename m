Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVICWNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVICWNt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 18:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVICWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 18:13:49 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:19522 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751043AbVICWNt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 18:13:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tDbY3qP4l4wNiOq/R3nxGu00ofU8LGQmuP5u9v284mR1WvCdnQ4ATp7ABGrdH/pyyvNHtSGYnRsD3M2bYWc72oNeB4ZQhjPLKplAtJY98SDagP7sb2xEsEXkf7hmj/c+6a4xTVLJ0A55vJ6NGMexnVcXeGgrFyBRTXg7iQW9h4U=
Message-ID: <29495f1d0509031513232b11b1@mail.gmail.com>
Date: Sat, 3 Sep 2005 15:13:43 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Chase Venters <chase.venters@clientec.com>
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Cc: Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200509031627.00947.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904101218.GM4415@rama.de.gnumonks.org>
	 <200509031627.00947.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/05, Chase Venters <chase.venters@clientec.com> wrote:
> > Below you can find a driver for the Omnikey CardMan 4040 PCMCIA
> > Smartcard Reader.
> 
> Someone correct me if I'm wrong, but wouldn't these #defines be a problem 
> with the new HZ flexibility:
> 
> #define CCID_DRIVER_BULK_DEFAULT_TIMEOUT        (150*HZ)
> #define CCID_DRIVER_ASYNC_POWERUP_TIMEOUT       (35*HZ)
> #define CCID_DRIVER_MINIMUM_TIMEOUT             (3*HZ)
> #define READ_WRITE_BUFFER_SIZE 512
> #define POLL_LOOP_COUNT                         1000

These are all fine. Although I am a bit suspicious of 150 second
timeouts; but if that is the hardware...

> /* how often to poll for fifo status change */
> #define POLL_PERIOD                             (HZ/100)

This needs to be msecs_to_jiffies(10), please.

> In particular, 2.6.13 allows a HZ of 100, which would define POLL_PERIOD to 0.

Um, 100/100 = 1, not 0?

> Your later calls to mod_timer would be setting cmx_poll_timer to the current
> value of jiffies.

Which is technically ok, because HZ=100, a
     jiffies + 0
or
     jiffies + 1
timeout request will both result in the soft-timer being expired at
the *next* timer interrupt. Regardless, you're right, and
msecs_to_jiffies() will cover it.

> Also, you've got a typo in the comments:
> 
> *       - adhere to linux kenrel coding style and policies
> 
> Forgive me if I'm way off - I'm just now getting my feet wet in kernel
> development. Just making comments based on what I (think) I know at this
> point.

Of bigger concern to me is the use of the sleep_on() family of
functions, all of which are deprecated.

Thanks,
Nish
