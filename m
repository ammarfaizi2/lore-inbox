Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbULHAzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbULHAzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 19:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbULHAzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 19:55:50 -0500
Received: from wbar4.sea1-4-5-123-194.sea1.dsl-verizon.net ([4.5.123.194]:477
	"EHLO sr71.net") by vger.kernel.org with ESMTP id S261977AbULHAzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 19:55:40 -0500
Subject: oops in proc_pid_stat() on task->real_parent?
From: Dave Hansen <dave@sr71.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1102467332.19465.197.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Dec 2004 16:55:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this OOPS while running a relatively intensive PostgreSQL load on
my dual-CPU PIII with 2.6.9, while simultaneously running top.  Sorry,
no serial console, but I do have a screenshot:

	http://sprucegoose.sr71.net/~dave/oops/dsc02631.jpg

$ addr2line -e vmlinux-2.6.9 c017920e
/home/dave/blackbird/fs/proc/array.c:359

>From the disassembly:

  c01791f7:       e8 d0 2b 15 00          call   c02cbdcc <_read_lock>
  c01791fc:       83 c4 08                add    $0x8,%esp
  c01791ff:       83 be a4 00 00 00 00    cmpl   $0x0,0xa4(%esi)
  c0179206:       74 18                   je     c0179220 <proc_pid_stat+0x20c>
  c0179208:       8b 86 ac 00 00 00       mov    0xac(%esi),%eax
->c017920e:       8b 80 a4 00 00 00       mov    0xa4(%eax),%eax
  c0179214:       89 44 24 48             mov    %eax,0x48(%esp)
  c0179218:       eb 0e                   jmp    c0179228 <proc_pid_stat+0x214>
  c017921a:       8d b6 00 00 00 00       lea    0x0(%esi),%esi

cmpl   $0x0,0xa4(%esi)                # check task->pid
je     c0179220 <proc_pid_stat+0x20c> 
mov    0xac(%esi),%eax                # load task->real_parent
mov    0xa4(%eax),%eax                # load real_parent->pid
mov    %eax,0x48(%esp)                # store into ppid

It sure looks like the culprit is the dereference of real_parent.

        read_lock(&tasklist_lock);
        ppid = task->pid ? task->real_parent->pid : 0;
        read_unlock(&tasklist_lock);

Since I have DEBUG_PAGEALLOC turned on, I have the feeling that,
although eax is an apparently valid address (d1a0ea90), that particular
address was actually unmapped because the task had been freed at the
time.  Is there a reference that needs to be taken on ->real_parent
somewhere?

Anyway, this was with 2.6.9, and I've been so far unable to reproduce it
on the same kernel.  Although I'm not running current -bk, it looks like
there's been some churn in the same area since 2.6.9, so maybe it was
fixed.  

Thought I'd report it, just in case someone else sees the same thing.

-- Dave

