Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbWAMLlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWAMLlh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 06:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbWAMLlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 06:41:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932701AbWAMLlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 06:41:36 -0500
Date: Fri, 13 Jan 2006 03:40:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PATCH] [1/6] Add pselect/ppoll system call implementation
Message-Id: <20060113034058.066a2a8b.akpm@osdl.org>
In-Reply-To: <1136924299.3435.103.camel@localhost.localdomain>
References: <1136923488.3435.78.camel@localhost.localdomain>
	<1136924299.3435.103.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> This patch adds the pselect() and ppoll() system calls, providing core
>  routines usable by the original select() and poll() system calls and
>  also the new calls (with their semantics w.r.t timeouts).

This patch sends python into a busywait:

root      2041 98.6  0.4  11192  4656 ?        R    02:36   5:29 python ./hpssd.py

strace says:

select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)
select(6, [4 5], [], [], {0, 500000})   = 0 (Timeout)


The below fixes it.

A few slipups here, so please can you re-review the code that lands in next
-mm, make sure we got everything?


--- devel/fs/select.c~add-pselect-ppoll-system-call-implementation-fix	2006-01-13 03:24:53.000000000 -0800
+++ devel-akpm/fs/select.c	2006-01-13 03:30:27.000000000 -0800
@@ -390,7 +390,7 @@ asmlinkage long sys_select(int n, fd_set
 		if ((u64)tv.tv_sec >= (u64)MAX_INT64_SECONDS)
 			timeout = -1;	/* infinite */
 		else {
-			timeout = ROUND_UP(tv.tv_sec, 1000000/HZ);
+			timeout = ROUND_UP(tv.tv_usec, USEC_PER_SEC/HZ);
 			timeout += tv.tv_sec * HZ;
 		}
 	}
@@ -441,7 +441,7 @@ asmlinkage long sys_pselect7(int n, fd_s
 		if ((u64)ts.tv_sec >= (u64)MAX_INT64_SECONDS)
 			timeout = -1;	/* infinite */
 		else {
-			timeout = ROUND_UP(ts.tv_sec, 1000000000/HZ);
+			timeout = ROUND_UP(ts.tv_nsec, NSEC_PER_SEC/HZ);
 			timeout += ts.tv_sec * HZ;
 		}
 	}
@@ -723,7 +723,7 @@ asmlinkage long sys_ppoll(struct pollfd 
 		if ((u64)ts.tv_sec >= (u64)MAX_INT64_SECONDS)
 			timeout = -1;	/* infinite */
 		else {
-			timeout = ROUND_UP(ts.tv_sec, 1000000000/HZ);
+			timeout = ROUND_UP(ts.tv_nsec, NSEC_PER_SEC/HZ);
 			timeout += ts.tv_sec * HZ;
 		}
 	}
_

