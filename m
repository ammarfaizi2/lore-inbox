Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWE2Xsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWE2Xsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWE2Xsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:48:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:41594 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751261AbWE2Xsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:48:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qy4MyjF1A60NTgTDlWn4eSFNcs+y78PE8scFsWraYne/wle5dbES2/jSYQbjGe0MnxDqokY8r+9FZ54pqSzXkZd1tDLdW8LpNoA9jFcC/Km6nX3MW3oe6Pus2hnxf81P0vC40jADXIA6YQ7QT/XUMuUy1YFEtBUuJO9mhTskcsI=
Message-ID: <4423333a0605291648w11a66440xcd9f833f654fb468@mail.gmail.com>
Date: Tue, 30 May 2006 01:48:28 +0200
From: "Marko M" <marcus.magick@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Pavel Machek" <pavel@ucw.cz>, "D. Hazelton" <dhazelton@enter.net>,
       "Jon Smirl" <jonsmirl@gmail.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <20060529102339.GA746@elf.ucw.cz>
	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
	 <20060529124840.GD746@elf.ucw.cz>
	 <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no doubt in my mind. If we want a robust, clean and feature
rich graphical subsystem in Linux, we shall re implement lower layer as
much as possible (AMAP). Transition as always will not be painless,
but nevertheless is much needed.

AFAIC Jon's approach is about "doing things right" AMAP and
maintainer's approach is keeping things backward compatible AMAP -
which is the meaning of "doing things right" in their books and both
goals are legitimate. So things sum up to this:

1) Current framework is inefficient (duplicated work) and inconsistent
(with good OS design). Modifying it with backward compatibility in
mind adds to the complexity of the solution and probably results in
lots of nasty hacks, which in return slows down development and
inevitably invokes more disputation. => Slow development with
questionable results.

2) Any breakage of currently working drivers or applications demand
lots of work on fixing them. => Slow deployment of usable solutions
and painful death from irrelevance.

So, we need a new subsystem as clean as possible, which on the other
hand would require as lees modified LOCs as possible
(driver/application base). It is basically a balance between principles
and real world demands (as always).

My solution:

1) Make a new subsystem (fbdev+DRM or so), which would be an OPTIONAL
replacement for current one, but in such way that porting existing
drivers would be fast and easy AMAP. Pretty much like XAA -> EXA.

2) After porting drivers for most relevant chips (R200, GF2/4,
i810/i915, Unichrome...), offer help to Xorg guys in writing DDX part
of the server for this OPTIONAL target.

3) Help adding backends for this subsystem to all relevant rendering
libraries (SDL, DirectFB, Cairo, Evas...) and gain acceptance.
Backward compatibility with frame buffer applications is implied,
either generic or through compatibility layer.

4) Write a good documentation and if system is functioning well,
people will start using it as it will provide clear advantage over the
old one (at least for security). Then, some distributions will start
using it by default, and if everything goes well (almost never),
vendors will eventually start releasing proprietary drivers for it.

5) New subsystem is all new and fancy Linux thing, while old one is
becoming legacy.

The key point is making porting of current fbdev/DRM drivers as easy
as possible. This is where KGI failed in my opinion, so lets not
repeat that mistake.

My $0,05 to gfx subsystem architecture:

The key point is to provide a good drawing API which wouldn't fight
abstracting different hardware and at the same time would be adequate
for accelerating most current rendering libraries (Porter/Duff,
splines, etc). The fbdev should undoubtedly provide more
advanced/usable API, so maybe DirectFB could give us a good waymark.

It would be neat if we could create many (virtual) frame buffers and
interact with them on different consoles, or redirect them to
different CRTCs. They would be just like different applications (with
their contexts) running on gfx cards and underlying framework
(fbdev/DRM) would control their switching and card(s)
detection/resource management.

Regarding separation of gfx drivers to 2D and 3D parts, I think that
it should exist i some way, but with all memory and bus management in
2D one. I'm not that familiar with 3D hardware and rendering pipes,
but we should try to make it like loadable module/extension to this
new 2D core driver/API (fused fbdev/DRM), even if it's not so
distinctively separated from 2D core. There is no much wisdom in
hardware blitters, backend scalers, DMA engines or PCI(E)/AGP bus
mastering, although graphic memory management (controller) could be an
issue here...

As I see it, gfx vendors are concerned about exposure of their
proprietary 3D hardware design, and possibly some parts of
sophisticated video encoding hardware, which is protected by patents
(MPEG2, Macromedia protected TV-out, etc). So, we should enable them
(ATi, NVidia) to provide us with good OpenSource 2D part on which they
would cooperate with community - improving quality and reducing their
costs - without concern of compromising their IP, or exposing themselves
to legal actions of other parties.

My point is that we should design a new framework, with more
meaningful and practical separation in mind. So, instead 2D and 3D
parts, with duplicated functions, we should have "basic 2D" Open Source
part, which will handle all basic PCI/memory/mode_setting and 2D core
functionality, and optional open or closed source part for 3D
acceleration and proprietary features/extensions.

Before flaming me for supporting those corporate blood-suckers, just
think about it... Proprietary software will not disappear just because
some of us don't like it. We should reach the point where everybody
will listen to what we'll have to say, and isolation is not a way to
get there. Making people share is communism - stimulating them and
making friendly environment for sharing is business and democracy. So
lets make that environment! This will actually promote FOSS drivers,
while keeping vendors happy about their dirty secrets. If we could
extract all basic, IP non-violate, functions into the "basic 2D"
driver, then we would have excellent OSS drivers for offices and
enterprise with less effort, so we could focus on hacking just 3D and
possibly other proprietary/closed parts for our cause and enjoyment
(it would certainly be much easier). Big digital content producers,
which utilize 3D workstations, will use proprietary drivers any way,
because only vendors can afford to pay application and driver
certificates, while gamers could use whatever they want - much like
now days.

Regarding obsolescence of vgacon and vesafb:

These drivers are so fundamental that this isn't even discussable. Do
what ever you want but provide vgacon and generic vesafb drivers.
Though I really fail to understand way vgacon can't be loaded and
unloaded as needed before actual driver kicks in.

And another slightly off topic thing about gfx drivers issue:

Being video engineer, I must say that I'm all against neglecting 2D
core functions and using mainly 3D hardware for things like color
space conversions, video scaling or font rendering. It is not
efficient (more power hungry) and in some cases even hardly plausible
at all (multiple video overlays), not to mention dependency on right
software implementation. Video processing is often misunderstood by
programmers and computer graphic guys which often leads to terminology
misuse and erroneous implementations. Relying on dedicated hardware is
more neat then reimplementing that feature by coding through several
software layers (library/API/driver).

That said, I think you guys are underestimating momentum which Linux
graphics (desktop) has gained. If Linux community could pull off
something like discussed above, it would certainly gain enormous
attention in just couple of months.

Regards

Marko M
