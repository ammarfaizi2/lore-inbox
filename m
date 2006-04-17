Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWDQVe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWDQVe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 17:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWDQVe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 17:34:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:59105 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751303AbWDQVe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 17:34:57 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/5] shmat: stop mprotect from giving write permission to a readonly attachment (CVE-2006-1524)
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 17 Apr 2006 14:33:39 -0700
Message-Id: <11453096192342-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.0.rc4.ge6bf
In-Reply-To: <11453096192073-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>

I found that all of 2.4 and 2.6 have been letting mprotect give write
permission to a readonly attachment of shared memory, whether or not IPC
would give the caller that permission.

SUS says "The behaviour of this function [mprotect] is unspecified if the
mapping was not established by a call to mmap", but I don't think we can
interpret that as allowing it to subvert IPC permissions.

I haven't tried 2.2, but the 2.2.26 source looks like it gets it right; and
the patch below reproduces that behaviour - mprotect cannot be used to add
write permission to a shared memory segment attached readonly.

This patch is simple, and I'm sure it's what we should have done in 2.4.0:
if you want to go on to switch write permission on and off with mprotect,
just don't attach the segment readonly in the first place.

However, we could have accumulated apps which attach readonly (even though
they would be permitted to attach read/write), and which subsequently use
mprotect to switch write permission on and off: it's not unreasonable.

I was going to add a second ipcperms check in do_shmat, to check for
writable when readonly, and if not writable find_vma and clear VM_MAYWRITE.
 But security_ipc_permission might do auditing, and it seems wrong to
report an attempt for write permission when there has been none.  Or we
could flag the vma as SHM, note the shmid or shp in vm_private_data, and
then get mprotect to check.

But the patch below is a lot simpler: I'd rather stick with it, if we can
convince ourselves somehow that it'll be safe.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 ipc/shm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

b78b6af66a5fbaf17d7e6bfc32384df5e34408c8
diff --git a/ipc/shm.c b/ipc/shm.c
index 6b0c9af..1c2faf6 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -162,6 +162,8 @@ static int shm_mmap(struct file * file, 
 	ret = shmem_mmap(file, vma);
 	if (ret == 0) {
 		vma->vm_ops = &shm_vm_ops;
+		if (!(vma->vm_flags & VM_WRITE))
+			vma->vm_flags &= ~VM_MAYWRITE;
 		shm_inc(file->f_dentry->d_inode->i_ino);
 	}
 
-- 
1.2.6

