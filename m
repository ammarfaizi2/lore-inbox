Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285190AbRLRV0z>; Tue, 18 Dec 2001 16:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285195AbRLRVZh>; Tue, 18 Dec 2001 16:25:37 -0500
Received: from hermes.toad.net ([162.33.130.251]:47304 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S285180AbRLRVYG>;
	Tue, 18 Dec 2001 16:24:06 -0500
Subject: Re: APM driver patch summary
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, 125612@bugs.debian.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 18 Dec 2001 16:24:05 -0500
Message-Id: <1008710648.21102.1.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated list of the patches:

Notify listener of suspend before notifying driver  (Russell King / me)
    (appended)
Fix idle handling                                   (Andreas Steinmetz)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100754277600661&w=2
Control apm idle calling by runtime parameter       (Andrej Borsenkow)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100852862320955&w=2
Detect failure to stop CPU on apm idle call         (Andrej Borsenkow)
    http://marc.theaimsgroup.com/?l=linux-kernel&m=100869841008117&w=2

I added the last one which was posted today.

I have modified Russell's patch to notify (of standbys & suspends)
listeners before drivers.  I made the following changes:

Return EBUSY instead of EIO (or EAGAIN) on rejection of request.
   (Suggestion from apmd maintainer.  Is this okay?)
Move "sti()" up a bit inside suspend() function.  (Should be harmless.)
Move "out:" after "queue_event" so that no RESUME event will be queued.
   (Listeners should notice the EBUSY and undo whatever they did.)
Recode suspend() a bit to make it easier to read.
   (Unfortunately this makes the patch harder to read.)
Skip actual suspend even if APM version is 0x100 (... just don't
   try to set APM_STATE_REJECT.  I don't see why this should be
   a problem, judging from a quick read of the APM spec).

The driver compiles with this patch, but I haven't tested it yet.

I still have one worry about the driver with this patch applied.
If a user requests a suspend and it is rejected by a driver
(and the APM version > 0x100) then APM_STATE_REJECT is sent
to the BIOS.  If the BIOS didn't generate the request then this
REJECT is comes out of the blue.  Is that acceptable, or
should we refrain from sending such REJECTS when the suspend
request didn't come from the BIOS?

--
Thomas


