Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWGUUGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWGUUGs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 16:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWGUUGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 16:06:48 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:37067 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751140AbWGUUGs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 16:06:48 -0400
Date: Fri, 21 Jul 2006 13:06:47 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell2.speakeasy.net
To: Mauro Carvalho Chehab <mchehab@infradead.org>
cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device
 corruption
In-Reply-To: <1153484805.16225.12.camel@praia>
Message-ID: <Pine.LNX.4.58.0607211226430.26854@shell2.speakeasy.net>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com> 
 <20060713050541.GA31257@kroah.com>  <20060712222407.d737129c.rdunlap@xenotime.net>
  <20060712224453.5faeea4a.akpm@osdl.org> <20060715230849.GA3385@localhost>
  <1153013464.4755.35.camel@praia>  <Pine.LNX.4.58.0607171650510.18488@shell3.speakeasy.net>
  <1153310092.27276.9.camel@praia>  <Pine.LNX.4.58.0607201425060.18071@shell2.speakeasy.net>
 <1153484805.16225.12.camel@praia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've trimmed the CCs, they were getting big and it didn't look like anyone
else is taking part.

I have a fix for the immediate issue of struct video_device, it doesn't fix
everything else, but does fix this bug.
http://linuxtv.org/hg/~tap/v4l-dvb?cmd=changeset;node=f3cc7acae78a;style=gitweb

On Fri, 21 Jul 2006, Mauro Carvalho Chehab wrote:
> Em Qui, 2006-07-20 às 14:57 -0700, Trent Piepho escreveu:
> > I've looked into this more, and there is still a serious bug here.  If you
> > turn off V4L1 and V4L1_COMPAT, many drivers will a big issue with struct
> > video_device.
> If you turn V4L and V4L1_COMPAT off, most drivers won't compile.

There are many drivers which depend on VIDEO_V4L1 in Kconfig.  But, there
are many drivers that don't depend on it.  All those drivers will compile
with V4L1 turned all the way off.  I was able to compile 101 modules
without V4L1 turned on.

> > In some files (saa7134-tvaudio.c, saa6752hs.c, v4l2-common.c, dozens
> > more), V4L1 will be off and HAVE_V4L1 will not be defined.  This gives you
> > the struct video_dev _without_ vidiocgmbuf.
> Ok.
> >
> > In other files (tveeprom.c, tvaudio.c, bttv-driver.c, and many more), V4L1
> > will still be off (of course) by HAVE_V4L1 _will_ be defined.  This gives
> > you the struct viddeo_dev _with_ vidiocgmbuf.
> Hmm... tveeprom shouln't include videodev but, instead, videodev2.
> Anyway, both aren't dependent of v4l2-dev.h. For bttv, it is not really
> a complete V4L2 driver and should be disabled. You should also notice
> that tvaudio is part of bttv stuff (although also not dependent of
> video_device struct and v4l2-dev.h).

Well, tvaudio.c does include v4l2-dev.h.  There are more that do this:

bttv-cards.c   bttv-vbi.c        msp3400-kthreads.c  tuner-core.c
bttv-driver.c  compat_ioctl32.c  saa5249.c           tuner-simple.c
bttv-gpio.c    cpia2_core.c      tda7432.c           tvaudio.c
bttv-i2c.c     cpia2_usb.c       tda9875.c           tveeprom.c
bttv-if.c      cpia2_v4l.c       tda9887.c           wm8739.c
bttv-input.c   cs53l32a.c        tlv320aic23b.c      wm8775.c
bttv-risc.c    msp3400-driver.c  tuner-3036.c

All these files include v4l2-dev.h and have HAVE_V4L1 defined when V4L1 is
not turned on in Kconfig.  There files are all buildable when V4L1 is off;
they don't depend on it in Kconfig.  There might be more files which have
the problem with the defines but don't include v4l2-dev.h, I haven't
checked for that.

> > The first thing to solve this that HAVE_V4L1 should die.
> Partially agreed. We should move all in-kernel stuff to use
> CONFIG_VIDEO_V4L1_COMPAT. For userspace, this flag might be interesting
> (as well as his counterpart HAVE_V4L2).
> > Why have a define that is supposed to mirror a Kconfig variable?
> Legacy stuff. HAVE_V4L1 came before the Kconfig flag.
> > If everyone used CONFIG_VIDEO_V4L1_COMPAT then there wouldn't be this problem, which some
> > code things V4L1 is on, and some code thinks it's off.
> >
> > The second thing, is that many drivers don't respect
> > CONFIG_VIDEO_V4L1_COMPAT.  They include V4L1 code when V4L1 is turned off.
> >
> > To fix this completely:
> > 1. Find all unnecessary includes of videodev.h and remove them.
> Ok.
> >
> > 2. Any remaining includes of videodef.h in drivers which don't depend on
> >    VIDEO_V4L1_COMPAT or VIDEO_V4L1 in Kconfig should be protected with
> >    #ifdef CONFIG_VIDEO_V4L1_COMPAT.  This will break many drivers.
> Instead, we should do the opposite: checking for both flags inside
> videodev.h. If no V4L1 or V4L1_COMPAT, it should just include
> videodev2.h.

Would some drivers continue to include videodev2.h directly?  Or would it
only be included through videodev.h?

> > 3. Replace HAVE_V4L1 with CONFIG_VIDEO_V4L1_COMPAT everywhere.
> Agreed.
> >    This will break many drivers.
> Perhaps I missed the point, but I can't see what else would be broken by
> replacing the check.

See my list above of files in which HAVE_V4L1 is defined but
CONFIG_VIDEO_V4L1* is not defined.  If you change an #ifdef from HAVE_V4L1
to CONFIG_VIDEO_V4L1_COMPAT, then that #ifdef is changing from on to off.
This can breaks things.  Go ahead and try it, you'll see.

> > 4. Any drivers broken by steps 2 and 3 should be fixed by either:
> >    A.  Protecting all V4L1 code with #ifdef CONFIG_VIDEO_V4L1_COMPAT
> >    B.  Making the drivers require V4L1 in Kconfig
> Broken drivers for V4L2 only should be marked in Kconfig, just like
> bttv. Of course, we should work to fix it. Nickolay did a patch in the
> past removing V4L1 code from bttv and make it use v4l1-compat module
> instead. We should work seriously on such patch.

Is it possible that a driver might include V4L1 compatilbility code, for
functionality beyond that which the v4l-compat module can provide?
