Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265126AbUASOKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUASOKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:10:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:55429 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265126AbUASOKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:10:04 -0500
Date: Mon, 19 Jan 2004 09:11:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: timing code in 2.6.1
In-Reply-To: <20040116153122.2c4adffe.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0401190849230.6524@chaos>
References: <Pine.LNX.4.53.0401161150390.28039@chaos> <20040116153122.2c4adffe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004, Andrew Morton wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >
> >
> > Some drivers are being re-written for 2.6++. The following
> > construct seems to work for "waiting for an event" in
> > the kernel modules.
> >
> >         // No locks are being held
> >         tim = jiffies + EVENT_TIMEOUT;
> >         while(!event() && time_before(jiffies, tim))
> >             schedule_timeout(0);
> >
> > Is there anything wrong?
>
> This is not a good thing to be doing.  You should add this task to a
> waitqueue and then sleep.  Make the code which causes event() to come true
> deliver a wake_up to that waitqueue.  There are many examples of this in
> the kernel.
>

Huh? The code that causes "event()" needs to get the CPU occasionally
to check for the event. The hardware doesn't produce an interrupt
upon that event.

> If the hardware only supports polling then gee, you'd be best off spinning
> for a few microseconds then fall into a schedule_timeout(1) polling loop.
> Or something like that.  Or make the hardware designer write the damn
> driver.

The poll will almost never be true when first called. Spinning and
wasting CPU cycles that can be used by another task isn't a good
idea.

The hardware designer has designed the hardware according to
the requirements dictated by a government agency (the FDA).
There was no requirement to make interface code simple. The
interface code must check for multiple failure modes during
every specific operation. Both the hardware and software
check for these modes so that no single failure can cause
injury to a patient. This is SOP for medical equipment.

In the specific case, we operate a patient table. The operator
presses an UP and DOWN button. These will produce interrupts.

When an UP button is hit, thousands of interrupts are generated.
This is because it is a mechanical operation. The same is true
for the DOWN button. These events are filtered to determine
the true intervals for "UP", "NOTHING", and "DOWN". When the
"UP" button is pressed, the CPU servos position information
from another driver and motor speed to to move the table to
the commanded position. If the button is pressed for a short
period of time, the table moves slowly. If it is pressed for
a longer period, it moves quickly. It must accellerate according
to a schedule and decellerate according to a schedule so that
patients that weigh 350 lbs and patients that weigh 45 lbs are
accellerated and decellerated at the same rate.

When the table is being moved, 12 different parameters are
monitored. At least two parameters are actually calculated
and filtered to predict where the patient will be if the
button is released.

So, this cannot be dismissed as "get the hardware designer
to write the same driver..."

Writing software often requires knowing about the whole sustem.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


