Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbUL3Nj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbUL3Nj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 08:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUL3Nix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 08:38:53 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:51933 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S261637AbUL3NhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 08:37:05 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Is CAP_SYS_ADMIN checked by every program !?
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
References: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
In-Reply-To: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
Message-Id: <200412302236.DGE46722.PSVOYJLMtGOMFFStN@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Thu, 30 Dec 2004 22:37:08 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Bernd Eckenfels wrote:
> You can add dump_stack(void) from kernel.h to you patch, since there are not
> many sources for SYS_ADMIN capabilities checks in the kernel. You will
> quickly find the syscall in question.

Oh, this is exactly what I need.

And the following is the results of these tow lines.
  printk("\n[%s]\n", current->comm);
  dump_stack();

[ls]
 [<c01e1852>] cap_vm_enough_memory+0x82/0x1f0
 [<c0156dcd>] setup_arg_pages+0x9d/0x230
 [<c0174373>] load_elf_binary+0x473/0xca0
 [<c01334e7>] __alloc_pages+0xa7/0x360
 [<c0156bdd>] copy_strings+0x1dd/0x200
 [<c0157b00>] search_binary_handler+0x50/0x170
 [<c0157d9e>] do_execve+0x17e/0x210
 [<c01010bc>] sys_execve+0x3c/0x80
 [<c010246d>] sysenter_past_esp+0x52/0x75

[cat]
 [<c01e1852>] cap_vm_enough_memory+0x82/0x1f0
 [<c0156dcd>] setup_arg_pages+0x9d/0x230
 [<c0174373>] load_elf_binary+0x473/0xca0
 [<c01334e7>] __alloc_pages+0xa7/0x360
 [<c0156bdd>] copy_strings+0x1dd/0x200
 [<c0157b00>] search_binary_handler+0x50/0x170
 [<c0157d9e>] do_execve+0x17e/0x210
 [<c01010bc>] sys_execve+0x3c/0x80
 [<c010246d>] sysenter_past_esp+0x52/0x75

[tcsh]
 [<c01e1852>] cap_vm_enough_memory+0x82/0x1f0
 [<c0112c1e>] copy_mm+0x17e/0x360
 [<c0113686>] copy_process+0x406/0x9c0
 [<c0113d45>] do_fork+0x75/0x1ad
 [<c01e753e>] copy_to_user+0x3e/0x50
 [<c011f85e>] sys_rt_sigprocmask+0xae/0x100
 [<c010103c>] sys_clone+0x3c/0x40
 [<c010246d>] sysenter_past_esp+0x52/0x75

[sed]
 [<c01e1852>] cap_vm_enough_memory+0x82/0x1f0
 [<c0156dcd>] setup_arg_pages+0x9d/0x230
 [<c0174373>] load_elf_binary+0x473/0xca0
 [<c01334e7>] __alloc_pages+0xa7/0x360
 [<c0156bdd>] copy_strings+0x1dd/0x200
 [<c0157b00>] search_binary_handler+0x50/0x170
 [<c0157d9e>] do_execve+0x17e/0x210
 [<c01010bc>] sys_execve+0x3c/0x80
 [<c010246d>] sysenter_past_esp+0x52/0x75

[klogd]
 [<c01e179c>] cap_syslog+0x4c/0x80
 [<c011445d>] do_syslog+0x2d/0x380
 [<c0127640>] autoremove_wake_function+0x0/0x60
 [<c011cb84>] update_process_times+0x44/0x50
 [<c0127640>] autoremove_wake_function+0x0/0x60
 [<c014cda6>] vfs_read+0x116/0x160
 [<c014d0b1>] sys_read+0x51/0x80
 [<c010246d>] sysenter_past_esp+0x52/0x75

The function which calls capable(CAP_SYS_ADMIN) is
cap_vm_enough_memory() defined in security/commoncap.c ,
and this function is called whenever sys_execve() is called.
Therefore, it seemed to me that every program calls capable(CAP_SYS_ADMIN).

Thank you very much.
--
Tetsuo Handa
