Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWIYGyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWIYGyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWIYGyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:54:12 -0400
Received: from [212.227.126.177] ([212.227.126.177]:12005 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964848AbWIYGyM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:54:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Mon, 25 Sep 2006 08:54:04 +0200
User-Agent: KMail/1.9.4
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com> <200609230218.36894.arnd@arndb.de> <6d6a94c50609232035x4025672dg4f02b3bcceb6d531@mail.gmail.com>
In-Reply-To: <6d6a94c50609232035x4025672dg4f02b3bcceb6d531@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609250854.04470.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 September 2006 05:35, Aubrey wrote:
> > This looks racy. What if you get an interrupt after testing need_resched()
> > but before the idle instruction?
> >
> > Normally, this should look like
> >
> >         while(!need_resched()) {
> >                 local_irq_disable();
> >                 if (!need_resched())
> >                         asm volatile("idle");
> >                 local_irq_enable();
> >         }
> >
> > Of course that only works if your idle instruction wakes up on pending
> > interrupts.
> 
> 
> No, that doesn't work on blackfin. Blackfin need interrupt(here is
> timer interrupt) to wake up the core from IDLE mode. Once you disable
> the interrupt, the core will sleep forever.

Ok, then this is something you should take back as feedback to your
CPU designers. With the behavior you describe, the interrupt latency
(until the point where an application runs) can be up to one jiffy
longer than it should be, which is unacceptable for many real-time
users.

Worse, it means that you can not use the CONFIG_NO_IDLE_HZ option in the
future, because you have no way to guarantee that you ever wake up from
idle if you hit the race.

	Arnd <><
