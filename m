Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269764AbSISPGn>; Thu, 19 Sep 2002 11:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269977AbSISPGn>; Thu, 19 Sep 2002 11:06:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34066 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269764AbSISPGm>; Thu, 19 Sep 2002 11:06:42 -0400
Date: Thu, 19 Sep 2002 08:12:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
In-Reply-To: <20020919105940.GJ28202@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209190809020.3759-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Sep 2002, William Lee Irwin III wrote:
> 
> I did this intentionally. Basically, sys_setsid() does the right thing,
> but tty_ioctl() does not. There is already some inconsistency
> about how task->tty is locked, and I'd not yet come to a conclusion.

I agree about the locking issue (although I do _not_ believe that the
tasklock should have anything to do with the tsk->tty locking - it should
most likely use some per-task lock for the actual tty accesses, together
with the optimization that a write lock on the tasklock is sufficient to
protect it because it means that nobody else can look up the task).

However, what I worry about is that there may not (will not) be a 1:1
session<->tty thing. In particular, when somebody creates a new session 
with "setsid()", that does not remove the tty from processes that used to 
hold it, I think (this is all from memory, so I might be wrong).

Which means that if the tty is going away, it has to be removed from _all_ 
tasks, not just from the one session that happened to be the most recent 
one.

		Linus

