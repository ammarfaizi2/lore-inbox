Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265311AbUFDBVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUFDBVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 21:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUFDBVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 21:21:21 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:8332 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S265311AbUFDBVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 21:21:19 -0400
Date: Thu, 3 Jun 2004 18:21:16 -0700
Message-Id: <200406040121.i541LGAI012332@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix signal race during process exit
X-Windows: the joke that kills.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a reproducer case around so we can test fixes for this problem?

It seems to me that signals sent to an already dying task might as well
just be discarded anyway.  All they ever do now (except for trip bugs) is
change what pending signals you see in the /proc/pid/status entry for a
zombie.  What's wrong with this:

Index: linux-2.6/kernel/signal.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/signal.c,v
retrieving revision 1.120
diff -u -b -p -r1.120 signal.c
--- linux-2.6/kernel/signal.c 10 May 2004 20:28:20 -0000 1.120
+++ linux-2.6/kernel/signal.c 4 Jun 2004 01:16:31 -0000
@@ -161,6 +161,9 @@ static int sig_ignored(struct task_struc
 {
 	void * handler;
 
+	if (t->flags & PF_DEAD)
+		return 1;
+
 	/*
 	 * Tracers always want to know about signals..
 	 */



Thanks,
Roland
