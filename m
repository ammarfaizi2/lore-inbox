Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUJAVRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUJAVRi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUJAVQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:16:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266683AbUJAU7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:59:23 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16733.50382.569265.183099@segfault.boston.redhat.com>
Date: Fri, 1 Oct 2004 16:57:50 -0400
To: linux-kernel@vger.kernel.org
CC: mingo@redhat.com, sct@redhat.com
Subject: [patch rfc] towards supporting O_NONBLOCK on regular files
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes an attempt at supporting the O_NONBLOCK flag for regular
files.  It's pretty straight-forward.  One limitation is that we still call
into the readahead code, which I believe can block.  However, if we don't
do this, then an application which only uses non-blocking reads may never
get it's data.

Comments welcome.

-Jeff

--- linux-2.6.8/mm/filemap.c.orig	2004-09-30 16:33:46.881129560 -0400
+++ linux-2.6.8/mm/filemap.c	2004-09-30 16:34:12.109294296 -0400
@@ -720,7 +720,7 @@ void do_generic_mapping_read(struct addr
 	unsigned long index, end_index, offset;
 	loff_t isize;
 	struct page *cached_page;
-	int error;
+	int error, nonblock = filp->f_flags & O_NONBLOCK;
 	struct file_ra_state ra = *_ra;
 
 	cached_page = NULL;
@@ -755,10 +755,20 @@ find_page:
 		page = find_get_page(mapping, index);
 		if (unlikely(page == NULL)) {
 			handle_ra_miss(mapping, &ra, index);
+			if (nonblock) {
+				desc->error = -EWOULDBLOCK;
+				break;
+			}
 			goto no_cached_page;
 		}
-		if (!PageUptodate(page))
+		if (!PageUptodate(page)) {
+			if (nonblock) {
+				page_cache_release(page);
+				desc->error = -EWOULDBLOCK;
+				break;
+			}
 			goto page_not_up_to_date;
+		}
 page_ok:
 
 		/* If users can be writing to this page using arbitrary
@@ -1004,7 +1014,7 @@ __generic_file_aio_read(struct kiocb *io
 			desc.error = 0;
 			do_generic_file_read(filp,ppos,&desc,file_read_actor);
 			retval += desc.written;
-			if (!retval) {
+			if (!retval || desc.error) {
 				retval = desc.error;
 				break;
 			}
