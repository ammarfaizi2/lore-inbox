Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265544AbUGDMEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbUGDMEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbUGDMEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:04:08 -0400
Received: from holomorphy.com ([207.189.100.168]:18889 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265544AbUGDMED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:04:03 -0400
Date: Sun, 4 Jul 2004 05:04:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, hugh@veritas.com
Subject: spurious remap_file_pages() -EINVAL
Message-ID: <20040704120401.GE21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As ->vm_private_data is used as a cursor for swapout of VM_NONLINEAR
vmas, the check for NULL ->vm_private_data or VM_RESERVED is too
strict, and should allow VM_NONLINEAR vmas with non-NULL ->vm_private_data.

This fixes an issue on 2.6.7-mm5 where system calls to remap_file_pages()
spuriously failed while under memory pressure.


Index: mm5-2.6.7/mm/fremap.c
===================================================================
--- mm5-2.6.7.orig/mm/fremap.c	2004-07-04 04:28:50.836939584 -0700
+++ mm5-2.6.7/mm/fremap.c	2004-07-04 04:30:37.645702184 -0700
@@ -194,7 +194,8 @@
 	 * or VM_LOCKED, but VM_LOCKED could be revoked later on).
 	 */
 	if (vma && (vma->vm_flags & VM_SHARED) &&
-		(!vma->vm_private_data || (vma->vm_flags & VM_RESERVED)) &&
+		(!vma->vm_private_data ||
+			(vma->vm_flags & (VM_NONLINEAR|VM_RESERVED))) &&
 		vma->vm_ops && vma->vm_ops->populate &&
 			end > start && start >= vma->vm_start &&
 				end <= vma->vm_end) {
