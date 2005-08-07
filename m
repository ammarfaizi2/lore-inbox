Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752731AbVHGUwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbVHGUwz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbVHGUwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 16:52:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12224 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752731AbVHGUwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 16:52:54 -0400
Date: Sun, 7 Aug 2005 13:52:48 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Maurer <martinmaurer@gmx.at>
Cc: zaitcev@redhat.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Elitegroup K7S5A + usb_storage problem
Message-Id: <20050807135248.7a3ab233.zaitcev@redhat.com>
In-Reply-To: <200508071228.17984.martinmaurer@gmx.at>
References: <20050805151820.3f8f9e85.akpm@osdl.org>
	<200508070222.57340.martinmaurer@gmx.at>
	<20050806180608.0ecab568.zaitcev@redhat.com>
	<200508071228.17984.martinmaurer@gmx.at>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when i delete the files which are on the stick and do an umount/mount cycle, 
> the files are there again. 
>[... other mail ...]

> I did the usbmon thing (hopefully correctly). Attached is the output.

Yes, that was perfect, thanks a lot. Unfortunately, I do not see a lot
of interesting things. The last write before the disconnect is a FAT
update:

c31650b8 1617078003 S Bo:006:01 -115 31 = 55534243 c6000000 00020000 00000a2a 00000000 30000001 00000000 000000
c31650b8 1617078987 C Bo:006:01 0 31 >
c31650b8 1617078997 S Bo:006:01 -115 512 = f8ffffff ffffffff ffffffff 00000000 00000000 00000000 00000000 00000000
c31650b8 1617080988 C Bo:006:01 0 512 >
c31650b8 1617080998 S Bi:006:02 -115 13 <
c31650b8 1617084987 C Bi:006:02 0 13 = 55534253 c6000000 00000000 00

Only one cluster was taken, when compared with the FAT that was read.
Everything seems to be in order. But the next trace (after replug -
see the device number changing from 6 to 7) shows FAT with old contents
being read (same block number 0x30):

> cd6960b8 1874976301 S Bo:007:01 -115 31 = 55534243 0b000000 00020000 80000a28 00000000 30000001 00000000 000000
> cd6960b8 1874977274 C Bo:007:01 0 31 >
> cd6960b8 1874977288 S Bi:007:02 -115 512 <
> cd6960b8 1874979271 C Bi:007:02 0 512 = f8ffffff ffffffff ffff0000 00000000 00000000 00000000 00000000 00000000
> cd6960b8 1874979282 S Bi:007:02 -115 13 <
> cd6960b8 1874981271 C Bi:007:02 0 13 = 55534253 0b000000 00000000 00

So, the device replies that writes were successful, but does not
actually commit them to the stable storage.

I suspect that this device may require some delays. I seem to recall
that we added delayes to usb-storage when we worked with Genesys
Logic. But ub contains no delays.

How about this:

--- linux-2.6.13-rc4/drivers/block/ub.c	2005-07-29 19:51:00.000000000 -0700
+++ linux-2.6.13-rc4-lem/drivers/block/ub.c	2005-08-07 13:48:11.000000000 -0700
@@ -1209,6 +1279,8 @@
 			return;
 		}
 
+		udelay(125);	// XXX for Martin Maurer <martinmaurer@gmx.at> 
+
 		UB_INIT_COMPLETION(sc->work_done);
 
 		if (cmd->dir == UB_DIR_READ)

Please try this patchlet and let us know how it went.

-- Pete
