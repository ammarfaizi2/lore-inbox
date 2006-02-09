Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422750AbWBIBUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422750AbWBIBUD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 20:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422753AbWBIBUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 20:20:03 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:213 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422750AbWBIBUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 20:20:02 -0500
Message-ID: <43EA9920.6070106@jp.fujitsu.com>
Date: Thu, 09 Feb 2006 10:21:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUGFIX][PATCH] shmdt cannot detach not-alined shm segment cleanly.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for a problem of shmdt().
It is found by a test, not a serious problem.
-- Kame

sys_shmdt() can manages shm segments which is covered by multiple vmas.
(This can happen when a user uses mprotect() after shmat().)

This works well if shm is aligned to PAGE_SIZE, but if not, the last segment
cannot be detached. It is because a comparison in sys_shmdt()

	(vma->vm_end - addr) < size
		addr == return address of shmat()
		size == shmsize, argments to shmget()

size should be aligned to PAGE_SIZE before being compared with vma->vm_end,
which is aligned.

Signed-Off-By:KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc2.org/ipc/shm.c
===================================================================
--- linux-2.6.16-rc2.org.orig/ipc/shm.c
+++ linux-2.6.16-rc2.org/ipc/shm.c
@@ -870,6 +870,7 @@ asmlinkage long sys_shmdt(char __user *s
  	 * could possibly have landed at. Also cast things to loff_t to
  	 * prevent overflows and make comparisions vs. equal-width types.
  	 */
+	size = PAGE_ALIGN(size);
  	while (vma && (loff_t)(vma->vm_end - addr) <= size) {
  		next = vma->vm_next;


