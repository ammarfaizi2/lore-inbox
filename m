Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVFQWdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFQWdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 18:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFQWdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 18:33:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:4252 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261197AbVFQWdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 18:33:16 -0400
Subject: [PATCH] fix for generic_file_write iov problem
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-JxLzzTADbBlEXjBJyy8/"
Organization: 
Message-Id: <1119046157.4301.526.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jun 2005 15:09:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JxLzzTADbBlEXjBJyy8/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Here is the fix for the problem described in 

	http://bugzilla.kernel.org/show_bug.cgi?id=4721


Basically, problem is generic_file_buffered_write() is accessing
beyond end of the iov[] vector after handling the last vector.
If we happen to cross page boundary, we get a fault.

I think this simple patch is good enough. If we really don't
want to depend on the "count", then we need pass nr_segs to 
filemap_set_next_iovec() and decrement it and check it.

What do you think ?

Thanks,
Badari





--=-JxLzzTADbBlEXjBJyy8/
Content-Disposition: attachment; filename=generic_file_write-iovfix.patch
Content-Type: text/plain; name=generic_file_write-iovfix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.12-rc6.org/mm/filemap.c	2005-06-17 15:10:05.000000000 -0700
+++ linux-2.6.12-rc6/mm/filemap.c	2005-06-17 15:10:29.000000000 -0700
@@ -2023,7 +2023,8 @@ generic_file_buffered_write(struct kiocb
 				if (unlikely(nr_segs > 1)) {
 					filemap_set_next_iovec(&cur_iov,
 							&iov_base, status);
-					buf = cur_iov->iov_base + iov_base;
+					if (count)
+						buf = cur_iov->iov_base + iov_base;
 				}
 			}
 		}

--=-JxLzzTADbBlEXjBJyy8/--

