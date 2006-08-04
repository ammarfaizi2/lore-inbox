Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161266AbWHDP5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161266AbWHDP5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWHDP5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:57:22 -0400
Received: from sandeen.net ([209.173.210.139]:52599 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S1161266AbWHDP5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:57:22 -0400
Message-ID: <44D36E60.2020006@sandeen.net>
Date: Fri, 04 Aug 2006 10:57:20 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: bfennema@falcon.csc.calpoly.edu
Subject: [PATCH]: initialize parts of udf inode earlier in create
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw an oops down this path when trying to create a new file on a UDF 
filesystem which was internally marked as readonly, but mounted rw:

udf_create
        udf_new_inode
                new_inode
                        alloc_inode
                        	udf_alloc_inode
                udf_new_block
                        returns EIO due to readonlyness
                iput (on error)
                        udf_put_inode
                                udf_discard_prealloc
                                        udf_next_aext
                                                udf_current_aext
                                                        udf_get_fileshortad
                                                                OOPS

the udf_discard_prealloc() path was examining uninitialized fields of the 
udf inode.

udf_discard_prealloc() already has this code to short-circuit the discard 
path if no extents are preallocated:

        if (UDF_I_ALLOCTYPE(inode) == ICBTAG_FLAG_AD_IN_ICB ||
                inode->i_size == UDF_I_LENEXTENTS(inode))
        {
                return;
        }

so if we initialize UDF_I_LENEXTENTS(inode) = 0 earlier in udf_new_inode, we
won't try to free the (not) preallocated blocks, since this will match
the i_size = 0 set when the inode was initialized.

Thanks,

-Eric

Signed-off-by: Eric Sandeen <sandeen@sandeen.net>

Index: linux-2.6.17/fs/udf/ialloc.c
===================================================================
--- linux-2.6.17.orig/fs/udf/ialloc.c
+++ linux-2.6.17/fs/udf/ialloc.c
@@ -75,6 +75,12 @@ struct inode * udf_new_inode (struct ino
 	}
 	*err = -ENOSPC;
 
+	UDF_I_UNIQUE(inode) = 0;
+	UDF_I_LENEXTENTS(inode) = 0;
+	UDF_I_NEXT_ALLOC_BLOCK(inode) = 0;
+	UDF_I_NEXT_ALLOC_GOAL(inode) = 0;
+	UDF_I_STRAT4096(inode) = 0;
+
 	block = udf_new_block(dir->i_sb, NULL, UDF_I_LOCATION(dir).partitionReferenceNum,
 		start, err);
 	if (*err)
@@ -84,11 +90,6 @@ struct inode * udf_new_inode (struct ino
 	}
 
 	mutex_lock(&sbi->s_alloc_mutex);
-	UDF_I_UNIQUE(inode) = 0;
-	UDF_I_LENEXTENTS(inode) = 0;
-	UDF_I_NEXT_ALLOC_BLOCK(inode) = 0;
-	UDF_I_NEXT_ALLOC_GOAL(inode) = 0;
-	UDF_I_STRAT4096(inode) = 0;
 	if (UDF_SB_LVIDBH(sb))
 	{
 		struct logicalVolHeaderDesc *lvhd;
 

