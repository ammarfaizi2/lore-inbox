Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbUKJOZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbUKJOZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbUKJOVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:21:55 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:5008 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261989AbUKJOR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:17:58 -0500
Date: Wed, 10 Nov 2004 20:05:18 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sripathi Kodi <sripathik@in.ibm.com>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] do_wait fix for 2.6.10-rc1
Message-ID: <20041110143518.GC4502@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <418B4E86.4010709@in.ibm.com> <Pine.LNX.4.58.0411051101500.30457@ppc970.osdl.org> <418F826C.2060500@in.ibm.com> <Pine.LNX.4.58.0411080744320.24286@ppc970.osdl.org> <Pine.LNX.4.58.0411080806400.24286@ppc970.osdl.org> <Pine.LNX.4.58.0411080820110.24286@ppc970.osdl.org> <Pine.LNX.4.58.0411081708000.2301@ppc970.osdl.org> <20041109143118.GA8961@in.ibm.com> <Pine.LNX.4.58.0411090745250.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411090745250.2301@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 09, 2004 at 08:11:41AM -0800, Linus Torvalds wrote:
> 
> I think I have a potentially better approach: make the rules for "flag" a 
> bit more explicit, and make it have structure. We use "flag" for two 
> things: we use it to determine if we should return -ECHILD (no children), 
> and for whether we should wait for something that might become available 
> later. So just split up "flag" into these two meanings, instead of just 
> trying to use a single bit:
> 
>  - one bit that says "we found a child that _will_ wake us up when it's 
>    ready". In other words, that's a child that is ours, and is not yet a 
>    zombie.
> 
>  - one bit that says "we found a child that is ours".
> 
> Make "eligible_child()" follow these rules, and then instead of just 
> setting "flag = 1", we'd set "flag |= ret".
> 
> Now, with these rules, we know just what to do: we only do the wait if the 
> "we have children that will wake us up" bit is set. But we return ECHILD 
> only if flag is totally clear.
> 
> Does that sound like it would fix the problem?
> 

How about if we set the flag only in the cases when the exit state is not
either TASK_DEAD or TASK_ZOMBIE. 
Patch attached below. I confirmed that this fixes the problem and I also ran 
some LTP tests

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>
Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>



--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="do_wait.patch"

diff -Naurp linux-2.6.10-rc1.orig/kernel/exit.c linux-2.6.10-rc1/kernel/exit.c
--- linux-2.6.10-rc1.orig/kernel/exit.c	2004-10-23 03:10:06.000000000 +0530
+++ linux-2.6.10-rc1/kernel/exit.c	2004-11-10 17:18:20.818103584 +0530
@@ -1325,14 +1325,15 @@ repeat:
 			ret = eligible_child(pid, options, p);
 			if (!ret)
 				continue;
-			flag = 1;
 
 			switch (p->state) {
 			case TASK_TRACED:
+				flag = 1;
 				if (!my_ptrace_child(p))
 					continue;
 				/*FALLTHROUGH*/
 			case TASK_STOPPED:
+				flag = 1;
 				if (!(options & WUNTRACED) &&
 				    !my_ptrace_child(p))
 					continue;
@@ -1365,6 +1366,7 @@ repeat:
 						goto end;
 					break;
 				}
+				flag = 1;
 check_continued:
 				if (!unlikely(options & WCONTINUED))
 					continue;

--WYTEVAkct0FjGQmd--
