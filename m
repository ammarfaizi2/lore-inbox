Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318857AbSHRErZ>; Sun, 18 Aug 2002 00:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318858AbSHRErZ>; Sun, 18 Aug 2002 00:47:25 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:7908 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S318857AbSHRErY>; Sun, 18 Aug 2002 00:47:24 -0400
Date: Sat, 17 Aug 2002 21:57:02 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D5F291E.5040806@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Questionable Sources and Time Scales
 > ------------------------------------
 >
 >  Due to the vagarities of computer architecture, things like keyboard
 >  and mouse interrupts occur on their respective scanning or serial
 >  clock edges, and are clocked relatively slowly. Worse, devices like
 >  USB keyboards, mice, and disks tend to share interrupts and probably
 >  line up on USB clock boundaries.

Last time I looked, USB didn't feed into the pool of randomness at
any level ... certainly none of the host controller drivers do, and
I didn't notice any drivers layered on top of those bus drivers
doing so either.  That includes keyboards, mice, and disks; as well
as network devices, webcams, and more.  So that "worse" isn't real.

It's likely correct that the host controller drivers don't use the
SA_SAMPLE_RANDOM flag: they're effectively sharing interrupts from
many kinds of devices, some of which may be very predictable (like
webcams).  But it might be OK for for some of those layered drivers
(HID, storage, ...) to act as entropy sources ... if such timescale
issues get addressed!  Maybe an URB_SAMPLE_RANDOM flag would be the
right kind of model.

FWIW, interrupts for OHCI and UHCI occur on frame (1 msec) boundaries,
according to their specs, though one person said he saw one vendor's
OHCI silicon doing interrupts more often.  For EHCI (USB 2.0) it's
tunable from 1 to 64 microframes, where there are 8 microframes per
frame.  (Linux defaults EHCI latency to 1 microframe == 125 usec.)

- Dave

