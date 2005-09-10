Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVIJCXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVIJCXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 22:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbVIJCXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 22:23:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62150 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932170AbVIJCXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 22:23:42 -0400
Date: Fri, 9 Sep 2005 19:23:30 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, bunk@stusta.de, johnstul@us.ibm.com,
       drepper@redhat.com, Franz.Fischer@goyellow.de,
       linux-kernel@vger.kernel.org
Subject: [UPDATE PATCH][Bug 5132] fix sys_poll() large timeout handling
Message-ID: <20050910022330.GD24225@us.ibm.com>
References: <20050831200109.GB3017@us.ibm.com> <20050906212514.GB3038@us.ibm.com> <20050910003525.GC24225@us.ibm.com> <20050909181658.221eb6f9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909181658.221eb6f9.akpm@osdl.org>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.2005 [18:16:58 -0700], Andrew Morton wrote:
> Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> >
> > Description: The current sys_poll() implementation does not seem to
> >  handle large timeouts correctly. Any value in milliseconds (@timeout)
> >  which exceeds the maximum representable jiffy value
> >  (MAX_SCHEDULE_TIMEOUT) should result in a MAX_SCHEDULE_TIMEOUT
> >  schedule_timeout() request. To achieve this, convert @timeout to jiffies
> >  first, then compare to MAX_SCHEDULE_TIMEOUT.
> 
> The above doesn't describe the bug very well.

Yes, sorry, in the e-mail I sent with the updated patch, the beginning
description had more detailed information. I meant to also change this
to an RFC, as no one is commenting on just the patch :) Fixed in the
description below. And I guess now that I have your attention I don't
need to bother changing the subject *again*...

> >  Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > 
> >  ---
> > 
> >   fs/select.c |   17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> >  diff -urpN 2.6.13/fs/select.c 2.6.13-dev/fs/select.c
> >  --- 2.6.13/fs/select.c	2005-08-28 17:46:14.000000000 -0700
> >  +++ 2.6.13-dev/fs/select.c	2005-09-09 17:22:30.000000000 -0700
> >  @@ -469,13 +469,16 @@ asmlinkage long sys_poll(struct pollfd _
> >   	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
> >   		return -EINVAL;
> >   
> >  -	if (timeout) {
> >  -		/* Careful about overflow in the intermediate values */
> >  -		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
> 
> This is the problem to which you're referring, yes?
> 
> We're comparing milliseconds with jiffies/HZ, yes?

Yes, exactly.

> >  -			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
> >  -		else /* Negative or overflow */
> >  -			timeout = MAX_SCHEDULE_TIMEOUT;
> >  -	}
> >  +	if (timeout > 0)
> >  +		/*
> >  +		 * Convert the value from msecs to jiffies - if overflow
> >  +		 * occurs we get a negative value, which gets handled by
> >  +		 * the next block
> >  +		 */
> >  +		timeout = msecs_to_jiffies(timeout) + 1;
> >  +	if (timeout < 0) /* Negative requests result in infinite timeouts */
> >  +		timeout = MAX_SCHEDULE_TIMEOUT;
> >  +	/* 0 case falls through */
> 
> I don't particularly like the idea of relying on msecs_to_jiffies(too much)
> returning a negative value.

I agree with your changes. Does the patch below reflect what you wanted?
I used >=, though, as we want to still +1 to the request, so that we
don't return early.

> Why can't we do
> 
> 	int too_much;
> 
> 	/*
> 	 * We compare HZ with 1000 to work out which side of the expression
> 	 * needs conversion.  Because we want to avoid converting any value
> 	 * to a numerically higher value, which could overflow.
> 	 */
> #if HZ > 1000
> 	too_much = timeout > jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
> #else
> 	too_much = msecs_to_jiffies(timeout) > MAX_SCHEDULE_TIMEOUT;
> #endif
> 
> 	if (too_much)
> 		timeout = MAX_SCHEDULE_TIMEOUT;
> 
> And while we're there, let's stop using the same variable for two different
> units - it's horrid.  How about we nuke `timeout' and create timeout_msecs
> and timeout_jiffies to show what units they're in?

Done as well.

Description: The @timeout parameter to sys_poll() is in milliseconds but
we compare it to (MAX_SCHEDULE_TIMEOUT / HZ), which is
(jiffies/jiffies-per-sec) or seconds. That seems blatantly broken.  This
led to improper overflow checking for @timeout. As Andrew Morton pointed
out, the best fix is to to check for potential overflow first, then
either select an indefinite value or convert @timeout.

To achieve this and clean-up the code, change the prototype of the
sys_poll to make it clear that the parameter is in milliseconds and
introduce a variable, timeout_jiffies to hold the corresonding jiffies
value.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 fs/select.c              |   33 ++++++++++++++++++++++++---------
 include/linux/syscalls.h |    2 +-
 2 files changed, 25 insertions(+), 10 deletions(-)

diff -urpN 2.6.13/fs/select.c 2.6.13-dev/fs/select.c
--- 2.6.13/fs/select.c	2005-08-28 17:46:14.000000000 -0700
+++ 2.6.13-dev/fs/select.c	2005-09-09 19:20:53.000000000 -0700
@@ -457,25 +457,40 @@ static int do_poll(unsigned int nfds,  s
 	return count;
 }
 
-asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
+asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds,
+							long timeout_msecs)
 {
 	struct poll_wqueues table;
- 	int fdcount, err;
+ 	int fdcount, err, overflow;
  	unsigned int i;
 	struct poll_list *head;
  	struct poll_list *walk;
+	unsigned long timeout_jiffies;
 
 	/* Do a sanity check on nfds ... */
 	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
 		return -EINVAL;
 
-	if (timeout) {
-		/* Careful about overflow in the intermediate values */
-		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
-			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
-		else /* Negative or overflow */
-			timeout = MAX_SCHEDULE_TIMEOUT;
-	}
+	/*
+	 * We compare HZ with 1000 to work out which side of the
+	 * expression needs conversion.  Because we want to avoid
+	 * converting any value to a numerically higher value, which
+	 * could overflow.
+	 */
+#if HZ > 1000
+	overflow = timeout_msecs >= jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
+#else
+	overflow = msecs_to_jiffies(timeout_msecs) >= MAX_SCHEDULE_TIMEOUT;
+#endif
+
+	/*
+	 * If we would overflow in the conversion or a negative timeout
+	 * is requested, sleep indefinitely.
+	 */
+	if (overflow || timeout_msecs < 0)
+		timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
+	else
+		timeout_jiffies = msecs_to_jiffies(timeout_msecs) + 1;
 
 	poll_initwait(&table);
 
diff -urpN 2.6.13/include/linux/syscalls.h 2.6.13-dev/include/linux/syscalls.h
--- 2.6.13/include/linux/syscalls.h	2005-08-28 17:46:36.000000000 -0700
+++ 2.6.13-dev/include/linux/syscalls.h	2005-09-09 19:05:34.000000000 -0700
@@ -420,7 +420,7 @@ asmlinkage long sys_socketpair(int, int,
 asmlinkage long sys_socketcall(int call, unsigned long __user *args);
 asmlinkage long sys_listen(int, int);
 asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
-				long timeout);
+				long timeout_msecs);
 asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 			fd_set __user *exp, struct timeval __user *tvp);
 asmlinkage long sys_epoll_create(int size);
