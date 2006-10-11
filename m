Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWJKU0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWJKU0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbWJKU0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:26:42 -0400
Received: from havoc.gtf.org ([69.61.125.42]:57044 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161223AbWJKU0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:26:42 -0400
Date: Wed, 11 Oct 2006 16:26:41 -0400
From: Jeff Garzik <jeff@garzik.org>
To: kkeil@suse.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ISDN: check for userspace copy faults
Message-ID: <20061011202641.GA10599@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Most of the ISDN ->readstat() implementations needed to check
copy_to_user() and put_user() return values.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/isdn/capi/capidrv.c      |    3 ++-
 drivers/isdn/hisax/config.c      |    6 ++++--
 drivers/isdn/icn/icn.c           |    3 ++-
 drivers/isdn/isdnloop/isdnloop.c |    3 ++-
 drivers/isdn/pcbit/drv.c         |   16 ++++++++++------
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/isdn/capi/capidrv.c b/drivers/isdn/capi/capidrv.c
index d10c8b8..b6f9476 100644
--- a/drivers/isdn/capi/capidrv.c
+++ b/drivers/isdn/capi/capidrv.c
@@ -1907,7 +1907,8 @@ static int if_readstat(u8 __user *buf, i
 	}
 
 	for (p=buf, count=0; count < len; p++, count++) {
-		put_user(*card->q931_read++, p);
+		if (put_user(*card->q931_read++, p))
+			return -EFAULT;
 	        if (card->q931_read > card->q931_end)
 	                card->q931_read = card->q931_buf;
 	}
diff --git a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
index e4823ab..785b085 100644
--- a/drivers/isdn/hisax/config.c
+++ b/drivers/isdn/hisax/config.c
@@ -631,7 +631,8 @@ static int HiSax_readstatus(u_char __use
 		count = cs->status_end - cs->status_read + 1;
 		if (count >= len)
 			count = len;
-		copy_to_user(p, cs->status_read, count);
+		if (copy_to_user(p, cs->status_read, count))
+			return -EFAULT;
 		cs->status_read += count;
 		if (cs->status_read > cs->status_end)
 			cs->status_read = cs->status_buf;
@@ -642,7 +643,8 @@ static int HiSax_readstatus(u_char __use
 				cnt = HISAX_STATUS_BUFSIZE;
 			else
 				cnt = count;
-			copy_to_user(p, cs->status_read, cnt);
+			if (copy_to_user(p, cs->status_read, cnt))
+				return -EFAULT;
 			p += cnt;
 			cs->status_read += cnt % HISAX_STATUS_BUFSIZE;
 			count -= cnt;
diff --git a/drivers/isdn/icn/icn.c b/drivers/isdn/icn/icn.c
index 6649f8b..730bbd0 100644
--- a/drivers/isdn/icn/icn.c
+++ b/drivers/isdn/icn/icn.c
@@ -1010,7 +1010,8 @@ icn_readstatus(u_char __user *buf, int l
 	for (p = buf, count = 0; count < len; p++, count++) {
 		if (card->msg_buf_read == card->msg_buf_write)
 			return count;
-		put_user(*card->msg_buf_read++, p);
+		if (put_user(*card->msg_buf_read++, p))
+			return -EFAULT;
 		if (card->msg_buf_read > card->msg_buf_end)
 			card->msg_buf_read = card->msg_buf;
 	}
diff --git a/drivers/isdn/isdnloop/isdnloop.c b/drivers/isdn/isdnloop/isdnloop.c
index fabbd46..9a66524 100644
--- a/drivers/isdn/isdnloop/isdnloop.c
+++ b/drivers/isdn/isdnloop/isdnloop.c
@@ -451,7 +451,8 @@ isdnloop_readstatus(u_char __user *buf, 
 	for (p = buf, count = 0; count < len; p++, count++) {
 		if (card->msg_buf_read == card->msg_buf_write)
 			return count;
-		put_user(*card->msg_buf_read++, p);
+		if (put_user(*card->msg_buf_read++, p))
+			return -EFAULT;
 		if (card->msg_buf_read > card->msg_buf_end)
 			card->msg_buf_read = card->msg_buf;
 	}
diff --git a/drivers/isdn/pcbit/drv.c b/drivers/isdn/pcbit/drv.c
index 94f2148..d2e5e10 100644
--- a/drivers/isdn/pcbit/drv.c
+++ b/drivers/isdn/pcbit/drv.c
@@ -725,23 +725,27 @@ static int pcbit_stat(u_char __user *buf
 
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
+				       STATBUF_LEN - stat_st))
+				return -EFAULT;
+			if (copy_to_user(buf, statbuf, 
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
 			
