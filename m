Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266280AbUFPM4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266280AbUFPM4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUFPM4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:56:49 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:25768 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266280AbUFPMzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:55:47 -0400
Subject: Re: JFS compilation fix [was Re: Linux 2.6.7]
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040616080740.GC23998@louise.pinerecords.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
	 <20040616080740.GC23998@louise.pinerecords.com>
Content-Type: text/plain
Message-Id: <1087390524.29047.10.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 16 Jun 2004 07:55:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 03:07, Tomas Szepe wrote:
> Here's a trivial patch to fix JFS compilation in 2.6.7.  The error
> only happens in specific configs -- one such config can be found here:
> http://www.pinerecords.com/kala/_nonpub/.config.louise26

I don't know why gcc-3.2.2 doesn't complain about this one, as I have
compiled this numerous times.

Your patch has an unnecessary include of jfs_dtree.h.  jfs_dtree.h is
included by jfs_inline.h, and is not needed in jfs_dtree.c.

> I don't have the time to narrow the problem down to the config
> entry that gets jfs_dtree.c to include jfs_dtree.h (jfs_dtree.c
> itself doesn't have any relevat ifdefs).

My guess is the config entry is CONFIG_JFS_FS. :^)

Here's the patch without the unneeded include:
----------------------------------------------
JFS: move declaration of temp_table to beginning of block

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff -urp linux-2.6.7/fs/jfs/jfs_dtree.c linux/fs/jfs/jfs_dtree.c
--- linux-2.6.7/fs/jfs/jfs_dtree.c	2004-06-16 07:38:20.244688936 -0500
+++ linux/fs/jfs/jfs_dtree.c	2004-06-16 07:46:38.210986552 -0500
@@ -374,6 +374,8 @@ static u32 add_index(tid_t tid, struct i
 		return index;
 	}
 	if (index == (MAX_INLINE_DIRTABLE_ENTRY + 1)) {
+		struct dir_table_slot temp_table[12];
+
 		/*
 		 * It's time to move the inline table to an external
 		 * page and begin to build the xtree
@@ -385,7 +387,6 @@ static u32 add_index(tid_t tid, struct i
 		 * Save the table, we're going to overwrite it with the
 		 * xtree root
 		 */
-		struct dir_table_slot temp_table[12];
 		memcpy(temp_table, &jfs_ip->i_dirtable, sizeof(temp_table));
 
 		/*

-- 
David Kleikamp
IBM Linux Technology Center

