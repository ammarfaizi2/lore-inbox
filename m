Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSHBOg3>; Fri, 2 Aug 2002 10:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSHBOg3>; Fri, 2 Aug 2002 10:36:29 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:22010 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314149AbSHBOg2>; Fri, 2 Aug 2002 10:36:28 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3D4A27FE.8030801@snapgear.com> 
References: <3D4A27FE.8030801@snapgear.com> 
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.30uc0 MMU-less patches 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Aug 2002 15:39:56 +0100
Message-ID: <3007.1028299196@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gerg@snapgear.com said:
>  I have coded a generic MTD map driver to replace the old crufty
> blkmem driver. The blkmem driver will be going away in future patches.

--- linux-2.5.30/drivers/mtd/maps/snapgear-uc.c	Thu Jan  1 10:00:00 1970
+++ linux-2.5.30uc0/drivers/mtd/maps/snapgear-uc.c	Mon Jul 15 21:29:25 2002
+#ifdef CONFIG_NFTL
+#include <linux/mtd/nftl.h>
+#endif

You shouldn't need that.


+int flash_eraseconfig(void)
+{

This will cause an oops if it gets woken by a signal -- you leave and the 
the 'struct erase_info' on your stack frame, which you passed to the 
asynchronous erase call, goes bye bye.

+		ROOT_DEV = MKDEV(NFTL_MAJOR, 1);

Oh, I see -- if we fail to find a file system we recognise on the NOR 
flash, try booting from DiskOnChip. Does this really live here?

--- linux-2.5.30/drivers/mtd/mtdblock.c	Fri Aug  2 15:15:41 2002
+++ linux-2.5.30uc0/drivers/mtd/mtdblock.c	Fri Aug  2 16:00:13 2002
-		if (req->flags & REQ_CMD)
+		if (! (req->flags & REQ_CMD))

Yes.

+#ifdef MAGIC_ROM_PTR
+static int
+mtdblock_romptr(kdev_t dev, struct vm_area_struct * vma)

No, although the fix I'm happy with is going to take a while to get 
implemented so maybe in the short term. This is likely to get rejected on 
other grounds anyway; perhaps separate it and don't submit it for inclusion 
just now?



--
dwmw2


