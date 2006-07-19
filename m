Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWGSP2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWGSP2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWGSP2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:28:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26569 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964871AbWGSP2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:28:22 -0400
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device
	corruption
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Robert Fitzsimons <robfitz@273k.net>, Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       76306.1226@compuserve.com, fork0@t-online.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       shemminger@osdl.org
In-Reply-To: <Pine.LNX.4.58.0607171650510.18488@shell3.speakeasy.net>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>
	 <20060713050541.GA31257@kroah.com>
	 <20060712222407.d737129c.rdunlap@xenotime.net>
	 <20060712224453.5faeea4a.akpm@osdl.org> <20060715230849.GA3385@localhost>
	 <1153013464.4755.35.camel@praia>
	 <Pine.LNX.4.58.0607171650510.18488@shell3.speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 19 Jul 2006 08:54:52 -0300
Message-Id: <1153310092.27276.9.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2006-07-17 às 17:25 -0700, Trent Piepho escreveu:
> On Sat, 15 Jul 2006, Mauro Carvalho Chehab wrote:
> > Em Sb, 2006-07-15 s 23:08 +0000, Robert Fitzsimons escreveu:
> > > The layout of struct video_device would change depending on whether
> > > videodev.h (V4L1) was include or not before v4l2-dev.h, which caused
> > > the structure to get corrupted.
> > Hmm... good point! However, I the proper solution would be to trust on
> > CONFIG_VIDEO_V4L1_COMPAT or CONFIG_VIDEO_V4L1 instead. it makes no sense
> > to keep a pointer to an unsupported callback, when V4L1 is not selected.
> 
> It's not so clear that the problem is with v4l2-dev.h, because if you look
> that file:
> 
> #ifdef CONFIG_VIDEO_V4L1
> #include <linux/videodev.h>
> #else
> #include <linux/videodev2.h>
> #endif
That's true. I think the OOPS is related to this -git patch:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6ab3d5624e172c553004ecc862bfeac16d9d68b7

It removed config.h from bttv-cards (and other places), but we need
CONFIG_* symbols before including v4l2-dev.h. Maybe the right solution
would be to include autoconf.h or config.h at the top of v4l2-dev.h.

> 
> linux/videodev.h is where HAVE_V4L1 is defined (always).  So, if
> CONFIG_VIDEO_V4L1 is set, then HAVE_V4L1 must also bet set.
> 
> I think that the real problem is that many drivers include the V4L1 API
> file videodev.h when V4L1 is NOT on.  Should drivers be providing V4L1 API
> functions, or need anything from videodev.h, if V4L1 is not on?
> 
> It seems like they either need to depend on VIDEO_V4L1 or only include the
> V4L1 API header file when V4L1 is turned on.  Which also means they would
> need to #ifdef out any V4L1 code when V4L1 is turned off.  The bttv driver
> for example does not do this.  It includes a bunch of V4L1 functions even
> when V4L1 (and V4L1_COMPAT) are turned off.
> 
> BTW, I think the CONFIG_VIDEO_V4L1 check in v4l2-dev.h should instead check
> for CONFIG_VIDEO_V4L1_COMPAT.  For example, cx88-video.c includes
> videodev.h when CONFIG_VIDEO_V4L1_COMPAT is turned on.
Yes, you are right. Checking for COMPAT covers both cases.

Cheers, 
Mauro.

