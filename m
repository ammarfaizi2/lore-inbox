Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289018AbSBMWjD>; Wed, 13 Feb 2002 17:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289026AbSBMWiz>; Wed, 13 Feb 2002 17:38:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54279 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289018AbSBMWil>; Wed, 13 Feb 2002 17:38:41 -0500
Date: Wed, 13 Feb 2002 17:37:42 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RFC: one solution to sys_sync livelock fix
Message-ID: <Pine.LNX.3.96.1020213172509.12448G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We haven't discussed what current sync does on a busy system. The process
gets half way through a system call and hangs. What happens when more
processes do that, say at the end of every client run? Will the kernel get
clogged with dozens of threads or process queues? Will processes in the
middle of a system call be swapable?

Proposed solution:

What would happen if the sync(2) call from a non-root user were treated as
if it were an fsync(2) call on every file open for write?
- it would protect the data from that process
- it would NOT burden the system with updating data for every other
  process

For root I think the behaviour should be to write all existing dirty
buffers as a single pass, which eliminates the possible hang.

I think the shutdown issue is hypothetical, shutdown supposedly killed all
other processes which could be writing, one pass would do as well as wait
forever, and if a kill -9 doesn't stop the process doing the writing,
nothing will. The problem is not so much shutdown hanging as root doing
something as simple as 'df' and hanging for a very long time, on a busy
mail server I would bet money on days between occurences of no dirty
buffers. I could find no other UNIX variant which does hang on sync in
actual fact.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

