Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270999AbUJUWWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270999AbUJUWWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271019AbUJUWUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:20:16 -0400
Received: from smtp06.auna.com ([62.81.186.16]:41701 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S270999AbUJUV5U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:57:20 -0400
Date: Thu, 21 Oct 2004 21:57:13 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4176E08B.2050706@techsource.com>
	<9e4733910410201808c0796c8@mail.gmail.com>
	<9e473391041020181150638b4@mail.gmail.com> <4177185A.9080708@sover.net>
	<4177DF15.8010007@techsource.com>
In-Reply-To: <4177DF15.8010007@techsource.com> (from miller@techsource.com
	on Thu Oct 21 18:08:53 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1098395833l.27352l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.21, Timothy Miller wrote:
> 
...
> > antialiasing (related to alpha blending)
> 
> Antialiasing implies oversampling or supersampling, unless you're 
> thinking about something else.  Sometimes, "antialiasing" is nothing 
> more than a fuzzy texture.  For instance, the way the X11 font server 
> handles antialiased text... it just spits out a grayscale bitmap which 
> can be used as texture.
> 
> > bitblt
> > fast primitive drawing
> 
> No problem.
> 
> > accelerated offscreen operations
> 
> It's funny that people mention that.  Every DDX module I have ever 
> produced has had sophistocated off-screen memory management so that 
> pixmaps could be accelerated.  I never even considered NOT supporting 
> accelerated off-screen surfaces.
> 
> There was one chip I had to support a number of years ago which didn't 
> have separate registers for the base pointers to source and destination 
> surfaces.  That meant that you couldn't use "bitblt" to copy an image 
> from off-screen to on-screen.  What I ended up having to do was 
> implement bitblt as a texture-mapping operation.  (It wound up being 
> slightly faster than the regular bitblt, even if the source and dest 
> were the same surface.)
> 
> Anyhow, in my world, accelerated off-screen surfaces are a given.
> 

Following with this, and looking at the new features that user interfaces
show, I think everything should be off-screen. Look.

Taking OSX as the best example, all the rendering is done offscreen, and
then the result is blittted and alpha merged to the screen. They use
OpenGL to draw each window offscreen, take the image and paste it as texture
onto a rectangular polygon, and then alpha-blend it with the others on the
screen. This is overkill, but allows to do things like put a movie onto
an spinning rectangle...

Without entering to 3D, I would design a card that always renders offscreen.
Each window has its own offscreen buffer, and redraws blit/blend the
pixmap onto the screen. With a good and fast scaler, you can get some
fancy things for free:
- antialiasing: just make the back buffer 2x2 or 4x4 the screen space of
  the window, and resample/filter it. Font rendering just needs to be
  monochrome, but at higher resolution. The rescaler will give you the
  antialiasing. Good work for a DSP.
- real multilayer transparency and shadows
- real time zooming, for things like expocity (metacity version of Exposé):
  no redrawing of contents, just rescaling.
- with some projective math in 2D, you can easily do things like rotations
  over the axis of the screen...simulated.

In short, you need:
- A ton of memory for offscreen buffer. Note: this depends on how much windows
  you want to handle, not on screen res...:)
- Fast (very high res) but simple (no algorthimic antialiasing for lines nor
  fonts) 2D renderer
- An _ultra fast_ scaler/blitter/blender. Scaling can be just 2D, and even
  power-of-2 based with good filtering.

Really simple things, the problem is that they need to be lightning fast.
No 3D needed, the stacking order can be stored in soft and just determines
the order for blending. OSX runs on my iBook, so if a G3 with an ATI 7200
can do, a modern FPGA sure can beat it.

I hope all this cr*k sm*king ends up in something useful for you...

Ah, and you can add later the 3D part as a daughterboard....;)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #4


