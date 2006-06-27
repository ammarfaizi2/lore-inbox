Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030746AbWF0HVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030746AbWF0HVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030740AbWF0HU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:20:59 -0400
Received: from mx1.suse.de ([195.135.220.2]:33413 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030731AbWF0HUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:49 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:20:43 +1000
Message-Id: <1060627072043.26745@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 013 of 14] knfsd: nfsd: mark rqstp to prevent use of sendfile in privacy case
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@citi.umich.edu>


Add a rq_sendfile_ok flag to svc_rqst which will be cleared in the privacy
case so that the wrapping code will get copies of the read data instead of
real page cache pages.  This makes life simpler when we encrypt the
response.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

### Diffstat output
 ./fs/nfsd/vfs.c              |    2 +-
 ./include/linux/sunrpc/svc.h |    4 +++-
 ./net/sunrpc/svc.c           |    2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff .prev/fs/nfsd/vfs.c ./fs/nfsd/vfs.c
--- .prev/fs/nfsd/vfs.c	2006-06-27 15:04:03.000000000 +1000
+++ ./fs/nfsd/vfs.c	2006-06-27 15:07:01.000000000 +1000
@@ -840,7 +840,7 @@ nfsd_vfs_read(struct svc_rqst *rqstp, st
 	if (ra && ra->p_set)
 		file->f_ra = ra->p_ra;
 
-	if (file->f_op->sendfile) {
+	if (file->f_op->sendfile && rqstp->rq_sendfile_ok) {
 		svc_pushback_unused_pages(rqstp);
 		err = file->f_op->sendfile(file, &offset, *count,
 						 nfsd_read_actor, rqstp);

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-06-27 15:07:01.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-06-27 15:07:01.000000000 +1000
@@ -159,7 +159,9 @@ struct svc_rqst {
 						 * determine what device number
 						 * to report (real or virtual)
 						 */
-
+	int			rq_sendfile_ok; /* turned off in gss privacy
+						 * to prevent encrypting page
+						 * cache pages */
 	wait_queue_head_t	rq_wait;	/* synchronization */
 };
 

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-06-27 15:07:01.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-06-27 15:07:01.000000000 +1000
@@ -281,6 +281,8 @@ svc_process(struct svc_serv *serv, struc
 	rqstp->rq_res.page_len = 0;
 	rqstp->rq_res.buflen = PAGE_SIZE;
 	rqstp->rq_res.tail[0].iov_len = 0;
+	/* Will be turned off only in gss privacy case: */
+	rqstp->rq_sendfile_ok = 1;
 	/* tcp needs a space for the record length... */
 	if (rqstp->rq_prot == IPPROTO_TCP)
 		svc_putu32(resv, 0);
