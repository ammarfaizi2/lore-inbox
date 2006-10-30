Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWJ3Nr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWJ3Nr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWJ3Nr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:47:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:54716 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751144AbWJ3Nr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:47:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=deoElWgvM+GeYRUAUQktxfOZNMtDeBiqh5iNtY8Ah/q0rqSTPJa5vYnZJf7njoBSMWfVjNPsu2uRuMarBoBmPyScbo04xbwBaB5InLYVe/WQGUcltgvG+wZ438ofNi/SZBfVRZi5yhu4doF8v3ovTGKUD3nAxVqJX/XGGFuFErA=
Message-ID: <653402b90610300547t6396d37au2ed6002a71a54e63@mail.gmail.com>
Date: Mon, 30 Oct 2006 14:47:26 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <4545C52A.5010105@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013023218.31362830.maxextreme@gmail.com>
	 <453C8027.2000303@innova-card.com>
	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>
	 <453CE85B.2080702@innova-card.com>
	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>
	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>
	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>
	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com>
	 <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com>
	 <4545C52A.5010105@innova-card.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Miguel Ojeda wrote:
> > Refresh rate is fixed in this driver (the user can change it to other
> > value at Kconfig or at loading time as a module parameter).
> >
> > An application should not refresh images so fast (the LCD controller
> > can handle it, but the readability is pretty bad). Having a refresh
> > rate like 10 Hz for example, the application can be sure all images
> > are displayed. Anyway, an animation of 10 Hz wouldn't be fine at this
> > kind of LCDs, so it is pointless which the refresh rate of the driver
> > is, as it is not useful to display images as fast as the driver
> > refresh the LCD.
> >
>
> An application might want to display quickly a set of images, not for
> doing animations but rather displaying 'fake' greyscale images.
>

And what is the problem?

> > Well, mmaping is the best option, as it is the easiest and the
> > fastest. Any use will be better using mmaping than doing synchrone
> > write(). Yes, many uses just need a write() call, but other uses would
> > need mmap.
> >
>
> That's true for devices which have a frame buffer. But it's not your
> case. You _emulate_ this behaviour and I can see big drawbacks to
> this design:
>
>   - You need to keep synchrone your buffer and the display every
>     100ms. It makes your CPU busy even if nothing has been written in
>     LCD for a while. Futhermore this kind of display is likely to run
>     on embedded system where CPU speed can be less than 100MHz.
>

No. Paulo pointed that and I added a cache so the CPU is doesn't waste
much time. Less than 1% on a P4 3Ghz. The kernel do a lot more things,
not only refreshing the LCD.

The driver is not intended for an embedded system, as they usually
doesn't have a parallel port.

>   - All accesses to the device depend on the previous behaviour whereas
>     write(), read() syscall could be synchrone and easier to use for
>     fast writing of image sets. Actually the refresh stuff is really
>     needed only if you mmap the device. And it seems not really used
>     for now since it was broken on your last patch.
>

I had the write() and read() syscalls coded. People like Pavel didn't
like such behaviour, and he told me to recode it to be a framebuffer.
Please read other threads before telling it is wrong when other people
thought the opposite.

>   - Your driver _is_ a frame buffer driver by design, I think you
>     don't need to seperate cfa12864cb.c and cfa12864cfb.c
>

Well, I think it's better to split it. I have already given reasons to you.

> So ok you code is very small with this design but IMHO it is not the
> most polyvalent if you want to address all needs. Why not starting the
> refresh stuff only if you mmap the device and keep the rest synch ?
>

Because mmaping is better than read() write() in any case. I know, it
waste a little more CPU, but get the point: If you only need to show
static images, the driver won't update the LCD (that is what really
waste the CPU time). If you really need performance, you can decrease
the refresh rate if you don't need it. But 20 Hz is useful for
everybody and doesn't waste a lot of time.

Also, if you want attach fbcon to the device, you need to refresh it
constantly to behave like a framebuffer device, so it is a
requirement.

>
> > $ cat /sys/module/cfag12864b/parameters/cfag12864b_rate
> >
> > Yes, a more generic option would be better. Do the fbdevices have some
> > standard way to retrieve such kind of info (like the bits per pixel,
> > width, height...)? If not, which would be a good to retrieve the
> > refresh rate?
>
> maybe fb_ioctl() can return that. Or your driver can have its own
> ioctl() method which could return such specific info.

No way. Please read previous threads. Greg KH doesn't want more ioctls
in any way. The first versions used it, and he told me to remove them.
Sorry.

>
>                 Franck
>
