Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbTE2Kzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTE2Kzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:55:50 -0400
Received: from web11804.mail.yahoo.com ([216.136.172.158]:11921 "HELO
	web11804.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262138AbTE2Kzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:55:45 -0400
Message-ID: <20030529110903.79026.qmail@web11804.mail.yahoo.com>
Date: Thu, 29 May 2003 13:09:03 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: IDE kernel parameter (was: 2.4.20 SMP, a PDC20269, and a huge Maxtor disk)
To: linux-kernel@vger.kernel.org
Cc: phil@jaj.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Edwards wrote (edited):
> ... I've installed a 200GB Maxtor drive, and a Promise Ultra133
> TX2 card to let me actually use all of it.
> 
> The mobo BIOS doesn't speak 48-bit LBA, so it sees a 137 GB drive.
> That's fine, I'm guessing, since (I'm told) Linux doesn't get its
> information from the BIOS.
> 
> Windows 2000 sees the whole drive, and uses it with no problems.  (Using
> Promise's supplied drivers.)  I mention this only to point out that there
> doesn't /seem/ to be anything physically wrong with the drive, the card,
> the cable, etc.
> 
> Booting 2.4.20 with "ide2=0x10d8,0x10d2" lets me see the new drive, along
> with a smaller drive on the same channel as slave:

  I am not sure about your problem, but maybe I can add my £0.02...

  the second parameter of "ide2=0x10d8,0x10d2", i.e. 0x10d2, is the address
 of an (only one) IDE register which is used for two things:
 - If you write to it, you can enable the interrupt bit of the IDE
 interface. Most of the time the IDE interface is used with its default
 of "interrupt enabled" - so if this second address is false you will
 not notice it there (you are writing to an invalid address, but that
 does not usually trigger an error, and the default value of the register
 is what you wanted to write anyways).
 - Some software can decide to read this register because it is the
 copy of the IDE status register - but unlike the real IDE status register
 reading the copy does not acknowledge an IDE interrupt. One possible use
 of this register is for the power saving drivers to know the state of
 the disk without interfering with data read/written, for tools like
 hdparm to get some information (special read polling modes)...

  Unfortunately, most of the so-called IDE PCI boards (I am talking
 here of my SIIG PCI card, maybe not yours) do not get this register
 right (this SIIG returns 0 when you read this register, not the copy),
 or implement an "upgraded" IDE interface to support RAID in an
 undocumented way (writing another bit to this register?).

  Testing on Redmond with their own driver doesn't prove that it is
 a real IDE interface - the driver may volumtary never read the
 copy register (to not acknowledge an interrupt from another request).
 Also the driver may not care about power saving.
  IMNSHO this copy register is absolutely needed in some cases
 under Linux.

  Unfortunately also, when this second parameter is completely wrong,
 Linux continues to work approximately correctly.

  What I can propose you is:
  - to first double check with your documentation that you typed in
 the right address 0x10d2 (I have also seen wrong documentation).
  - to check under Redmond that the reserved I/O address for this
 board is the documented one.
  - to check under Linux the PCI description of reserved I/O address
  - to check what the BIOS is thinking - not so easy...
 Download Gujin:
http://sourceforge.net/projects/gujin
 i.e.:
http://prdownloads.sourceforge.net/gujin/install-0.7.tgz?download
 untar and and install it on a floppy:
./instboot boot.bin /dev/fd0 --full
 (you need read/write access to /dev/fd0 if not root, read install.txt)
 If you boot this floppy, it will display what is the address
 reported by the Promise Ultra133 TX2 BIOS on the startup screen,
 for the HD drive connected. Note that Gujin does not display an
 IDE interface if no HD are connected.

  As an extra information, my SIIG PCI card does not appear on this
 screen, so I booted a very simple DOS to run dbgdisk.exe
 (in standard.tgz) and it is easy to see the extra register always
 reads as 0 on the "DBG" file created by dbgdisk.exe (read doc).

  What a long £0.02!
  Etienne.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
