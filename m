Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUFCGvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUFCGvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUFCGvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:51:40 -0400
Received: from vsmtp2alice.tin.it ([212.216.176.142]:45026 "EHLO vsmtp2.tin.it")
	by vger.kernel.org with ESMTP id S261347AbUFCGvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:51:31 -0400
Subject: Re: 2.6.x partition breakage and dual booting
From: Frediano Ziglio <freddyz77@tin.it>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20040531180821.GC5257@louise.pinerecords.com>
References: <40BA2213.1090209@pobox.com>
	 <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com>
	 <20040530200300.GA4681@apps.cwi.nl> <s5g8yf9ljb3.fsf@patl=users.sf.net>
	 <20040531180821.GC5257@louise.pinerecords.com>
Content-Type: text/plain
Message-Id: <1086245495.3988.4.camel@freddy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 03 Jun 2004 08:51:35 +0200
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il lun, 2004-05-31 alle 20:08, Tomas Szepe ha scritto:
> > This is really very simple.  If you move a disk from a machine with a
> > different BIOS and you preserve the partition table geometry, you will
> > NEVER be able to install Windows on the drive.  If you partition a
> > blank drive and use the wrong geometry, you will NEVER be able to
> > install Windows on the drive.
> 
> I don't quite believe this.  AFAICT the Windows 2000/XP install program will
> succeed no matter what, the only problem is with getting the dirty thing to
> boot AFTER install has completed.  If it craps out, boot off the install
> CD to the repair console prompt, run fixboot/fixmbr and all should be swell.
> If you need dual boot, you can go ahead and reinstall lilo/grub at this point.
> The one scenario unfixable without a hex editor that I know of is installing
> Windows on a partition that was created using mkdosfs -F 32 (and even that
> will sometimes work).

Sorry to have to post again this message, I'm new to this ML so I forgot
to CC Andries.

Actually I'm writing two patch:
 - extending EDD code to provide DPTE informations and signature for all
drives
 - modify IDE code to match BIOS disks.

Original post follows
***************************

Let me explain my point of view

I encountered the problem trying to install Fedora Core 2. Using Fedora
Core 2 and fdisk do not works (it return bad head count), so it's not
only an anaconda problem.

I analyzed 2.4.22 code and 2.6.5 code (both from Fedora kernels)
In 2.4 when an IDE drive is detected it looks in CMOS to see if a HD is
configured, then fetch BIOS data from int 41h / int 46h. If this is not
possible it try to compute heads number (the number that allow you to
access most data) (drivers/ide/ide-geometry.c). Another hint is to check
partition table (fs/partitions/msdos.c). In 2.6 this code just
disappeared...

I think it's important to know BIOS point of view. Linux provide these
information so we have two choices to solve the problem:
- correct the informations we return
- do not return anything and let user space programs do the job!

How to match Linux view with BIOS view? We have some unimplemented mode
I'll explain below (I just want to fix this problem).

Mainly the problem raise cause we have a lot of choices and different
configurations:
- SCSI. BIOS can see SCSI disks before IDE disks, see the first SCSI
disk then IDEs then others SCSIs;
- BIOS settings. Some BIOS always minimize cylinder count (maximizing
head count), others no, others allow you to select geometry (in my BIOS
I have three choices: LBA, CHS and Large)
- BIOS boot sequence. Newer BIOS let you choice what's is the first
disks. Also I tried to plug a USB disks and select as first disk but
BIOS put it always as second (even if I boot from floppy)... perhaps it
check MBR???

How to match BIOS with Linux?
There are some infos that can helps:
- if we have only a disks it's easy
- we can use dimensions (int13h/8h, int 41h/46h)
- MBR signature. I don't even know this before yesterday!!! We save only
this information for first BIOS disk (80h), we can improve saving this
information (and provide in sysfs)
- EDD 1.0. Use physical dimensions to match
- EDD 2.0. I don't understand why Linux code int 41h/46h and ignore
these informations. My BIOSes do not support EDD 3.0 but support EDD
2.0. EDD 2.0 provide informations like command port and if slave or not
(see Ralph Brown's interrupt list, int 13h/48h). If a disk is IDE we can
match _exactly_ the disk!
- EDD 3.0. Here we have disk type and path (like LUN/ID on SCSI), very
easy to match but not very widely implemented.
IMHO we should try to use these informations as best that we can.

There are also some informations in EDD that should be detected like
removable disks. It would be useful if Linux can provide a mapping
between BIOS and Linux disks to user-space programs.

I can try to code some implementation but I'm not an Linux kernel
hacker... for example I don't know if IDE is detected before SCSI
(something suggests me that there isn't an order).

freddy77


