Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUCZWiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUCZWiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:38:11 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:49589 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261366AbUCZWiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:38:06 -0500
To: linux-kernel@vger.kernel.org
Subject: Scheduling proposal
From: David Kastrup <dak@gnu.org>
Date: 26 Mar 2004 23:38:04 +0100
Message-ID: <x5lllndyk3.fsf@lola.goethe.zz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


During some 2.5.x phase I already had explained the details of a
scheduler problem on single CPU machines, exhibited for example by
running the command

hexdump -v /dev/zero|dd obs=1

inside of an xterm: as soon as dd writes one byte into the pipe, xterm
gets woken to process that byte, and during that time, the completely
CPU-starved dd will not will the pipe, even though it can do so with
very little CPU usage.  As a result, the pipe will keep merely a fill
level of 1 for long periods, resulting in very inefficient operation
of the pipeline.

It appears that this problem (which will afflict all programs using
up CPU as a terminal emulator or shell or similar) is still prevalent
in Linux-2.6.4 and has a considerable impact.

I'd propose the following fix to it: regardless of the priority of
the reader on a pipe, the scheduler will not preempt the writer on
the pipe before its time slice is over.  This particular priority
treatment will however

a) only be made on the CPU that the writer is running on
b) only be made with regard to the process responsible for the write

In particular, if another process with priority in between the two
processes would preempt the writer, instead the reader is scheduled
in.  If another process writes to the same pipe, the priority
inversion with the original process is canceled as well.

And if the writing processes yields the CPU for any other reason
(including having used up its time slice), the priority inversion is
ended, too.

That would tend to keep pipes filled when this is possible with
reasonable delay.

It is not latency critical: if the writing process has a
significantly lower priority than the reading process, its data would
already be expected to arrive with larger delays, so it can't be part
of a low latency pipeline.  Also, since the priority inversion would
end the moment the CPU is yielded, it would not have any effect for
event-driven scenarios, but only for those where the source of the
data is purely CPU-bound.

This would be useful behavior for pipes, sockets, and pttys.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
