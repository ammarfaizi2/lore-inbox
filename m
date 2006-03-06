Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752312AbWCFJIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbWCFJIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbWCFJIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:08:35 -0500
Received: from fmr13.intel.com ([192.55.52.67]:26833 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1752312AbWCFJIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:08:34 -0500
Subject: RE: [PATCH] hugetlb_no_page might break hugetlb quota
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <200603060815.k268FXg07605@unix-os.sc.intel.com>
References: <200603060815.k268FXg07605@unix-os.sc.intel.com>
Content-Type: text/plain
Message-Id: <1141635963.29825.28.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 06 Mar 2006 17:06:03 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 16:15, Chen, Kenneth W wrote:
> Zhang, Yanmin wrote on Sunday, March 05, 2006 10:22 PM
> > In function hugetlb_no_page, backout path always calls hugetlb_put_quota.
> > It's incorrect when find_lock_page gets the page or the new page is added
> > into page cache.
> 
> While I acknowledge the bug, this patch is not complete.  It makes file
> system quota consistent with respect to page cache state. But such quota
> (more severely, the page cache state) is still buggy, for example under
> ftruncate case: if one ftrucate hugetlb file and then tries to fault a
> page outside ftruncate area, a new hugetlb page is allocated and then
> added into page cache along with file system quota; and at the end
> returning VM_FAULT_SIGBUS.  In this case, kernel traps an unreachable
> page until possibly next mmap that extends it.  That need to be fixed.
I have another patch to fix it. The second patch is to delete checking
(!(vma->vm_flags & VM_WRITE) && len > inode->i_size) in function
hugetlbfs_file_mmap, and add a checking in hugetlb_no_page,
to implement a capability for application to mmap
an zero-length huge page area. It's useful for process to protect one area.
As a side effect, the second patch also fixes the problem you said.


> Which means we will be adding back conditional call to
> hugetlb_put_quota(mapping) in the backout path.
> 
> 
> > In addition, if the vma->vm_flags doesn't include VM_SHARED, the quota
> > shouldn't be decreased.
> 
> Why? Private hugetlb page should be charged against the quota.  Or is
> there a better reason not to do so?
I checked tmpfs and other fs. Most of them don't charge private
page against the quota.


