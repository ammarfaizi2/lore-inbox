Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWDYJLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWDYJLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWDYJLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:11:11 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:8172 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751493AbWDYJLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:11:10 -0400
Subject: [PATCH 2/2] ipmi: strstrip conversion
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: minyard@acm.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Apr 2006 12:11:07 +0300
Message-Id: <1145956267.27659.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch switches an open-coded strstrip to use the new API.

Cc: Corey Minyard <minyard@acm.org>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 drivers/char/ipmi/ipmi_watchdog.c |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

342eaae5800b0fd002f5101d66ccb02e786016d8
diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 2d11ddd..8f88671 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -212,24 +212,16 @@ static int set_param_str(const char *val
 {
 	action_fn  fn = (action_fn) kp->arg;
 	int        rv = 0;
-	const char *end;
-	char       valcp[16];
-	int        len;
-
-	/* Truncate leading and trailing spaces. */
-	while (isspace(*val))
-		val++;
-	end = val + strlen(val) - 1;
-	while ((end >= val) && isspace(*end))
-		end--;
-	len = end - val + 1;
-	if (len > sizeof(valcp) - 1)
-		return -EINVAL;
-	memcpy(valcp, val, len);
-	valcp[len] = '\0';
+	char       *dup, *s;
+
+	dup = kstrdup(val, GFP_KERNEL);
+	if (!dup)
+		return -ENOMEM;
+
+	s = strstrip(dup);
 
 	down_read(&register_sem);
-	rv = fn(valcp, NULL);
+	rv = fn(s, NULL);
 	if (rv)
 		goto out_unlock;
 
@@ -239,6 +231,7 @@ static int set_param_str(const char *val
 
  out_unlock:
 	up_read(&register_sem);
+	kfree(dup);
 	return rv;
 }
 
-- 
1.3.0



