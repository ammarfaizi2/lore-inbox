Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUEORhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUEORhX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 13:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUEORhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 13:37:23 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:2437 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S262606AbUEORhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 13:37:20 -0400
Subject: Re: NFS & long symlinks = stack overflow
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20040515145306.GQ17014@parcelfarce.linux.theplanet.co.uk>
References: <1W7yE-3lZ-13@gated-at.bofh.it> <1W7S5-3Am-13@gated-at.bofh.it>
	 <E1BP0BI-0000lo-09@localhost>
	 <20040515145306.GQ17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1084642637.3490.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 15 May 2004 13:37:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-15 at 10:53, viro@parcelfarce.linux.theplanet.co.uk
wrote:

> Lovely...  How are other clients dealing with that?  Put a reasonable
> limit on the size and return an error if READLINK brings more than that?

Yes. The following patch (backported from the NFSv4 code) should do the
right thing...

Cheers,
  Trond

--- linux-2.6.6-rc3/fs/nfs/nfs3xdr.c.orig	2004-05-09 01:31:17.000000000 -0400
+++ linux-2.6.6-rc3/fs/nfs/nfs3xdr.c	2004-05-15 13:35:06.000000000 -0400
@@ -742,8 +742,11 @@ nfs3_xdr_readlinkres(struct rpc_rqst *re
 	strlen = (u32*)kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
-	if (len > rcvbuf->page_len)
-		len = rcvbuf->page_len;
+	if (len > PAGE_CACHE_SIZE - 5) {
+		printk(KERN_WARNING "nfs: server returned giant symlink!\n");
+		kunmap_atomic(strlen, KM_USER0);
+		return -EIO;
+	}
 	*strlen = len;
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);

