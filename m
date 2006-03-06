Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWCFIPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWCFIPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbWCFIPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:15:38 -0500
Received: from fmr21.intel.com ([143.183.121.13]:63140 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751009AbWCFIPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:15:38 -0500
Message-Id: <200603060815.k268FXg07605@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zhang, Yanmin'" <yanmin_zhang@linux.intel.com>,
       <linux-kernel@vger.kernel.org>
Cc: "David Gibson" <david@gibson.dropbear.id.au>
Subject: RE: [PATCH] hugetlb_no_page might break hugetlb quota
Date: Mon, 6 Mar 2006 00:15:33 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZA5pJHFkkChS3oSOqykP1Js48NGwACfMnQ
In-Reply-To: <1141626096.29825.13.camel@ymzhang-perf.sh.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang, Yanmin wrote on Sunday, March 05, 2006 10:22 PM
> In function hugetlb_no_page, backout path always calls hugetlb_put_quota.
> It's incorrect when find_lock_page gets the page or the new page is added
> into page cache.

While I acknowledge the bug, this patch is not complete.  It makes file
system quota consistent with respect to page cache state. But such quota
(more severely, the page cache state) is still buggy, for example under
ftruncate case: if one ftrucate hugetlb file and then tries to fault a
page outside ftruncate area, a new hugetlb page is allocated and then
added into page cache along with file system quota; and at the end
returning VM_FAULT_SIGBUS.  In this case, kernel traps an unreachable
page until possibly next mmap that extends it.  That need to be fixed.
Which means we will be adding back conditional call to
hugetlb_put_quota(mapping) in the backout path.


> In addition, if the vma->vm_flags doesn't include VM_SHARED, the quota
> shouldn't be decreased.

Why? Private hugetlb page should be charged against the quota.  Or is
there a better reason not to do so?

- Ken

