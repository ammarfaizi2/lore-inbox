Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265713AbSLBIfX>; Mon, 2 Dec 2002 03:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbSLBIfW>; Mon, 2 Dec 2002 03:35:22 -0500
Received: from h68-146-142-19.cg.shawcable.net ([68.146.142.19]:1920 "EHLO
	h68-146-142-19.localdomain") by vger.kernel.org with ESMTP
	id <S265713AbSLBIfV>; Mon, 2 Dec 2002 03:35:21 -0500
Subject: SOLVED : scsi-eide interrupt/ read errors with cdparanoia; CDROM
	works fine otherwise; dmesq included; 2.4.20
From: Kim Lux <lux@diesel-research.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1038811691.1085.5.camel@h68-146-142-19.localdomain>
References: <1038808565.1397.12.camel@h68-146-142-19.localdomain>
	 <1038811691.1085.5.camel@h68-146-142-19.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1038818567.1301.0.camel@h68-146-142-19.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 01:42:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people

Disclaimer: I'm a linux newbie.  Some of this may be incorrect. 

I spent a good day troubleshooting cdparanoia crashing my RH8 linux
install.  I traced the problem to a conflict between two kernel options
involving SCSI operation of an IDE/ATAPI CDROM drive. 

Related posts: "What is the difference between /dev/sg0, /dev/scd0..."
and
"cdparanoia crashes linx, hdd loses interrupt, can't kill process" 
These
posts were made to linux.redhat, etc. over the weekend. 

Background Info

Frequently, certain CDROM applications ie cdparanoia and cd burning
require
SCSI access to an IDE/ATAPI CDROM device because it offers a richer set
of features
to control it.

The default manner of CDROM control in a stock Linux kernel is via the
ATAPI interface.  In fact, it appears to me that unless the ATAPI
interface is turned off as a kernel option, the CDROM drive will be
accessed
this way no matter what options might be selected elsewhere. (Ie: grub
and
lilo)

Symptoms Of a IDE/ATAPI SCSI CDROM Problem

- linux crashes or becomes unresponsive when accessing the CDROM
- the message "hdx lost interrupt" appears (x = CDROM drive)
- CDROM applications hang
- improper operation of the CDROM in general
- your operation require SCSI CDROM access
- a dirty dmesg printout after CDROM operation
- the process using the CDROM won't kill after crashing

Root Problem

IDE-ATAPI CDROM operation becomes unstable under SCSI emulation if both
of the following options are
selected:

a) SCSI CDROM Support
b) IDE-SCSI Emulation

SCSI CDROM support is enabled to allow the use of a true SCSI CDROM
IDE-SCSI Emulation is enabled to allow Linux to emulate a SCSI CDROM
when
accessing an IDE CDROM.

WARNING: There may be more to this issue than resolving these two
options.
My CDROM works OK with these two options resolved.  Others are saying
that
they need to disable all the low level SCSI drivers in the kernel.    


So... to set a CDROM up for SCSI access, one should perform the
following:

a) check that the line hdx=ide-scsi appears in your boot loader (ie lilo
or
grup.) x = the position of the cdrom drive ie hda for primary master,
hdb
for primary slave, hdc for secondary master, etc.  This line will
request
that linux operate the CDROM in SCSI emulation mode 

b) in the kernel options, the ATAPI CDROM support MUST be turned OFF. 
This option is selected under ATA/IDE/MFM/RLL Support-> ATA/IDE.. Block
Devices-> Include IDE/ATAPI CDROM Support.  Turning this option off will
force Linux to access the CDROM by another method. 

c) in the kernel options, in the same area, SCSI Emulation Support must
be
turned ON.  This allows Linux to access the EDI/ATAPI CDROM via the SCSI
emulation interface.  

d) in the kernel options, Under SCSI Support, turn off SCSI CDROM
Support.
 SCSI CDROM Support is used to access a real SCSI CDROM.       

e) in /dev/, set the /cdrom link to point to /hdd.  Actually I am not
sure
about this.

f) It might or might not help to disable autorun or at least disable the
CDROM player application from attempting to control the CDROM device. 

I hope this helps someone. 

Nobody






Kim Lux <lux@diesel-research.com>
