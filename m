Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWE1ADF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWE1ADF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 20:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWE1ADF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 20:03:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:20012 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964989AbWE1ADE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 20:03:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LVbrnWvlvP1UBFkp77FKerS5xGdVd/iabVif9rkKsZc+OoKZtNm3YzfJiCO3HXMzOUCT+gzPXJwMYN5DvUxW+xrtEO1JA6vLlQbWGAOTmR6cIDfj0+AKKcvpOzp67X1BNfCsrVjLTQDF2cl1TF45/erAyKIToUZyNhRpcpw4MpY=
Message-ID: <9e4733910605271703p5f9de85dw74bc97d86d9a3cd7@mail.gmail.com>
Date: Sat, 27 May 2006 20:03:02 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605271801.36942.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
	 <20060526173913.GA3357@ucw.cz>
	 <200605271801.36942.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/06, D. Hazelton <dhazelton@enter.net> wrote:
> On Friday 26 May 2006 17:39, Pavel Machek wrote:
> > Could fb and drm simply be 'merged' into one driver (at least as far
> > as rest of system is concerned)? That should have no driver model
> > issues...?
> >                                                       Pavel
>
> And such was my original idea. However I've been informed that doing such
> would either constitute "Breaking working systems" or "introducing a third
> and unneeded driver".
>
> For that reason I've begun doing a bit of research and planning... it might
> show fruit in a couple of days.

The simplest solution to starting a DRM/fbdev merge is to declare
fbdev the bottom layer that binds to the hardware. Doing this is easy
since the fbdev drivers already contain code for binding to the
hardware. If you don't do this and instead create a new bottom layer
that binds, you are forced into modifying the 60 existing fbdev
drivers to remove their binding code and to use the new layer. I don't
see anyone volunteering to edit 60 fbdev drivers.

DRM drivers currently works in stealth mode. They use the graphics
hardware without attaching to it like a normal PCI driver would. Using
hardware in stealth mode is a bad design, but DRM can't be modified to
attach to the PCI device because it would conflict with the fbdev
driver that is already attached.

So, the easiest way to fix this is to change the eight DRM drivers in
the kernel so that they are linked to their corresponding fbdev
driver. After these changes you would not be able to load the DRM
drivers without also loading their corresponding base fbdev driver.
The embedded people are still happy since they can load fbdev and
ignore DRM. Note that you can use symbols to create a dependency
without changing the existing functions of either driver.

Making the drivers dependent starts us down the path of a full merge
and having one driver in control of the hardware. As part of the basic
merge patch I would also move the drm directory from drivers/char/drm
to drivers/video/drm. After this very basic linkage is established you
can start making real changes.

BTW, I have already submitted a patch that does this and it was
rejected. I might be able to find it somewhere, but the dependency
code is not very hard to write.

-- 
Jon Smirl
jonsmirl@gmail.com
