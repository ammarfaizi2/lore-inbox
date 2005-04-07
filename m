Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVDGQSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVDGQSH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVDGQSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:18:06 -0400
Received: from pat.uio.no ([129.240.130.16]:52456 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262506AbVDGQSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:18:01 -0400
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make
	sense
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050407153848.GN347@unthought.net>
References: <20050406160123.GH347@unthought.net>
	 <20050406231906.GA4473@sgi.com>  <20050407153848.GN347@unthought.net>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 12:17:51 -0400
Message-Id: <1112890671.10366.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.842, required 12,
	autolearn=disabled, AWL 1.16, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 07.04.2005 Klokka 17:38 (+0200) skreiv Jakob Oestergaard:

> I tweaked the VM a bit, put the following in /etc/sysctl.conf:
>  vm.dirty_writeback_centisecs=100
>  vm.dirty_expire_centisecs=200
> 
> The defaults are 500 and 3000 respectively...
> 
> This improved things a lot; the client is now "almost not very laggy",
> and load stays in the saner 1-2 range.

OK. That hints at what is causing the latencies on the server: I'll bet
it is the fact that the page reclaim code tries to be clever, and uses
NFSv3 STABLE writes in order to be able to free up the dirty pages
immediately. Could you try the following patch, and see if that makes a
difference too?

Cheers,
  Trond
----
 fs/nfs/write.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc2/fs/nfs/write.c
===================================================================
--- linux-2.6.12-rc2.orig/fs/nfs/write.c
+++ linux-2.6.12-rc2/fs/nfs/write.c
@@ -305,7 +305,7 @@ do_it:
 		if (err >= 0) {
 			err = 0;
 			if (wbc->for_reclaim)
-				nfs_flush_inode(inode, 0, 0, FLUSH_STABLE);
+				nfs_flush_inode(inode, 0, 0, 0);
 		}
 	} else {
 		err = nfs_writepage_sync(ctx, inode, page, 0,


-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

