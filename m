Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbVIJAfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbVIJAfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 20:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbVIJAfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 20:35:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:41669 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932652AbVIJAfc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 20:35:32 -0400
Date: Fri, 9 Sep 2005 17:35:25 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: dwmw2@infradead.org, bunk@stusta.de, johnstul@us.ibm.com,
       drepper@redhat.com, Franz.Fischer@goyellow.de,
       LKML <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH][Bug 5132] fix sys_poll() large timeout handling
Message-ID: <20050910003525.GC24225@us.ibm.com>
References: <20050831200109.GB3017@us.ibm.com> <20050906212514.GB3038@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906212514.GB3038@us.ibm.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.2005 [14:25:14 -0700], Nishanth Aravamudan wrote:
> On 31.08.2005 [13:01:09 -0700], Nishanth Aravamudan wrote:
> > Sorry everybody, forgot the most important Cc: :)
> > 
> > -Nish
> > 
> > Hi Andrew,
> > 
> > In looking at Bug 5132 and sys_poll(), I think there is a flaw in the
> > current code.
> > 
> > The @timeout parameter to sys_poll() is in milliseconds but we compare
> > it to (MAX_SCHEDULE_TIMEOUT / HZ), which is jiffies/jiffies-per-sec or
> > seconds. That seems blatantly broken. Also, I think we are better served
> > by converting to jiffies first then comparing, as opposed to converting
> > our maximum to milliseconds (or seconds, incorrectly) and comparing.
> > 
> > Comments, suggestions for improvement?
> 
> I haven't got any responses (here or on the bug)... A silent NACK?
> Anything I should change to make people happier?

Well, I found one thing to change. msecs_to_jiffies() deals in unsigned
quantities while the parameter we are passing in is signed (and with
reason). I mistakenly left the

	if (timeout)

check in, when it should be

	if (timeout > 0)

check. Fixed below.

Thanks,
Nish

Description: The current sys_poll() implementation does not seem to
handle large timeouts correctly. Any value in milliseconds (@timeout)
which exceeds the maximum representable jiffy value
(MAX_SCHEDULE_TIMEOUT) should result in a MAX_SCHEDULE_TIMEOUT
schedule_timeout() request. To achieve this, convert @timeout to jiffies
first, then compare to MAX_SCHEDULE_TIMEOUT.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 fs/select.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff -urpN 2.6.13/fs/select.c 2.6.13-dev/fs/select.c
--- 2.6.13/fs/select.c	2005-08-28 17:46:14.000000000 -0700
+++ 2.6.13-dev/fs/select.c	2005-09-09 17:22:30.000000000 -0700
@@ -469,13 +469,16 @@ asmlinkage long sys_poll(struct pollfd _
 	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
 		return -EINVAL;
 
-	if (timeout) {
-		/* Careful about overflow in the intermediate values */
-		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
-			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
-		else /* Negative or overflow */
-			timeout = MAX_SCHEDULE_TIMEOUT;
-	}
+	if (timeout > 0)
+		/*
+		 * Convert the value from msecs to jiffies - if overflow
+		 * occurs we get a negative value, which gets handled by
+		 * the next block
+		 */
+		timeout = msecs_to_jiffies(timeout) + 1;
+	if (timeout < 0) /* Negative requests result in infinite timeouts */
+		timeout = MAX_SCHEDULE_TIMEOUT;
+	/* 0 case falls through */
 
 	poll_initwait(&table);
 
