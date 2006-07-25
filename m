Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWGYImV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWGYImV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 04:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWGYImV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 04:42:21 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:46983 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932140AbWGYImU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 04:42:20 -0400
Date: Tue, 25 Jul 2006 01:42:19 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell2.speakeasy.net
To: Andrew Morton <akpm@osdl.org>
cc: Mauro Carvalho Chehab <mchehab@infradead.org>, robfitz@273k.net,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       76306.1226@compuserve.com, fork0@t-online.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       shemminger@osdl.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device
 corruption
In-Reply-To: <20060724200855.603be3bb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0607250054410.18397@shell3.speakeasy.net>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com> <20060713050541.GA31257@kroah.com>
 <20060712222407.d737129c.rdunlap@xenotime.net> <20060712224453.5faeea4a.akpm@osdl.org>
 <20060715230849.GA3385@localhost> <1153013464.4755.35.camel@praia>
 <20060724200855.603be3bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006, Andrew Morton wrote:
> On Sat, 15 Jul 2006 22:31:04 -0300
> Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
>
> > Em Sáb, 2006-07-15 às 23:08 +0000, Robert Fitzsimons escreveu:
> > > The layout of struct video_device would change depending on whether
> > > videodev.h (V4L1) was include or not before v4l2-dev.h, which caused
> > > the structure to get corrupted.
> > Hmm... good point! However, I the proper solution would be to trust on
> > CONFIG_VIDEO_V4L1_COMPAT or CONFIG_VIDEO_V4L1 instead. it makes no sense
> > to keep a pointer to an unsupported callback, when V4L1 is not selected.
> >
>
> So I've lost the plot with all of this.  Does the current git-dvb contain
> the desired fixes?

The problem was that the v4l code in general was not using
CONFIG_VIDEO_V4L1* like it should, but was detecting V4L1 support based on
whether on not the V4L1 header file had been included.

Some drivers didn't depend on V4L1 in Kconfig, and would include the V4L1
header when V4L1 was off.  This caused some code to think V4L1 was off and
some code to think it was on.

This caused a serious bug with inconsistent defintions of struct
video_device, as well as other problems.

I posted a patch that fixed the video_device problem, then Mauro made a
comprehensive patch that incorporated this fix and well as all the other
code that was using V4L1 when it shouldn't.  That patch is in the v4l-dvb
Mercurial repository, but not moved on to git yet.

> Do we expect this will fix the various DVB crashes which people (including
> Alex) have reported?

This problem would only appear if VIDEO_V4L1 was turned off.  If it was on,
then all the code would agree it was on, and there would be no problems.
If the crash is still there when VIDEO_V4L1 = y, then it's not related to
this bug.

If VIDEO_V4L1 was turned off, then some drivers (one of which is bttv)
would have a different struct video_device than the video core code.  This
would break things so completely that it could crash just about anywhere.
