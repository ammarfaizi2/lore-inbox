Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUKPOII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUKPOII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbUKPOIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:08:07 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:54729 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261974AbUKPOHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:07:16 -0500
Date: Tue, 16 Nov 2004 19:33:47 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch 2/4] Cleanup file_count usage: Error/debug messages on f_count reads
Message-ID: <20041116140347.GC23257@impedimenta.in.ibm.com>
References: <20041116135200.GA23257@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116135200.GA23257@impedimenta.in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viro doesn't like reads to f_count. This patch cleans up (removes) some
error messages and warnings based on f_count checks. 

We also don't want to have atomic_reads to refcount lying around, since for
converting the f_count refcounter to struct kref and lockfree kref extensions,
krefs might not support read routines to struct kref.

Notes: 
1. Not sure if the debug message in __aio_put_req is _really_ useful. This 
patch removes this debug message for aio.
2. The file_count check to check if the file is already closed in filp_close 
also doesn't seem to be useful, as an fput should have a corresponding fget,
and a close on a closed file will return -EBADF from sys_close itself,
without having to call filp_close
3. Not sure if the debug messages in atm scheduler are _really_ useful either.

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>
---

 fs/aio.c            |    2 --
 fs/open.c           |    5 -----
 net/sched/sch_atm.c |    3 ---
 3 files changed, 10 deletions(-)

diff -ruN -X dontdiff2 linux-2.6.9/fs/aio.c f_count-2.6.9/fs/aio.c
--- linux-2.6.9/fs/aio.c	2004-10-19 03:24:07.000000000 +0530
+++ f_count-2.6.9/fs/aio.c	2004-11-15 14:07:29.000000000 +0530
@@ -493,8 +493,6 @@
  */
 static int __aio_put_req(struct kioctx *ctx, struct kiocb *req)
 {
-	dprintk(KERN_DEBUG "aio_put(%p): f_count=%d\n",
-		req, atomic_read(&req->ki_filp->f_count));
 
 	req->ki_users --;
 	if (unlikely(req->ki_users < 0))
diff -ruN -X dontdiff2 linux-2.6.9/fs/open.c f_count-2.6.9/fs/open.c
--- linux-2.6.9/fs/open.c	2004-10-19 03:23:08.000000000 +0530
+++ f_count-2.6.9/fs/open.c	2004-11-15 14:07:29.000000000 +0530
@@ -995,11 +995,6 @@
 	if (retval)
 		filp->f_error = 0;
 
-	if (!file_count(filp)) {
-		printk(KERN_ERR "VFS: Close: file count is 0\n");
-		return retval;
-	}
-
 	if (filp->f_op && filp->f_op->flush) {
 		int err = filp->f_op->flush(filp);
 		if (!retval)
diff -ruN -X dontdiff2 linux-2.6.9/net/sched/sch_atm.c f_count-2.6.9/net/sched/sch_atm.c
--- linux-2.6.9/net/sched/sch_atm.c	2004-10-19 03:24:07.000000000 +0530
+++ f_count-2.6.9/net/sched/sch_atm.c	2004-11-15 14:07:29.000000000 +0530
@@ -196,8 +196,6 @@
 	qdisc_destroy(flow->q);
 	destroy_filters(flow);
 	if (flow->sock) {
-		DPRINTK("atm_tc_put: f_count %d\n",
-		    file_count(flow->sock->file));
 		flow->vcc->pop = flow->old_pop;
 		sockfd_put(flow->sock);
 	}
@@ -279,7 +277,6 @@
 	DPRINTK("atm_tc_change: type %d, payload %d, hdr_len %d\n",
 	    opt->rta_type,RTA_PAYLOAD(opt),hdr_len);
 	if (!(sock = sockfd_lookup(fd,&error))) return error; /* f_count++ */
-	DPRINTK("atm_tc_change: f_count %d\n",file_count(sock->file));
         if (sock->ops->family != PF_ATMSVC && sock->ops->family != PF_ATMPVC) {
 		error = -EPROTOTYPE;
                 goto err_out;
