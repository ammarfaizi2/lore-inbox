Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUIEVMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUIEVMz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 17:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUIEVMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 17:12:55 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:5473 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267326AbUIEVMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 17:12:43 -0400
Message-ID: <9e47339104090514122ca3240a@mail.gmail.com>
Date: Sun, 5 Sep 2004 17:12:42 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New proposed DRM interface design
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <1094398257.1251.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040904102914.B13149@infradead.org>
	 <4139B03A.6040706@tungstengraphics.com>
	 <20040904122057.GC26419@redhat.com>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
	 <1094398257.1251.25.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure you can use this to get around both fbdev and DRM trying to claim
the resource. But it doesn't help at all to fix the problem that fbdev
and DRM are programming the radeon chip in conflicting ways.

Look at the case of two independent users, one logged into each head.
One is running DRI and one fbdev. On every process swap I am going to
have to save graphics state, stop the coprocessor, flush the drawing
queue, etc because fbdev runs the chip in 2D mode and DRM runs it in
3D. It may take longer than a timeslice to flush the graphics queue. 
In a coordinated driver world I can leave the chip in 3D mode and
processes swap without overhead. The coordinated driver can also
manage allocating the VRAM between users.

How is multihead mode setting going to work with separate drivers? Set
head #1 using fbdev and head #2 using DRM? I can't imagine how merged
fb will work in that model. Or am I supposed to teach existing fbdev
how to do merged fb?

Some of the fbdev drivers are starting to attempt acceleration using
3D mode. This is going to be a complete mess when swapping to DRM.

What is so awful about merging the code? I'm the one doing the all of
the work. I intend to use 95% of the code extracted from fbdev without
change. I'm not getting rid of fbdev capability in the merged code,
I'm just coordinating use of the hardware.

On Sun, 05 Sep 2004 16:31:15 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> The only glue structure you need for most of this is
> 
> struct fb_device
> {
>         struct fb_info *fb;     /* NULL or frame buffer device */
>         struct dri_whatever *dri;  /* As yet not nicely extracted DRI
>                                         object */
>         atomic_t refcnt;
>         void *private
> };
> 
> Right now the drvdata for most PCI/AGP frame buffers is set to the
> fb_info. If that is set to the shared object then you can attach DRI and
> or FB first and they can find and call each others methods.
> 
> It might also need a single lock just to avoid DRI deciding to go away
> while fb is calling dri and the reverse although I think the refcnt is
> easier and cheaper.
> 
> With that in place if X tells DRI "640x480 starting here" then DRI can
> tell fb "640x480 starting here". Similarly fb and dri can find each
> other for acceleration and the kernel can become a DRI client for
> console acceleration.
> 
> Once you have this object you can start attaching memory managers and
> mode setup pointers to the shared structure so that they live
> independantly.
> 
> 



-- 
Jon Smirl
jonsmirl@gmail.com
