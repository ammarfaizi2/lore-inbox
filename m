Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272451AbRIOR7K>; Sat, 15 Sep 2001 13:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272448AbRIOR7B>; Sat, 15 Sep 2001 13:59:01 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:42249 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S272450AbRIOR6o> convert rfc822-to-8bit; Sat, 15 Sep 2001 13:58:44 -0400
Date: Sat, 15 Sep 2001 19:53:51 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Linux <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: PCI 64 bit DMA addressing with SYM-2 driver.
Message-ID: <20010915193104.H968-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The O/S independant part of the latest SYM-2 driver version incorporates
support for PCI 64 bit DMA addressing, with some limitations (nothing is
perfect). This feature requires the PCI-SCSI chip to support PCI DAC
addressing. The LSI53C875A, LSI53C895A, SYM53C896, LSI53C1010 and
LSI53C1010 support such feature. Earlier chips donnot. This feature is
tunable from a driver configuration option, as follows:

SYM_CONF_DMA_ADDRESSING_MODE = 0
With such setting, all chips will use legacy PCI 32 bit DMA addressing.

SYM_CONF_DMA_ADDRESSING_MODE = 1
Such setting allows 40 bit addressing for DMA, the upper 24 bits being
wired to zero. This mode may be useful for some machines (may-be ia64),
but isn't useful for alpha and sparc64 machines. This is due to these
machines (pci-host bridges) requiring some bits past bit 39 to be set for
64 bit DMA addressing to be possible.

SYM_CONF_DMA_ADDRESSING_MODE = 2
With such setting, the driver uses 16 segment registers (IO registers
C..R) to store the high 32 bits of bus (dma) addresses. As a result, the
DMA addressable range is 16x4GB = 64GB. This mode allows to provide the
full 64 bit of addresses and so can be used on alpha and sparc64 machines.

It is possible with the LSI/SYMBIOS chips listed above to perform 64 bit
DMA addressing without limitations (using direct BMOV64 SCRIPTS
instructions), but such a support will require large additions and changes
in the driver code. Btw, for now, the 64 GB range should fit at least
99.9..9% of existing systems and even more :).

I have been unable to actually check on my machine that the driver code
does what it is intended to do when 64 bit DMA addressing is enabled
(bi-PIII with 256 MB of memory). But I have checked that configuring the
driver for either of the modes described above does not harm on my machine
using Linux-2.4.9 and FreeBSD-4.3. I couldn't do much more testing.

Here's the software config:

- linux-2.4.9                         (Linus Torvalds branch)
- pci64-2.4.9-3.patch.gz              (David S. Miller)
- sym-2.1.13-for-linux-2.4.9.patch.gz (me)

The sym-2.1.13 driver patch can be downloaded from:
   ftp://ftp.tux.org/roudier/drivers/linux/experimental/

[Btw, the pci64 patch is not required, but only SYM_CONF_ADDRESSING_MODE =
0 (thus legacy 32 bit PCI addressing) does make sense without this patch
applied and other dma mode configurations will not even compile]

In order to build the kernel with the SYM-2 driver, the following must be
defined in the kernel configuration:

SYM53C8XX driver version 2: YES
SYM53C8XX driver version 1: NO
NCR53C8XX driver          : NO
53c7,8xx  driver          : NO

For now, the SYM-2 dma addressing mode configuration parameter is not
tunable from kernel 'make [|x|menu]config'. You will have instead to edit
a driver header file and to make the appropriate change:

File: linux/drivers/scsi/sym53c8xx_2/sym_glue.h

Here are the relevant lines to change in this file:

#if 0
#define SYM_CONF_DMA_ADDRESSING_MODE 2
#endif

In fact mode 1 was already supported by the core code of stock sym53c8xx driver.
David's patch added the needed changes for the driver to call the new pci64
kernel primitives. Mode 2 seems more general, as described above. just changing
"#if 0" by "#if 1" will tell the driver to use mode 2 that is new.

The PCI 64 bit addressing support in driver sym-2.1.13 is EXPERIMENTAL and
UNTESTED. Also, the SYM53C8xx/1010 hardware and my-be common 64 bit PCI
system hardwares should not have been heavily used with real 64 PCI
addressing. This let me recommend to be very CAREFUL if you intend to try
sym-2.1.13 with 64 bit PCI addressing on a such capable machine.

Regards,
  Gérard.

