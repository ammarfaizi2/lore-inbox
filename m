Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWEWRRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWEWRRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWEWRRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:17:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:58799 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751051AbWEWRRT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:17:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ry0Su7xXsDfT2NStvAFwneCYSeDdEnkp45MuhEE1cmW+Wto4d2uxaODcaNZBRY+EnY6veEB1K35r0UYj+Z9NuiD//uzUTe4FJsLSFG5Af92iy0Dxv68ZXMcriVRySDwLAwsd3k8OZv1zeneE1YvKTynfxEQ2GjysA/vN9PPOmJ0=
Message-ID: <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
Date: Tue, 23 May 2006 13:17:18 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605230048.14708.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com>
	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <200605230048.14708.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/06, D. Hazelton <dhazelton@enter.net> wrote:
> Not that I can see, but the network connectivity bit should probably not be
> targeted in the first set of patches. IMHO, the best way to handle this would
> be to start merging the DRI drivers into the Framebuffer drivers.  This would
> then provide some of the infrastructure needed to bring an accelerated
> graphics framework into the realm of possibility just in userspace.

Merging fbdev and DRM is the obvious place to start. Fully
implementing a merge requires solving a number of issues. Here are a
few to get you going...

1) Running the video ROM at boot to reset cards, emu86
2) Sorting out VGA when multiple cards are present
3) Determining where mode setting code is going to live
4) Providing a default driver for video cards that have none
5) Actually merging DRM/fbdev
6) Some way for multiple users to control their video card without being root

None of this is rocket science, patches have been already attempted
for everything on the list. The real challenge is political, not
technical.

> By implementing a framework where userspace doesn't have to know - or care -
> about the hardware, which, IMNSHO, is the way things should be, then
> userspace applications can take advantage of such a system and be even more
> stable.

A true monolithic design doesn't really work for video hardware. In
the monolithic model all devices in a class present a uniform API. The
better design for GPUs is the exo-kernel model. DRM already uses the
exo-kernel model. With exokernels each driver presents a unique API
and userspace libraries are used to provide a uniform API.

The exo-kernel model works well with software fallbacks. mesa provides
a complete software OpenGL implementation. The device specific user
space library then overlays functions that its hardware can
accelerate.

The current microkernel'ish design of the 2D Xserver causes a great
deal of conflict with existing Linux subsystems. Given that 3D is
already in the exo-kernel model, I don't see much benefit is pursuing
a microkernel 2D solution.

> > The necessary kernel support would include a graphics-memory
> > allocator, resource management, GPU-time allocation, etc, as well as
> > support for an overlaid kernel console.  Ideally an improved graphics
> > driver like that would be able to dump panics directly to the screen
> > composited on top of whatever graphics are being displayed, so you'd
> > get panics even while running X.  If that kind of support was
> > available in-kernel, fixing X to not need root would be far simpler,

There is no technical reason requiring X to run as root, it is a
matter of choice and convenience. I have had versions of X with 3D
support running without root on my local machine but the patches were
not merged.

> > plus you could also write replacement X-like tools without half the
> > effort.  Given that sort of support, a rootless xserver would be a
> > fairly trivial wrapper over whatever underlying implementation there
> > was.
>
> Here you outline what is needed, and strangely I find myself thinking that a
> lot of this code has already been written. The DRI/DRM system provides a
> method for userspace to directly access the acceleration features of graphics
> cards. Would it not be possible, then, to take the DRI system, merge it with
> the framebuffer system in some manner, and provide a single interface to
> userspace?

The strategy of adding acceleration feature to the framebuffer drivers
causes conflict with X and DRM drivers. The better solution is to
collect all acceleration support into a single driver. The DRM
acceleration code is much more advanced than the fbdev code.

> One thing that I've been thinking about is that there is some need for DMA to
> and from the card. This would probably best be done by the current S/G DMA
> system, as it's a well known and very stable part of the kernel that is
> (IIRC) exposed to userspace.

DRM already supports DMA to/from the GPU and does security checks on
the parameters. It also security checks the commands being fed to the
GPU to keep Direct Rendering applications from causing mischief.

-- 
Jon Smirl
jonsmirl@gmail.com
