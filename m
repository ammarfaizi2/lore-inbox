Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVAaOl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVAaOl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVAaOl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:41:57 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:48258 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261221AbVAaOlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:41:44 -0500
Message-ID: <41FE439B.6080500@cosmosbay.com>
Date: Mon, 31 Jan 2005 15:41:31 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org, akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Time to change NR_OPEN value
References: <41FE2C63.mailD8U11TTK4@phoenix.one.melware.de>
In-Reply-To: <41FE2C63.mailD8U11TTK4@phoenix.one.melware.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Time has come to change NR_OPEN value, some production servers hit the 
not so 'ridiculously high value' of 1024*1024 file descriptors per process.

AFAIK this is safe to raise this value, because alloc_fd_array() uses 
vmalloc() for large arrays and vmalloc() returns NULL  if a too large 
allocation is attempted (or in case of memory shortage)

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

diff -Nru /tmp/fs.h include/linux/fs.h
--- linux.orig/include/linux/fs.h   2005-01-31 15:28:01.926685144 +0100
+++ inux/include/linux/fs.h  2005-01-31 15:29:37.047224624 +0100
@@ -32,7 +32,8 @@
   * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
   * the file limit at runtime and only root can increase the per-process
   * nr_file rlimit, so it's safe to set up a ridiculously high absolute
- * upper limit on files-per-process.
+ * upper limit on files-per-process. Actual limit depends on vmalloc()
+ * constraints.
   *
   * Some programs (notably those using select()) may have to be
   * recompiled to take full advantage of the new limits..
@@ -40,7 +41,7 @@

  /* Fixed constants first: */
  #undef NR_OPEN
-#define NR_OPEN (1024*1024)    /* Absolute upper limit on fd num */
+#define NR_OPEN (16*1024*1024) /* Absolute upper limit on fd num */
  #define INR_OPEN 1024          /* Initial setting for nfile rlimits */

  #define BLOCK_SIZE_BITS 10

