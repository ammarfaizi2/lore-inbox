Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261475AbTCVAht>; Fri, 21 Mar 2003 19:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbTCVAht>; Fri, 21 Mar 2003 19:37:49 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:12416 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261475AbTCVAhp>; Fri, 21 Mar 2003 19:37:45 -0500
Date: Sat, 22 Mar 2003 09:47:36 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: module for legacy PC9800 ide
Message-ID: <20030322004736.GA1033@yuzuki.cinet.co.jp>
References: <200303211928.h2LJSjWS025795@hraefn.swansea.linux.org.uk> <20030321185905.A7664@infradead.org> <1048278284.5718.87.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048278284.5718.87.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 08:24:44PM +0000, Alan Cox wrote:
> On Fri, 2003-03-21 at 18:59, Christoph Hellwig wrote:
> > On Fri, Mar 21, 2003 at 07:28:45PM +0000, Alan Cox wrote:
> > > +	/* These ports are probably used by IDE I/F.  */
> > > +	request_region(0x430, 1, "ide");
> > > +	request_region(0x435, 1, "ide");
> > 
> > No error chechking?
> 
> If it fails you have a rather bigger problem on your hands.
> 
> I agree however - Osamu, can you fix this
Thanks.
Could you plese replace patch by this one.
Some PC-98 has these port, not all PC-98. These ports are connected to
IDE chip. But driver doesn't use these ports. So I added a warning
messeage.

--- /dev/null	2002-08-31 08:31:37.000000000 +0900
+++ linux/drivers/ide/legacy/pc9800.c	2003-03-22 09:09:25.000000000 +0900
@@ -0,0 +1,84 @@
+/*
+ *  ide_pc9800.c
+ *
+ *  Copyright (C) 1997-2000  Linux/98 project,
+ *			     Kyoto University Microcomputer Club.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/pc9800.h>
+
+#define PC9800_IDE_BANKSELECT	0x432
+
+#undef PC9800_IDE_DEBUG
+
+static void pc9800_select(ide_drive_t *drive)
+{
+#ifdef PC9800_IDE_DEBUG
+	byte old;
+
+	/* Too noisy: */
+	/* printk(KERN_DEBUG "pc9800_select(%s)\n", drive->name); */
+
+	outb(0x80, PC9800_IDE_BANKSELECT);
+	old = inb(PC9800_IDE_BANKSELECT);
+	if (old != HWIF(drive)->index)
+		printk(KERN_DEBUG "ide-pc9800: switching bank #%d -> #%d\n",
+			old, HWIF(drive)->index);
+#endif
+	outb(HWIF(drive)->index, PC9800_IDE_BANKSELECT);
+}
+
+void __init ide_probe_for_pc9800(void)
+{
+	u8 saved_bank;
+
+	if (!PC9800_9821_P() /* || !PC9821_IDEIF_DOUBLE_P() */)
+		return;
+
+	if (!request_region(PC9800_IDE_BANKSELECT, 1, "ide0/1 bank")) {
+		printk(KERN_ERR
+			"ide: bank select port (%#x) is already occupied!\n",
+			PC9800_IDE_BANKSELECT);
+		return;
+	}
+
+	/* Do actual probing. */
+	if ((saved_bank = inb(PC9800_IDE_BANKSELECT)) == (u8) ~0
+	    || (outb(saved_bank ^ 1, PC9800_IDE_BANKSELECT),
+		/* Next outb is dummy for reading status. */
+		outb(0x80, PC9800_IDE_BANKSELECT),
+		inb(PC9800_IDE_BANKSELECT) != (saved_bank ^ 1))) {
+		printk(KERN_INFO
+			"ide: pc9800 type bank selecting port not found\n");
+		release_region(PC9800_IDE_BANKSELECT, 1);
+		return;
+	}
+
+	/* Restore original value, just in case. */
+	outb(saved_bank, PC9800_IDE_BANKSELECT);
+
+	/* These ports are reseved by IDE I/F.  */
+	if (!request_region(0x430, 1, "ide") ||
+	    !request_region(0x435, 1, "ide")) {
+		printk(KERN_WARNING
+			"ide: IO port 0x430 and 0x435 are reserved for IDE"
+			" the card using these ports may not work\n");
+	}
+
+	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET] == HD_DATA &&
+	    ide_hwifs[1].io_ports[IDE_DATA_OFFSET] == HD_DATA) {
+		ide_hwifs[0].chipset = ide_pc9800;
+		ide_hwifs[0].mate = &ide_hwifs[1];
+		ide_hwifs[0].selectproc = pc9800_select;
+		ide_hwifs[1].chipset = ide_pc9800;
+		ide_hwifs[1].mate = &ide_hwifs[0];
+		ide_hwifs[1].selectproc = pc9800_select;
+	}
+}
