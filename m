Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWIAMmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWIAMmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 08:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWIAMmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 08:42:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30618 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750730AbWIAMmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 08:42:22 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/2] Check if start address is in vma region in NOMMU function get_user_pages().
Date: Fri, 01 Sep 2006 13:42:07 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org, dhowells@redhat.com
Message-Id: <20060901124207.26038.24367.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonic Zhang <sonic.adi@gmail.com>

Hi,

In NOMMU arch, if run "cat /proc/self/mem", data from physical address
0 are read. This behavior is different from MMU arch.  In IA32,
message "cat: /proc/self/mem: Input/output error" is reported.

This issue is rootcaused by not validate the start address in NOMMU
function get_user_pages(). Following patch solves this issue.

Thanks

Sonic Zhang


Signed-off-by: Sonic Zhang <sonic.adi@gmail.com>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 mm/nommu.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 3215f46..2fe3fe4 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -129,16 +129,20 @@ int get_user_pages(struct task_struct *t
 	struct page **pages, struct vm_area_struct **vmas)
 {
 	int i;
-	static struct vm_area_struct dummy_vma;
+	struct vm_area_struct *vma;
 
 	for (i = 0; i < len; i++) {
+		vma = find_vma(mm, start);
+		if(!vma)
+			return i ? : -EFAULT;
+		
 		if (pages) {
 			pages[i] = virt_to_page(start);
 			if (pages[i])
 				page_cache_get(pages[i]);
 		}
 		if (vmas)
-			vmas[i] = &dummy_vma;
+			vmas[i] = vma;
 		start += PAGE_SIZE;
 	}
 	return(i);
