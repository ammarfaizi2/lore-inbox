Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131695AbRCONTf>; Thu, 15 Mar 2001 08:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131697AbRCONTZ>; Thu, 15 Mar 2001 08:19:25 -0500
Received: from lxmayr6.informatik.tu-muenchen.de ([131.159.44.50]:57503 "EHLO
	lxmayr6.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S131695AbRCONTR>; Thu, 15 Mar 2001 08:19:17 -0500
Date: Thu, 15 Mar 2001 14:18:35 +0100
From: Ingo Rohloff <rohloff@in.tum.de>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
Subject: DMA Speed Select Problem (a bug ?)
Message-ID: <20010315141835.A32265@lxmayr6.informatik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First of all I'm using linux-2.4.2.
After various reboots and frustration I finally found
out, why my machine did hang, as soon as I tried to burn
a CD on my ATAPI CD Burner.

Now I know why:
A look at /proc/ide/hdc relveals that
init_speed = 66

Which is wrong, because my CDBurner is only capable of
Multiword2 DMA transfers (speed 34).
Calling "hdparm -d1 -X34 /dev/hdc" fixes the problem.

I even found these messages in /var/log/messages:

Mar 14 18:01:48 pcrohloff kernel: hdc: set_drive_speed_status: status=0x51 {
DriveReady SeekComplete Error }
Mar 14 18:01:48 pcrohloff kernel: hdc: set_drive_speed_status: error=0x04

Which basically means that the linux driver even finds out that my
drive doesn't like UDMA66, but doesn't react to it.

I think that's a bug yes ?

I got a PIIX chipset, so this might be a problem of this specific
chipset driver  (piix.c). Then again probably not ...

so long
  Ingo Rohloff

PS: Burning a CD was only one trigger for the problem. In fact
    accessing my CDBurner in any way (like mounting a CD, or reading
    from it) will lock up my whole computer, as long as 
    "hdparm -d1 -X34" isn't called.
    It also doesn't depend on "ide-scsi" or "ide-cd" it will lock
    up with both modules.

    Also after unloading "ide-cd" and then reloading it, it is
    necessary to call "hdparm" again, because ide-cd will initialize
    the drive again with init_speed=66...
