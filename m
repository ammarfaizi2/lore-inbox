Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265225AbUD3TFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUD3TFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUD3TFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:05:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:55190 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265225AbUD3TEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:04:48 -0400
Subject: Re: [CHECKER] A derefence of null pointer errorin JFS (jfs2.4,
	kernel 2.4.19)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       mc@cs.Stanford.EDU, Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
In-Reply-To: <Pine.GSO.4.44.0404262355040.7369-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0404262355040.7369-100000@elaine24.Stanford.EDU>
Content-Type: text/plain
Message-Id: <1083351872.14136.38.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Apr 2004 14:04:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 01:56, Junfeng Yang wrote:
> file fs/jfs/jfs_dtree.c
> -----------------------------------------------------------
> [BUG] get_metapage can return null when grab_cache_page or read_cache_page
> fails in function __get_metapage.

Thanks.  This patch should fix it.  I'll submit the fix to Linus &
Marcelo.

Shaggy

===== fs/jfs/jfs_dtree.c 1.27 vs edited =====
--- 1.27/fs/jfs/jfs_dtree.c	Wed Mar 24 14:11:46 2004
+++ edited/fs/jfs/jfs_dtree.c	Fri Apr 30 13:47:31 2004
@@ -982,7 +982,9 @@
 		split->pxdlist = &pxdlist;
 		rc = dtSplitRoot(tid, ip, split, &rmp);
 
-		DT_PUTPAGE(rmp);
+		if (!rc)
+			DT_PUTPAGE(rmp);
+
 		DT_PUTPAGE(smp);
 
 		goto freeKeyName;
@@ -1876,6 +1878,9 @@
 	xlen = lengthPXD(pxd);
 	xsize = xlen << JFS_SBI(sb)->l2bsize;
 	rmp = get_metapage(ip, rbn, xsize, 1);
+	if (!rmp)
+		return -EIO;
+
 	rp = rmp->data;
 
 	BT_MARK_DIRTY(rmp, ip);

-- 
David Kleikamp
IBM Linux Technology Center

