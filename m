Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTEZH3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 03:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264322AbTEZH3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 03:29:38 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:52748 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S264321AbTEZH3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 03:29:36 -0400
Subject: 2.4.21-rc Self-clearing lockups syncing to EHCI USB storage
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 26 May 2003 03:42:26 -0400
Message-Id: <1053934947.2528.47.camel@ktkhome>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, Greg, et al,

Appologies if this is has already been reported on the linux-usb-x lists
or LK.  Before 2.4.21-final goes out, I wanted to report a deadlock
condition that has existed since late 2.4.21-pre.

Somewhere between 2.4.21-pre6 and 2.4.21-rc1 changes were introduced
that have caused buffer syncing to an EHCI-HCD interfaced USB hard drive
to fail.  I back-up my dual-booting (slackware/windoze) system onto a
USB2.0 hard drive via a standard NEC USB2.0 EHCI-HCD interface card. 
The first few buffer flushes seem to go through at the normal rate
(about 13MB/sec) after which write performance would drop to just a few
percent of that.  Here is where kernel version becomes interesting.

In late 2.4.21-pre through 2.4.21-rc1 (IIRC) the slow buffer flushes
were not accompanied by any slowdown of the remainder of the system.  I
wasn't aware of the issue until  I noticed that (A) the backup was
taking an awefully long time, and (B) there were many seconds going by
when neither the system disk activity LED nor the USB drive activity LED
were lit (normally at least one, and usually both, are illuminated).

In 2.4.21-rc3, there is a very definite and easy to identify pattern. 
While trying to flush buffers to the USB drive, the USB drive's activity
light will become hard-lit without any head seeking; almost seems as if
it is stuck waiting for a partial buffer transfer.  This lasts for
almost exactly 20 seconds.  Then the activity light extinguishes.  This
lasts for 10 seconds (there is no activity of either drive).  Then the
situation repeats: the system drive flickers sub-1-second gathering
data, followed by the USB drive stuck waiting for data for 20 seconds.

While the USB drive is stuck with its activity LED illuminated, the
storage system under 2.4.21-rc3 becomes locked.  I can switch VCs, or
type non-disk-activity-generating commands to a shell interpreter, but
any attempt to access either disk results in a lockup of the process in
question.  After the 30 second repeating time window, the locked process
will get a few milliseconds of activity before it is once again locked.

Oddly, there does not appear to be any data corruption.  The lockups
self-clear.  Almost seems as if it is a memory starvation problem with
all buffers taken up for disk cache, except that it only seems to occur
when writing to the EHCI-HCD hard drive.

Poor man's debug tool:  I have a very noisy (unshielded) AC97 audio
aboard my VIA KT266A/8233 motherboard.  When not playing sound, you can
"hear" what the processor is doing by listening to the assortment of
pops, clicks, whines, buzzes, and other sound artifacts as the processor
moves memory around, etc.  During the 30 second lockup periods noted
above, the audio out is absolutely quiet, not a pop, nothing.  Sounds as
if the processor is really sitting tight indeed, IRQ loop or some such.

That's all the useful info I have at the moment.  Everything works just
fine on 2.4.20 and early 2.4.21-pre.  System is a Soltek SL75-DRV2 mobo
(AthlonXP-1700, VIA KT266A/8233, 1/2GB ECC Mem), NEC EHCI 2.0 USB
controller card, Maxtor 3000LE USB2.0 hard drive enclosure w/D540X
drive.

Further debugging ideas?
Thanks,
Kris

P.S. I'm not on linux-usb, only LK, so any USB devos, please CC me.

