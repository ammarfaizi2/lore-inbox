Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbULVV6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbULVV6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 16:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbULVV6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 16:58:08 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:5311 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262058AbULVV6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 16:58:05 -0500
Date: Wed, 22 Dec 2004 13:57:59 -0800
From: Jason Uhlenkott <jasonuhl@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] Fix rlimit check in precheck_file_write()
Message-ID: <20041222215759.GA217560@dragonfly.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a broken assumption that rlimits are 32 bits which can cause
nasty things to happen on 64-bit machines if we try to write past the
2^32-1th character of a file and a larger file size limit exists.

Signed-off-by: Jason Uhlenkott <jasonuhl@sgi.com>

--- linux-2.4.29-pre3.orig/mm/filemap.c	2004-11-17 03:54:22.000000000 -0800
+++ linux-2.4.29-pre3/mm/filemap.c	2004-12-22 13:41:46.000000000 -0800
@@ -3088,9 +3088,9 @@
 			send_sig(SIGXFSZ, current, 0);
 			goto out;
 		}
-		if (pos > 0xFFFFFFFFULL || *count > limit - (u32)pos) {
+		if (*count > limit - pos) {
 			/* send_sig(SIGXFSZ, current, 0); */
-			*count = limit - (u32)pos;
+			*count = limit - pos;
 		}
 	}
 
