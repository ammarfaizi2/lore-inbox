Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUHWRTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUHWRTC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUHWRTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:19:01 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:30179 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S266217AbUHWRQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:16:12 -0400
Message-ID: <412A2630.70509@ttnet.net.tr>
Date: Mon, 23 Aug 2004 20:15:28 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [9/10] [3/4]
Content-Type: multipart/mixed;
	boundary="------------080500000605040307020909"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080500000605040307020909
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

splitted-up the fs/* gcc3.4-inline-patches.

[3/4] intermezzo, while we're here



--------------080500000605040307020909
Content-Type: text/plain;
	name="gcc34_inline_09-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_09-3.diff"

--- 28p1/fs/intermezzo/file.c~	2004-02-18 15:36:31.000000000 +0200
+++ 28p1/fs/intermezzo/file.c	2004-08-07 14:09:39.000000000 +0300
@@ -78,16 +78,19 @@
         pathlen = MYPATHLEN(buffer, path);
         
         CDEBUG(D_FILE, "de %p, dd %p\n", de, dd);
+
         if (dd->remote_ino == 0) {
                 rc = presto_get_fileid(minor, fset, de);
+                if (dd->remote_ino == 0)
+                        CERROR("get_fileid failed %d, ino: %Lx, fetching by name\n", rc,
+                               dd->remote_ino);
+
         }
         memset (&info, 0, sizeof(info));
         if (dd->remote_ino > 0) {
                 info.remote_ino = dd->remote_ino;
                 info.remote_generation = dd->remote_generation;
-        } else
-                CERROR("get_fileid failed %d, ino: %Lx, fetching by name\n", rc,
-                       dd->remote_ino);
+        }
 
         rc = izo_upc_open(minor, pathlen, path, fset->fset_name, &info);
         PRESTO_FREE(buffer, PAGE_SIZE);
=== http://marc.theaimsgroup.com/?l=bk-commits-head&m=105399886001079&w=2
--- 28p1/fs/intermezzo/methods.c~	2002-11-29 01:53:15.000000000 +0200
+++ 28p1/fs/intermezzo/methods.c	2004-08-17 05:02:58.000000000 +0300
@@ -254,8 +254,8 @@
         if (ops == NULL) {
                 CERROR("prepare to die: unrecognized cache type for Filter\n");
         }
-        return ops;
         FEXIT;
+        return ops;
 }
 
 
--- 28p1/fs/intermezzo/journal_xfs.c~	2002-11-29 01:53:15.000000000 +0200
+++ 28p1/fs/intermezzo/journal_xfs.c	2004-08-17 05:02:58.000000000 +0300
@@ -58,7 +57,7 @@
         VFS_STATVFS(vfsp, &stat, NULL, rc);
         avail = statp.f_bfree;
 
-        return sbp->sb_fdblocks;; 
+        return sbp->sb_fdblocks;
 #endif
         return 0x0fffffff;
 }
--- 28p1/fs/intermezzo/psdev.c~	2002-11-29 01:53:15.000000000 +0200
+++ 28p1/fs/intermezzo/psdev.c	2004-08-17 15:18:34.000000000 +0300
@@ -564,6 +564,10 @@
         buffer->u_uniq = req->rq_unique;
         buffer->u_async = async;
 
+        /* Remove potential datarace possibility*/
+        if ( async ) 
+                req->rq_flags = REQ_ASYNC;
+
         spin_lock(&channel->uc_lock); 
         /* Append msg to pending queue and poke Lento. */
         list_add(&req->rq_chain, channel->uc_pending.prev);
@@ -576,7 +580,7 @@
 
         if ( async ) {
                 /* req, rq_data are freed in presto_psdev_read for async */
-                req->rq_flags = REQ_ASYNC;
+                /* req->rq_flags = REQ_ASYNC;*/
                 EXIT;
                 return 0;
         }
@@ -647,5 +651,6 @@
 exit_req:
         PRESTO_FREE(req, sizeof(struct upc_req));
 exit_buf:
+        PRESTO_FREE(buffer,*size);
         return error;
 }

--------------080500000605040307020909--
