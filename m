Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbVHaUBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVHaUBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 16:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVHaUBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 16:01:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:9949 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751046AbVHaUBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 16:01:22 -0400
Date: Wed, 31 Aug 2005 13:01:09 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: dwmw2@infradead.org, bunk@stusta.de, johnstul@us.ibm.com,
       drepper@redhat.com, Franz.Fischer@goyellow.de,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][Bug 5132] fix sys_poll() large timeout handling
Message-ID: <20050831200109.GB3017@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry everybody, forgot the most important Cc: :)

-Nish

Hi Andrew,

In looking at Bug 5132 and sys_poll(), I think there is a flaw in the
current code.

The @timeout parameter to sys_poll() is in milliseconds but we compare
it to (MAX_SCHEDULE_TIMEOUT / HZ), which is jiffies/jiffies-per-sec or
seconds. That seems blatantly broken. Also, I think we are better served
by converting to jiffies first then comparing, as opposed to converting
our maximum to milliseconds (or seconds, incorrectly) and comparing.

Comments, suggestions for improvement?

Description: The current sys_poll() implementation does not seem to
handle large timeouts correctly. Any value in milliseconds (@timeout)
which exceeds the maximum representable jiffy value
(MAX_SCHEDULE_TIMEOUT) should result in a MAX_SCHEDULE_TIMEOUT
schedule_timeout() call. To achieve this, convert @timeout to jiffies
first, then compare to MAX_SCHEDULE_TIMEOUT.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 fs/select.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff -urpN 2.6.13/fs/select.c 2.6.13-dev/fs/select.c
--- 2.6.13/fs/select.c	2005-08-28 17:46:14.000000000 -0700
+++ 2.6.13-dev/fs/select.c	2005-08-31 12:43:52.000000000 -0700
@@ -470,12 +470,16 @@ asmlinkage long sys_poll(struct pollfd _
 		return -EINVAL;
 
 	if (timeout) {
-		/* Careful about overflow in the intermediate values */
-		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
-			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
-		else /* Negative or overflow */
-			timeout = MAX_SCHEDULE_TIMEOUT;
+		/*
+		 * Convert the value from msecs to jiffies - if overflow
+		 * occurs we get a negative value, which gets handled by
+		 * the next block
+		 */
+		timeout = msecs_to_jiffies(timeout) + 1;
 	}
+	if (timeout < 0) /* Negative requests result in infinite timeouts */
+		timeout = MAX_SCHEDULE_TIMEOUT;
+	/* 0 case falls through */
 
 	poll_initwait(&table);
 
