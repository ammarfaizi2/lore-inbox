Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUHBKPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUHBKPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266434AbUHBKNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:13:43 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:35049 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266442AbUHBKM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:12:28 -0400
Date: Mon, 2 Aug 2004 15:40:55 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       dipankar@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: [patchset] Lockfree fd lookup 0 of 5
Message-ID: <20040802101053.GB4385@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patchset to eliminate taking struct files_struct.file_lock on 
reader side using rcu and rcu based refcounting.  These patches
extend the kref api to include kref_lf_xxx api and kref_lf_get_rcu to
do lockfree refcounting, and use the same.  As posted earlier, since fd
lookups (struct files_struct.fd[]) will be lock free with these patches, 
threaded workloads doing lots of io should see performance benefits 
due to this patchset.  I have observed 13-15% improvement with tiobench 
on a 4 way xeon with this patchset.

The patchset contains:
1. kref-merged-2.6.7.patch -- kref shrinkage patch which GregKH has applied to
   his tree.
2. kref-drivers-2.6.7.patch -- existing users of kref modified to use the
   'shrunk' krefs.  GregKH has applied this to his tree too
3. kref-lf-2.6.7.patch -- kref api additions for lock free refcounting.  
   This patch relocates kref api to kref.h as static inlines since they
   are mostly wrappers around atomic_xxx operations
4. files_struct-kref-s-2.6.7.patch -- change struct file.f_count to a kref
   and use kref api for refcounting.  This does not add any performance
   benefit and is just an intermediate patch
5. files_struct-rcu-kref-2.6.7.patch -- Make fd lookups lock free by using
   rcu and kref_lf_xxx api for lockfree refcounting

The patchset will follow this post.

Thanks,
Kiran

