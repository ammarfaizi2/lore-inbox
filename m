Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUD2EWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUD2EWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUD2EWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:22:00 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:21657 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263295AbUD2EV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:21:57 -0400
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: busterbcook@yahoo.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0404282254290.13673@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
	 <20040427230203.1e4693ac.akpm@osdl.org>
	 <Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
	 <20040428124809.418e005d.akpm@osdl.org>
	 <Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
	 <1083187174.2856.162.camel@lade.trondhjem.org>
	 <Pine.LNX.4.58.0404282254290.13673@ozma.hauschen>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083212515.2856.247.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 00:21:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 23:55, Brent Cook wrote:

> ozma:/home /home nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=ozma 0 0

OK, then it's not the case that it is doing synchronous I/O.

I see that we're failing to set wbc->encountered_congestion in the case
where a nonblocking writeback is forced to exit due to congestion. Could
that be causing pdflush to loop Andrew?

If so, does the following patch help?

--- linux-2.6.6-rc3/fs/nfs/write.c.orig	2004-04-28 22:25:46.000000000 -0400
+++ linux-2.6.6-rc3/fs/nfs/write.c	2004-04-29 00:06:25.000000000 -0400
@@ -347,8 +347,10 @@ int nfs_writepages(struct address_space 
 	if (err)
 		return err;
 	while (test_and_set_bit(BDI_write_congested, &bdi->state) != 0) {
-		if (wbc->nonblocking)
+		if (wbc->nonblocking) {
+			wbc->encountered_congestion = 1;
 			return 0;
+		}
 		nfs_wait_on_write_congestion(mapping, 0);
 	}
 	err = nfs_flush_inode(inode, 0, 0, wb_priority(wbc));

