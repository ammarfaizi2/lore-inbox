Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277559AbRJVFFn>; Mon, 22 Oct 2001 01:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277560AbRJVFFe>; Mon, 22 Oct 2001 01:05:34 -0400
Received: from andromeda.dsdk12.net ([207.109.100.251]:28053 "HELO dsdk12.net")
	by vger.kernel.org with SMTP id <S277559AbRJVFFZ>;
	Mon, 22 Oct 2001 01:05:25 -0400
Date: Sun, 21 Oct 2001 23:05:56 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: <linux-kernel@vger.kernel.org>
Subject: "Device busy for revalidation" with usb-storage
Message-ID: <Pine.LNX.4.33.0110212256010.26280-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently acquired a SanDisk CompactFlash card reader, and was trying
it with Linux (2.4.12, on an Apple iBook). The unit works well, but I
discovered that when different-sized cards are used, the SCSI disk driver
reports "Device busy for revalidation (usage=1)" when I try to access it
(causing out-of-bounds errors, since the SCSI disk driver still thinks
it's dealing with the old geometry). After a look in drivers/scsi/sd.c, I
found the fop_revalidate_scsidisk() routine, which calls
revalidate_scsidisk() with 0 as the second parameter (maxusage, apparently
the usage-count limit beyond which it should not try to revalidate).
Shouldn't this be a 1, instead of a 0, since when the mount takes place,
something will have the device open (the kernel, of course), so it will
never have a 0 usage count when fop_revalidate_scsidisk() gets called?

Changing the 0 to a 1, rebuilding the sd_mod driver and loading the
modified version, then swapping the CF cards and mounting them, I found
that my change did cause them to be revalidated properly, correcting the
geometry that the SCSI disk driver had.

(Please CC: me with replies, I am not subscribed to the list.)

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN

