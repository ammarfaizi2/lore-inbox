Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbRAWVkX>; Tue, 23 Jan 2001 16:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRAWVkN>; Tue, 23 Jan 2001 16:40:13 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:6156 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S130017AbRAWVkC>;
	Tue, 23 Jan 2001 16:40:02 -0500
Date: Tue, 23 Jan 2001 22:39:22 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount, summary
In-Reply-To: <20010114233208.A2487@suse.cz>
Message-ID: <Pine.LNX.4.30.0101232130150.27097-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, folks, it's time for a summary.  Since my last post, I've had time to
experiment a bit more, and I've also had some private communication with
Vojtech.

First, I would like to say that you do need quite a bit of bad luck (or
hardware) to have the same problems I did.  Linux 2.4, VIA and IDE works
very well for most users.  But I really recommend making a backup of all
your vital data before installing 2.4 and enabling DMA with IDE disks.
(And, yes, I did this.  Honest! :-) )

Problem log
===========

1. Installed RedHat 7
2. Built 2.4.0 with VIA driver and DMA by default (well, in 2.4.0, the VIA
   driver will always use DMA by default, wheather you want to or not.)
3. Rebooted -> 2.4.0
4. The computer froze on the remounting root read-write message.
5. Powercycle
6. Rebooted -> 2.2.16-22
7. Got a corrupt disk, missing files, moved files, incorrect file contents
8. Goto 1

So, why did this happen?

Problem one
===========

This one really makes me upset, because had it not been for this one, it
would have been soo much easier to find the cause of the problem.  It is
also so easy to fix.

The problem is that the RedHat disables all kernel messages during boot,
except for panics.  I my not so very humble opinion, kernel error
messages, and possibly also warning messages, should of course be shown.
It can easyly be fixed by editing /etc/sysconfig/init.

The error messages that was hidden by RH7, was a couple of CRC error
messages, and then an endless stream of "Busy" and "Drive not ready for
command" errors.  More on this later.

Problem two
===========

The computer in question has problems with UDMA(33), otherwise I would not
have gotten CRC errors, and everything would have been fine.  Why I do get
CRC errors, one can so far only speculate, especially since I am able to
use UDMA(66) with another drive, on the same controller, without much
trouble.

One theory is that the PCI bus clock may be too fast, and the drive cannot
catch up.  To check this, I plan to measure the PCI clock to see if this
is true.  Quick measurements with a not too great oscilloscope seems to
indicate a clock speed of around 33.3-33.4 MHz, so it may actully be out
of spec, but not by much.

Another theory is that the CRC errors are caused by bad cables,
connectors, or motherboard, but the fact that I can use UDMA(66) on the
same controller seems to contradicts this.  But OTOH I have learnt not to
underestimate the amazing amount of trouble a bad cable can cause.

Possible work-arounds include a "idebus=40" kernel option, or using
hdparm to configure the drive and kernel for UDMA(22).

Problem three
=============

The drive that gave me these problems is a SAMSUNG VG34323A, and the
problem with this drive is that it does not seem to recover from CRC
errors.  Once I get my first CRC error, the drive becomes permanently
busy, until I power cycle.

Problem four
============

<speculation>I do not know exactly what Linux is doing when remounting a
partition read-write, but it does seem to update some very sensitive
sectors, and when the write fails, a lot of very vital data is destroyed.
It is perhaps questionable whether the destruction of a couple of files
would be much better than the destruction of /dev, but I think it is.
</speculation>

Lesson
======

Be very careful when enabling DMA on a Linux machine, especially on cheap
hardware.  It is not enough to test DMA on a read-only partition first,
since writing is a completely different story.

...and probably some more things that I either forgot, or are too painful
to remember...

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
