Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbTIHSUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTIHSUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:20:48 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45455 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263442AbTIHSUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:20:45 -0400
Date: Mon, 8 Sep 2003 19:20:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Make futex waiters take an mm or inode reference
Message-ID: <20030908182021.GD27097@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> But why not solve the problem by just holding an mm reference, too?

Rusty also wrote:
> Why not make the code a *whole* lot more readable (and only marginally
> slower, if at all) by doing it in two passes: pull them off onto a
> (on-stack) list in one pass, then requeue them all in another.

This patch makes each futex waiter hold a reference to the mm or inode
that a futex is keyed on.

This is very important, because otherwise a malicious or erroneous
program can use FUTEX_FD to create futexes on mms or inodes which are
recycled, and steal wakeups from other, unrelated programs.

It isn't entirely trivial, because we can't call mmdrop() or iput()
while holding the spinlock, I think.  (Does someone know to the
contrary?)  Rusty, you will be glad to see that I have reimplemented
futex_requeue() exactly as you suggest: in two passes.

Ulrich will be glad to hear tst-cond2 runs just fine :)

Linus, please apply unless there are objections.

Thanks,
-- Jamie
