Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbTDXTr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbTDXTr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:47:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:20124 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264402AbTDXTr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:47:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16040.16960.528537.454110@gargle.gargle.HOWL>
Date: Thu, 24 Apr 2003 22:00:00 +0200
From: mikpe@csd.uu.se
To: ak@suse.de
Subject: 2.4.21-rc1 on x86_64 oops at shutdown -h
Cc: linux-kernel@vger.kernel.org
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

2.4.21-rc1 on x86_64 oopses on me at shutdown -h in certain situations.
It's repeatable. Here's the raw oops:

Turning off swap:				[  OK  ]
Unable to handle kernel paging request at virtual address 0000010010000000
 printing rip:
ffffffff801ed7ea
PML4 8063 PGD 9063 PMD 0 
Oops: 0002
CPU 0 
Pid: 0, comm:  Not tainted
RIP: 0010:[<ffffffff801ed7ea>]
RSP: 0018:000001000f99def8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000003fff881fc0
RDX: 0000003ffffffff0 RSI: 0000000000515ff0 RDI: 0000010010000000
RBP: 0000000000515030 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000001000f881000
R13: 000001000f99df40 R14: 0000000000001000 R15: 0000000000514ec0
FS:  00000000005040a0(0000) GS:ffffffff80280f80(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000010010000000 CR3: 0000000000101000 CR4: 00000000000006a0

Call Trace: <1>Unable to handle kernel NULL pointer dereference at virtual addre
ss 0000000000000000
 printing rip:
ffffffff8010de83

The call trace is inaccessible because the stack dumper itself immediately
triggers a new oops (ffffffff8010de83 is show_trace+0x223), resulting in the
second oops repeating rapidly until Simics hangs or gets a triple fault.
I had to ^C Simics and copy-paste the first oops from the Simics Console window.

The RIP of the first oops, ffffffff801ed7ea, is copy_user_generic+0xea.

1. ksymoops-2.4.9 hangs on the raw oops.
2. The kernel is 2.4.21-rc1 with modules, modversions, and kmod enabled.
   ide-cd, cdrom, isofs, and af_packet were loaded at the point of the oops.
   modutils-2.4.22-10 from RedHat rawhide's x86_64 .rpm.
4. Steps to reproduce: boot; find / -type f -print; rpm -qa | sort | diff -u /tmp/old.rpmlist -;
   mount /mnt/cdrom (with no cdrom in cd drive, but it loads the modules); sync;
   shutdown -h now. The oops occurs just after init's "Turning off swap:", at
   the "Halting system..." step (which is probably where copy_user came from).
5. A monolithic kernel doesn't oops.

/Mikael
