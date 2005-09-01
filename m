Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVIAGA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVIAGA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVIAGA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:00:57 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:38391 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964830AbVIAGA4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:00:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VSdBI5d36apk+UzQTCHrnrqVuIHU2jRrSU2Pk++fRo/Kwfplg7X/p6vv1AjRJuJK57d15QFgK/j5FjjxeMCp3GiJ24fbN4WiEq3bQaEg7RzBBXKZGJALuK/3PpdHuwKh9AdhInrgku+iMrk82+EdugGRl7WlBk+RyGAUUGOVGF8=
Message-ID: <69304d1105083123007c00f9e0@mail.gmail.com>
Date: Thu, 1 Sep 2005 08:00:55 +0200
From: Antonio Vargas <windenntw@gmail.com>
To: Ian Romanick <idr@us.ibm.com>
Subject: Re: State of Linux graphics
Cc: Allen Akin <akin@pobox.com>,
       Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43167150.1040808@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
	 <20050831063355.GE27940@tuolumne.arden.org>
	 <1125512970.4798.180.camel@evo.keithp.com>
	 <20050831200641.GH27940@tuolumne.arden.org>
	 <1125522414.4798.222.camel@evo.keithp.com>
	 <20050901015859.GA11367@tuolumne.arden.org>
	 <43167150.1040808@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, Ian Romanick <idr@us.ibm.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Allen Akin wrote:
> > On Wed, Aug 31, 2005 at 02:06:54PM -0700, Keith Packard wrote:
> > |
> > |         ...So far, 3D driver work has proceeded almost entirely on the
> > | newest documented hardware that people could get. Going back and
> > | spending months optimizing software 3D rendering code so that it works
> > | as fast as software 2D code seems like a thankless task.
> >
> > Jon's right about this:  If you can accelerate a given simple function
> > (blending, say) for a 2D driver, you can accelerate that same function
> > in a Mesa driver for a comparable amount of effort, and deliver a
> > similar benefit to apps.  (More apps, in fact, since it helps
> > OpenGL-based apps as well as Cairo-based apps.)
> 
> The difference is that there is a much larger number of state
> combinations possible in OpenGL than in something stripped down for
> "just 2D".  That can make it more difficult to know where to spend the
> time tuning.  I've spent a fair amount of time looking at Mesa's texture
> blending code, so I know this to be true.
> 
> The real route forward is to dig deeper into run-time code generation.
> There are a large number of possible combinations, but they all look
> pretty similar.  This is ideal for run-time code gen.  The problem is
> that writing correct, tuned assembly for this stuff takes a pretty
> experience developer, and writing correct, tuned code generation
> routines takes an even more experienced developer.  Experienced and more
> experienced developers are, alas, in short supply.

Ian, the easy way would be to concentrate on 2d-like operations and
optimize them by hand. I mean if _we_ are developing the opegl-using
application (xserver-over-opengl), we already know what opengl
operations and moder are needed, so we can concentrate on coding them
in software. And if this means that we have to detect the case when a
triangle is z-constant, then so be it.

Using an OSX desktop everyday and having experience on
software-graphics for small machines, and assuming OSX is drawing the
screen just by rendering each window to a offscreen-buffer and then
compositing, our needs are:

1. offscreen buffers, that can be drawn into. we don't really need
anything fancy, just be able to point the drawing operations to
another memory space. they should be any size, not just power-of-two.

2. whole screen z-buffer, for depth comparison between the pixels
generated from each window.

3. texture+alpha (RGBA) triangles, using any offscreen buffer as a
texture. texturing from a non-power-of-two texture is not that
difficult anymore since about '96 or '97.

4. alpha blending, where the incoming alpha is used as a blending
factor with this equation: scr_color_new = scr_color * (1-alpha) +
tex_color * alpha.

1+2+3 gives us a basic 3d-esque desktop. adding 4 provides the dropshadows ;)

But, 3d software rendering is easily speeded-up by not using z-buffer,
which is a PITA. Two aproaches for solving this:

a. Just sort the polys (they are just 2 polys per window) back to
front and draw at screen-buffer flip. This is easy. Previous work I
did sugests you can reach 16fps for a 320x192x8bit screen with a 10
mips machine (68030@50mhz).

b. Implement a scanline zbuffer, where we have to paint by scanlines
instead of whole triangles. Drawing is delayed until screen-buffer
flip and then we have an outer loop for each screen scanline, middle
loop for each poly that is affected and inner loop for each pixel from
that poly in that scanline.

Software rendering is just detecting the common case and coding a
proper code for it. It's not really that difficult to reach
memory-speed if you simply forget about implementing all combinations
of graphics modes.

> BTW, Alan, when are you going to start writing code again? >:)
> 
> > So long as people are encouraged by word and deed to spend their time on
> > "2D" drivers, Mesa drivers will be further starved for resources and the
> > belief that OpenGL has nothing to offer "2D" apps will become
> > self-fulfilling.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.6 (GNU/Linux)
> 
> iD8DBQFDFnFQX1gOwKyEAw8RAgZsAJ9MoKf+JTX4OGrybrhD+i2axstONgCghwih
> /Bln/u55IJb3BMWBwVTA3sk=
> =k086
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
