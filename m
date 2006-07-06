Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWGFMsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWGFMsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 08:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWGFMsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 08:48:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030242AbWGFMrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 08:47:35 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/6] NOMMU: Fix execution off of ramfs with mmap() [try #3]
Date: Thu, 06 Jul 2006 13:47:23 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20060706124723.7098.33292.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com>
References: <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com>
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
