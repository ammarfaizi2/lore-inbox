Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWHLWPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWHLWPo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 18:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWHLWPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 18:15:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:57489 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964913AbWHLWPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 18:15:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qhsmzidQOaOlncm23hsk/pg1FAQ2muIB3uW2ElgKxwPQB/UgckuTjL52opsnKxCoRbMnJWE1dZo4wWEe+Rev6g3GhAAeGplHn3+0zKbl/VN7PdKjxYd2JFVESFd3Xx/5AxTBN3yi34G3B9V/sah1gO1mQrG+0h8Hizv5Msqu0tE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] XFS: remove pointless conditional testing 'nmp' vs NULL in fs/xfs/xfs_rtalloc.c::xfs_growfs_rt()
Date: Sun, 13 Aug 2006 00:16:50 +0200
User-Agent: KMail/1.9.4
Cc: xfs-masters@oss.sgi.com, xfs@oss.sgi.com, nathans@sgi.com,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608130016.51136.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/xfs/xfs_rtalloc.c::xfs_growfs_rt() there's a completely useless
conditional at the error_exit label.
The 'if (nmp)' check is pointless and might as well be removed for two 
reasons.
1) if 'nmp' is NULL then kmem_free() will end up calling kfree() with a NULL
   argument - which in turn will just cause a return from kfree(). No harm 
   done.
2) At the beginning of the function there's an assignment; '*nmp = *mp;' so
   if 'nmp' was NULL we'd already have blown up due to dereferencing a NULL 
   pointer.

This patch gets rid of the pointless check.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/xfs/xfs_rtalloc.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.18-rc4-orig/fs/xfs/xfs_rtalloc.c	2006-08-11 00:11:13.000000000 +0200
+++ linux-2.6.18-rc4/fs/xfs/xfs_rtalloc.c	2006-08-13 00:07:43.000000000 +0200
@@ -2107,8 +2107,7 @@ xfs_growfs_rt(
 	 * Error paths come here.
 	 */
 error_exit:
-	if (nmp)
-		kmem_free(nmp, sizeof(*nmp));
+	kmem_free(nmp, sizeof(*nmp));
 	xfs_trans_cancel(tp, cancelflags);
 	return error;
 }


