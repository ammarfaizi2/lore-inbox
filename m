Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbTLaWrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbTLaWrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:47:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:39563 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265278AbTLaWri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:47:38 -0500
Subject: [PATCH linux-2.6.1-rc1-mm1] dio_isize.patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, janetmor@us.ibm.com,
       Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1072910061.712.67.camel@ibm-c.pdx.osdl.net>
References: <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	 <1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	 <1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
	 <20031216180319.6d9670e4.akpm@osdl.org> <20031231091828.GA4012@in.ibm.com>
	 <20031231013521.79920efd.akpm@osdl.org> <20031231095503.GA4069@in.ibm.com>
	 <20031231015913.34fc0176.akpm@osdl.org> <20031231100949.GA4099@in.ibm.com>
	 <20031231021042.5975de04.akpm@osdl.org> <20031231104801.GB4099@in.ibm.com>
	 <20031231025309.6bc8ca20.akpm@osdl.org>
	 <20031231025410.699a3317.akpm@osdl.org>
	 <20031231031736.0416808f.akpm@osdl.org>
	 <1072910061.712.67.camel@ibm-c.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-ZAJY5ej3rPB4sj3k278e"
Organization: 
Message-Id: <1072910844.712.80.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Dec 2003 14:47:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZAJY5ej3rPB4sj3k278e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch samples i_size before dropping the i_sem.
The i_size could change by a racing write and we could
return uninitialized data.

re-diffed against 2.6.1-rc1-mm1.

Daniel

--=-ZAJY5ej3rPB4sj3k278e
Content-Disposition: attachment; filename=linux-2.6.1-rc1-mm1.dio_isize.patch
Content-Type: text/plain; name=linux-2.6.1-rc1-mm1.dio_isize.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.1-rc1-mm1/fs/direct-io.c	2003-12-31 10:52:45.940193469 -0800
+++ linux-2.6.1-rc1-mm1.dio_isize/fs/direct-io.c	2003-12-31 13:56:06.836825169 -0800
@@ -882,6 +882,7 @@ direct_io_worker(int rw, struct kiocb *i
 	int ret = 0;
 	int ret2;
 	size_t bytes;
+	loff_t i_size;
 
 	dio->bio = NULL;
 	dio->inode = inode;
@@ -982,7 +983,12 @@ direct_io_worker(int rw, struct kiocb *i
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
 
@@ -1026,7 +1032,6 @@ direct_io_worker(int rw, struct kiocb *i
 		if (ret == 0)
 			ret = dio->page_errors;
 		if (ret == 0 && dio->result) {
-			loff_t i_size = i_size_read(inode);
 
 			ret = dio->result;
 			/*

--=-ZAJY5ej3rPB4sj3k278e--

