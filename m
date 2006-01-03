Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWACVKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWACVKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWACVHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:23183 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932510AbWACVHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:42 -0500
To: torvalds@osdl.org
Subject: [PATCHSET] thread_info annotations and fixes
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PA-2x@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Message-ID: <20060103210515.5135@ftp.linux.org.uk>

	Patchset annotates arch/* uses of ->thread_info.  Ones that really
are about access of thread_info of given process are simply switched to
task_thread_info(task); ones that deal with access to objects on stack
are switched to new helper - task_stack_page().  A _lot_ of the latter are
actually open-coded instances of "find where pt_regs are"; those are
consolidated into task_pt_regs(task) (many architectures actually have
such helper already).

	Note that these annotations are not mandatory - any code not
converted to these helpers still works.  However, they clean up a lot
of places and have actually caught a number of bugs, so converting out
of tree ports would be a good idea...

	As an example of breakage caught by that stuff, see i386
pt_regs mess - we used to have it open-coded in a bunch of places
and when back in April Stas had fixed a bug in copy_thread(), the
rest had been left out of sync.  That required two followup patches
(the latest - just before 2.6.15) _and_ still had left /proc/*/stat
eip field broken.  Try ps -eo eip on i386 and watch the junk...

Patchset contents:
      missing helper - task_stack_page()
      alpha: task_thread_info()
      alpha: task_stack_page()
      alpha: task_pt_regs()
      amd64: task_thread_info()
      amd64: task_pt_regs()
      amd64: task_stack_page()
      i386: task_thread_info()
      i386: fix task_pt_regs()
      i386: task_stack_page()
      sparc64: task_thread_info()
      sparc64: task_stack_page()
      sparc64: task_pt_regs()
      sh: task_pt_regs()
      sh: task_thread_info()
      sh: task_stack_page()
      sparc: task_thread_info()
      sparc: task_stack_page()
      uml: task_thread_info()
      uml: task_stack_page()
      s390: task_pt_regs()
      s390: task_stack_page()
      xtensa: task_pt_regs(), task_stack_page()
      v850: task_stack_page(), task_pt_regs()
      m32r: task_pt_regs(), task_stack_page(), task_thread_info()
      frv: task_thread_info(), task_stack_page()
      m68k: task_stack_page()
      m68knommu: task_stack_page()
      parisc: task_stack_page(), task_thread_info()
      h8300: task_stack_page()
      arm: task_thread_info()
      arm: task_pt_regs()
      arm: end_of_stack()
      arm: task_stack_page()
      arm26: task_thread_info()
      arm26: task_pt_regs()
      arm26: task_stack_page()
      sh64: task_stack_page()
      powerpc: task_thread_info()
      powerpc: task_stack_page()
      cris: task_pt_regs()
      cris: fix KSTK_EIP
      cris: task_thread_info()
      ia64: task_thread_info()
      ia64: task_pt_regs()
      mips: namespace pollution: dump_regs() -> elf_dump_regs()
      mips: task_pt_regs()
      mips: task_thread_info()
      mips: task_stack_page()
      death of get_thread_info/put_thread_info

The only ordering requirements are that the first patch (introducing a
trivial #define for task_stack_page()) goes before the rest and that
patches for given architecture go in order.
