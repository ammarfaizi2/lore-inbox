Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWFMVNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWFMVNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWFMVNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:13:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2195 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932270AbWFMVNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:13:48 -0400
Date: Tue, 13 Jun 2006 14:13:36 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Cedric Le Goater <clg@fr.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.16-rc6-mm2
In-Reply-To: <448F1E8A.3030202@fr.ibm.com>
Message-ID: <Pine.LNX.4.64.0606131412290.31769@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <448DA5DD.203@fr.ibm.com>
 <Pine.LNX.4.64.0606121511090.21172@schroedinger.engr.sgi.com>
 <448E6798.3020104@fr.ibm.com> <Pine.LNX.4.64.0606131049270.29947@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606131234010.31186@schroedinger.engr.sgi.com>
 <448F1E8A.3030202@fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, Cedric Le Goater wrote:

> NFS write seems to work fine with that patch. No more oops.

Sigh. There is another issue that the NR_DIRTY count is not decremented. 

Which brings us to this fix:

Index: linux-2.6.17-rc6-mm2/fs/nfs/write.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/nfs/write.c	2006-06-10 11:11:53.051397816 -0700
+++ linux-2.6.17-rc6-mm2/fs/nfs/write.c	2006-06-13 10:52:04.428456013 -0700
@@ -1418,8 +1418,9 @@ static void nfs_commit_done(struct rpc_t
 		dprintk(" mismatch\n");
 		nfs_mark_request_dirty(req);
 	next:
+		if (req->wb_page)
+			dec_zone_page_state(req->wb_page, NR_UNSTABLE);
 		nfs_clear_page_writeback(req);
-		dec_zone_page_state(req->wb_page, NR_UNSTABLE);
 	}
 }
 
Index: linux-2.6.17-rc6-mm2/fs/nfs/pagelist.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/nfs/pagelist.c	2006-06-10 11:11:53.049444812 -0700
+++ linux-2.6.17-rc6-mm2/fs/nfs/pagelist.c	2006-06-13 14:12:17.963198388 -0700
@@ -154,6 +154,7 @@ void nfs_clear_request(struct nfs_page *
 {
 	struct page *page = req->wb_page;
 	if (page != NULL) {
+		dec_zone_page_state(page, NR_UNSTABLE);
 		page_cache_release(page);
 		req->wb_page = NULL;
 	}
@@ -315,7 +316,7 @@ nfs_scan_lock_dirty(struct nfs_inode *nf
 						req->wb_index, NFS_PAGE_TAG_DIRTY);
 				nfs_list_remove_request(req);
 				nfs_list_add_request(req, dst);
-				inc_zone_page_state(req->wb_page, NR_DIRTY);
+				dec_zone_page_state(req->wb_page, NR_DIRTY);
 				res++;
 			}
 		}
