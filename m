Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVGKMt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVGKMt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 08:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVGKMt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 08:49:26 -0400
Received: from gw.alcove.fr ([81.80.245.157]:44218 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261657AbVGKMtZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 08:49:25 -0400
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
From: Stelian Pop <stelian@popies.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Frank Arnold <frank@scirocco-5v-turbo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Andrew Morton <akpm@osdl.org>, Peter Osterlund <petero2@telia.com>
In-Reply-To: <20050711112121.GA24345@ucw.cz>
References: <20050708101731.GM18608@sd291.sivit.org>
	 <1120821481.5065.2.camel@localhost>
	 <20050708121005.GN18608@sd291.sivit.org> <20050709191357.GA2244@ucw.cz>
	 <m33bqnr3y9.fsf@telia.com> <20050710120425.GC3018@ucw.cz>
	 <m3y88e9ozu.fsf@telia.com>
	 <1121078371.12621.36.camel@localhost.localdomain>
	 <20050711110024.GA23333@ucw.cz>
	 <1121080115.12627.44.camel@localhost.localdomain>
	 <20050711112121.GA24345@ucw.cz>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Jul 2005 14:47:53 +0200
Message-Id: <1121086073.5021.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 11 juillet 2005 à 13:21 +0200, Vojtech Pavlik a écrit :
> On Mon, Jul 11, 2005 at 01:08:35PM +0200, Stelian Pop wrote:
> 
> > Possible. The 'fuzz' parameter in input core serves too many usages
> > ihmo. Let me try removing the quick motion compensation and see...
> 
> It was designed for joysticks and works very well for them. Usefulness
> for other device types may vary. And I'll gladly accept patches to
> improve it.

Ok, I understand now what is happenning, but I'm not sure how to solve
the problem. As I suspected, it is caused by 'fuzz' being a bit abused
by the input core.

The fuzz parameter in the input core is used today to say:
	* any change in the -fuzz/2 / +fuzz/2 range is ignored
	* any change in the -fuzz / +fuzz range is smoothed using x_old * 3 +
x) / 4;
	* any change in the -fuzz*2 / +fuzz/2 range is smoothed using x_old
+x) / 2;

My driver needs to ignore changes in the -8 / +8 range (that's why I set
FUZZ to 16 in the first place), but it needs to smooth the movement when
much larger changes occur (I would need to set FUZZ to 64 for smoothing
to work correctly here).

How to make it work ? Obviously I could implement either fuzz
elimination or smoothing in the driver, and leave the other
transformation to the input core (today it is the smoothing which is in
the driver, but doing it the other way around would result in much less
code).

The other (proper ?) solution would be to change the input core and
separate fuzz and smoothing. This would however require an API addition,
and I'm not sure you want to do that. If you do, I could work on a patch
implementing an inputdev->abssmooth[] table, etc).

> > I thought the hardware is capable of calculating real pressure...
> 
> Since the sensor is just a multi-layer PCB with a clever trace layout,
> it can't.
> 
> > > > I don't think this value is reliable enough to be reported to the
> > > > userspace as ABS_PRESSURE...
> > > 
> > > I believe it'd still be more useful than a two-value (0 and 100) output.
> > 
> > Ok, I'll do it.
> 
> Thanks. Should I wait for that or apply the patch you just sent?

Well, it depends on what we do with smoothing.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

