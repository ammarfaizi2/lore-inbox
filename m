Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264876AbUEQAiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264876AbUEQAiU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 20:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264878AbUEQAiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 20:38:19 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:28087 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264876AbUEQAiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 20:38:11 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Mon, 17 May 2004 10:37:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16552.2406.114861.925324@cse.unsw.edu.au>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
Subject: dget BUG from proc_exe_link in 2.6.6-mm2
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is entirely possible that this is a known problem, as I saw a bit
of discussion in linux-kernel about locking and VMAs, but..

I had 2.6.6-mm2 running over the weekend, and some nightly jobs
including  /usr/sbin/dpkg-statoverride
triggered:


        ___      ______
      0--,|    /OOOOOO\
     {_o  /  /OO plop OO\
       \__\_/OO oh dear OOO\s
          \OOOOOOOOOOOOOOOO/
           __XXX__   __XXX__
------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:277!
invalid operand: 0000 [#5]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c0194c97>]    Not tainted VLI
EFLAGS: 00010246   (2.6.6-mm2) 
EIP is at proc_exe_link+0x107/0x150
eax: 00000000   ebx: e7d17dc4   ecx: e2be1f60   edx: ecfa4f58
esi: e7d17de4   edi: de698fc8   ebp: e2be1f60   esp: e2be1f24
ds: 007b   es: 007b   ss: 0068
Process dpkg-statoverri (pid: 26426, threadinfo=e2be1000 task=de698a50)
Stack: c0d8a000 c011505b fffffffe e2be1f5c 00000282 0024c5a3 00000000 ead86e94 
       00000000 00000fff c0195cca ead86e94 ead86e94 bfffec40 40a7ce68 f7fa1720 
       40a7ce68 1de1cfe4 c043dee0 ead86e94 00000fff e2be1f80 c0169187 c67ccf58 
Call Trace:
 [<c011505b>] kernel_map_pages+0x2b/0x68
 [<c0195cca>] proc_pid_readlink+0x8a/0x160
 [<c0169187>] sys_readlink+0x87/0x90
 [<c014efdb>] sys_brk+0xeb/0x120
 [<c0105dff>] syscall_call+0x7/0xb


It would seem that a readlink of /proc/$PID/exe is happening while the
vma is being torn down, and when we dget(vma->vm_file->f_dentry), the
dentry has already be dput by someone.  So presumable whoever calls
fput on vma->vm_file isn't doing it under mm->mmap_sem.

Well, that's my guess.  I'll let you know if anything happens under
2.6.6-mm3.

NeilBrown
