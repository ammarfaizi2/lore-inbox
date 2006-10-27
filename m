Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWJ0UZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWJ0UZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbWJ0UZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:25:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:21872 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751397AbWJ0UZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:25:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jRiolYd79Pr3SXiI43bb+dzEsShLOdqvSOHkxbsh7/EEWKVn5Tm8OeAZAXFAV5YIY4/vlYzcj2cB+/qE5zPFuq6LnEMs6rtAXRJ/Ngw3fHXGwY5NQmmJR3rhaEZZwYJZFgPV4MzZf99ZXcM5UPP8InUS/OiOw7zjKZRwoOCBzl0=
Message-ID: <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com>
Date: Fri, 27 Oct 2006 20:25:03 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE85B.2080702@innova-card.com>
	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>
	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>
	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>
	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> On 10/26/06, Miguel Ojeda <maxextreme@gmail.com> wrote:
> > To be clearer. And you are wrong: you can write other modules which
> > want to know what the LCD is showing, or use it; without worrying
> > about framebuffer things. They can read / write "cfag12864b_buffer" as
> > well as cfag12864bfb do. Why not?
> >
>
> Suppose I'm writing a user space application which uses your frame
> buffer driver. I would naturaly mmap your device since it's the
> easiest way to use a frame buffer. Now I want to display as fast as
> possible a set of images. How am I sure that each image is sent to the
> lcd ? For example, suppose the application just finished to copy image
> A into the buffer,  and now it starts to copy image B into the buffer
> but the work queue has not been scheduled yet...
>

Refresh rate is fixed in this driver (the user can change it to other
value at Kconfig or at loading time as a module parameter).

An application should not refresh images so fast (the LCD controller
can handle it, but the readability is pretty bad). Having a refresh
rate like 10 Hz for example, the application can be sure all images
are displayed. Anyway, an animation of 10 Hz wouldn't be fine at this
kind of LCDs, so it is pointless which the refresh rate of the driver
is, as it is not useful to display images as fast as the driver
refresh the LCD.

(I don't know if I'm explaining myself...)

>
> Futhermore I'm not sure it's a common use case for such device, is it
> ? I would say that the usual case for such LCD is to display an image
> every now and then. If so do we really need to give the possibility to
> mmap the device ? Is a simple synchrone write() enough ?
>

Well, you can show a set of images, animations... althought it's not
so useful. Usual cases:
1. Display a static image / info.
2. Display refreshed info every X seconds (like % usage of CPU and so
on, the music you are listening to...)
3. Display, maybe, a animated graph (like the wave created by your
music), althought this one is not so usual, as it changes much more
quickly than [2]. Still, there are apps in other SOs that show such
kind of info.

Well, mmaping is the best option, as it is the easiest and the
fastest. Any use will be better using mmaping than doing synchrone
write(). Yes, many uses just need a write() call, but other uses would
need mmap.

> BTW how can the application retrieve the refresh rate from the driver ?
>

Hum, right now one way is:

$ cat /sys/module/cfag12864b/parameters/cfag12864b_rate

Yes, a more generic option would be better. Do the fbdevices have some
standard way to retrieve such kind of info (like the bits per pixel,
width, height...)? If not, which would be a good to retrieve the
refresh rate?

Anyway, a application which would like to use this LCD should know its
specs and the user knows he shouldn't change the refresh rate without
a good reason. If a user changes it to other value, he knows he can be
breaking the apps, the same way you can break your kernel adding
things you shouldn't; also the driver could stop working properly at
higher rates.

>
>                 Franck
>
