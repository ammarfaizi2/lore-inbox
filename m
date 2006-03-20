Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWCTNMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWCTNMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWCTNMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:12:40 -0500
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:60838 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S1751124AbWCTNMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:12:39 -0500
Date: Mon, 20 Mar 2006 14:08:34 +0100 (CET)
From: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]micro optimization of kcalloc
Message-ID: <Pine.LNX.4.58.0603201404550.16767@fachschaft.cup.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this transforms the limit check of kcalloc() so that size becomes the
divisor. This saves some kernel code, because size is always a constant,
thus turning the check into a simple comparison saving a full division.
This saved 18K in allyesconfig's kernel size.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oliver@neukum.name>

--- a/include/linux/slab.h	2006-03-11 23:12:55.000000000 +0100
+++ b/include/linux/slab.h	2006-03-20 09:00:41.000000000 +0100
@@ -118,7 +118,7 @@
  */
 static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
 {
-	if (n != 0 && size > INT_MAX / n)
+	if (unlikely(n > INT_MAX / size ))
 		return NULL;
 	return kzalloc(n * size, flags);
 }
