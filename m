Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbSJJIQW>; Thu, 10 Oct 2002 04:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSJJIQW>; Thu, 10 Oct 2002 04:16:22 -0400
Received: from holomorphy.com ([66.224.33.161]:34280 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263320AbSJJIQV>;
	Thu, 10 Oct 2002 04:16:21 -0400
Date: Thu, 10 Oct 2002 01:18:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.41-mm2
Message-ID: <20021010081850.GO10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3DA512B1.63287C02@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA512B1.63287C02@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 10:40:01PM -0700, Andrew Morton wrote:
> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.41/2.5.41-mm2/

hugetlbfs update:

CAP_IPC_LOCK is required to utilize hugetlb shm segments, memory
allocation, and other facilities. The following patch does three things:

(1) check capable(CAP_IPC_LOCK) in ->f_ops->mmap
	This may be redundant but it errors out with less state to
	clean up and at least clarifies the fact that checks are
	being performed at the relevant entry points.

(2) check capable(CAP_IPC_LOCK) in hugetlbfs_zero_setup()
	This is called at shmget() time and is an actual potential
	security hole. hugetlb_prefault() does not perform this
	check itself, so it must be done here.


--- akpm-2.5.41/fs/hugetlbfs/inode.c	2002-10-08 18:43:39.000000000 -0700
+++ wli-2.5.41/fs/hugetlbfs/inode.c	2002-10-10 00:30:15.000000000 -0700
@@ -56,6 +56,9 @@
 	struct address_space *mapping = inode->i_mapping;
 	int ret;
 
+	if (!capable(CAP_IPC_LOCK))
+		return -EPERM;
+
 	if (vma->vm_start & ~HPAGE_MASK)
 		return -EINVAL;
 
@@ -259,6 +262,9 @@
 	struct qstr quick_string;
 	char buf[16];
 
+	if (!capable(CAP_IPC_LOCK))
+		return ERR_PTR(-EPERM);
+
 	n = atomic_read(&hugetlbfs_counter);
 	atomic_inc(&hugetlbfs_counter);
 
