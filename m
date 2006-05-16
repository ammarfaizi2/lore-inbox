Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWEPTST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWEPTST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWEPTST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:18:19 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:56465 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750863AbWEPTSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:18:18 -0400
Date: Tue, 16 May 2006 21:18:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] openpromfs: fix missing NUL
Message-ID: <Pine.LNX.4.61.0605162117020.26647@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tchars is not '\0'-terminated so the strtoul may run into problems. Fix 
that.
Also make tchars as big as a long in hexadecimal form would take rather 
than just 16.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru linux-2.6.17-rc4~/fs/openpromfs/inode.c linux-2.6.17-rc4+/fs/openpromfs/inode.c
--- linux-2.6.17-rc4~/fs/openpromfs/inode.c	2006-05-16 20:56:41.395807000 +0200
+++ linux-2.6.17-rc4+/fs/openpromfs/inode.c	2006-05-16 20:57:32.725807000 +0200
@@ -448,10 +448,11 @@ static ssize_t property_write(struct fil
 					*q |= simple_strtoul (tmp, NULL, 16);
 					buf += last_cnt;
 				} else {
-					char tchars[17]; /* XXX yuck... */
+					char tchars[2 * sizeof(long) + 1];
 
-					if (copy_from_user(tchars, buf, 16))
+					if (copy_from_user(tchars, buf, sizeof(tchars) - 1))
 						return -EFAULT;
+                                        tchars[sizeof(tchars) - 1] = '\0';
 					*q = simple_strtoul (tchars, NULL, 16);
 					buf += 9;
 				}
#<<eof>>

Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
