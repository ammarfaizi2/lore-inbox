Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbUCJKyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 05:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUCJKyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 05:54:53 -0500
Received: from mail.daysofwonder.com ([209.61.173.130]:65222 "EHLO
	mail.daysofwonder.com") by vger.kernel.org with ESMTP
	id S261999AbUCJKyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 05:54:13 -0500
Subject: PROBLEM: task->tty->driver problem/oops in proc_pid_stat (was Re:
	[2.6.4-rc2] Unable to handle kernel paging request at virtual address
	02000064)
From: Brice Figureau <brice@daysofwonder.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1078823808.23748.88.camel@localhost.localdomain>
References: <1078823808.23748.88.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Days of Wonder
Message-Id: <1078916045.2157.195.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Wed, 10 Mar 2004 11:54:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I've digged a little deeper into the following oops that occurs every
night on my servers (see my previous mail):

On Tue, 2004-03-09 at 10:16, Brice Figureau wrote:
> Mar  9 02:00:06 server2 kernel: Unable to handle kernel paging request at virtual address 02000064
> Mar  9 02:00:06 server2 kernel:  printing eip:
> Mar  9 02:00:06 server2 kernel: c01915bc
> Mar  9 02:00:06 server2 kernel: *pde = 00000000
> Mar  9 02:00:06 server2 kernel: Oops: 0000 [#1]
> Mar  9 02:00:06 server2 kernel: PREEMPT SMP
> Mar  9 02:00:06 server2 kernel: CPU:    2
> Mar  9 02:00:06 server2 kernel: EIP:    0060:[proc_pid_stat+160/1280]    Not tainted
> Mar  9 02:00:06 server2 kernel: EFLAGS: 00010286
> Mar  9 02:00:06 server2 kernel: EIP is at proc_pid_stat+0xa0/0x500
> Mar  9 02:00:06 server2 kernel: eax: 02000000   ebx: f597a000   ecx: c182d548 edx: 00000000
> Mar  9 02:00:06 server2 kernel: esi: f71d77c0   edi: c269ed00   ebp: f46b9f44 esp: f46b9e30
> Mar  9 02:00:06 server2 kernel: ds: 007b   es: 007b   ss: 0068
> Mar  9 02:00:06 server2 kernel: Process ps (pid: 17291, threadinfo=f46b8000 task=c26ac830)
> Mar  9 02:00:06 server2 kernel: Stack: c269ed00 404d1716 0cf254ae c0402bb0 f4f1bc90 c03e6442 f46b9e78 c018f400
> Mar  9 02:00:06 server2 kernel:        f45e4980 f4f1bc90 0000001d c03e643e 00000004 f71d77c0 ffffffea fffffff4
> Mar  9 02:00:06 server2 kernel:        f59f30fc f59f3090 f46b9e9c c016a7b4 f59f3090 f45e4980 c0402b60 f45e4980
> Mar  9 02:00:06 server2 kernel: Call Trace:
> Mar  9 02:00:06 server2 kernel:  [proc_pident_lookup+246/588] proc_pident_lookup +0xf6/0x24c
> Mar  9 02:00:06 server2 kernel:  [real_lookup+199/238] real_lookup+0xc7/0xee
> Mar  9 02:00:06 server2 kernel:  [in_group_p+67/118] in_group_p+0x43/0x76
> Mar  9 02:00:06 server2 kernel:  [buffered_rmqueue+237/404] buffered_rmqueue+0xe d/0x194
> Mar  9 02:00:06 server2 kernel:  [__alloc_pages+151/804] __alloc_pages+0x97/0x32 4
> Mar  9 02:00:06 server2 kernel:  [proc_info_read+83/305] proc_info_read+0x53/0x1 31
> Mar  9 02:00:06 server2 kernel:  [filp_open+93/95] filp_open+0x5d/0x5f
> Mar  9 02:00:06 server2 kernel:  [vfs_read+161/268] vfs_read+0xa1/0x10c
> Mar  9 02:00:06 server2 kernel:  [sys_read+63/93] sys_read+0x3f/0x5d
> Mar  9 02:00:06 server2 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Mar  9 02:00:06 server2 kernel:
> Mar  9 02:00:06 server2 kernel: Code: 8b 48 64 c1 e1 14 0b 48 68 03 4b 08 89 c8 0f b6 d1 81 e1 00
> Mar  9 02:00:06 server2 kernel:  <6>note: ps[17291] exited with preempt_count 1

I found that the problem occurs there:
fs/proc/array.c (proc_pid_stat):

	if (task->tty) {
		tty_pgrp = task->tty->pgrp;
-->		tty_nr = new_encode_dev(tty_devnum(task->tty));
	}

The oops occured on:
	mov    0x64(%eax),%ecx	

eax value was 02000000.
This code is part of the tty_devnum() inline:
static inline dev_t tty_devnum(struct tty_struct *tty)
{
  return MKDEV(tty->driver->major, tty->driver->minor_start) + tty->index;
}

The faulty instruction is the deferencing of task->tty->driver.

As a side effect, the oops occurs while holding a task_lock, that's why
my further ps mauxgww were stuck at some point.

Something interesting: the oops occurs always in a thread (either mysql
or java), not in a principal process (verified by finding the only task
that is locked by doing some cat in /proc/<pid>/task/).

Then I tried to reproduce it exactly and found the following:
1) log in with ssh on the server (this allocates a tty: /dev/pts/0)
2) launch a java application using some threads, the application in
question uses /dev/pts/0 as tty
3) log-out, this releases /dev/pts/0
4) log in again (this session uses /dev/pts/1)
5) run chkrootkit or a 'ps mauxgww' -> the previous oops is reported.

It seems that task->tty for the threads are not properly zeroed when the
corresponding tty is unregistered (parent process is OK, though).

I'll let real kernel hackers find exactly where the problem is (and
possibly a fix)...

I'm not subscribed to the list, so please CC: me on answers.

--
Brice Figureau

