Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288092AbSBDUYc>; Mon, 4 Feb 2002 15:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288113AbSBDUYW>; Mon, 4 Feb 2002 15:24:22 -0500
Received: from ECE.CMU.EDU ([128.2.136.200]:46722 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S288092AbSBDUYI>;
	Mon, 4 Feb 2002 15:24:08 -0500
Date: Mon, 4 Feb 2002 15:24:00 -0500 (EST)
From: Nilmoni Deb <ndeb@ece.cmu.edu>
Reply-To: Nilmoni Deb <ndeb@ece.cmu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: bugs in drivers/ide/ide-pci.c and drivers/ide/hpt366.c prevents boot up with VIA KT266A chipsets
In-Reply-To: <Pine.LNX.4.33.0110242122250.9147-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96L.1020204140359.21434C-100000@d-alg.ece.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BUG DESCRIPTION

	Kernel fails to boot with some VIA KT266A chipsets. It gives the
message "Booting VMlinuz............." and the screen immediately blanks
out and freezes. Example motherboards where this happenned are
MSI-K7T266-Pro2(MS-6380), abit kr7a-raid.

The following is with respect to kernel-2.4.17 source tree.

	In drivers/ide/ide-pci.c, in the definition of function
hpt366_device_order_fixup, the line:

	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev); 
	
reads class_rev and gets 5 on the abit kr7a-raid system.
Since the code is only prepared for 4 or less, the problem appears in the
subsequent line:

	strcpy(d->name, chipset_names[class_rev]);

where chipset_names[class_rev]=chipset_names[5] attempts to access
an invalid array element, given that chipset_names[4] is the last valid
elelment.

After the lines
	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
	class_rev &= 0xff;
adding these two check lines solves the boot problem:

	if( class_rev >= (sizeof(chipset_names)/sizeof(char *)) ) { 
		class_rev = (sizeof(chipset_names)/sizeof(char *)) - 1; 
		}

The same problem exists for drivers/ide/hpt366.c and needs the same
fix. So after the lines
	pci_read_config_dword(bmide_dev, PCI_CLASS_REVISION, &class_rev);
    	class_rev &= 0xff;
these two lines must be added:
	
	if( class_rev >= (sizeof(chipset_names)/sizeof(char *)) ) {
                class_rev = (sizeof(chipset_names)/sizeof(char *)) - 1;
                }

Also, in drivers/ide/ide-pci.c, in the definition of function
hpt366_device_order_fixup, the line:

	strcpy(d->name, chipset_names[class_rev]);

would (for a test case) copy a 7 char string "HPT370A" into and over the
string "HPT366" destroying the terminating null byte. What this may lead
to is unknown but has been fixed by replacing this statement by a strncpy:

	/* DON'T COPY 7 CHARS (HPT370A) OVER 6 CHARS (HPT366) */ 
	strncpy(d->name, chipset_names[class_rev], strlen(d->name));

KERNEL VERSIONS AFFECTED

	The following kernels are known to have this bug ->
2.4.8 (mandrake-8.1)
2.4.7 (redhat-7.2)
2.4.17


AFFECTED FILES

	drivers/ide/ide-pci.c
	drivers/ide/hpt366.c

More files may be affected. I could look into this as soon as the
developers get back with a response.


The bug and a possible fix are described in

http://forums.viaarena.com/messageview.cfm?catid=6&threadid=2258


thanks
- Nil

