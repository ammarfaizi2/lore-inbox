Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVLIWZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVLIWZH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVLIWZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:25:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33127 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932472AbVLIWZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:25:05 -0500
Date: Fri, 09 Dec 2005 17:25:02 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] input: fix ucb1x00-ts breakage after conversion to dynamic
 input_dev allocation
In-reply-to: <d120d5000512091308lb633c0an34dee39af7f498ad@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: dtor_core@ameritech.net
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Russell King <rmk@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0512091719110.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0512091520000.26663@localhost.localdomain>
 <d120d5000512091308lb633c0an34dee39af7f498ad@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, Dmitry Torokhov wrote:

> On 12/9/05, Nicolas Pitre <nico@cam.org> wrote:
> > The bd622663192e8ebebb27dc1d9397f352a82d2495 commit broke the UCB1x00
> > touchscreen driver since the idev structure was assumed to be into the
> > ts structure, simply casting the former to the later in a couple places.
> >
> > This patch fixes those, and also cache the idev pointer between multiple
> > calls to input_report_abs() to avoid growing the compiled code
> > needlessly.
> >
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> >
> > ---
> >
> > diff --git a/drivers/mfd/ucb1x00-ts.c b/drivers/mfd/ucb1x00-ts.c
> > index a984c0e..e0794c2 100644
> > --- a/drivers/mfd/ucb1x00-ts.c
> > +++ b/drivers/mfd/ucb1x00-ts.c
> > @@ -59,16 +59,18 @@ static int adcsync;
> >
> >  static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x, u16 y)
> >  {
> > -       input_report_abs(ts->idev, ABS_X, x);
> > -       input_report_abs(ts->idev, ABS_Y, y);
> > -       input_report_abs(ts->idev, ABS_PRESSURE, pressure);
> > -       input_sync(ts->idev);
> > +       struct input_dev *idev = ts->idev;
> > +       input_report_abs(idev, ABS_X, x);
> > +       input_report_abs(idev, ABS_Y, y);
> > +       input_report_abs(idev, ABS_PRESSURE, pressure);
> > +       input_sync(idev);
> >  }
> >
> >  static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
> >  {
> > -       input_report_abs(ts->idev, ABS_PRESSURE, 0);
> > -       input_sync(ts->idev);
> > +       struct input_dev *idev = ts->idev;
> > +       input_report_abs(idev, ABS_PRESSURE, 0);
> > +       input_sync(idev);
> >  }
> >
> 
> The changes above are not really needed.

They are, I hope, obvious enough, and they fix what I'd call a generated 
assembly regression which was introduced by said commit above.  Before 
that commit the generated assembly was (more) optimal and the those 
changes are meant to bring that state back.

> The rest is good and we
> should get it int before 2.6.15 I think.

Indeed.  Otherwise the driver simply crashes.


Nicolas
