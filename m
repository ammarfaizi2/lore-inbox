Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266378AbUHSOyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266378AbUHSOyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUHSOyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:54:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32406 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266311AbUHSOvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:51:48 -0400
Message-ID: <4124BE89.20909@redhat.com>
Date: Thu, 19 Aug 2004 10:51:53 -0400
From: Frank Hirtz <fhirtz@redhat.com>
User-Agent: Mozilla Thunderbird 0.6 (Macintosh/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.8.1:  display committed memory limit and available in
 meminfo
Content-Type: multipart/mixed;
 boundary="------------030103000904070608090505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030103000904070608090505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following patch will have the committed memory limit (per the current 
overcommit ratio) and the amount of memory remaining under this limit displayed 
in meminfo.

It's presently somewhat difficult to use the strict memory overcommit settings 
as it's somewhat difficult to determine the amount of memory remaining under the 
cap. This patch would make using strict overcommit a good bit simpler. Does such 
an addition seem reasonable?

Thank you,

Frank.

--------------030103000904070608090505
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="linux-2.6.8.1-committedmem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8.1-committedmem.patch"

--- linux-2.6.8.1/fs/proc/proc_misc.c		2004-08-18 16:32:07.000000000 -0400
+++ linux-2.6.8.1.new/fs/proc/proc_misc.c	2004-08-18 16:55:47.000000000 -0400
@@ -153,7 +153,7 @@
 				 int count, int *eof, void *data)
 {
 	struct sysinfo i;
-	int len, committed;
+	int len, committed, allowed;
 	struct page_state ps;
 	unsigned long inactive;
 	unsigned long active;
@@ -171,6 +171,8 @@
 	si_meminfo(&i);
 	si_swapinfo(&i);
 	committed = atomic_read(&vm_committed_space);
+	allowed = ((totalram_pages - hugetlb_total_pages()) 
+		* sysctl_overcommit_ratio / 100) + total_swap_pages;
 
 	vmtot = (VMALLOC_END-VMALLOC_START)>>10;
 	vmi = get_vmalloc_info();
@@ -198,7 +200,9 @@
 		"Writeback:    %8lu kB\n"
 		"Mapped:       %8lu kB\n"
 		"Slab:         %8lu kB\n"
+		"CommitLimit:  %8lu kB\n"
 		"Committed_AS: %8u kB\n"
+		"CommitAvail:  %8ld kB\n"
 		"PageTables:   %8lu kB\n"
 		"VmallocTotal: %8lu kB\n"
 		"VmallocUsed:  %8lu kB\n"
@@ -220,7 +224,9 @@
 		K(ps.nr_writeback),
 		K(ps.nr_mapped),
 		K(ps.nr_slab),
+		K(allowed),
 		K(committed),
+		K(allowed - committed),
 		K(ps.nr_page_table_pages),
 		vmtot,
 		vmi.used,

--------------030103000904070608090505--
