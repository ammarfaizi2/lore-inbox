Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSFQNhk>; Mon, 17 Jun 2002 09:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSFQNhj>; Mon, 17 Jun 2002 09:37:39 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:39943 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S313477AbSFQNhj>; Mon, 17 Jun 2002 09:37:39 -0400
Subject: PIIX4 IDE tri-state support?
To: linux-kernel@vger.kernel.org
Date: Mon, 17 Jun 2002 15:37:37 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17JwhN-000847-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as I can see, there are IDE driver updates in the 2.4.19pre kernels
including support for bus tri-state feature on some newer chipsets.
How about the good old PIIX4 chip?  Here is the datasheet:

  http://www.intel.com/design/intarch/DATASHTS/29056201.pdf

See page 66, bits 11 and 12 of GENCFG register (function 0, address
0xb0 in PCI config space).  Is anyone working on supporting this?

Sure, hot-swapping IDE disks is still risky, but some people are
doing it anyway :) so let's make it a little less risky - unmount
everything, then "hdparm -Y" (flush any write cache, spin down),
then "hdparm -b0" and only then remove the disk.

Perhaps there should be some higher level logic here, like this:

 - if no device is found on an IDE bus on startup (or module load),
   tri-state that bus (so it is "safe" to connect a device later)

 - if the driver is told to tri-state an IDE bus, first make sure
   the devices on that bus are not busy, tell them to go to sleep,
   unregister them (as they will be removed - if not, the bus will
   be rescanned later anyway, after it is re-enabled)

 - if the driver is told to rescan the bus that was tri-stated,
   re-enable it first (if no devices found, tri-state it again)

 - if the system is being shut down (or driver module is removed),
   also tri-state the bus (as above, first tell all devices to go to
   sleep, etc.) - the "go to sleep" part is already being done by
   the Debian shutdown scripts, as it seems to be the only sure way
   to flush write caches on some disks before power off.

I admit I haven't looked much at 2.5 yet, so excuse me if parts of
this are already done.  It's just a few small suggestions...

Thanks,
Marek

