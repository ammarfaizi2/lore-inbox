Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWFMRy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWFMRy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWFMRy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:54:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63185 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750824AbWFMRy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:54:28 -0400
Date: Tue, 13 Jun 2006 10:54:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Cedric Le Goater <clg@fr.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.16-rc6-mm2
In-Reply-To: <448E6798.3020104@fr.ibm.com>
Message-ID: <Pine.LNX.4.64.0606131049270.29947@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <448DA5DD.203@fr.ibm.com>
 <Pine.LNX.4.64.0606121511090.21172@schroedinger.engr.sgi.com>
 <448E6798.3020104@fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, Cedric Le Goater wrote:

> thanks for the patch ! I gave it a try but req->wb_page seems bogus ?

It seems that req->wb_page is bogus after nfs_clear_page_writeback()
has run. So we need to do the statistics before.

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
 

