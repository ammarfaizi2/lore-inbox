Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbUKKWgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbUKKWgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUKKWe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:34:57 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:55820 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S262377AbUKKWcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:32:47 -0500
Date: Thu, 11 Nov 2004 16:32:45 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: tripperda@nvidia.com
Subject: [patch] VM accounting change
Message-ID: <20041111223245.GA15759@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 11 Nov 2004 22:32:45.0869 (UTC) FILETIME=[5DB1FDD0:01C4C83E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I apologize for not having more first hand info on this problem.

I've been told that recent changes in vm accounting in mmap have
caused some problems with our driver during mmap.

the problem seems to stem from us oring vma->vm_flags w/ (VM_LOCKED 
| VM_IO). we do this for agp and pci pages that are mapped to push
buffers. VM_LOCKED since we don't want the pages to move and VM_IO so
they are not dumped during a core dump.

I've been told that the new vm accounting changes call
make_pages_present() for all pages in a vma range marked VM_LOCKED and
that this causes problems with our driver. the attached patch modifies
this to not call make_pages_present() if VM_IO is also set.

what I'm unclear on is if this is a valid fix. should
make_pages_present work for memory ranges that are already mapped and
locked down (via PG_reserved)? are we wrong in using (VM_IO |
VM_LOCKED) for our pages? is this fix correct?

Thanks,
Terence




--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.10-rc1-bk8-VM_IO.diff"

diff -ru linux-2.6.10-rc1-bk8/mm/mmap.c linux-2.6.10-rc1-bk8-2/mm/mmap.c
--- linux-2.6.10-rc1-bk8/mm/mmap.c	2004-11-06 15:04:28.000000000 +0100
+++ linux-2.6.10-rc1-bk8-2/mm/mmap.c	2004-11-06 15:39:47.000000000 +0100
@@ -1011,7 +1011,8 @@
 	__vm_stat_account(mm, vm_flags, file, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += len >> PAGE_SHIFT;
-		make_pages_present(addr, addr + len);
+		if (!(vm_flags & VM_IO))
+			make_pages_present(addr, addr + len);
 	}
 	if (flags & MAP_POPULATE) {
 		up_write(&mm->mmap_sem);

--qMm9M+Fa2AknHoGS--
