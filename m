Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSHBQ5B>; Fri, 2 Aug 2002 12:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSHBQ5B>; Fri, 2 Aug 2002 12:57:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22249 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315427AbSHBQ5A>; Fri, 2 Aug 2002 12:57:00 -0400
Message-ID: <3D4ABA9D.8060307@us.ibm.com>
Date: Fri, 02 Aug 2002 10:00:13 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kasper Dupont <kasperd@daimi.au.dk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Race condition?
References: <3D4A8D45.49226E2B@daimi.au.dk>
Content-Type: multipart/mixed;
 boundary="------------040303030603070001070305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040303030603070001070305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kasper Dupont wrote:
> Is there a race condition in this piece of code from do_fork in
> linux/kernel/fork.c? I cannot see what prevents two processes
> from calling this at the same time and both successfully fork
> even though the user had only one process left.
> 
>         if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur
>                       && !capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
>                 goto bad_fork_free;
> 
>         atomic_inc(&p->user->__count);
>         atomic_inc(&p->user->processes);

I don't see any locking in the call chain leading to this function, so 
I think you're right.  The attached patch fixes this.  It costs an 
extra 2 atomic ops in the failure case, but otherwise just makes the 
processes++ operation earlier.

Patch is against 2.5.27, but applies against 30.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------040303030603070001070305
Content-Type: text/plain;
 name="fork-up-race-2.5.27.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fork-up-race-2.5.27.patch"

--- linux-2.5.27-clean/kernel/fork.c	Sat Jul 20 12:11:07 2002
+++ linux/kernel/fork.c	Fri Aug  2 09:35:17 2002
@@ -628,13 +628,15 @@
 		goto fork_out;
 
 	retval = -EAGAIN;
-	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur) {
-		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
+	atomic_inc(&p->user->processes);
+	if (atomic_read(&p->user->processes) > p->rlim[RLIMIT_NPROC].rlim_cur) {
+		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE)) {
+			atomic_dec(&p->user->processes);
 			goto bad_fork_free;
+		}
 	}
 
 	atomic_inc(&p->user->__count);
-	atomic_inc(&p->user->processes);
 
 	/*
 	 * Counter increases are protected by

--------------040303030603070001070305--

