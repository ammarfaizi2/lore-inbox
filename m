Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132144AbRDFRoH>; Fri, 6 Apr 2001 13:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132146AbRDFRn6>; Fri, 6 Apr 2001 13:43:58 -0400
Received: from front2.grolier.fr ([194.158.96.52]:27067 "EHLO
	front2.grolier.fr") by vger.kernel.org with ESMTP
	id <S132144AbRDFRnl> convert rfc822-to-8bit; Fri, 6 Apr 2001 13:43:41 -0400
Date: Fri, 6 Apr 2001 16:31:51 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Stefano Coluccini <s.coluccini@caen.it>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: RE: st corruption with 2.4.3-pre4
In-Reply-To: <NDBBIFIMCKPOADMAJOKMKEPFDAAA.s.coluccini@caen.it>
Message-ID: <Pine.LNX.4.10.10104061609330.996-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Apr 2001, Stefano Coluccini wrote:

> > I'm still waiting for other reports of st/sym53c8xx on PPC under
> > 2.4.x. BTW,
> > does it work on other big-endian platforms, like sparc?
> 
> I don't know if it is the same problem, but ...
> I have a Motorola MVME5100 (PowerPC 750 based CPU) with a mezzanine PCI
> based on the sym53c875 chip. I'm using the 2_5 kernel from fmslabs and the
> first time I have downloaded the kernel all works fine, while in a
> successive update the sym53c8xx driver was changed and my board don't work
> anymore. The driver hangs on downloading the SCSI scripts.
> I'm not a SCSI driver expert, so I've solved the problem installing the old
> version of the driver.
> Tom Rini says to me that it happened when he have merged some updates from
> the 2_4 tree, so I think my problem is related to the latest updates to the
> driver.
> I hope this helps you.
> Bye.
> Stefano.

IMO, it might well be the Linux/PPC PCI interface that doesn't return
expected values.

1) The [sym|ncr]53c8xx need to know about BAR addresses as physical
   address values as seen from the BUS. These values are used by the 
   SCSI SCRIPTS and _NOT_ by the CPU.

2) The pcidev structure returns cookies instead, that commonly are
   BARs physical addresses as seen from CPU.

The recent change in the Symbios driver about point (1) is that the
driver now reads the BARs using the pci_read_config*() interface. If these
functions donnot return the actual BAR values usable from the BUS for some
obscure reasons, this may explain your problem.

The cookies contained in the pcidev structure are completely useless for
the driver and probably for any driver. They just have to be used to remap
memory BARs to CPU virtual addresses. Then the driver forgets about them.

There are still some PPC PCI specific hacks in the sym53c8xx driver and it
has been reported to me that they can be removed. If the PPC PCI interface
is correct, then they should be removed without problems, IMO.

Here is a patch that removes the offending PPC PCI hacky area from the
driver (sym53c8xx_defs.h):

--- sym53c8xx_defs.h	Fri Apr  6 16:23:48 2001
+++ sym53c8xx_defs.h.orig	Sun Mar  4 13:54:11 2001
@@ -175,6 +175,9 @@
 #define	SCSI_NCR_IOMAPPED
 #elif defined(__alpha__)
 #define	SCSI_NCR_IOMAPPED
+#elif defined(__powerpc__)
+#define	SCSI_NCR_IOMAPPED
+#define SCSI_NCR_PCI_MEM_NOT_SUPPORTED
 #elif defined(__sparc__)
 #undef SCSI_NCR_IOMAPPED
 #endif
-------------------- Cut Here ------------------

Regards,
  Gérard.

