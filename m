Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267216AbUBMVHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267217AbUBMVHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:07:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:4058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267216AbUBMVEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:04:08 -0500
Subject: [PATCH 2.6.3-rc2-mm1]
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040212015710.3b0dee67.akpm@osdl.org>
References: <20040212015710.3b0dee67.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-WkKm/Ky7yo68JQtEmqu/"
Organization: 
Message-Id: <1076706243.1956.26.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Feb 2004 13:04:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WkKm/Ky7yo68JQtEmqu/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch samples i_size before dropping the i_sem.
The i_size could change by a racing write and we could
return uninitialized data.

re-diffed against 2.6.3-rc2-mm1.

Daniel

--=-WkKm/Ky7yo68JQtEmqu/
Content-Disposition: attachment; filename=dio_size.2.6.3-rc2-mm1.patch
Content-Type: text/plain; name=dio_size.2.6.3-rc2-mm1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.3-rc2-mm1.orig/fs/direct-io.c	2004-02-12 11:35:41.613567579 -0800
+++ linux-2.6.3-rc2-mm1/fs/direct-io.c	2004-02-12 11:35:52.135706887 -0800
@@ -909,6 +909,7 @@ direct_io_worker(int rw, struct kiocb *i
 	int ret = 0;
 	int ret2;
 	size_t bytes;
+	loff_t i_size;
 
 	dio->bio = NULL;
 	dio->inode = inode;
@@ -1017,7 +1018,12 @@ direct_io_worker(int rw, struct kiocb *i
 	 * All block lookups have been performed. For READ requests
 	 * we can let i_sem go now that its achieved its purpose
 	 * of protecting us from looking up uninitialized blocks.
+	 * 
+	 * We also need sample i_size before we release i_sem to prevent
+	 * a racing write from changing i_size causing us to return
+	 * uninitialized data.
 	 */
+	i_size = i_size_read(inode);
 	if ((rw == READ) && dio->needs_locking)
 		up(&dio->inode->i_sem);
 
@@ -1064,7 +1070,6 @@ direct_io_worker(int rw, struct kiocb *i
 		if (ret == 0)
 			ret = dio->page_errors;
 		if (ret == 0 && dio->result) {
-			loff_t i_size = i_size_read(inode);
 
 			ret = dio->result;
 			/*

--=-WkKm/Ky7yo68JQtEmqu/--

