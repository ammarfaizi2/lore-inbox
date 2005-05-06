Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVEFJrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVEFJrt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 05:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVEFJrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 05:47:49 -0400
Received: from ns.itc.it ([217.77.80.3]:36575 "EHLO mail.itc.it")
	by vger.kernel.org with ESMTP id S261193AbVEFJrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 05:47:45 -0400
Date: Fri, 6 May 2005 11:50:23 +0200
From: Fabio Brugnara <brugnara@itc.it>
To: linux-kernel@vger.kernel.org
Subject: problem with mmap over nfs
Message-ID: <20050506095023.GS9742@maestoso.itc.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I hope I will be able to find some advice for solving a problem I
observed from going to linux 2.4 to linux 2.6. I'm not a kernel expert, and
was not able to get help from those I know. I tried to search the archives
for something related, but was also unsuccessful. So I try here hoping that
someone will have the patience to read the message and maybe give some
help.

	If anyone answers, please post also the message in CC directly to
me, as I'm not subscribed to the list (it doesn't make much sense at my
level of expertise).

	The problem is related to the use of memory mapped files over a nfs
mounted filesystem. In a rather complex system (speech recognition) that we
developed and use, we need to share large read-only data structures between
different processes, also on several machines. Until a few months ago, we
observed that it was perfectly adequate to just mmap() a file residing on a
particular disk, that machines other as the owner mounted via nfs. This was
very convenient, as we had only a single physical copy of the data
structure, and it did not introduce any significant performance penalty. We
have used this method for years.
	Now, after the machines have been upgraded to kernel 2.6.10 from
kernel 2.4.20, something disappointing happens. Everything still works
correctly, but somehow it introduces a massive slowdown of the machines.
While the processes are running, the machines that map the shared file via
nfs (not the one that owns it) report (with "top") a very high usage of
system time (e.g. 50% or more), and also become very unresponsive at the
shell prompt.
	Another strange thing that can be seen is that in this situation
the "top" process itself, that normally reports something like 0.3% CPU
time), starts using percentages of 30% CPU time or more.
	Beside observing the behavior with "top", we also measure the time
processes take in the program itself, using the "times()" primitive at
the end of the processing. A typical short run of the system on the old
kernel reported numbers such as:

Times: user: 1125.50, system: 6.28

that is, with a proportion always much lower that 1% between system time
and user time. Now, we see things like:

Times: user: 660.29, system: 326.64

i.e., a proportion of 50% between the two (Absolute values cannot
be compared, as the hardware is different).
Typically we run two of these processes on each machine, which
are 2-CPU SMP Xeon systems with 2 or 4 Gb of memory.

	Notice that, if we take care to copy the shared file on local
disks on each machine, and perform the mmap() on the local copy for each
of them, the problem disappears, i.e. the machine do not become overloaded,
and all timings are perfectly reasonable as before. So it's not a problem
of mmap() in itself, but something that comes from the combination of
mmap() and nfs, and maybe sychronization in the access of shared pages
on an SMP system.
	I'm aware that I should present some simple program that triggers
the misbehavior, but unfortunately I was not able to reproduce the problem
in a simple context. The system in question is rather complex,
computationally expensive and makes an intensive use both of these static
shared structures, and of large amounts of dynamically allocated memory
(process size is typically of several hundreds Mb, and CPU usage as high
as possible).

If all this story flashes some lamp in the knowledgeable heads that
populate this list, please let me know

best regards,
thank you for your patience
Fabio
