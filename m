Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUJVWJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUJVWJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUJVWGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:06:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34974 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268113AbUJVWDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:03:32 -0400
Date: Fri, 22 Oct 2004 15:03:20 -0700
Message-Id: <200410222203.i9MM3KJG005761@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: joe.korty@ccur.com
X-Fcc: ~/Mail/linus
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] posix timers using == instead of & for bitmask tests
In-Reply-To: Joe Korty's message of  Friday, 22 October 2004 10:39:53 -0400 <20041022143953.GA17881@tsunami.ccur.com>
X-Shopping-List: (1) Despondent scrupulous ski rendezvous
   (2) Prenatal Abrasion string-art
   (3) Compliant combustion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Make posix-timers do a get_task_struct / put_task_struct if either
> SIGEV_SIGNAL or SIGEV_THREAD_ID is set.  Currently the get/put is done
> only if both are set.

What is the purpose of this change?  The `good_sigevent' check ensures that
if SIGEV_THREAD_ID is set, then the value is exactly
SIGEV_SIGNAL|SIGEV_THREAD_ID.  In fact, this change has no effect at all
because SIGEV_SIGNAL is zero.  If it weren't, it would have an undesireable
effect of doing the task_struct refcounting all the time instead of only
for SIGEV_THREAD_ID.  That refcounting is never required in the plain
SIGEV_SIGNAL case, because the task_struct pointer stored in the
group_leader, and that is never freed before all the posix-timers data
structures get cleared out anyway (exit_itimers).  It's only required for
SIGEV_THREAD_ID, where the target thread might have died before the timer
was next examined.


Thanks,
Roland

