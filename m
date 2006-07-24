Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWGXPZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWGXPZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 11:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWGXPZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 11:25:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25805 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751124AbWGXPZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 11:25:58 -0400
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device
	corruption
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0607231828430.16282@shell3.speakeasy.net>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>
	 <20060713050541.GA31257@kroah.com>
	 <20060712222407.d737129c.rdunlap@xenotime.net>
	 <20060712224453.5faeea4a.akpm@osdl.org> <20060715230849.GA3385@localhost>
	 <1153013464.4755.35.camel@praia>
	 <Pine.LNX.4.58.0607171650510.18488@shell3.speakeasy.net>
	 <1153310092.27276.9.camel@praia>
	 <Pine.LNX.4.58.0607201425060.18071@shell2.speakeasy.net>
	 <1153484805.16225.12.camel@praia>
	 <Pine.LNX.4.58.0607211226430.26854@shell2.speakeasy.net>
	 <1153513837.32625.71.camel@praia>
	 <Pine.LNX.4.58.0607211536190.26854@shell2.speakeasy.net>
	 <1153647324.22089.32.camel@praia>
	 <Pine.LNX.4.58.0607231828430.16282@shell3.speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 24 Jul 2006 09:34:44 -0300
Message-Id: <1153744484.22089.56.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2006-07-23 às 19:16 -0700, Trent Piepho escreveu:
> On Sun, 23 Jul 2006, Mauro Carvalho Chehab wrote:
> > Ok, I had some time to fix the broken dependencies. Please look at the
> > two commits I did today.
> 
> Two things I noticed.  bttv didn't use to _require_ V4L1.  I use bttv and have
> V4L1 turned off.  I guess this is just because bttv ignored the V4L1 setting?
> 
In fact, as videodev.h were included, all V4L1 stuff were also added.
Now, if you try to compile it with V4L1, it will fail. Bttv have support
for both V4L1 and V4L2 inside, but still relies on several V4L1 stuff at
the code Nickolay did a patch in the past to remove V4L1, using,
instead, v4l1_compat mode. At that time, it suffered some troubles, and
his patch became obsoleted by several changes (basically at msp3400). We
should get his patch again, port to current version and fix.
> Second, the fix for class_device_create_file() doesn't roll-back properly
> on failure.  I already posted a patch which does this correctly.  Attached
> is the patch against the current Hg, go ahead and import it.
On your hg, there are 4 patches to be applied:

1) Fix bug where struct video_device was not defined consistently
This one seems to conflict with some previous changes I did. Please
remove it from your tree (you need to re-clone it - you may use hg-menu
to help on this stuff);

2) Remove of couple of useless lines
Seems ok.

3) Handle class_device_create_file in V4L2 drivers
The patch didn't applied well at current tree.

4) bttv: clean up some pre-2.6.0 class device compat stuff
the removal of class_device_create_file on compat.h won't break
compilation against kernel versions 2.4? Yes, I know that current
building system won't allow such compilations, but I don't want to
remove compat stuff for 2.4. Maybe someone may work later on make V4L to
work well on 2.4. This would be interesting to embedded systems.

Please re-do your tree and ask me to pull after done.
> 
> Also attached is patch to bttv-driver.c that has it use
> class_device_create_file(), with an error message and handling of failure.
> 
> 
> > One patch removes HAVE_V4L1 check at drivers. It also include some checks for
> > V4L1_COMPAT on some core files that should implement both calls to provide
> > support for V4L1 drivers.
> >
> > The other fixes the broken dependencies for drivers that still need V4L1
> > to work properly.
> >
> > Cheers,
> > Mauro.
> >
> > Em Sex, 2006-07-21 s 15:55 -0700, Trent Piepho escreveu:
> > > On Fri, 21 Jul 2006, Mauro Carvalho Chehab wrote:
> > > > config VIDEO_BT848
> > > >         tristate "BT848 Video For Linux"
> > > >         depends on VIDEO_DEV && PCI && I2C && VIDEO_V4L2
> > > >
> > > > Argh! it should be V4L1 instead!
> > >
> > > You can compile and use bt848 without V4L1 turned on.  It still has some
> > > V4L1 functions defined.
> > >
> > > > > All these files include v4l2-dev.h and have HAVE_V4L1 defined when V4L1 is
> > > > > not turned on in Kconfig.  There files are all buildable when V4L1 is off;
> > > > > they don't depend on it in Kconfig.
> > > > Some of the above drivers are V4L2, like tda9887, tuner-core,
> > > > tuner-simple, msp3400, cs53l32a, tveeprom, wm87xx. Maybe they are just
> > > > including the wrong headers. We should try to change to videodev2.h and
> > > > see what happens with all those drivers. The ones that break should me
> > > > marked with the proper requirement on Kconfig.
> > > >
> > > > Some of they need some #ifdef inside. For example, compat_ioctl32 should
> > > > handle both APIs, since it is a generic code to fix 32 bit calls to 64
> > > > bit kernel.
> > >
> > > I think this is pretty much what I've been saying.  Drivers should:
> > > A. Not include videodev.h, but use videodev2.h
> > > B. Include videodev.h, but be marked V4L1 in Kconfig
> > > C. #ifdef around videodev.h (and code that needs videodev.h), so it
> > >    is not included or needed when V4L1 is turned off.
> > Cheers,
> > Mauro.
> >
> >
Cheers, 
Mauro.

