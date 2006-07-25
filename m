Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWGYAbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWGYAbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWGYAbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:31:36 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:4288 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932360AbWGYAbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:31:35 -0400
Subject: [PATCH] [fuse] Add lock annotations to request_end and
	fuse_read_interrupt
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
       fuse-devel@lists.sourceforge.net
Content-Type: text/plain
Date: Mon, 24 Jul 2006 17:31:36 -0700
Message-Id: <1153787496.31581.43.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

request_end and fuse_read_interrupt release fc->lock.  Add lock annotations to
these two functions so that sparse can check callers for lock pairing, and so
that sparse will not complain about these functions since they intentionally
use locks in this manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 fs/fuse/dev.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1e2006c..4fc557c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -212,6 +212,7 @@ void fuse_put_request(struct fuse_conn *
  * Called with fc->lock, unlocks it
  */
 static void request_end(struct fuse_conn *fc, struct fuse_req *req)
+	__releases(fc->lock)
 {
 	void (*end) (struct fuse_conn *, struct fuse_req *) = req->end;
 	req->end = NULL;
@@ -640,6 +641,7 @@ static void request_wait(struct fuse_con
  */
 static int fuse_read_interrupt(struct fuse_conn *fc, struct fuse_req *req,
 			       const struct iovec *iov, unsigned long nr_segs)
+	__releases(fc->lock)
 {
 	struct fuse_copy_state cs;
 	struct fuse_in_header ih;


