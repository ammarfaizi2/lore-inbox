Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270797AbTHFT0D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270862AbTHFT0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:26:03 -0400
Received: from 69-55-72-141.ppp.netsville.net ([69.55.72.141]:63156 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S270797AbTHFT0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:26:00 -0400
Subject: [PATCH] [2.4] beyond_eof check in generic_direct_IO
From: Chris Mason <mason@suse.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1060197938.5877.442.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 06 Aug 2003 15:25:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

reiserfs has to do a few odd tail conversion steps during direct io. 
Picture a file whose size is currently 3500 bytes, and a direct io write
extending it to 4096 bytes.

reiserfs will have those 3500 bytes packed into a tail, and when it gets
a get_block call with create == 1, it will convert the tail into a full
block and return the newly created block.

The new generic_direct_IO code doesn't send create == 1 to get_block
unless the new block is entirely past eof.  I think it should instead
allow any part of the block to be past eof, which allows reiserfs to
properly convert the tail:

-chris

--- 1.89/fs/buffer.c	Tue Jun 24 17:11:29 2003
+++ edited/fs/buffer.c	Fri Jul 18 13:24:57 2003
@@ -2147,7 +2148,7 @@
 		bh.b_size = blocksize;
 		bh.b_page = NULL;
 
-		if (((loff_t) blocknr) * blocksize >= inode->i_size)
+		if (((loff_t) (blocknr + 1)) * blocksize > inode->i_size)
 			beyond_eof = 1;
 
 		/* Only allow get_block to create new blocks if we are safely



