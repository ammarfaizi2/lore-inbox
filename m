Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbUJ0TuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbUJ0TuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbUJ0Tsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:48:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:62647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262632AbUJ0Tk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:40:58 -0400
Date: Wed, 27 Oct 2004 12:40:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Early call_usermodehelper causes double fault on x86_64
Message-ID: <20041027124055.B2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing a double fault on recent (2.6.10-rc1-bk) kernels during
driver_init().  The upcall to userspace gets far enough to schedule the
work, khelper picks it up, calls kernel_thread, the child thread does
execve, then double faults.  Bootup continues, I get three more double
faults, then the system appears fine (even w/ continued upcalls).

I have an example of the fault below.  It shows a rip and rsp
of 0.  I poked about a bit and see that the FAKE_STACK_FRAME $0 in
arch/x86-64/kernel/entry.S sets up a 0 rip, and if I change the \rip
in that macro call, that's the rip in the double fault.  Any ideas on
further debugging?

thanks,
-chris

double fault: 0000 [1] PREEMPT SMP 
CPU 1 
Modules linked in:
Pid: 9, comm: khelper Tainted: G   M  2.6.10-rc1
RIP: 0010:[<0000000000000000>] [<0000000000000000>]
RSP: 0000:0000000000000000  EFLAGS: 00010202
RAX: 0000000000000000 RBX: 000001007ff09dc8 RCX: 000001007ff0e870
RDX: 000001003fff9e88 RSI: 000001007ff09e58 RDI: ffffffff805b8fe0
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000010037e87120
R13: 0000000000000206 R14: 000001007ff09dc8 R15: ffffffff80149200
FS:  0000000000000000(0000) GS:ffffffff816daa40(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 000000007ff0a000 CR4: 00000000000006e0
Process khelper (pid: 9, threadinfo 000001000258c000, task 000001007ff0e870)
Stack: 0000010037ea8e58 0000000000000000 0000010037ea8f58 0000000000000000 
       0000000000000001 ffffffff80111f78 0000000000000004 0000010037ea8f58 
       0000000000000000 0000000000000000 
Call Trace:<ffffffff80111f78>{show_registers+200} <ffffffff8011222b>{__die+155} 
       <ffffffff801122a6>{die+54} <ffffffff80112bbf>{do_double_fault+175} 
       <ffffffff801118ed>{double_fault+125} <ffffffff80149200>{__call_usermodehelper+0} 
       

Code:  Bad RIP value.
RIP [<0000000000000000>] RSP <0000000000000000>
