Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423369AbWBBIBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423369AbWBBIBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423366AbWBBIBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:01:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:50148 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1423367AbWBBIBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:01:01 -0500
Date: Thu, 2 Feb 2006 00:00:46 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jes Sorensen <jes@sgi.com>, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: [patch] Fix DMA timeouts with sgiioc4
Message-ID: <20060202080046.GB157213@sgi.com>
References: <yq0vevzpi8r.fsf@jaguar.mkp.net> <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com> <20060201104913.GA152005@sgi.com> <58cb370e0602010308o4cde24aeg8d629b1b3d45cdd3@mail.gmail.com> <20060201111754.GB152005@sgi.com> <58cb370e0602010326k265ef278k4010df13fb5adf8c@mail.gmail.com> <20060201113607.GF152005@sgi.com> <58cb370e0602010444m46a39705q4a3043778df1628d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0602010444m46a39705q4a3043778df1628d@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 01:44:01PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 2/1/06, Jeremy Higdon <jeremy@sgi.com> wrote:
> >
> > Here's one that removes xcount.  It seems to work too.
> > Should we set hwif->rqsize to 256, or are we pretty safe in
> > expecting that the default won't rise?  The driver should be
> > able to handle more, but this ioc4 hardware is weird, and it
> > probably wouldn't get tested if a general change were made :-)
> 
> The current maximum request size is:
> *  256 for LBA28 and ATAPI devices
> * 1024 for LBA48 devices
> 
> The maximum request size allowed by IDE driver for
> LBA48 devices will change to 65536 but block layer will
> continue to use 1024 as a default maximum request size,
> also IIRC sgiioc4 IDE is used only for ATAPI devices.
> So I think that there is no need to worry about ->rqsize.


Thanks Bartlomiej.  You're correct in that it is ATAPI only (and
read-only also).

In this case, this is the final patch (last night's with a copyright
update and removing spurious whitespace at end of line).

thanks

jeremy

Signed-off-by: Jeremy Higdon <jeremy@sgi.com>

Fix sgiioc4 DMA timeout problem with 64KiB s/g elements.

--- a/linux/drivers/ide/pci/sgiioc4.c	2006-02-01 23:57:08.000000000 -0800
+++ b/linux/drivers/ide/pci/sgiioc4.c	2006-02-01 23:56:47.169588392 -0800
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2003-2006 Silicon Graphics, Inc.  All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -510,7 +510,7 @@
 				       drive->name);
 				goto use_pio_instead;
 			} else {
-				u32 xcount, bcount =
+				u32 bcount =
 				    0x10000 - (cur_addr & 0xffff);
 
 				if (bcount > cur_len)
@@ -525,8 +525,7 @@
 				*table = 0x0;
 				table++;
 
-				xcount = bcount & 0xffff;
-				*table = cpu_to_be32(xcount);
+				*table = cpu_to_be32(bcount);
 				table++;
 
 				cur_addr += bcount;
@@ -680,7 +679,7 @@
 		return -EIO;
 
 	/* Create /proc/ide entries */
-	create_proc_ide_interfaces(); 
+	create_proc_ide_interfaces();
 
 	return 0;
 }
