Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWAEBBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWAEBBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWAEBAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:00:48 -0500
Received: from linuxhacker.ru ([217.76.32.60]:17542 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S1750992AbWAEBAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:00:12 -0500
Date: Thu, 5 Jan 2006 03:00:47 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no,
       viro@zeniv.linux.org.uk
Subject: d_instantiate_unique / NFS inode leakage?
Message-ID: <20060105010047.GJ5743@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Searching for inode leakage in NFS code (seen in 2.6.14 and 2.6.15 at least,
   have not tried earlier versions), I see suspicious place in
   d_instantiate_unique (the only user happens to be NFS).
   There if we have found aliased dentry that we return, inode reference is
   not dropped and inode is not attached anywhere, so it seems the reference
   to inode is leaked in that case.
   This simple patch below fixes the problem. Unfortunatelly the leakage seems
   to be non-100% in my testing, so I will continue the testing to see
   if I still see inodes to leak or not (no leak seen so far with the patch).

--- fs/dcache.c.orig	2006-01-05 02:28:57.000000000 +0200
+++ fs/dcache.c	2006-01-05 02:32:08.000000000 +0200
@@ -838,6 +838,7 @@ struct dentry *d_instantiate_unique(stru
 		dget_locked(alias);
 		spin_unlock(&dcache_lock);
 		BUG_ON(!d_unhashed(alias));
+		iput(inode);
 		return alias;
 	}
 	list_add(&entry->d_alias, &inode->i_dentry);

Bye,
    Oleg
