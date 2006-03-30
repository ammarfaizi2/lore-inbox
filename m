Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWC3BxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWC3BxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWC3BxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:53:21 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:59061 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751275AbWC3BxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:53:21 -0500
Date: Thu, 30 Mar 2006 03:53:18 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: [2.6.16-gitX] (x86_64) WARNING: vmlinux: 'strlen' exported twice.
 Previous export was in vmlinux
Message-Id: <20060330035318.41a5b74c.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Git versions keep incrementing but no fix for:

  BUILD   arch/x86_64/boot/bzImage
Root device is (3, 2)
Boot sector 512 bytes.
Setup is 4696 bytes.
System is 1530 kB
Kernel: arch/x86_64/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST
WARNING: vmlinux: 'strlen' exported twice. Previous export was in vmlinux

And every module built ouside of the kernel also spews that message. Has
been the case since this got in:

6edfba1b33c701108717f4e036320fc39abe1912 is first bad commit
diff-tree 6edfba1b33c701108717f4e036320fc39abe1912 (from 681558fdb5848f0a6dc248108f0f7323f7380857)
Author: Andi Kleen <ak@suse.de>
Date:   Sat Mar 25 16:29:49 2006 +0100

    [PATCH] x86_64: Don't define string functions to builtin

    gcc should handle this anyways, and it causes problems when
    sprintf is turned into strcpy by gcc behind our backs and
    the C fallback version of strcpy is actually defining __builtin_strcpy

    Then drop -ffreestanding from the main Makefile because it isn't
    needed anymore and implies -fno-builtin, which is wrong now.
    (it was only added for x86-64, so dropping it should be safe)

    Noticed by Roman Zippel

    Cc: Roman Zippel <zippel@linux-m68k.org>
    Signed-off-by: Andi Kleen <ak@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Or at least that's what an "almost" complete bisect says. I was down to
the very last test, and that one didn't compile, so I said 'git-bisect good'
based on the commit subject (it shouldn't have any bearing to this issue).

git-bisect start
# bad: [5a3a5a98b6422d05c39eaa32c8b3f83840c7b768] Add flush_kernel_dcache_page() API
git-bisect bad 5a3a5a98b6422d05c39eaa32c8b3f83840c7b768
# good: [2e1ca21d46aaef95101723fa402f39d3a95aba59] Merge master.kernel.org:/pub/scm/linux/kernel/git/sam/kbuild
git-bisect good 2e1ca21d46aaef95101723fa402f39d3a95aba59
# bad: [2e9abdd9bad485970b37cd53a82f92702054984c] Merge master.kernel.org:/pub/scm/linux/kernel/git/davej/agpgart
git-bisect bad 2e9abdd9bad485970b37cd53a82f92702054984c
# good: [2b514e74f4e59e3b8e54891580fef2c9ff6c7bd0] x86_64: eliminate set_debug()
git-bisect good 2b514e74f4e59e3b8e54891580fef2c9ff6c7bd0
# bad: [4bdc3b7f1b730c07f5a6ccca77ee68e044036ffc] x86_64: Basic reorder infrastructure
git-bisect bad 4bdc3b7f1b730c07f5a6ccca77ee68e044036ffc
# bad: [4bc32c4d5cde5c57edcc9c2fe5057da8a4dd0153] x86_64: Implement compat code for raw1394 read/write
git-bisect bad 4bc32c4d5cde5c57edcc9c2fe5057da8a4dd0153
# good: [681558fdb5848f0a6dc248108f0f7323f7380857] x86_64: Check that early arguments are words on their own
git-bisect good 681558fdb5848f0a6dc248108f0f7323f7380857
# bad: [1f50249e940baa7133e0bdb32cd564bb3ba28456] x86_64: Make pfn_valid work early in boot
git-bisect bad 1f50249e940baa7133e0bdb32cd564bb3ba28456
# bad: [b2b978f98036717e2508cf3288aecb8f9c7d724e] x86_64: Fix wrong PCI ID for ALI M1695 AGP bridge
git-bisect bad b2b978f98036717e2508cf3288aecb8f9c7d724e
# bad: [6edfba1b33c701108717f4e036320fc39abe1912] x86_64: Don't define string functions to builtin
git-bisect bad 6edfba1b33c701108717f4e036320fc39abe1912

Mvh
Mats Johannesson
--
