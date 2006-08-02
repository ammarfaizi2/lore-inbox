Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWHBSv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWHBSv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWHBSv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:51:26 -0400
Received: from navgwout.symantec.com ([198.6.49.12]:33278 "EHLO
	navgwout.symantec.com") by vger.kernel.org with ESMTP
	id S932144AbWHBSvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:51:25 -0400
Date: Wed, 2 Aug 2006 19:50:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: mm snapshot broken-out-2006-08-02-00-27.tar.gz uploaded
In-Reply-To: <6bffcb0e0608021115s65f81224td8d852b931a9b787@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0608021942500.13042@blonde.wat.veritas.com>
References: <200608020728.k727SegM012704@shell0.pdx.osdl.net>
 <6bffcb0e0608021115s65f81224td8d852b931a9b787@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Aug 2006 18:51:05.0001 (UTC) FILETIME=[9B975990:01C6B664]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006, Michal Piotrowski wrote:
> On 02/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > The mm snapshot broken-out-2006-08-02-00-27.tar.gz has been uploaded to
> >
> >    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-02-00-27.tar.gz
> >
> > It contains the following patches against 2.6.18-rc3:
....
> 
> Here is something new, previous mm snapshot was fine
> 
> Aug  2 19:56:08 ltg01-fedora kernel: ------------[ cut here ]------------
> Aug  2 19:56:08 ltg01-fedora kernel: kernel BUG at
> /usr/src/linux-work4/mm/shmem.c:1228!
> 1228            BUG_ON(!(vma->vm_flags & VM_CAN_INVALIDATE));
> 
> I will revert
> fix-the-race-between-invalidate_inode_pages-and-do_no_page.patch
> fix-the-race-between-invalidate_inode_pages-and-do_no_page-tidy.patch
> and see what will happen.

Rather than reverting those, please add something like (I've not seen
this particular tree) the fixup below - it's easily missed that
ipc/shm.c has its own reference to shmem_nopage.  (Last I heard,
the flag was called VM_CAN_INVLD, but it looks like I'm not the
only one averse to unpronounceables.)

Hugh

--- 2.6.18-rc2-mm1/ipc/shm.c	2006-07-27 16:19:18.000000000 +0100
+++ linux/ipc/shm.c	2006-08-02 19:29:46.000000000 +0100
@@ -264,6 +264,7 @@ static struct vm_operations_struct shm_v
 	.set_policy = shmem_set_policy,
 	.get_policy = shmem_get_policy,
 #endif
+	.vm_flags = VM_CAN_INVALIDATE,
 };
 
 static int newseg (struct ipc_namespace *ns, key_t key, int shmflg, size_t size)
