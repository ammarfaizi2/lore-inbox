Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754573AbWKHMgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbWKHMgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572AbWKHMgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:36:43 -0500
Received: from nz-out-0102.google.com ([64.233.162.199]:52642 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1754573AbWKHMgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:36:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=l3xjIB8X1heXHFk1eEJW+aSrxK4XAKSozJdTb9mDqZstXv0/bM761ifRQq5+2RWic4TMwiw2MHmGJIasXy536/YWnvO9pm2AocQn4n02ZqY9yLXGz/Gv18BoUozEW1rxA1yJ2EH1qk3EZTCVWRq6xVokMaY6WDm2WP42kCxukPA=
Date: Wed, 8 Nov 2006 21:36:36 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] input: make serio_register_driver() return error code
Message-ID: <20061108123636.GA14871@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061107120605.GA13896@localhost> <d120d5000611070620l5a0731d8jd5778bc8c8b49b2b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000611070620l5a0731d8jd5778bc8c8b49b2b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 09:20:07AM -0500, Dmitry Torokhov wrote:
> >This patch makes serio_register_driver() call driver_register()
> >directly instead of kseriod so that it can check whether
> >driver_register() is succeeded or not.
> >
> 
> This slows down boot process because probing for mice and keyboards
> takes too long (for some touchpads it takes about 4 seconds to do

I understand the reason why driver_register() is done by kseriod.

> reset). We could change allocation from GFP_ATOMIC to GFP_KERNEL for
> SERIO_REGISTER_DRIVER events to make it more robust but otherwise I'd
> leave serio_register_driver return void. You could also add a flag to
> serio driver indicating whether registration is complete and check
> that flag in serio_unregister_driver so it does not do stupid things.

I reorganzed the patch set.

serio driver registration can fail in two different ways.

1) serio_event allocation failure by serio_register_driver().

   It happens in module_init() context. It is possible to check this
   allocation failure by making serio_register_driver() return error.

2) driver_register() failure by kseriod.

   This failure cannot be checked by serio_register_driver().
   But it is necessary to prevent serio_unregister_driver() from
   trying to call driver_unregister() with not registered driver
   by adding flag to serio driver indicating whether registration is
   complete.

1/4: make serio_register_driver() return error -- 1)
2/4: check serio_register_driver() error -- 1)
3/4: check whether serio dirver registration is completed -- 2)
4/4: change to GFP_KERNEL for SERIO_REGISTER_DRIVER event allocation

