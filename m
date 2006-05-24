Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWEXAYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWEXAYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 20:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWEXAYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 20:24:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:23949 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932514AbWEXAYR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 20:24:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vw3vVtK8S4Qe/I/QvfNLGmmEKVWWMCfLo1iUmFbXlLV8q4IJvyqwDc15ytitADfexfmqhVJWtJMVoPQDFQGnw/yeFZZsYoIEeycXXNrfGCl4mg4AhwBG7H//awWmj30Mv54ZNoly5bd5LZ32YXF6I+b/4PGTPEIv59fNm13JuCU=
Message-ID: <9e4733910605231724i73c5f389m1be332d664efe2c5@mail.gmail.com>
Date: Tue, 23 May 2006 20:24:16 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com>
	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <200605230048.14708.dhazelton@enter.net>
	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On May 23, 2006, at 13:17:18, Jon Smirl wrote:
> >> By implementing a framework where userspace doesn't have to know -
> >> or care - about the hardware, which, IMNSHO, is the way things
> >> should be, then userspace applications can take advantage of such
> >> a system and be even more stable.
> >
> > A true monolithic design doesn't really work for video hardware. In
> > the monolithic model all devices in a class present a uniform API.
> > The better design for GPUs is the exo-kernel model. DRM already
> > uses the exo-kernel model. With exokernels each driver presents a
> > unique API and userspace libraries are used to provide a uniform API.
>
> The one really significant potential problem with the exo-kernel
> model for graphics is that the kernel *must* have a stable way to
> display kernel panics regardless of current video mode, framebuffer
> settings, 3D rendering, etc.  The kernel driver should be able to
> provide some fundamental operations for compositing text on top of
> the framebuffer at the primary viewport regardless of whatever
> changes userspace makes to the GPU configuration.  We don't have this
> now, but I see it as an absolute requirement for any replacement
> graphics system.  This means that the kernel driver should be able to
> understand and modify the entire GPU state to the extent necessary
> for such a text console.

It's not as bad as it seems. I haven't tried implementing this; I
believe the Novell kernel debugger is the system that has done so.
Here's what I think needs to be done, but I may be missing something.

1) Track where the scanout buffer is.
2) Track the x/y size of the buffer and it's pixel format
3) Know how to stop the GPU (usually a poke into an IO port)
4) Have a minimal font in the driver - fbdev already has this.

On a panic, stop the GPU and then use the font and buffer info to
paint into the display. fbdev already contains code that can draw
using the fbdev fonts into an arbitrary resolution/pixel format
buffer. The code that implements this is small and is probably already
in the kernel that you are using.

This model doesn't work with the current X server since it never tells
the kernel the location and size of the scan out buffer.

Of course they are windows when this won't work, for example a panic
in the middle of a mode change, but it is a lot better than what we
have today.

-- 
Jon Smirl
jonsmirl@gmail.com
