Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbVIAUDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbVIAUDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVIAUDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:03:07 -0400
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:31669 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030345AbVIAUDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:03:05 -0400
Date: Thu, 1 Sep 2005 13:03:01 -0700
From: Allen Akin <akin@pobox.com>
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: State of Linux graphics
Message-ID: <20050901200301.GE11367@tuolumne.arden.org>
Mail-Followup-To: Discuss issues related to the xorg tree <xorg@lists.freedesktop.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e47339105083009037c24f6de@mail.gmail.com> <1125422813.20488.43.camel@localhost> <20050831063355.GE27940@tuolumne.arden.org> <1125512970.4798.180.camel@evo.keithp.com> <20050831200641.GH27940@tuolumne.arden.org> <1125522414.4798.222.camel@evo.keithp.com> <20050901015859.GA11367@tuolumne.arden.org> <1125547173.4798.289.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125547173.4798.289.camel@evo.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 08:59:23PM -0700, Keith Packard wrote:
| 
| Yeah, two systems, but (I hope) only one used for each card. So far, I'm
| not sure of the value of attempting to provide a mostly-software GL
| implementation in place of existing X drivers.

For the short term it's valuable for the apps that use OpenGL directly.
Games, of course, on platforms from cell-phone/PDA complexity up; also
things like avatar-based user interfaces.  On desktop platforms, plenty
of non-game OpenGL-based apps exist in the Windows world and I'd expect
those will migrate to Linux as the Linux desktop market grows enough to
be commercially viable.  R128-class hardware is fast enough to be useful
for many non-game apps.

For the long term, you have to decide how likely it is that demands for
new functionality on old platforms will arise.  Let's assume for the
moment that they do.  If OpenGL is available, we have the option to use
it.  If OpenGL isn't available, we have to go through another iteration
of the process we're in now, and grow Render (or some new extensions)
with consequent duplication of effort and/or competition for resources.

| I continue to work on devices for which 3D isn't going to happen.  My
| most recent window system runs on a machine with only 384K of memory...

I'm envious -- sounds like a great project.  But such systems aren't
representative of the vast majority of hardware for which we're building
Render and EXA implementations today.  (Nor are they representative of
the hardware on which most Gnome or KDE apps would run, I suspect.)  I
question how much influence should they have over our core graphics
strategy.

| Again, the question is whether a mostly-software OpenGL implementation
| can effectively compete against the simple X+Render graphics model for
| basic 2D application operations...

I think it's pretty clear that it can, since the few operations we want
to accelerate already fit within the OpenGL framework.  

(I just felt a bit of deja vu over this -- I heard eerily similar
arguments from Microsoft when the first versions of Direct3D were
created.)

|                               ...and whether there are people interested
| in even trying to make this happen.

In the commercial world people believe such a thing is valuable, and
it's already happened.  (See, for example,
http://www.hybrid.fi/main/esframework/tools.php).

Why hasn't it happened in the Open Source world?  Well, I'd argue it's
largely because we chose to put our limited resources behind projects
inside the X server instead.

| > The point of OpenGL is to expose what the vast majority of current
| > display hardware does well, and not a lot more.  So if a class of apps
| > isn't "happy" with the functionality that OpenGL provides, it won't be
| > happy with the functionality that any other low-level API provides.  The
| > problem lies with the hardware.
| 
| Not currently; the OpenGL we have today doesn't provide for
| component-level compositing or off-screen drawable objects. The former
| is possible in much modern hardware, and may be exposed in GL through
| pixel shaders, while the latter spent far too long mired in the ARB and
| is only now on the radar for implementation in our environment.

Component-level compositing:  Current and past hardware doesn't support
it, so even if you create a new low-level API for it you won't get
acceleration.  You can, however, use a multipass algorithm (as Glitz
does) and get acceleration for it through OpenGL even on marginal old
hardware.  I'd guess that the latter is much more likely to satisfy app
developers than the former (and that's the point I was trying to make
above).

Off-screen drawable objects:  PBuffers are offscreen drawable objects
that have existed in OpenGL since 1995 (if I remember correctly).
Extensions exist to allow using them as textures, too.  We simply chose
to implement an entirely new mechanism for offscreen rendering rather
than putting our resources into implementing a spec that already
existed.

| So, my motivation for moving to GL drivers is far more about providing
| drivers for closed source hardware and reducing developer effort needed
| to support new hardware ...

I agree that these are extremely important.

|                      ...than it is about making the desktop graphics
| faster or more fancy.

Some people do feel otherwise on that point. :-)

| The bulk of 2D applications need to paint solid rectangles, display a
| couple of images with a bit of scaling and draw some text.

Cairo does a lot more than that, so it would seem that we expect that
situation to change (for example, as SVG gains traction).

Aside:  [I know you know this, but I just want to call it out for any
reader who hasn't considered it before.]  You can almost never base a
design on just the most common operations; infrequent operations matter
too, if they're sufficiently expensive.  For example, in a given desktop
scene glyph drawing commands might outnumber window-decoration drawing
commands by 1000 to 1, but if drawing a decoration is 1000 times as slow
as drawing a glyph, it accounts for half the redraw time for the scene.
In an important sense the two operations are equally critical even
though one occurs 1000 times as often as the other.

| Neither of us gets to tell people what code they write...

True, but don't underestimate your influence!

|                                                         ... right now a
| developer can either spend a week or so switching an XFree86 driver to
| EXA and have decent Render-based performance or they can stand around
| and wait for 'some one else' to fix the Mesa/DRI drivers so that we can
| then port Xgl to them. ...

Also true, but the point I've often tried to make is that this situation
is the result of a lot of conscious decisions that we made in the past:
funding decisions (where funded work was involved), design decisions,
personal decisions.  It doesn't have to be this way, and there are
advantages in not doing it this way again.  Jon's paper that inspired
this exchange asks us to think about how we might do things better in
the future.

| Plus, it's not all bad -- we're drawing in new developers who are
| learning about how graphics chips work at a reasonably low level and who
| may become interested enough to go help with the GL drivers. And, I'm
| seeing these developers face up to some long-standing DRI issues
| surrounding memory management. EXA on DRM (the only reasonable EXA
| architecture in my mind) has all of the same memory management issues
| that DRI should be facing to provide FBO support. Having more eyes and
| brains looking at this problem can't hurt.

Well said.

| Yes, you *can*, but the amount of code needed to perform simple
| pixel-aligned upright blends is a tiny fraction of that needed to deal
| with filtering textures and *then* blending. ...

I think Brian covered this, but the short summary is you wouldn't use
texturing for this; you'd use glDrawPixels or glCopyPixels and optimize
the simple paths that are equivalent to those in Render.

| I'll consider Xgl a success if it manages to eliminate 2D drivers from
| machines capable of supporting OpenGL. Even if the bulk of applications
| continue to draw using Render and that is translated by X to OpenGL, we
| will at least have eliminated a huge duplication of effort between 2D
| and 3D driver development, provided far better acceleration than we have
| today for Render operations and made it possible for the nasty
| closed-source vendors to ship working drivers for their latest video
| cards.
| 
| I see the wider availability of OpenGL APIs to be a nice side-effect at
| this point; applications won't (yet) be able to count on having decent
| OpenGL performance on every desktop, but as the number of desktops with
| OpenGL support grows, we will see more and more applications demanding
| it and getting people to make purchasing decisions based on OpenGL
| availablity for such applications.
| 
| Resources for Mesa development are even more constrained than X
| development, but both of these show signs of improvement, both for
| social and political reasons within the community as well as economic
| reasons within corporations. Perhaps someday we really will have enough
| resources that watching a large number of people get side-tracked with
| the latest shiny objects won't bother us quite so much.

I can support nearly all of that, so I think it's a good note on which
to close.

You and I and Jim have talked about this stuff many times, but hopefully
recapping it has helped provide background for the folks who are new to
the discussion.

Thanks!
Allen
