Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263623AbUEKUp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbUEKUp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUEKUp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:45:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22743 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263623AbUEKUpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:45:21 -0400
Date: Tue, 11 May 2004 21:45:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Bug in VM accounting code, probably exploitable
In-Reply-To: <40A12E83.7030209@aknet.ru>
Message-ID: <Pine.LNX.4.44.0405112118230.9018-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004, Stas Sergeev wrote:
> mprotect() fails to merge VMAs because one VMA can end up with
> VM_ACCOUNT flag set, and another without that flag. That makes
> several apps of mine to malfuncate.
> And the fix looks also very strange, but it seems to work.

Great find!  Someone has got their test the wrong way round.
Your patch is good, but since that VM_MAYACCT macro is being
used in one place only, and just hiding what it's actually about,
I'd prefer the patch below.  Against 2.6.6: Andrew, please apply.

--- 2.6.6/include/linux/mm.h	2004-05-10 03:33:36.000000000 +0100
+++ linux/include/linux/mm.h	2004-05-11 21:26:12.296881936 +0100
@@ -112,9 +112,6 @@ struct vm_area_struct {
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 
-/* It makes sense to apply VM_ACCOUNT to this vma. */
-#define VM_MAYACCT(vma) (!!((vma)->vm_flags & VM_HUGETLB))
-
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
 #endif
--- 2.6.6/mm/mprotect.c	2004-05-10 03:33:48.000000000 +0100
+++ linux/mm/mprotect.c	2004-05-11 21:27:17.079033552 +0100
@@ -174,8 +174,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
 	if (newflags & VM_WRITE) {
-		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))
-				&& VM_MAYACCT(vma)) {
+		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED|VM_HUGETLB))) {
 			charged = (end - start) >> PAGE_SHIFT;
 			if (security_vm_enough_memory(charged))
 				return -ENOMEM;

