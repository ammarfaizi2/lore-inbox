Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWB0Wmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWB0Wmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWB0WmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:42:16 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:640 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932352AbWB0WbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:25 -0500
Message-Id: <20060227223319.071279000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:03 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com, hugh@veritas.com,
       manfred@colorfullife.com, mm-commits@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/39] shmdt cannot detach not-alined shm segment cleanly.
Content-Disposition: inline; filename=shmdt-cannot-detach-not-alined-shm-segment-cleanly.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

sys_shmdt() can manage shm segments which are covered by multiple vmas.  (This
can happen when a user uses mprotect() after shmat().)

This works well if shm is aligned to PAGE_SIZE, but if not, the last
segment cannot be detached.  It is because a comparison in sys_shmdt()

	(vma->vm_end - addr) < size
		addr == return address of shmat()
		size == shmsize, argments to shmget()

size should be aligned to PAGE_SIZE before being compared with vma->vm_end,
which is aligned.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 ipc/shm.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.15.3.orig/ipc/shm.c
+++ linux-2.6.15.3/ipc/shm.c
@@ -863,6 +863,7 @@ asmlinkage long sys_shmdt(char __user *s
 	 * could possibly have landed at. Also cast things to loff_t to
 	 * prevent overflows and make comparisions vs. equal-width types.
 	 */
+	size = PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <= size) {
 		next = vma->vm_next;
 

--
