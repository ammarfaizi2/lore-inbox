Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263084AbTCYR2b>; Tue, 25 Mar 2003 12:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263125AbTCYR2b>; Tue, 25 Mar 2003 12:28:31 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62587 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263084AbTCYR2a>; Tue, 25 Mar 2003 12:28:30 -0500
Date: Tue, 25 Mar 2003 17:39:35 GMT
Message-Id: <200303251739.h2PHdZi4006887@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 1/8] 2.4: Fix ext3 panic due to ll_rw_block behaviour after illegal block access.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is really rude to clear all the buffer state bits on an access
beyond end-of-device.  It can panic filesystems which have internal
state bits, for example.  Just clear the dirty flag instead, and leave
the others intact.

--- linux-2.4-ext3push/drivers/block/ll_rw_blk.c.=K0000=.orig	2003-03-25 10:59:15.000000000 +0000
+++ linux-2.4-ext3push/drivers/block/ll_rw_blk.c	2003-03-25 10:59:15.000000000 +0000
@@ -1129,7 +1129,7 @@ void generic_make_request (int rw, struc
 
 		if (maxsector < count || maxsector - count < sector) {
 			/* Yecch */
-			bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);
+			bh->b_state &= ~(1 << BH_Dirty);
 
 			/* This may well happen - the kernel calls bread()
 			   without checking the size of the device, e.g.,
@@ -1140,7 +1140,6 @@ void generic_make_request (int rw, struc
 			       kdevname(bh->b_rdev), rw,
 			       (sector + count)>>1, minorsize);
 
-			/* Yecch again */
 			bh->b_end_io(bh, 0);
 			return;
 		}
