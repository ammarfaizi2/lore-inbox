Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318196AbSIJWim>; Tue, 10 Sep 2002 18:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318198AbSIJWim>; Tue, 10 Sep 2002 18:38:42 -0400
Received: from ausadmmsps305.aus.amer.dell.com ([143.166.224.100]:33289 "HELO
	AUSADMMSPS305.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318196AbSIJWil>; Tue, 10 Sep 2002 18:38:41 -0400
X-Server-Uuid: bc938b4d-8e35-4c08-ac42-ea3e606f44ee
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E7ED@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: mochel@osdl.org, greg@kroah.com
cc: phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: RE: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Date: Tue, 10 Sep 2002 17:43:22 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1160AA012122958-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated the EDD code to use driverfs instead of /proc.  It's now
exported as:

.
|-- edd
|   |-- 80
|   |   `-- info
|   |-- 81
|   |   `-- info
|   |-- 82
|   |   `-- info
|   |-- 83
|   |   `-- info
|   |-- 84
|   |   `-- info
|   `-- 85
|       `-- info

where 80..85 are the BIOS device numbers, and info is a file that displays
the same information I was displaying before.  Thanks Patrick for the
pointers, and once the top-level firmware/bios/whatever directory is made,
it can move there easily.
Patch available from http://domsch.com/linux/edd30/edd-driverfs-1.patch and
http://domsch.com/linux/edd30/edd-driverfs-1.patch.sign applies against
2.5.34 or BK-current, and is the whole of the feature, not incremental.
Also in BK at http://mdomsch.bkbits.net/linux-2.5-edd.

The next logical extension would be to make a symlink 'disk' in each
directory that points at the PCI bus:dev.fn/scsiX/a:b:c:d:disk file for the
appropriate disk.  However, I'm in a quandry...  There's no simple way to do
this.

For EDD to do the mapping itself, it needs to walk various lists of devices
(Scsi_Disks, IDE disks, ...)  Those lists aren't currently exported.
EDD could do it itself brute-force, except that it knows all the information
*except* the scsiX host logical number, so it would still have to some sort
of lookup.  That nice physical (and virtually identical logical) path got a
kernel-logical component added which requires a lookup. :-(   The third
problem is that mapping needs to happen at device discovery time, not at EDD
load time, else scsi-add-single-device and/or modular IDE insertions later
won't pick it up.

So, I start thinking about making calls from the various disk type drivers
back to the EDD code to get the symlinks made.  That touches more than I
wanted to this round, but is probably the best way to go, and what I'll
investigate.  Per-arch dummy asm/edd.h dummy files with noop functions for
the calls into EDD that are only x86-applicable...  yuck.

Thoughts?

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

