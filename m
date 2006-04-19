Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWDSQtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWDSQtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWDSQtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:49:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:52514 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750777AbWDSQtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:49:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type;
        b=VRJWXhzpeIRrM6DvDfyJ3RDW+FxnbuNhMzo5m2Gdpdzvx7KegpMyzCsvMk8Ldz2x8ErhTXsSC+H08xVCsm94PMk38SbWg5VrQWPor3QyZvrLVNvVvmsocDy9F6b9bXmMcJsBGhubtXKypuZfdI3irfnNz5B3d8K2eB7wSdjd/Lg=
Message-ID: <4789af9e0604190949t42677b35mcba4ee57b92ffff9@mail.gmail.com>
Date: Wed, 19 Apr 2006 10:49:24 -0600
From: "Jim Ramsay" <kernel@jimramsay.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Possible MTD bug in 2.6.15
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7653_9205056.1145465364040"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7653_9205056.1145465364040
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

We have an interesting problem with MTD and a flash chip on an
embedded board.  The problem stems from the fact that due to hardware
constraints we can only access up to 32M of address space on an
attached flash device.  However, the actual part attached to the board
is 64M.  Yes, I know this is not likely to happen, but it points at a
kernel bug which will happen if you ever specify a MTD map->size which
is less than the actual size of the CFI flash chip.

When we specify the map->size as 32M (0x02000000) and do the CFI
probe, the chip is properly detected, but then in gen_probe.c the
following happens:

- genprobe_ident_chips is run
  - It sets cfi.chipshift based on the cfi.cfiq->DevSize, which gets
properly set to 0x1a (64M flash chip).
  - It then sets the local "max_chips" variable by shifting down
map->size by this chipshift, which shifts our size (0x02000000 =3D 32M)
down all the way to 0.
  - Since 'max_chips' is zero, no memory is allocated for this chip,
and the waitqueue is not initialized.  The will cause a kernel panic
later, if you ever try to read from this chip.

The routine completes and you are left with a seemingly valid MTD
device.  However, if you ever try to read or write this device, the
waitqueue is uninitialized, which causes a nasty kernel panic.

My proposed fix is attached (a patch against 2.6.15).  After shifting
the map->size down by cfi.chipshift, I just ensure that max_chips is
at least one.  Does this seem like a reasonable fix?

Note: Please CC my email address in reply, as I am not currently
subscribed to the linux-kernel list.

--
Jim Ramsay
"Me fail English?  That's unpossible!"

------=_Part_7653_9205056.1145465364040
Content-Type: application/octet-stream; name=mtd_wrong_size_bug.patch
Content-Transfer-Encoding: 7bit
X-Attachment-Id: 0.1
Content-Disposition: attachment; filename="mtd_wrong_size_bug.patch"

Index: drivers/mtd/chips/gen_probe.c
===================================================================
RCS file: /cvs/PM35_35_14_01/linux_2_6/drivers/mtd/chips/gen_probe.c,v
retrieving revision 1.1.1.3
diff -u -u -r1.1.1.3 gen_probe.c
--- drivers/mtd/chips/gen_probe.c	10 Jan 2006 00:44:25 -0000	1.1.1.3
+++ drivers/mtd/chips/gen_probe.c	19 Apr 2006 16:32:10 -0000
@@ -100,6 +100,13 @@
 	 * Align bitmap storage size to full byte.
 	 */
 	max_chips = map->size >> cfi.chipshift;
+	// If we shift down to 0, assume there is at least one chip here
+	if( max_chips == 0 )
+	{
+		printk( KERN_WARNING "%s: map->size as specified is less than "
+				     "actual chip size\n", map->name );
+		max_chips = 1;
+	}
 	mapsize = (max_chips / 8) + ((max_chips % 8) ? 1 : 0);
 	chip_map = kmalloc(mapsize, GFP_KERNEL);
 	if (!chip_map) {






------=_Part_7653_9205056.1145465364040--
