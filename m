Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbTARGBJ>; Sat, 18 Jan 2003 01:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTARGBJ>; Sat, 18 Jan 2003 01:01:09 -0500
Received: from dp.samba.org ([66.70.73.150]:42636 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262602AbTARGBJ>;
	Sat, 18 Jan 2003 01:01:09 -0500
Date: Sat, 18 Jan 2003 17:05:22 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: recent change to exit_mmap
Message-ID: <20030118060522.GE7800@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On ppc64 a 32bit task has 4GB and a 64bit task has 2TB of address space.

We use a bit in the thread struct to decide which limit to apply against
TASK_SIZE:

#define TASK_SIZE (test_thread_flag(TIF_32BIT) ? \
                TASK_SIZE_USER32 : TASK_SIZE_USER64)

The TIF_32BIT flag gets set in the arch specific SET_PERSONALITY hook
in load_elf_binary.

After the recent changes in mm/mmap.c, the following sequence of events
happens:

1. a 64bit task tries to exec a 32bit one
2. we reach load_elf_binary
3. call SET_PERSONALITY which sets TIF_32BIT to true
4. call flush_old_exec->exec_mmap->mmput->exit_mmap
5. call unmap_vmas(,,,,TASK_SIZE,) which only flushes mappings below 4GB
6. BUG_ON in exit_mmap

It seems with the TIF_32BIT scheme we have a window between
SET_PERSONALITY until exec returns where TASK_SIZE might be considered
incorrect (although at which exact point to you decide that, yes we are
now in the new context).

Any ideas on how to fix this? Maybe we can move SET_PERSONALITY down
after flush_old_exec.

Anton
