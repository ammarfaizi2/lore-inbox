Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129119AbQKAIxX>; Wed, 1 Nov 2000 03:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbQKAIxO>; Wed, 1 Nov 2000 03:53:14 -0500
Received: from mta2-rme.xtra.co.nz ([203.96.92.3]:19820 "EHLO
	mta2-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id <S129119AbQKAIxA>; Wed, 1 Nov 2000 03:53:00 -0500
Message-Id: <3.0.6.32.20001101213931.01275ad0@pop3.xtra.co.nz>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 01 Nov 2000 21:39:31 +1300
To: linux-kernel@vger.kernel.org
From: Simon Byrnand <sbyrnand@xtra.co.nz>
Subject: SMP freeze in <= 2.2.17 when toggling consoles
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

Although I follow lkml on and off through newsgroups etc, I'm not
subscribed, so please CC me any important replies via email.

Recently while trying to pin down SCSI errors with a Dual PII machine with
onboard SCSI I discovered a nasty and easily repeatable way to cause a
total system freeze.

First the machine details, at least as much as I can remember off the top
of my head, as it is at work:

Tyan Thunder 100 M/B
256MB ram
2x PII-233 (klamath core)
Onboard dual channel AIC-7895 (aic7xxx driver built into the kernel)
Onboard eepro100 compatible ethernet.
2x Seagate ST34501W, 4GB, 10,000rpm drives

The install is Redhat 6.2 but with a custom compiled 2.2.17 kernel,
although I've been testing various different kernel's.

The symptom is basically this - under heavy disk activity, rapidly
switching virtual consoles will trigger a system freeze. Nothing will
revive the machine, the Magic Sysreq key is also inoperable. Generally I
can get it to freeze within a couple of seconds. If I just switch consoles
slowly it doesnt seem to freeze, but holding down ALT and tapping
F1-F2-F1-F2 as quick as possible will freeze it in a few seconds. Quite
often it will even freeze right in the middle of redrawing the new console
- The top half of the screen will show part of the console you were
switching to, while the bottom is still showing the previous console
because it froze before it finished drawing the screen.

Now heres the kicker - if I compile the exact same kernel, but with SMP
support disabled the freeze does *NOT* happen! Additionally, all kernel
versions (2.2 series only) I've tried exhibit the same problem. As well as
2.2.17 SMP/UP, I tried 2.2.16 SMP and UP, (UP is ok, SMP freezes) and also
the default kernels shipped with redhat 6.2 (2.2.14-5 from memory) and the
result is the same, the UP kernel is ok, the SMP kernel will freeze.

Additionally, the freeze *only* happens when there is disk activity. How
much disk activity is required to trigger it is hard to estimate, but it
certainly does not freeze when the system is idle, only when there is
significant disk activity. To generate disk activity I was using something
like

dd if=/dev/zero of=testfile bs=1M count=256

Of course creating a 256 meg empty file constitutes significant disk
activity, and reliably reproduces the problem.

So what am I looking at here ? Faulty SMP hardware which somehow works ok
in UP mode ? A buggy SMP motherboard implementation ? Bugs in the Linux SMP
implementation triggered by this motherboard ? SMP races in the SCSI
driver, the console driver, the filesystem, or something else ?

For what its worth, the reason I've been testing the machine in the first
place is because of SCSI related problems with intermitant timeouts/parity
errors etc, but as far as _that_ problem goes, I think this discovery of
being able to freeze the machine by toggling the console is a red herring -
a geninue problem certainly, but (hopefully) unrelated to the problem I was
originally trying to solve. (At present a different hard drive is on test
to try and eliminate the cause of that problem..)

I can provide any other information required to help trace the problem,
(BIOS versions, log dumps, kernel .config etc) but please CC any questions
via email...

Regards,
Simon


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
