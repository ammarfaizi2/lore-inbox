Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWGENZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWGENZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWGENZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:25:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45990 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964854AbWGENYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:24:36 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/5] NOMMU: Fix execution off of ramfs with mmap()
Date: Wed, 05 Jul 2006 14:24:14 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060705132414.31510.6590.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com>
References: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Fix execution through the FDPIC binfmt of programs stored on ramfs by
preventing the ramfs mmap() returning successfully on a private mapping of a
ramfs file.  This causes NOMMU mmap to make a copy of the mapped portion of the
file and map that instead.

This could be improved by granting direct mapping access to read-only private
mappings for which the data is stored on a contiguous run of pages.  However,
this is only likely to be the case if the file was extended with truncate
before being written.

ramfs is left to map the file directly for shared mappings so that SYSV IPC
and POSIX shared memory both still work.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/ramfs/file-nommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 99fffc9..677139b 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -283,9 +283,9 @@ unsigned long ramfs_nommu_get_unmapped_a
 
 /*****************************************************************************/
 /*
- * set up a mapping
+ * set up a mapping for shared memory segments
  */
 int ramfs_nommu_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	return 0;
+	return vma->vm_flags & VM_SHARED ? 0 : -ENOSYS;
 }
