Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWFLWQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWFLWQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWFLWQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:16:44 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:63151 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932612AbWFLWQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:16:43 -0400
Date: Mon, 12 Jun 2006 15:16:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Cedric Le Goater <clg@fr.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.16-rc6-mm2
In-Reply-To: <448DA5DD.203@fr.ibm.com>
Message-ID: <Pine.LNX.4.64.0606121511090.21172@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <448DA5DD.203@fr.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Cedric Le Goater wrote:

> Unable to handle kernel NULL pointer dereference at 0000000000000007 RIP:
>  [<ffffffff8025b017>] dec_zone_page_state+0x1/0x5b

Seems that req->wb_page may be NULL.

This patch may fix it but we may miss an unstable page then. We may 
have to move the decrement of NR_UNSTABLE to a different location when
wb_page is still valid.

Index: linux-2.6.17-rc6-cl/fs/nfs/write.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/fs/nfs/write.c	2006-06-12 13:37:47.321243148 -0700
+++ linux-2.6.17-rc6-cl/fs/nfs/write.c	2006-06-12 15:13:48.020908204 -0700
@@ -1419,7 +1419,8 @@ static void nfs_commit_done(struct rpc_t
 		nfs_mark_request_dirty(req);
 	next:
 		nfs_clear_page_writeback(req);
-		dec_zone_page_state(req->wb_page, NR_UNSTABLE);
+		if (req->wb_page)
+			dec_zone_page_state(req->wb_page, NR_UNSTABLE);
 	}
 }
 

