Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVBWXM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVBWXM6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVBWXJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:09:57 -0500
Received: from calma.pair.com ([209.68.1.95]:57614 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S261680AbVBWXGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:06:39 -0500
Date: Wed, 23 Feb 2005 18:06:39 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: linux-kernel@vger.kernel.org
Subject: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050223230639.GA33795@calma.pair.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello-

We have hit a defect where an exiting xterm process will hang.  This is running
on a 2-cpu IA-64 box.  We have a multithreaded application, where one thread
is SCHED_FIFO and is running with priority 98, and the other thread is just
a normal SCHED_OTHER thread.  The SCHED_FIFO thread is in a CPU bound tight
loop, but I wouldn't expect that to cause since there are 2 CPUs.  

However, it does seem to cause some problems.  For example, if you ssh into
the system and run an Xterm using X11 forwarding, when you type "exit" in
the xterm window, the window hangs and doesn't close.  Killing the CPU-bound
app causes the window to exit immediately.  The sysrq output shows the 
following:

xterm         D a0000001000bef60     0  2905   2876                     (NOTLB)

Call Trace:
 [<a0000001004ac480>] schedule+0xca0/0x1300
                                sp=e000000012257d20 bsp=e000000012251080
 [<a0000001000bef60>] flush_cpu_workqueue+0x1a0/0x4a0
                                sp=e000000012257d30 bsp=e000000012251020
 [<a0000001000bf360>] flush_workqueue+0x100/0x160
                                sp=e000000012257d90 bsp=e000000012250fe8
 [<a0000001000bfd60>] flush_scheduled_work+0x20/0x40
                                sp=e000000012257d90 bsp=e000000012250fd0
 [<a0000001002e2060>] release_dev+0x8e0/0x1100
                                sp=e000000012257d90 bsp=e000000012250f20
 [<a0000001002e3350>] tty_release+0x30/0x60
                                sp=e000000012257e30 bsp=e000000012250ef8
 [<a00000010012d430>] __fput+0x330/0x340
                                sp=e000000012257e30 bsp=e000000012250ea8
 [<a00000010012d0e0>] fput+0x40/0x60
                                sp=e000000012257e30 bsp=e000000012250e88
 [<a00000010012a1b0>] filp_close+0xd0/0x160
                                sp=e000000012257e30 bsp=e000000012250e58
 [<a00000010012a380>] sys_close+0x140/0x1a0
                                sp=e000000012257e30 bsp=e000000012250dd8
 [<a00000010000aba0>] ia64_ret_from_syscall+0x0/0x20
                                sp=e000000012257e30 bsp=e000000012250dd8

So it would appear that xterm is hung in close() trying to shutdown a tty.
The comment says that is calling flush_scheduled_work() to 
"Wait for ->hangup_work and ->flip.work handlers to terminate".  Perhaps there
is some locking issue that is causing these to not run and complete?

I'm a bit out of my space here... does anybody have any ideas? I've tried 
this on both 2.6.8 and 2.6.10 with the same problem resulting.

Please make sure to CC me in any responses.

Regards,

Chad
