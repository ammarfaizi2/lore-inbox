Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVARQeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVARQeE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 11:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVARQeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 11:34:03 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:21124 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261345AbVARQdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 11:33:40 -0500
Date: Tue, 18 Jan 2005 08:33:32 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Hirokazu Takahashi <taka@valinux.co.jp>
cc: kenneth.w.chen@intel.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [1/8]: hugetlb fault handler
In-Reply-To: <20050118.212118.102612494.taka@valinux.co.jp>
Message-ID: <Pine.LNX.4.58.0501180831260.26383@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410251826430.12962@schroedinger.engr.sgi.com>
 <20050118.212118.102612494.taka@valinux.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, Hirokazu Takahashi wrote:

> > Index: linux-2.6.9/fs/hugetlbfs/inode.c
> > ===================================================================
> > --- linux-2.6.9.orig/fs/hugetlbfs/inode.c	2004-10-18 14:55:07.000000000 -0700
> > +++ linux-2.6.9/fs/hugetlbfs/inode.c	2004-10-21 14:50:14.000000000 -0700
> > @@ -79,10 +79,6 @@
> >  	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
> >  		goto out;
> >
> > -	ret = hugetlb_prefault(mapping, vma);
> > -	if (ret)
> > -		goto out;
> > -
> >  	if (inode->i_size < len)
> >  		inode->i_size = len;
> >  out:
>
> hugetlbfs_file_mmap() may fail with a weird error, as it returns
> uninitialized variable "ret".

Hmm. The current diff is:

@@ -79,11 +278,10 @@ static int hugetlbfs_file_mmap(struct fi
        if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
                goto out;

-       ret = hugetlb_prefault(mapping, vma);
-       if (ret)
-               goto out;
+       ret = hugetlb_acct_commit(inode, VMACCTPG(vma->vm_pgoff),
+               VMACCTPG(vma->vm_pgoff + (vma_len >> PAGE_SHIFT)));

-       if (inode->i_size < len)
+       if (ret >= 0 && inode->i_size < len)
                inode->i_size = len;
 out:
        up(&inode->i_sem);

which does not leave ret uninitialized. Also this whole hugetlb
stuff has not been finalized yet and is not that high on my list of things
todo.

