Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262856AbRFFNKn>; Wed, 6 Jun 2001 09:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262923AbRFFNKd>; Wed, 6 Jun 2001 09:10:33 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:31196 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262856AbRFFNKT>;
	Wed, 6 Jun 2001 09:10:19 -0400
Date: Wed, 6 Jun 2001 15:10:11 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200106061310.PAA14058@harpo.it.uu.se>
To: remi@a2zis.com
Subject: Re: 2.4.5-ac8 hardlocks when going to standby
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001 23:15:49 +0200, Remi Turk wrote:

>On Tue, Jun 05, 2001 at 09:37:52PM +0100, Alan Cox wrote:
>> > 2.4.5-ac[4678] all lock hard (no sysreq) when pushing my
>> > power-button (setup from the bios to go to standby) or
>> > when running apm --standby. (apm version 3.0final, RH6.2)
>> > apm --suspend works the way it should.
>> > 
>> > 2.4.5/2.4.6-pre1 don't hardlock.
>> 
>> Are you using the same build options for both
>> What machine is this - laptop ?
>
>It's not a laptop.
>Tbird 950 + Abit KT7 (KT133)
>
>UP APIC is enabled in -ac[4678] and emu10k1 is the in-kernel

and later quoted Alan as saying:

> On Tue, Jun 05, 2001 at 10:18:07PM +0100, Alan Cox wrote:
> > Thanks. UP-APIC is a real candidate for this case.

Actually, I suspect apm.c is at fault here. Suspend works,
which proves that the PM code in apic.c and nmi.c works.

But note how apm.c:send_event() ignores standby events and fails
to propagate them to PM clients. Thus, Remi's box will have an
activated local APIC and live NMI watchdog when the APM BIOS
finally gets to do whatever it does at standby.
It is fatal to have an active local APIC and NMI watchdog at suspend,
and I can only assume that this is true for standby as well.

Please try changing apm.c:send_event() to propagate standbys to PM
clients just like suspends. Does this fix the problem?

(Any why use standby in the first place? Any reason you don't
want to / can't use suspend?)

/Mikael
