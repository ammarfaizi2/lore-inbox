Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263056AbVAFX2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbVAFX2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbVAFXZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:25:56 -0500
Received: from mail.dif.dk ([193.138.115.101]:5307 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S263116AbVAFXYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:24:07 -0500
Date: Fri, 7 Jan 2005 00:35:24 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-net@vger.kernel.org, netdev@oss.sgi.com,
       Jorge Cwik <jorge@laser.satlink.net>,
       Arnt Gulbrandsen <agulbra@nvg.unit.no>
Subject: [patch] net: get rid of redundant access_ok() call in checksum
 calculation.
Message-ID: <Pine.LNX.4.61.0501070028010.3430@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

in include/net/checksum.h::csum_and_copy_to_user  it would seem that the 
access_ok() call before attempting to call copy_to_user() is redundant 
since copy_to_user() calls access_ok() internally.

If that is indeed the case then please consider applying the patch below 
(if that access_ok() does make sense I'd apreciate to be told why).


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk9-orig/include/net/checksum.h linux-2.6.10-bk9/include/net/checksum.h
--- linux-2.6.10-bk9-orig/include/net/checksum.h	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.10-bk9/include/net/checksum.h	2005-01-07 00:27:05.000000000 +0100
@@ -46,10 +46,9 @@ static __inline__ unsigned int csum_and_
 {
 	sum = csum_partial(src, len, sum);
 
-	if (access_ok(VERIFY_WRITE, dst, len)) {
-		if (copy_to_user(dst, src, len) == 0)
-			return sum;
-	}
+	if (copy_to_user(dst, src, len) == 0)
+		return sum;
+
 	if (len)
 		*err_ptr = -EFAULT;
 



