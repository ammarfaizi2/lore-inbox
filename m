Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWHaUZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWHaUZH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 16:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWHaUZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 16:25:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57480 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750788AbWHaUZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 16:25:04 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] NOMMU: Permit ptrace to ignore non-PROT_WRITE VMAs in NOMMU mode
Date: Thu, 31 Aug 2006 21:24:29 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060831202429.24083.96888.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Permit ptrace to modify a section that's non-shared but is marked unwritable,
such as is obtained by mapping the text segment of an ELF-FDPIC executable
binary with into a binary that's being ptraced[*].

[*] Under NOMMU conditions ptrace causes read-only MAP_PRIVATE mmaps to become
    totally private copies because if a private mapping was actually shared
    then the debugging setting breakpoints in it would potentially crash
    other processes.

This is done by using the VM_MAYWRITE flag rather than the VM_WRITE flag when
deciding whether to permit a write.

Without this patch a debugger can't set breakpoints in the mapped text sections
of executables that are mapped read-only private, even if the mmap() syscall
has taken a private copy because PT_PTRACED is set.

In addition, VM_MAYREAD is used instead of VM_READ for similar reasons.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/nommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 51e17b9..9d57c2a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1234,9 +1234,9 @@ int access_process_vm(struct task_struct
 			len = vma->vm_end - addr;
 
 		/* only read or write mappings where it is permitted */
-		if (write && vma->vm_flags & VM_WRITE)
+		if (write && vma->vm_flags & VM_MAYWRITE)
 			len -= copy_to_user((void *) addr, buf, len);
-		else if (!write && vma->vm_flags & VM_READ)
+		else if (!write && vma->vm_flags & VM_MAYREAD)
 			len -= copy_from_user(buf, (void *) addr, len);
 		else
 			len = 0;
