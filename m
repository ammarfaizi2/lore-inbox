Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289216AbSA3O44>; Wed, 30 Jan 2002 09:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289219AbSA3O4q>; Wed, 30 Jan 2002 09:56:46 -0500
Received: from castor.unesco.org.uy ([200.40.145.98]:28434 "EHLO
	castor.unesco.org.uy") by vger.kernel.org with ESMTP
	id <S289216AbSA3O4k>; Wed, 30 Jan 2002 09:56:40 -0500
Message-ID: <3C580AF6.90EF7086@unesco.org.uy>
Date: Wed, 30 Jan 2002 12:02:14 -0300
From: Eduardo =?iso-8859-1?Q?Tr=E1pani?= <etrapani@unesco.org.uy>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: eo, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] clipped disk reports clipped lba size
Content-Type: multipart/mixed;
 boundary="------------DEEA1C116B92289EF977140A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DEEA1C116B92289EF977140A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Since my BIOS does not support my disk (WD400) I had to clip to 33.8G.  At boot time Linux (2.4.17) uses the lba size reported by the disk, that is 33.8 and does not allow me to access the rest of the disk.

The problem is that even though the whole disk can be used after clipping, Linux uses only the reported lba size even if I force the geometry.

Here is a patch to solve that.  I am sure there is a more elegant solution, I guess we could add a "lba_size=" or something like that as a boot parameter.

The patch against 2.4.17 does this:  if the geometry has been forced then use it to calculate the lba size and ignore the (possibly clipped) answer from the disk.

Eduardo.
--------------DEEA1C116B92289EF977140A
Content-Type: text/plain; charset=us-ascii;
 name="patch-clipped-ide.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-clipped-ide.txt"

--- drivers/ide/ide-disk.c.orig	Wed Jan 30 11:26:51 2002
+++ drivers/ide/ide-disk.c	Wed Jan 30 11:30:26 2002
@@ -511,6 +511,12 @@
 
 	drive->select.b.lba = 0;
 
+	/* If the geometry has been forced recalculate lba_capacity */
+	if ((id->capability & 2) && lba_capacity_is_ok(id) &&
+	 drive->forced_geom)
+	{
+		id->lba_capacity = drive->bios_head * drive->bios_sect * drive->bios_cyl;
+	}
 	/* Determine capacity, and use LBA if the drive properly supports it */
 	if ((id->capability & 2) && lba_capacity_is_ok(id)) {
 		capacity = id->lba_capacity;

--------------DEEA1C116B92289EF977140A--

