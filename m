Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbUKGMDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbUKGMDd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 07:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUKGMDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 07:03:33 -0500
Received: from a4.complang.tuwien.ac.at ([128.130.173.65]:23999 "EHLO
	a4.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261583AbUKGMDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 07:03:30 -0500
X-mailer: xrn 9.03-beta-14
From: anton@mips.complang.tuwien.ac.at (Anton Ertl)
Subject: memory overcommit (was: [PATCH] Remove OOM killer ...)
To: Marko Macek <marko.macek@gmx.net>
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: linux.kernel
In-reply-to: <418DEA55.2080202@gmx.net>
Date: Sun, 07 Nov 2004 11:34:02 GMT
Message-ID: <2004Nov7.123402@mips.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marko Macek <marko.macek@gmx.net> writes:
>Andries Brouwer wrote:
>
>> I have always been surprised that so few people investigated
>> doing things right, that is, entirely without OOM killer.

I.e., without overcommitment.  That's not necessarily the right thing
for all processes, because many programs are not written in a way to
do useful things when a memory allocation or other system call fails.
For these programs it's better to let the allocation succeed, let it
use all the unused (but possibly commited) memory and swap space in
the system, and kill the process if the system runs out of memory
later.

In a recent posting <2004Oct9.085407@mips.complang.tuwien.ac.at> in
c.o.l.d.s, I proposed separating the processes in two classes:

- a no-overcommit class for which memory commitment is accounted.  It
may get ENOMEM on allocation, when the system runs out of commitable
memory, and processes in this class are never OOM killed.

- an overcommiting class for which memory commitment is not accounted.
It normally does not get ENOMEM on allocation, but if the system runs
out of memory (virtual memory, not commitable memory), processes from
this class are OOM-killed.  Note that these processes can use memory
that has been commited to, but has not been used by no-overcommit
class processes.

Ideally, all the important applications would be able to handle failed
allocations gracefully, and would be marked as no-overcommit, and thus
would be safe from the OOM killer.

And all the other applications would often continue running long after
they would have crashed or become otherwise useless from ENOMEM on a
pure no-overcommitment system.

>> This is not in a state such that I would like to submit it,
>> but I think it would be good to focus some energy into
>> offering a Linux that is guaranteed free of OOM surprises.
>
>A good thing would be to make the OOM killer only kill
>processes that actually overcommit (independant of overcommit mode).

What does that mean?  Overcommitment is normally a thing that all
processes do together (each one usually asks for less than the total
virtual memory).  In my proposal it means that the process would be
marked as overcommiting or not through something like "nice", maybe
with a default coming from a flag in the executable.

- anton
-- 
M. Anton Ertl                    Some things have to be seen to be believed
anton@mips.complang.tuwien.ac.at Most things have to be believed to be seen
http://www.complang.tuwien.ac.at/anton/home.html
