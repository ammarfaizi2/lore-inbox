Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbTGICev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 22:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbTGICev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 22:34:51 -0400
Received: from CPE00e02915899a-CM.cpe.net.cable.rogers.com ([24.157.227.104]:17318
	"EHLO mokona.furryterror.org") by vger.kernel.org with ESMTP
	id S265631AbTGICeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 22:34:50 -0400
From: Zygo Blaxell <uixjjji1@umail.furryterror.org>
Subject: 2.4.21 IDE and IEEE1394+SBP2 regressions, orinoco_pci progress
Date: Tue, 08 Jul 2003 22:49:26 -0400
Organization: Furry Cats and Hungry Terrors
Message-ID: <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org>
User-Agent: Pan/0.11.2 (Unix)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Comment-To: ALL
NNTP-Posting-Host: 10.215.3.77
X-Header-Mangling: Original "From:" was <zblaxell@umail.hungrycats.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously on kernels up to 2.4.20, an IDE disk I/O request that was in
progress at suspend time would trigger a DMA reset upon resume, after a
short delay while waiting for the timeout.  2.4.20 looked like this:

        ide_dmaproc: chipset supported ide_dma_lostirq func only: 13 hda:
        lost interrupt

After this, the machine happily resumes whatever it was doing.  There is a
delay of a few seconds while this happens.

Now in 2.4.21, the kernel prints the following message:

        hda: dma_timer_expiry: dma status == 0x04

and that's the last thing it ever does--the kernel locks up hard.

Note that in order to see this you need to be doing a lot of I/O at
suspend time, e.g. 'cp -a /usr /tmp' or some such thing.

Also in 2.4.21, a filesystem mounted from a CD-ROM via ide-scsi will start
to get I/O errors if it is accessed during the suspend/resume sequence. 
In 2.4.20, there were no ill effects when this happens.



The IEEE1394+SBP2 driver combination in 2.4.21 has problems.  When the
kernel is compiled for single-processor the SBP2 driver can't log into my
SBP2 devices and hangs rmmod when the module is removed--in other words,
it's useless.  When compiled for SMP, the SBP2 driver works more or less
normally, but still requires an IEEE1394 bus reset to work the second time
a device is attached.  Note this is a laptop, so it only has one
processor.

2.4.20 has no such problems with my IEEE1394 SBP2 device--no bus resets
needed, no compile-option-dependent bugs, and it logs in and out of the
device without problems.


On a positive note, the orinoco_pci driver in 2.4.21 is the best driver
I've used for this chipset so far.  It's a vast improvement over the same
driver in 2.4.20, which would hang after about 30 seconds.  2.4.21's
driver is even slightly faster than the linux-wlan-ng driver.


The hardware in question is an IBM Thinkpad A30p with an S.400 port and
builtin Prism2.5 chipset.  The SBP2 device is a "Prolific PL3507 Combo
Device" (IOGear ION external IDE disk enclosure).  Kernel was compiled
with gcc 2.95.4 on Debian.

Further details available on request.
