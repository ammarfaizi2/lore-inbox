Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279373AbRJWLDu>; Tue, 23 Oct 2001 07:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279372AbRJWLDk>; Tue, 23 Oct 2001 07:03:40 -0400
Received: from s1.relay.oleane.net ([195.25.12.48]:49829 "HELO
	s1.relay.oleane.net") by vger.kernel.org with SMTP
	id <S279371AbRJWLDf>; Tue, 23 Oct 2001 07:03:35 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Tue, 23 Oct 2001 13:03:44 +0200
Message-Id: <20011023110344.17140@smtp.adsl.oleane.com>
In-Reply-To: <20011023114407.B2639@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011023114407.B2639@atrey.karlin.mff.cuni.cz>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I forgot to mention to disable interrupts after the SUSPEND_NOTIFY call.
>> The idea is to allocate all memory in the first pass, disable interrupts,
>> then save state. Would that work? Or, should some of the state saving take
>> place with interrupts enabled?
>
>That looks ugly, because you'd need to add DONT_SUSPEND_NOTIFY, called
>when SUSPEND_NOTIFY fails.
>								Pavel

No, interrupts have to be shut down between SUSPEND_SAVE_STATE and
SUSPEND_POWER_DOWN, I beleive.

SUSPEND_SAVE_STATE must run with interrupts enabled, as it's supposed
to both block new incoming IOs and wait for pending ones to complete (*).
It would be sub-efficient to force drivers to implement polled IOs for
this case.

SUSPEND_POWER_DOWN itself should perfectly be able to run with interrupts
disabled, I beleive, as must of the actual suspend sequence can be done
in SUSPEND_SAVE_STATE on most chips.

There is no problem with failure there. Just call RESUME_POWER_ON if
SUSPEND_POWER_DOWN failed (or later), then RESUME_RESTORE_STATE in
all cases. The driver knows from which state it comes from anyway,
and we don't have, I beleive, that strick VM need of separating
suspend from free's. Well... let's think more about it... we might
actually need to allocate memory in RESUME_RESTORE_STATE to create
new requests or whatever the driver need... but we can also do that
earlier, inside SUSPEND_NOTIFY (or just use whatever memory we
pre-allocated to save state). So it might make sense to have the
resume process be an exact mirror of the wakeup one, or not, maybe
just a matter of taste.

In most cases, keep in mind that most drivers won't need to implement
all of these.

Ben.




