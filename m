Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTI1Lvy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 07:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbTI1Lvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 07:51:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:23231 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262522AbTI1Lvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 07:51:53 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 28 Sep 2003 13:51:46 +0200 (MEST)
Message-Id: <UTC200309281151.h8SBpkH15931.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] small dev_t fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See that we finally got a larger dev_t. Very good!
Will check over time what form my patches got in the current tree.
The first one I checked was broken a little. Below a fix.

[ext2 used a 32-bit field for dev_t, with possibly undefined
storage following; thus, no action was required to go to
32-bit dev_t, but going to 64-bit dev_t required some subtlety:
0 was written in the first word and the 64 bits in the following two.
Al truncated my 64-bit stuff to 32 bits but did not understand why
there was this split, and wrote 0 followed by a single word.
We should at least zero the word following to have well-defined
storage later.]

Andries

This is for fs/ext2/inode.c.

--- inode.c~	Sun Sep 28 12:42:15 2003
+++ inode.c	Sun Sep 28 13:25:03 2003
@@ -1228,6 +1228,7 @@
 			raw_inode->i_block[0] = 0;
 			raw_inode->i_block[1] =
 				cpu_to_le32(new_encode_dev(inode->i_rdev));
+			raw_inode->i_block[2] = 0;
 		}
 	} else for (n = 0; n < EXT2_N_BLOCKS; n++)
 		raw_inode->i_block[n] = ei->i_data[n];
