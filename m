Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318887AbSH1PmO>; Wed, 28 Aug 2002 11:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318888AbSH1PlN>; Wed, 28 Aug 2002 11:41:13 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:3459 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318881AbSH1PlG>; Wed, 28 Aug 2002 11:41:06 -0400
Date: Wed, 28 Aug 2002 16:45:19 +0100
Message-Id: <200208281545.g7SFjJO14326@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 2/8] 2.4.20-pre4/ext3: Fix out-of-inodes handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't consider ENOSPC as a fatal error when allocating an inode.  Otherwise
running out of inodes marks the fs as having an error, potentially taking
the kernel down if we are in panic-on-error fs mode.

--- linux-ext3-2.4merge/fs/ext3/ialloc.c.=K0003=.orig	Tue Aug 27 23:17:07 2002
+++ linux-ext3-2.4merge/fs/ext3/ialloc.c	Tue Aug 27 23:19:57 2002
@@ -392,7 +392,7 @@
 
 	err = -ENOSPC;
 	if (!gdp)
-		goto fail;
+		goto out;
 
 	err = -EIO;
 	bitmap_nr = load_inode_bitmap (sb, i);
@@ -523,9 +523,10 @@
 	return inode;
 
 fail:
+	ext3_std_error(sb, err);
+out:
 	unlock_super(sb);
 	iput(inode);
-	ext3_std_error(sb, err);
 	return ERR_PTR(err);
 }
 
