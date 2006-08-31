Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWHaMlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWHaMlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHaMlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:41:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42190 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932181AbWHaMlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:41:31 -0400
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CacheFiles: cachefiles_write_page() shouldn't indicate error twice
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 31 Aug 2006 13:41:17 +0100
Message-ID: <15128.1157028077@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Prevent cachefiles_write_page() from issuing an error twice, instead forgoing
the callback if it can return the error directly.

Previously, the netfs was being informed of the error twice, once by the error
being passed to the netfs callback, and a second time when fscache_write_page()
returned to the netfs.

In NFS's case, this meant it attempted to do error handling twice, including
clearing PG_fs_misc twice...

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-interface.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
index 6be3d98..4c0eb31 100644
--- a/fs/cachefiles/cf-interface.c
+++ b/fs/cachefiles/cf-interface.c
@@ -1247,9 +1247,11 @@ #else
 						"write page to backing file"
 						" failed");
 		ret = -ENOBUFS;
+	} else {
+		/* only invoke the callback if successful, we return the error
+		 * directly otherwise */
+		end_io_func(page, context, ret);
 	}
-
-	end_io_func(page, context, ret);
 #endif
 
 	_leave(" = %d", ret);
