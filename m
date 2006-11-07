Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbWKGOUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWKGOUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 09:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbWKGOUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 09:20:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:26020 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932653AbWKGOUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 09:20:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PRrwTdEnAK5G+vMnGCjAPN1i4AlKA119roKvqfWuyG6lq9R07pURl7B8joQVs4vRe5A1nGG7DUV06nfMpa5qvkg0mDRaRgH9fm4I8nZEoDIti08tlQ/uNPguWV0yEkGVbZE989rOTTzQ47LM8AvO3vJs98sTCM6FH+AR5TaVeJ0=
Message-ID: <d120d5000611070620l5a0731d8jd5778bc8c8b49b2b@mail.gmail.com>
Date: Tue, 7 Nov 2006 09:20:07 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Akinobu Mita" <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] input: make serio_register_driver() return error code
In-Reply-To: <20061107120605.GA13896@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061107120605.GA13896@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> serio_register_driver() may fail under memory shortage.
>
> When serio_register_driver() called, it queues SERIO_REGISTER_DRIVER
> event into global serio_event_list, and then kseriod kernel thread
> handles that event and do driver_register().
>
> But event allocation by serio_register_driver() may fail.
> Because it is GFP_ATOMIC allocation. It will cause the problem
> by serio_unregister_driver() with not being registered driver
> at module_exit() time
>
> This patch makes serio_register_driver() call driver_register()
> directly instead of kseriod so that it can check whether
> driver_register() is succeeded or not.
>

This slows down boot process because probing for mice and keyboards
takes too long (for some touchpads it takes about 4 seconds to do
reset). We could change allocation from GFP_ATOMIC to GFP_KERNEL for
SERIO_REGISTER_DRIVER events to make it more robust but otherwise I'd
leave serio_register_driver return void. You could also add a flag to
serio driver indicating whether registration is complete and check
that flag in serio_unregister_driver so it does not do stupid things.

-- 
Dmitry
