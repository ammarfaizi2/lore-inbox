Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965496AbWJ3JZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965496AbWJ3JZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965497AbWJ3JZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:25:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:14613 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965496AbWJ3JZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:25:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=HJ+KdowI4qQhZnv5WlUtZY7p9WPaDd/rBqQpRAZ/vhQgkMsSk9vhEv5EpRQqJJcJDiuGz4JsLCZuH57sYLqc2E9SN2Sk3XxyuTEtPeT44sxrYnBTujAg/50tO0WJ6F0Au/je0FsXCCGH9ZOqcvyYyNZk63YOxsejIJ8HxUjlZSQ=
Message-ID: <4545C52A.5010105@innova-card.com>
Date: Mon, 30 Oct 2006 10:26:02 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: Franck Bui-Huu <vagabon.xyz@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>	 <453CE85B.2080702@innova-card.com>	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com> <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com>
In-Reply-To: <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote:
> Refresh rate is fixed in this driver (the user can change it to other
> value at Kconfig or at loading time as a module parameter).
> 
> An application should not refresh images so fast (the LCD controller
> can handle it, but the readability is pretty bad). Having a refresh
> rate like 10 Hz for example, the application can be sure all images
> are displayed. Anyway, an animation of 10 Hz wouldn't be fine at this
> kind of LCDs, so it is pointless which the refresh rate of the driver
> is, as it is not useful to display images as fast as the driver
> refresh the LCD.
> 

An application might want to display quickly a set of images, not for
doing animations but rather displaying 'fake' greyscale images.

> Well, mmaping is the best option, as it is the easiest and the
> fastest. Any use will be better using mmaping than doing synchrone
> write(). Yes, many uses just need a write() call, but other uses would
> need mmap.
> 

That's true for devices which have a frame buffer. But it's not your
case. You _emulate_ this behaviour and I can see big drawbacks to
this design:

  - You need to keep synchrone your buffer and the display every
    100ms. It makes your CPU busy even if nothing has been written in
    LCD for a while. Futhermore this kind of display is likely to run
    on embedded system where CPU speed can be less than 100MHz.

  - All accesses to the device depend on the previous behaviour whereas
    write(), read() syscall could be synchrone and easier to use for
    fast writing of image sets. Actually the refresh stuff is really
    needed only if you mmap the device. And it seems not really used
    for now since it was broken on your last patch.

  - Your driver _is_ a frame buffer driver by design, I think you
    don't need to seperate cfa12864cb.c and cfa12864cfb.c

So ok you code is very small with this design but IMHO it is not the
most polyvalent if you want to address all needs. Why not starting the
refresh stuff only if you mmap the device and keep the rest synch ?


> $ cat /sys/module/cfag12864b/parameters/cfag12864b_rate
> 
> Yes, a more generic option would be better. Do the fbdevices have some
> standard way to retrieve such kind of info (like the bits per pixel,
> width, height...)? If not, which would be a good to retrieve the
> refresh rate?

maybe fb_ioctl() can return that. Or your driver can have its own
ioctl() method which could return such specific info.

		Franck
