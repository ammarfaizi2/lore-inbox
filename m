Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTGBAmX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 20:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTGBAmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 20:42:23 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:42846 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264393AbTGBAmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 20:42:21 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [RFC/PATCH] Touchpads in absolute mode (synaptics) and mousedev
Date: Tue, 1 Jul 2003 19:57:22 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200307010303.53405.dtor_core@ameritech.net> <200307011329.50551.dtor_core@ameritech.net> <16130.7342.567086.595743@gargle.gargle.HOWL>
In-Reply-To: <16130.7342.567086.595743@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307011957.22997.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 July 2003 06:43 pm, Neil Brown wrote:
> On Tuesday July 1, dtor_core@ameritech.net wrote:
> > Apologies if you seen this already but it seems the list ate my previous
> > replies...
> >
> > On Tuesday 01 July 2003 04:40 am, Neil Brown wrote:
> > > On Tuesday July 1, dtor_core@ameritech.net wrote:
> >
> > ... skip ...
> >
> > > > 1. Modify mousedev so if an input device announces that it generates
> > > > both relative and absolute events mousedev will discard all absolute
> > > > axis events and will rely on device supplied relative events.
> > >
> > > Nah.  I have an ALPS dualpoint which generates ABSolute events for the
> > > touchpad part and RElative events for the pointstick part.  I want
> > > them both.
> >
> > So pass relative events as is and do conversion of absolute to relatives.
> > That's what I gonna do about my track stick as well.
> >
> > Remember that mousedev provides _emulation_ of [Ex]PS/2 mouse protocol
> > for almost any device, it does not do any advanced tricks it's here to
> > use with old software that does not have advanced drivers yet, you are
> > not "loosing" your absolute mode packets, you hav /dev/input/eventX to
> > access them.
>
> If I do that, then on the eventX device I will see both 'real'
> relative events and 'synthesised' (from absoule) relative events and I
> won't be able to tell the difference.
>

I see there are 2 possible solutions. If I understand what Vojtech wrote 
regarding synaptics driver the track stick (or other pass-through device)
is best implemented as a separate serio. So you could have your touchpad
in absolute mode and stick as a separate device in native relative.

Other way is to check (in your userspace driver) whether your motion 
packets contains absolute packets and if they are present discard any 
relative events in this batch.

Hmmm... what if we introduce something like sythrelbit[NBITS(REL__MAX)]
for passing synthesized relative events and have mousedev use values in 
following order of precedence:
- absbit - lowest priority
- synthrelbit
- relbit - highest.

What you think?
> > > > 2. Add absolute->relative conversion code to touchpad drivers
> > > > themselves as drivers should know the best how to do that. If they
> > > > turn out to be similar across different touchpads then the common
> > > > module could be made.
> > > >
> > > > What you think?
> > >
> > > I think that mousedev should be just clever enough to mostly work and
> > > no cleverer.  Anything more interesting should be done in user-space.
> >
> > Right, and if device says that it can generate relative packets mousedev
> > should not get in its way and do its own absolute->relative conversion.
>
> A device should present raw events.  Whatever the user says to the
> device should come out eventX uninterpreted.
> mousedev should interpret what it can and present this out
> /dev/psaux.  As it can do limited interpretation of ABS events, it
> should.
>

The thing is that the result is not useable with touchpads right now. 
It just does not work :(

> This seems different to your perspective, but seeing there is not
> standard or other document that we can make reference too, it is not
> clear that anyone can decide who is *right*.....
>
> NeilBrown

Dmitry
