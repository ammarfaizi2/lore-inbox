Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUEADI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUEADI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 23:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUEADI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 23:08:57 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:21124 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261704AbUEADIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 23:08:54 -0400
Date: Sat, 1 May 2004 13:08:28 +1000
From: CaT <cat@zip.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata + siI3112 + 2.6.5-rc3 hang
Message-ID: <20040501030828.GE2109@zip.com.au>
References: <20040429234258.GA6145@zip.com.au> <200404300208.32830.bzolnier@elka.pw.edu.pl> <20040430093919.GA2109@zip.com.au> <200404301800.08763.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404301800.08763.bzolnier@elka.pw.edu.pl>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 06:00:08PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday 30 of April 2004 11:39, CaT wrote:
> > On Fri, Apr 30, 2004 at 02:08:32AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > Probably your drive needs mod15write quirk. please try this.
> > >
> > > [PATCH] sata_sil.c: ST3200822AS needs MOD15WRITE quirk
> >
> > Didn't work. Still hangs rather well. :/
> 
> I have no idea then.   Jeff?

A solution has come forth! Whee! :) Joe Rutledge sent me a message in 
private relating to his issues with the sil3112 and local apic. It solved
the hang issue for him and it appears to have solved it for me also as
I've run many a hdparm -tT on the drive and got upto 62MB/s each go where
as before I could run it once at the most, with the 2nd try resulting
in a hang.

Happy days. Linux doesn't hang anymore on my PC, my SATA drive does 62MB/s
thanks to libata (tons of thanks for the work on that - it did 35MB/s using
the normal IDE SATA driver) and I found a reclusive easter egg next to my
keyboard. Joy. :)

Here's the patch that Joe sent me. It doesn't apply cleanly mainly due
to formatting errors in the patch but a bit of manual fixerupping made
it all apply.

--- 8< ---
--- linux-2.6.4-orig/arch/i386/pci/fixup.c      2004-03-11 
03:55:36.000000000 +0100
+++ linux-2.6.4/arch/i386/pci/fixup.c   2004-03-16 13:12:25.706569480 +0100
@@ -187,6 +187,22 @@
               dev->transparent = 1;
}

+/*
+ * Halt Disconnect and Stop Grant Disconnect (bit 4 at offset 0x6F)
+ * must be disabled when APIC is used (or lockups will happen).
+ */
+static void __devinit pci_fixup_nforce2_disconnect(struct pci_dev *d)
+{
+       u8 t;
+
+       pci_read_config_byte(d, 0x6F, &t);
+       if (t & 0x10) {
+               printk(KERN_INFO "PCI: disabling nForce2 Halt Disconnect"
+                                " and Stop Grant Disconnect\n");
+               pci_write_config_byte(d, 0x6F, (t & 0xef));
+       }
+}
+
struct pci_fixup pcibios_fixups[] = {
       {
               .pass           = PCI_FIXUP_HEADER,
@@ -290,5 +306,11 @@
               .device         = PCI_ANY_ID,
               .hook           = pci_fixup_transparent_bridge
       },
+        {
+               .pass           = PCI_FIXUP_HEADER,
+               .vendor         = PCI_VENDOR_ID_NVIDIA,
+               .device         = PCI_DEVICE_ID_NVIDIA_NFORCE2,
+               .hook           = pci_fixup_nforce2_disconnect
+        },
       { .pass = 0 }
 };
--- 8< ---

-- 
    Red herrings strewn hither and yon.
