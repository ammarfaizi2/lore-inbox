Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318886AbSH1Pmd>; Wed, 28 Aug 2002 11:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318884AbSH1PmW>; Wed, 28 Aug 2002 11:42:22 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:4227 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318886AbSH1PlK>; Wed, 28 Aug 2002 11:41:10 -0400
Date: Wed, 28 Aug 2002 16:45:20 +0100
Message-Id: <200208281545.g7SFjKd14350@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 8/8] 2.4.20-pre4/ext3: Fix truncate restart error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for a rare problem seen under stress in data=journal mode: if we
have to restart a truncate transaction while traversing the inode's
direct blocks, we need to deal with bh==NULL in ext3_clear_blocks.

--- linux-ext3-2.4merge/fs/ext3/inode.c.=K0009=.orig	Tue Aug 27 23:19:57 2002
+++ linux-ext3-2.4merge/fs/ext3/inode.c	Tue Aug 27 23:19:57 2002
@@ -1591,8 +1591,10 @@
 		}
 		ext3_mark_inode_dirty(handle, inode);
 		ext3_journal_test_restart(handle, inode);
-		BUFFER_TRACE(bh, "get_write_access");
-		ext3_journal_get_write_access(handle, bh);
+		if (bh) {
+			BUFFER_TRACE(bh, "retaking write access");
+			ext3_journal_get_write_access(handle, bh);
+		}
 	}
 
 	/*
