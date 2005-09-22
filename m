Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVIVVit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVIVVit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVIVVit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:38:49 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:18010 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751201AbVIVVis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:38:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qWxnaPH74MoyfnSYDrewjY8YdTZcXfyBRRyHyYj/r95omMpiQusGQBdeoeg3JPf9AVUYQm87zOsKtGJSDhiipIkZXZq5A/Am9hNxRO4Y7ZjGXZzuVbwmowskUr3AchB3Q7oW9DBmKmcS5D8QSD9AsuP2UFrEjVEO+y/C+2xN6CM=
Date: Fri, 23 Sep 2005 01:49:26 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>, Nishanth Aravamudan <nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tty update speed regression (was: 2.6.14-rc2-mm1)
Message-ID: <20050922214926.GA6524@mipter.zuzino.mipt.ru>
References: <20050921222839.76c53ba1.akpm@osdl.org> <20050922195029.GA6426@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922195029.GA6426@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 11:50:29PM +0400, Alexey Dobriyan wrote:
> I see regression in tty update speed with ADOM (ncurses based
> roguelike) [1].
> 
> Messages at the top ("goblin hits you") are printed slowly. An eye can
> notice letter after letter printing.
> 
> 2.6.14-rc2 is OK.
> 
> I'll try to revert tty-layer-buffering-revamp*.patch pieces and see if
> it'll change something.
> 
> [1] http://adom.de/adom/download/linux/adom-111-elf.tar.gz (binary only)

Scratch TTY revamp, the sucker is
fix-sys_poll-large-timeout-handling.patch

HZ=250 here.
------------------------------------------------------------------------
From: Nishanth Aravamudan <nacc@us.ibm.com>

The @timeout parameter to sys_poll() is in milliseconds but we compare it
to (MAX_SCHEDULE_TIMEOUT / HZ), which is (jiffies/jiffies-per-sec) or
seconds.  That seems blatantly broken.  This led to improper overflow
checking for @timeout.  As Andrew Morton pointed out, the best fix is to to
check for potential overflow first, then either select an indefinite value
or convert @timeout.

To achieve this and clean-up the code, change the prototype of the sys_poll
to make it clear that the parameter is in milliseconds and introduce a
variable, timeout_jiffies to hold the corresonding jiffies value.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/select.c              |   36 ++++++++++++++++++++++++++----------
 include/linux/syscalls.h |    2 +-
 2 files changed, 27 insertions(+), 11 deletions(-)

diff -puN fs/select.c~fix-sys_poll-large-timeout-handling fs/select.c
--- devel/fs/select.c~fix-sys_poll-large-timeout-handling	2005-09-10 02:35:19.000000000 -0700
+++ devel-akpm/fs/select.c	2005-09-10 03:26:17.000000000 -0700
@@ -464,15 +464,18 @@ static int do_poll(unsigned int nfds,  s
 	return count;
 }
 
-asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
+asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
+				long timeout_msecs)
 {
 	struct poll_wqueues table;
- 	int fdcount, err;
+	int fdcount, err;
+	int overflow;
  	unsigned int i;
 	struct poll_list *head;
  	struct poll_list *walk;
 	struct fdtable *fdt;
 	int max_fdset;
+	unsigned long timeout_jiffies;
 
 	/* Do a sanity check on nfds ... */
 	rcu_read_lock();
@@ -482,13 +485,26 @@ asmlinkage long sys_poll(struct pollfd _
 	if (nfds > max_fdset && nfds > OPEN_MAX)
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
 
@@ -519,7 +535,7 @@ asmlinkage long sys_poll(struct pollfd _
 		}
 		i -= pp->len;
 	}
-	fdcount = do_poll(nfds, head, &table, timeout);
+	fdcount = do_poll(nfds, head, &table, timeout_jiffies);
 
 	/* OK, now copy the revents fields back to user space. */
 	walk = head;
diff -puN include/linux/syscalls.h~fix-sys_poll-large-timeout-handling include/linux/syscalls.h
--- devel/include/linux/syscalls.h~fix-sys_poll-large-timeout-handling	2005-09-10 02:35:19.000000000 -0700
+++ devel-akpm/include/linux/syscalls.h	2005-09-10 02:35:19.000000000 -0700
@@ -420,7 +420,7 @@ asmlinkage long sys_socketpair(int, int,
 asmlinkage long sys_socketcall(int call, unsigned long __user *args);
 asmlinkage long sys_listen(int, int);
 asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
-				long timeout);
+				long timeout_msecs);
 asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 			fd_set __user *exp, struct timeval __user *tvp);
 asmlinkage long sys_epoll_create(int size);
_

