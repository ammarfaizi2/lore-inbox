Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWGUM1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWGUM1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 08:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWGUM1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 08:27:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2447 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161061AbWGUM1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 08:27:53 -0400
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device
	corruption
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Robert Fitzsimons <robfitz@273k.net>, Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       76306.1226@compuserve.com, fork0@t-online.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       shemminger@osdl.org, "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>
In-Reply-To: <Pine.LNX.4.58.0607201425060.18071@shell2.speakeasy.net>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>
	 <20060713050541.GA31257@kroah.com>
	 <20060712222407.d737129c.rdunlap@xenotime.net>
	 <20060712224453.5faeea4a.akpm@osdl.org> <20060715230849.GA3385@localhost>
	 <1153013464.4755.35.camel@praia>
	 <Pine.LNX.4.58.0607171650510.18488@shell3.speakeasy.net>
	 <1153310092.27276.9.camel@praia>
	 <Pine.LNX.4.58.0607201425060.18071@shell2.speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 21 Jul 2006 09:26:45 -0300
Message-Id: <1153484805.16225.12.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trent,

Em Qui, 2006-07-20 às 14:57 -0700, Trent Piepho escreveu:
> On Wed, 19 Jul 2006, Mauro Carvalho Chehab wrote:
> > Em Seg, 2006-07-17 s 17:25 -0700, Trent Piepho escreveu:
> > > On Sat, 15 Jul 2006, Mauro Carvalho Chehab wrote:
> > > > Em Sb, 2006-07-15 s 23:08 +0000, Robert Fitzsimons escreveu:
> > > > > The layout of struct video_device would change depending on whether
> > > > > videodev.h (V4L1) was include or not before v4l2-dev.h, which caused
> > > > > the structure to get corrupted.
> 
> > > I think that the real problem is that many drivers include the V4L1 API
> > > file videodev.h when V4L1 is NOT on.  Should drivers be providing V4L1 API
> > > functions, or need anything from videodev.h, if V4L1 is not on?
> > >
> > > It seems like they either need to depend on VIDEO_V4L1 or only include the
> > > V4L1 API header file when V4L1 is turned on.  Which also means they would
> > > need to #ifdef out any V4L1 code when V4L1 is turned off.  The bttv driver
> > > for example does not do this.  It includes a bunch of V4L1 functions even
> > > when V4L1 (and V4L1_COMPAT) are turned off.
> 
> I've looked into this more, and there is still a serious bug here.  If you
> turn off V4L1 and V4L1_COMPAT, many drivers will a big issue with struct
> video_device.
If you turn V4L and V4L1_COMPAT off, most drivers won't compile.
> 
> In some files (saa7134-tvaudio.c, saa6752hs.c, v4l2-common.c, dozens
> more), V4L1 will be off and HAVE_V4L1 will not be defined.  This gives you
> the struct video_dev _without_ vidiocgmbuf.
Ok.
> 
> In other files (tveeprom.c, tvaudio.c, bttv-driver.c, and many more), V4L1
> will still be off (of course) by HAVE_V4L1 _will_ be defined.  This gives
> you the struct viddeo_dev _with_ vidiocgmbuf.
Hmm... tveeprom shouln't include videodev but, instead, videodev2.
Anyway, both aren't dependent of v4l2-dev.h. For bttv, it is not really
a complete V4L2 driver and should be disabled. You should also notice
that tvaudio is part of bttv stuff (although also not dependent of
video_device struct and v4l2-dev.h).
> 
> The first thing to solve this that HAVE_V4L1 should die.
Partially agreed. We should move all in-kernel stuff to use
CONFIG_VIDEO_V4L1_COMPAT. For userspace, this flag might be interesting
(as well as his counterpart HAVE_V4L2).
> Why have a define that is supposed to mirror a Kconfig variable?
Legacy stuff. HAVE_V4L1 came before the Kconfig flag.
> If everyone used CONFIG_VIDEO_V4L1_COMPAT then there wouldn't be this problem, which some
> code things V4L1 is on, and some code thinks it's off.
> 
> The second thing, is that many drivers don't respect
> CONFIG_VIDEO_V4L1_COMPAT.  They include V4L1 code when V4L1 is turned off.
> 
> To fix this completely:
> 1. Find all unnecessary includes of videodev.h and remove them.
Ok.
>
> 2. Any remaining includes of videodef.h in drivers which don't depend on
>    VIDEO_V4L1_COMPAT or VIDEO_V4L1 in Kconfig should be protected with
>    #ifdef CONFIG_VIDEO_V4L1_COMPAT.  This will break many drivers.
Instead, we should do the opposite: checking for both flags inside
videodev.h. If no V4L1 or V4L1_COMPAT, it should just include
videodev2.h. 
> 
> 3. Replace HAVE_V4L1 with CONFIG_VIDEO_V4L1_COMPAT everywhere.
Agreed.
>    This will break many drivers.
Perhaps I missed the point, but I can't see what else would be broken by
replacing the check.
> 
> 4. Any drivers broken by steps 2 and 3 should be fixed by either:
>    A.  Protecting all V4L1 code with #ifdef CONFIG_VIDEO_V4L1_COMPAT
>    B.  Making the drivers require V4L1 in Kconfig
Broken drivers for V4L2 only should be marked in Kconfig, just like
bttv. Of course, we should work to fix it. Nickolay did a patch in the
past removing V4L1 code from bttv and make it use v4l1-compat module
instead. We should work seriously on such patch.

Cheers, 
Mauro.

