Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbUDSNnm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbUDSNnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:43:33 -0400
Received: from ns.suse.de ([195.135.220.2]:48348 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264456AbUDSNlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:41:55 -0400
Subject: Re: [PATCH 1/3] lockfs - vfs bits
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20040417163007.67d23c10.akpm@osdl.org>
References: <20040417220632.GA2573@lst.de>
	 <20040417163007.67d23c10.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1082382187.27614.1491.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 09:43:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 19:30, Andrew Morton wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> >
> >  These are the generic lockfs bits.  Basically it takes the XFS freezing
> >  statemachine into the VFS.  It's all behind the kernel-doc documented
> >  freeze_bdev and thaw_bdev interfaces.
> 
> Do we expect to see snapshotting patches for other filesystems arise as a
> result of this?

Reiserfs needs this one liner:

reiserfs_write_super_lockfs() is supposed to wait for the transaction
to commit.

Index: linux.t/fs/reiserfs/super.c
===================================================================
--- linux.t.orig/fs/reiserfs/super.c	2004-04-01 08:54:54.000000000 -0500
+++ linux.t/fs/reiserfs/super.c	2004-04-01 09:08:45.000000000 -0500
@@ -88,7 +88,7 @@ static void reiserfs_write_super_lockfs 
     reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1);
     journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
     reiserfs_block_writes(&th) ;
-    journal_end(&th, s, 1) ;
+    journal_end_sync(&th, s, 1) ;
   }
   s->s_dirt = 0;
   reiserfs_write_unlock(s);


