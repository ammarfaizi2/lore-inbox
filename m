Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269183AbUIYBlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269183AbUIYBlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUIYBlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:41:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21738 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269183AbUIYBj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:39:29 -0400
Date: Fri, 24 Sep 2004 18:39:15 -0700
Message-Id: <200409250139.i8P1dFxg008226@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix PTRACE_ATTACH race with real parent's wait calls
In-Reply-To: Roland McGrath's message of  Friday, 24 September 2004 17:51:24 -0700 <200409250051.i8P0pO5v007053@magilla.sf.frob.com>
X-Fcc: ~/Mail/linus
X-Zippy-Says: I'm in ATLANTIC CITY riding in a comfortable ROLLING CHAIR...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've thought of one additional race associated with this.  If the real
parent bogusly tried a ptrace (rather than a wait) in that same interval,
it could pass the ptrace_check_attach test and then a moment later not
actually be that task's ->parent any more, which might break all sorts of
stuff and hit BUGs or who knows what.

This further patch should rule out that bogus ptrace call.

Thanks,
Roland


Index: linux-2.6/kernel/ptrace.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/ptrace.c,v
retrieving revision 1.36
diff -u -b -B -p -r1.36 ptrace.c
--- linux-2.6/kernel/ptrace.c 23 Sep 2004 23:35:16 -0000 1.36
+++ linux-2.6/kernel/ptrace.c 25 Sep 2004 01:35:02 -0000
@@ -82,7 +82,8 @@ int ptrace_check_attach(struct task_stru
 	 */
 	read_lock(&tasklist_lock);
 	if ((child->ptrace & PT_PTRACED) && child->parent == current &&
-	    child->signal != NULL) {
+	    (!(child->ptrace & PT_ATTACHED) || child->real_parent != current)
+	    && child->signal != NULL) {
 		ret = 0;
 		spin_lock_irq(&child->sighand->siglock);
 		if (child->state == TASK_STOPPED) {

