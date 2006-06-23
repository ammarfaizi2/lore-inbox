Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWFWMEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWFWMEi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933085AbWFWMEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:04:37 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:61129 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S933083AbWFWMEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:04:36 -0400
Date: Fri, 23 Jun 2006 21:04:30 +0900 (JST)
Message-Id: <20060623.210430.2110776701550307243.masano@tnes.nec.co.jp>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [RFC PATCH] add lookup hint for network file systems
From: ASANO Masahiro <masano@tnes.nec.co.jp>
X-Mailer: Mew version 4.2 on XEmacs 21.5-b21 (corn)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to speeding up mkdir(2) for network file systems.
A typical mkdir(2) calls two inode_operations: lookup and mkdir.
The lookup operation would fail with ENOENT in common case.  I think
it is unnecessary because the subsequent mkdir operation can check it.
In case of creat(2), lookup operation is called with the LOOKUP_CREATE
flag, so individual filesystem can omit real lookup. e.g. nfs_lookup().

Here is a sample patch which uses LOOKUP_CREATE and O_EXCL on mkdir,
symlink and mknod.  This uses the gadget for creat(2).

And here is the result of a benchmark on NFSv3.
  mkdir(2) 10,000 times:
    original  50.5 sec
    patched   29.0 sec

Signed-off-by: ASANO Masahiro <masano@tnes.nec.co.jp>

---

 fs/namei.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

5273ee304b4dc1096432dc3f3aa9183e20afab1d
diff --git a/fs/namei.c b/fs/namei.c
index 184fe4a..209867d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1759,6 +1759,8 @@ struct dentry *lookup_create(struct name
 	if (nd->last_type != LAST_NORM)
 		goto fail;
 	nd->flags &= ~LOOKUP_PARENT;
+	nd->flags |= LOOKUP_CREATE;
+	nd->intent.open.flags = O_EXCL;
 
 	/*
 	 * Do the final lookup.
-- 
1.3.3

