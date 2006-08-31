Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWHaNjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWHaNjv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWHaNjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:39:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58253 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932306AbWHaNju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:39:50 -0400
Subject: [PATCH 16/16] GFS2: Exported functions
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 31 Aug 2006 14:43:44 +0100
Message-Id: <1157031824.3384.815.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 16/16] GFS2: Exported functions

Export the routine for initialising ra_state structure. This allows
GFS2 to use the standard kernel readahead when reading its internal
files. Also a modification to the read path for direct i/o allows
a 0 return from the direct i/o function provided by the filesystem
to result in a "normal" buffered i/o. GFS2 uses this in cases where
direct i/o isn't possible for some reason (e.g. the file is "stuffed"
and this not aligned on disk).


Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>


 mm/filemap.c   |    3 ++-
 mm/readahead.c |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1181,7 +1181,8 @@ __generic_file_aio_read(struct kiocb *io
 				*ppos = pos + retval;
 		}
 		file_accessed(filp);
-		goto out;
+		if (retval != 0)
+			goto out;
 	}
 
 	retval = 0;
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -38,6 +38,7 @@ file_ra_state_init(struct file_ra_state 
 	ra->ra_pages = mapping->backing_dev_info->ra_pages;
 	ra->prev_page = -1;
 }
+EXPORT_SYMBOL_GPL(file_ra_state_init);
 
 /*
  * Return max readahead size for this inode in number-of-pages.


