Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVCFXRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVCFXRY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVCFWlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:41:45 -0500
Received: from coderock.org ([193.77.147.115]:17328 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261591AbVCFWib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:38:31 -0500
Subject: [patch 8/8] drivers/isdn/pcbit/* - compile warning cleanup
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       domen@coderock.org, yrgrknmxpzlk@gawab.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:38:22 +0100
Message-Id: <20050306223822.D72821EDA4@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


compile warning cleanup - handle copy_to/from_user error 
returns

Signed-off-by: Stephen Biggs <yrgrknmxpzlk@gawab.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/isdn/pcbit/drv.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff -puN drivers/isdn/pcbit/drv.c~return_code-drivers_isdn_pcbit drivers/isdn/pcbit/drv.c
--- kj/drivers/isdn/pcbit/drv.c~return_code-drivers_isdn_pcbit	2005-03-05 16:13:08.000000000 +0100
+++ kj-domen/drivers/isdn/pcbit/drv.c	2005-03-05 16:13:08.000000000 +0100
@@ -727,23 +727,26 @@ int pcbit_stat(u_char __user *buf, int l
 
 	if (stat_st < stat_end)
 	{
-		copy_to_user(buf, statbuf + stat_st, len);
+		if (copy_to_user(buf, statbuf + stat_st, len))
+			return -EFAULT;
 		stat_st += len;	   
 	}
 	else
 	{
 		if (len > STATBUF_LEN - stat_st)
 		{
-			copy_to_user(buf, statbuf + stat_st, 
-				       STATBUF_LEN - stat_st);
-			copy_to_user(buf, statbuf, 
-				       len - (STATBUF_LEN - stat_st));
+			if (copy_to_user(buf, statbuf + stat_st,
+				       STATBUF_LEN - stat_st) ||
+				copy_to_user(buf, statbuf,
+				       len - (STATBUF_LEN - stat_st)))
+				return -EFAULT;
 
 			stat_st = len - (STATBUF_LEN - stat_st);
 		}
 		else
 		{
-			copy_to_user(buf, statbuf + stat_st, len);
+			if (copy_to_user(buf, statbuf + stat_st, len))
+				return -EFAULT;
 
 			stat_st += len;
 			
_
