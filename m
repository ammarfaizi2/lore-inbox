Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVBHV5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVBHV5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 16:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVBHV5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 16:57:42 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:62336 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261678AbVBHV5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 16:57:38 -0500
Subject: Re: Merging the Suspend2 freezer implementation.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050208163644.GG1622@elf.ucw.cz>
References: <1107822206.2756.18.camel@desktop.cunninghams>
	 <20050208163644.GG1622@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1107899999.4330.39.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 09 Feb 2005 08:59:59 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-02-09 at 03:36, Pavel Machek wrote:
> Hi!
> 
> > I'm keen to see if we can merge Suspend2's freezer implementation after
> > 2.6.11. Does that conflict with any of your intended changes? If it
> > doesn't, I'll submit a patch for review/merge as quickly as I can.
> 
> Freezer is very independend, and no, I do not plan any changes in that area.

Ok.

> > The main change involves the introduction of a new SYNCTHREAD flag. We
> > use this to avoid deadlocking over processes that are running sys_sync
> > and siblings. Processes that enter those routines get the flag added,
> > and it's removed when they exit the sync routine. We then freeze in four
> > stages: 
> 
> Is SYNCTHREAD neccessary for me, too, or is it needed for suspend2, only?

It's necessary for reliable freezing under I/O load. Signalling the
non-sync threads first removes the race involved in some threads
submitting I/O while others are trying to sync. Try doing a dd and a
sync at the same time. The sync can take ages to return, worst case,
sometimes not until the dd is completed. (Actually, try doing anything
while a dd is running :>)

> > 1) Freeze user space threads without SYNCTHREAD set;
> > 2) Freeze user space threads with SYNCTHREAD set;
> > 3) Run our own sys_sync in case no one else was syncing
> > 4) Freeze kernel space threads without NOFREEZE set.
> > 
> > I'd also like to look at your SMP support and see if we can improve
> > compatibility there at the same time.
> 
> Why not... But parts of smp support really need to be in assembly, and
> they are not, neither in swsusp nor in suspend2...

I don't think there's any issue here - or at least not a significant
one. I've had SMP support for just over a year, and I don't believe
there are any outstanding SMP specific issues in the freezer code (or
anywhere else in suspend2). All the resuming failures people get with
Suspend2 are traceable to device drivers (usb, dri/drm, cpufreq,
8139too, e1000 cards...)

> > Finally I'd like to merge the support for freezer flags on workqueues.

No comment here? :>

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

