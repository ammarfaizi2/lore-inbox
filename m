Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVERWhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVERWhx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVERWhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:37:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:36262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262285AbVERWhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:37:41 -0400
Date: Wed, 18 May 2005 15:39:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] prevent NULL mmap in topdown model
In-Reply-To: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0505181535210.18337@ppc970.osdl.org>
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 May 2005, Rik van Riel wrote:
>
> This (trivial) patch prevents the topdown allocator from allocating
> mmap areas all the way down to address zero.  It's not the prettiest
> patch, so suggestions for improvement are welcome ;)

Why not just change the "addr >= len" test into "addr > len" and be done
with it?

Ie something as simple as the appended..

		Linus

---
diff --git a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1244,7 +1244,7 @@ arch_get_unmapped_area_topdown(struct fi
 	addr = mm->free_area_cache;
 
 	/* make sure it can fit in the remaining address space */
-	if (addr >= len) {
+	if (addr > len) {
 		vma = find_vma(mm, addr-len);
 		if (!vma || addr <= vma->vm_start)
 			/* remember the address as a hint for next time */
@@ -1266,7 +1266,7 @@ arch_get_unmapped_area_topdown(struct fi
 
 		/* try just below the current vma->vm_start */
 		addr = vma->vm_start-len;
-	} while (len <= vma->vm_start);
+	} while (len < vma->vm_start);
 
 	/*
 	 * A failed mmap() very likely causes application failure,
