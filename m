Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWEPC7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWEPC7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 22:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWEPC7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 22:59:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:12615 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751088AbWEPC7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 22:59:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=CXG2IXDWniUd/N5oFIiE025Z0mXUcB0UZ6sTYDJyH60xXuIRgku0rAS+QLv91K6NpAhAufC06hKaglsAkNfksxY3in+hzkhOKE6fApgG9iajY7uwjJHTnWJVQWz8Am0B7ZPSUE2G8zaqilcsJh/AnhOiAd2ihDv/a3UkTFeGaIg=
Message-ID: <4469411E.7060406@gmail.com>
Date: Mon, 15 May 2006 23:03:58 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: neilb@cse.unsw.edu.au
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: sign conversion obscuring errors in nfsd_set_posix_acl()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assigning the result of posix_acl_to_xattr() to an unsigned data type
(size/size_t) obscures possible errors.

Coverity CID: 1206.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6aa92d0..1d65f13 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1922,11 +1922,10 @@ nfsd_set_posix_acl(struct svc_fh *fhp, i
 		value = kmalloc(size, GFP_KERNEL);
 		if (!value)
 			return -ENOMEM;
-		size = posix_acl_to_xattr(acl, value, size);
-		if (size < 0) {
-			error = size;
+		error = posix_acl_to_xattr(acl, value, size);
+		if (error < 0)
 			goto getout;
-		}
+		size = error;
 	} else
 		size = 0;
 


