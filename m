Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264235AbUD1B3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbUD1B3B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUD1B3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:29:01 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:34708 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264235AbUD1B26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:28:58 -0400
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
	writeback
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040427180253.5a043319.akpm@osdl.org>
References: <1083080207.2616.31.camel@lade.trondhjem.org>
	 <20040428004707.89142.qmail@web12824.mail.yahoo.com>
	 <20040427180253.5a043319.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083115735.5928.119.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 21:28:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 21:02, Andrew Morton wrote:
> Shantanu Goel <sgoel01@yahoo.com> wrote:
> >
> > Andrew/Trond,
> > 
> > Any consensus as to what the right approach is here?
> 
> For now I suggest you do
> 
> -	err = WRITEPAGE_ACTIVATE;
> +	err = 0;
> 
> in nfs_writepage().

That will just cause the page to be put back onto the inactive list
without starting writeback. Won't that cause precisely those kswapd
loops that Shantanu was worried about?
AFAICS if you want to do this, you probably need to flush the page
immediately to disk on the server using a STABLE write as per the
appeanded patch. The problem is that screws the server over pretty hard
as it will get flooded with what are in effect a load of 4k O_SYNC
writes.

Cheers,
  Trond


--- linux-2.6.6-rc2/fs/nfs/write.c.orig	2004-04-27 16:01:01.000000000 -0400
+++ linux-2.6.6-rc2/fs/nfs/write.c	2004-04-27 21:18:58.000000000 -0400
@@ -313,7 +313,7 @@
 		if (err >= 0) {
 			err = 0;
 			if (wbc->for_reclaim)
-				err = WRITEPAGE_ACTIVATE;
+				nfs_flush_inode(inode, 0, 0, FLUSH_STABLE);
 		}
 	} else {
 		err = nfs_writepage_sync(NULL, inode, page, 0,

