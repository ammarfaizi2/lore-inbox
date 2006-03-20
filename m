Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWCTSBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWCTSBs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWCTSBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:01:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57510 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751191AbWCTSBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:01:47 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simplify/fix first_tid()
References: <441DB045.87C4134C@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 20 Mar 2006 11:00:59 -0700
In-Reply-To: <441DB045.87C4134C@tv-sign.ru> (Oleg Nesterov's message of
 "Sun, 19 Mar 2006 22:25:57 +0300")
Message-ID: <m1fyldvvvo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> first_tid:
>
> 	/* If nr exceeds the number of threads there is nothing todo */
> 	if (nr) {
> 		if (nr >= get_nr_threads(leader))
> 			goto done;
> 	}
>
> This is not reliable: sub-threads can exit after this check, so the
> 'for' loop below can overlap and proc_task_readdir() can return an
> already filldir'ed dirents.
>
> 	for (; pos && pid_alive(pos); pos = next_thread(pos)) {
> 		if (--nr > 0)
> 			continue;
>
> Off-by-one error, will return 'leader' when nr == 1.
>
> This patch tries to fix these problems and simplify the code.

This is better however if I read this code correctly.  It modifies
the code so the last time user space goes trough this loop
with nr > nr_threads.  Then we will walk the entire threads
list to achieve nothing.

So we really still need the nr_threads test in there so we don't
traverse the list twice everytime through readdir.

Eric
