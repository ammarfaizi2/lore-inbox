Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbTFCQCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbTFCQCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:02:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31202 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265078AbTFCQCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:02:10 -0400
Date: Tue, 3 Jun 2003 18:15:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] new sys_tkill2() system call, 2.5.70
In-Reply-To: <Pine.LNX.4.44.0306030856190.2855-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0306031807001.22509-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Jun 2003, Linus Torvalds wrote:

> How about calling it "tgkill()" for "thread" and "group", which are the
> new inputs?

ok, agreed.

> It would also seem a lot cleaner that the "any" value be "-1" (like it
> is for the other kill functions), and it works for both tgid _and_ for
> pid, so that
> 
> 	tgkill(-1, pid, sig) == tkill(pid, sig) == kill thread
> 	tgkill(pid, -1, sig) == kill(pid, sig) == kill group

well, the current sys_tkill implementation does not recognize '-1' at all:

        /* This is only valid for single tasks */
        if (pid <= 0)
                return -EINVAL;

it's a simple path to send signals to a single thread and nothing more.

are you suggesting to extend sys_tgkill() functionality to also detect -1
for the PID, and do a process-signal send? I dont think that's necessary,
because it overlaps the already existing sys_kill() functionality - and
probably it would just end up being an internal call to
kill_something_info() anyway.

if the goal is completeness then < -1 negative pid values should probably
be recognized as 'process group' values as well?

then sys_tgkill would basically be a super-kill(), encompassing all the
kill() semantics we have currently, extended with the group-specific send
functionality.

	Ingo

