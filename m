Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVCaM7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVCaM7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVCaM7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:59:37 -0500
Received: from [24.24.2.56] ([24.24.2.56]:11179 "EHLO ms-smtp-02.nyroc.rr.com")
	by vger.kernel.org with ESMTP id S261415AbVCaM73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:59:29 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1112272607.3691.225.camel@localhost.localdomain>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
	 <1112212608.3691.147.camel@localhost.localdomain>
	 <1112218750.3691.165.camel@localhost.localdomain>
	 <20050331110330.GA24842@elte.hu>
	 <1112272607.3691.225.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 31 Mar 2005 07:58:51 -0500
Message-Id: <1112273931.3691.233.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 07:36 -0500, Steven Rostedt wrote:
> On Thu, 2005-03-31 at 13:03 +0200, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> 

> Since this happened with the trylock, do you see anyway that a pending
> owner can cause problems?  Maybe this has to do with is_locked. Now a
> pending owner makes this ambiguous. Since the lock has a owner, and a
> task can't get it if it is of lower priority than the pending owner, but
> it can get it if it is higher. Now is it locked?  My implementation was
> to be safe and say that it is locked.
> 
> I'll play around some more with this.

Oops!  Found a little bug. Ingo, see if this fixes it.

-- Steve

--- ./kernel/rt.c.orig	2005-03-31 07:27:59.000000000 -0500
+++ ./kernel/rt.c	2005-03-31 07:53:14.913072893 -0500
@@ -1244,7 +1244,7 @@
 	/*
 	 * Check to see if we didn't have ownership stolen.
 	 */
-	if (ret) {
+	if (!ret) {
 		if (capture_lock(&waiter,task)) {
 			set_task_state(task, TASK_INTERRUPTIBLE);
 			goto wait_again;


