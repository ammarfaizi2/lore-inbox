Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbULaME5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbULaME5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 07:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbULaME5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 07:04:57 -0500
Received: from tim.rpsys.net ([194.106.48.114]:16622 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261866AbULaMEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 07:04:50 -0500
Message-ID: <007e01c4ef30$f23ba3c0$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: <linux-kernel@vger.kernel.org>
Subject: Flaw in ide_unregister()
Date: Fri, 31 Dec 2004 12:04:54 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having some problems with calls to ide_unregister() (in ide.c).

This function is declared void which should mean it always succeeds and yet 
it can fail *silently* under the following condition:

if (drive->usage || DRIVER(drive)->busy) goto abort;

(it also fails if (!hwif->present) although that is not a problem)

The driver I've been having problems with is ide-cs.c. Specifically if a CF 
card is removed without ejecting and unmounting the card first. In this 
case, the hardware is gone so we want the ide_unregister call to succeed and 
yet the above code aborts the unregister (silently). This makes it an ide 
problem rather than an ide-cs/pcmcia problem.

There are several solutions:

1. Fix ide_unregister so it always succeeds. (Preferred Solution)
2. Add parameter to ide_unregister to state whether it should abort on 
busy/usage or not. (ugly)
3. Add a return value. What does ide-cs.c do with it though? The hardware is 
gone. (doesn't help)

Only a limited number of drivers use ide_unregister():

drivers/ide/ide-pnp.c
drivers/ide/arm/rapide.c
drivers/ide/legacy/ide-cs.c
drivers/macintosh/mediabay.c

Of these, I can't see anything that would break if we make ide_unregister 
always succeed.

I've tried removing the if statement above and just letting ide_unregister 
succeed but the call then just deadlocks. I had to make some small changes 
to ide.c and ide-disk.c to stop it using interfaces we've marked as dead and 
allow deregistration of dead devices.

The bare minimum of code I needed to make ide_unregister succeed when called 
from ide-cs.c is in the following patch: 
http://www.rpsys.net/openzaurus/ide.patch

There are probably other places checks are needed. I would appreciate it if 
someone could comment on whether these changes can be made to the ide 
drivers, what else may need to be done or if there is an alternative 
solution I've overlooked.

Thanks,

Richard




-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.298 / Virus Database: 265.6.7 - Release Date: 30/12/2004

