Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVIWTHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVIWTHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVIWTHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:07:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:38304 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751156AbVIWTHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:07:49 -0400
Date: Fri, 23 Sep 2005 12:07:49 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: tty update speed regression (was: 2.6.14-rc2-mm1)
Message-ID: <20050923190749.GO5910@us.ibm.com>
References: <20050921222839.76c53ba1.akpm@osdl.org> <20050922195029.GA6426@mipter.zuzino.mipt.ru> <20050922214926.GA6524@mipter.zuzino.mipt.ru> <20050923000815.GB2973@us.ibm.com> <29495f1d050923101228384a34@mail.gmail.com> <20050923184216.GA6452@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923184216.GA6452@mipter.zuzino.mipt.ru>
X-Operating-System: Linux 2.6.14-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.2005 [22:42:16 +0400], Alexey Dobriyan wrote:
> On Fri, Sep 23, 2005 at 10:12:11AM -0700, Nish Aravamudan wrote:
> > I did not see any tty refresh problems on my TP with HZ=250 under
> > 2.6.14-rc2-mm1 (excuse the typo in my previous response) under the
> > adom binary you sent me. I even played two games just to make sure ;)
> 
> The slowdown is HZ dependent:
> * HZ=1000 - game is playable. If I would not know slowdown is there I
>   wouldn't notice it.
> * HZ=100 - messages at the top are printed r e a l l y  s l o w.
> * HZ=250 - somewhere in the middle.
> 
> > Is there any chance you can do an strace of the process while it is
> > slow to redraw your screen?
> 
> Typical pattern is:
> 
> rt_sigaction(SIGTSTP, {SIG_IGN}, {0xb7f1e578, [], SA_RESTART}, 8) = 0
> poll([{fd=0, events=POLLIN}], 1, 0) = 0
> poll([{fd=0, events=POLLIN}], 1, 0) = 0
> write(1, "\33[11;18H\33[37m\33[40m[g] Gnome\r\33[12"..., 58) = 58
> rt_sigaction(SIGTSTP, {0xb7f1e578, [], SA_RESTART}, NULL, 8) = 0
> rt_sigaction(SIGTSTP, {SIG_IGN}, {0xb7f1e578, [], SA_RESTART}, 8) = 0
> poll([{fd=0, events=POLLIN}], 1, 0) = 0
> poll([{fd=0, events=POLLIN}], 1, 0) = 0
> write(1, "\33[12;18H\33[37m\33[40m[h] Hurthling\r"..., 62) = 62
> rt_sigaction(SIGTSTP, {0xb7f1e578, [], SA_RESTART}, NULL, 8) = 0
> rt_sigaction(SIGTSTP, {SIG_IGN}, {0xb7f1e578, [], SA_RESTART}, 8) = 0
> poll([{fd=0, events=POLLIN}], 1, 0) = 0
> poll([{fd=0, events=POLLIN}], 1, 0) = 0
> write(1, "\33[13;18H\33[37m\33[40m[i] Orc\r\33[14d\33"..., 56) = 56
> rt_sigaction(SIGTSTP, {0xb7f1e578, [], SA_RESTART}, NULL, 8) = 0
> rt_sigaction(SIGTSTP, {SIG_IGN}, {0xb7f1e578, [], SA_RESTART}, 8) = 0
> 
> I can send full strace log if needed.

Nope, that helped tremendously! I think I know what the issue is (and
why it's HZ dependent).

In the current code, (2.6.13.2, e.g) we allow 0 timeout poll-requests to
be resolved as 0 jiffy requests. But in my patch, those requests become
1 jiffy (which of course depends on HZ and gets quite long if HZ=100)!

Care to try the following patch?

Note: I would be happy to not do the conditional and just have the patch
change the msecs_to_jiffies() line when assigning to timeout_jiffies.
But I figured it would be best to avoid *all* computations if we know
the resulting value is going to be 0. Hence all the tab changing.

Thanks,
Nish

Description: Modifying sys_poll() to handle large timeouts correctly
resulted in 0 being treated just like any other millisecond request,
while the current code treats it as an optimized case. Do the same in
the new code. Most of the code change is tabbing due to the inserted if.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 fs/select.c |   41 +++++++++++++++++++++++++----------------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff -urpN 2.6.14-rc2-mm1/fs/select.c 2.6.14-rc2-mm1-dev/fs/select.c
--- 2.6.14-rc2-mm1/fs/select.c	2005-09-23 11:52:36.000000000 -0700
+++ 2.6.14-rc2-mm1-dev/fs/select.c	2005-09-23 12:04:03.000000000 -0700
@@ -485,26 +485,35 @@ asmlinkage long sys_poll(struct pollfd _
 	if (nfds > max_fdset && nfds > OPEN_MAX)
 		return -EINVAL;
 
-	/*
-	 * We compare HZ with 1000 to work out which side of the
-	 * expression needs conversion.  Because we want to avoid
-	 * converting any value to a numerically higher value, which
-	 * could overflow.
-	 */
+	if (timeout_msecs) {
+		/*
+		 * We compare HZ with 1000 to work out which side of the
+		 * expression needs conversion.  Because we want to
+		 * avoid converting any value to a numerically higher
+		 * value, which could overflow.
+		 */
 #if HZ > 1000
-	overflow = timeout_msecs >= jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
+		overflow = timeout_msecs >=
+				jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
 #else
-	overflow = msecs_to_jiffies(timeout_msecs) >= MAX_SCHEDULE_TIMEOUT;
+		overflow = msecs_to_jiffies(timeout_msecs) >=
+				MAX_SCHEDULE_TIMEOUT;
 #endif
 
-	/*
-	 * If we would overflow in the conversion or a negative timeout
-	 * is requested, sleep indefinitely.
-	 */
-	if (overflow || timeout_msecs < 0)
-		timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
-	else
-		timeout_jiffies = msecs_to_jiffies(timeout_msecs) + 1;
+		/*
+		 * If we would overflow in the conversion or a negative
+		 * timeout is requested, sleep indefinitely.
+		 */
+		if (overflow || timeout_msecs < 0)
+			timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
+		else
+			timeout_jiffies = msecs_to_jiffies(timeout_msecs) + 1;
+	} else {
+		/*
+		 * 0 millisecond requests become 0 jiffy requests
+		 */
+		timeout_jiffies = 0;
+	}
 
 	poll_initwait(&table);
 
