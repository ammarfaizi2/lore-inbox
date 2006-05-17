Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWEQTYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWEQTYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 15:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWEQTYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 15:24:18 -0400
Received: from gold.veritas.com ([143.127.12.110]:55476 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751010AbWEQTYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 15:24:17 -0400
X-IronPort-AV: i="4.05,138,1146466800"; 
   d="scan'208"; a="59610491:sNHT29321528"
Date: Wed, 17 May 2006 20:24:13 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Staubach <staubach@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory mapped files not updating timestamps
In-Reply-To: <446B3E5D.1030301@redhat.com>
Message-ID: <Pine.LNX.4.64.0605171954010.16979@blonde.wat.veritas.com>
References: <446B3E5D.1030301@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 May 2006 19:24:16.0006 (UTC) FILETIME=[7C83DA60:01C679E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Peter Staubach wrote:
> 
> Attached are some changes to address the problem that modifications to
> the contents of a file, made via an mmap'd region, do not cause the
> modification time on the file to be updated.  This lack can cause corruption
> by allowing backup software to not detect files which should be backed up.
> This also represents a potential security hole because it allows a file to be
> modified with no corresponding change in the file modification or change
> time fields.

It would be grand to fix this (it's, umm, three years since I promised to
do so a few days later), but I'm not quite satisfied by your patch as is.

> The changes add support to detect when the modification time needs to be
> updated by placing a hook in __set_pages_dirty_buffers and
> __set_pages_dirty_nobuffers.  One of these two routines will be invoked
> when the dirty bit is detected in the pte.  The hook sets a new bit in the
> address_space mapping struct indicating that the file which is associated
> with that part of the address space needs to have its modification and
> change time attributes updated.

You're adding a little overhead to every set_page_dirty, when the vast
majority (ordinary writes) don't need it: their mctime update is already
well taken care of.  (Or should we be deleting the code that does that?
I think I'd rather not dare.)

Perhaps it's so little overhead that it's not worth worrying about.
But writes to a file which happens to be mapped readonly at that time
are liable to end up with too late a last mctime on the file, aren't
they (if the readonly mapping is unmapped later)?

I think you'd do better to target those places where set_page_dirty is
called on a mapped page - and do the file_update_time at that point -
or as near to that point as is sensible/permitted given the locking
(vma->vm_file gives you the file without needing inode_update_time).

Calling your inode_update_time from unmap_file_vma is probably unwise:
at present we may have preemption disabled there, and it's not clear
what ->dirty_inode might get up to.  Calling it from the vm_file case
of remove_vma would be safer.

Peter Zijlstra has patches relating to dirty mmaps in the -mm tree
at present: I need to take a look at those, and I'll see if it would
make sense to factor in this mctime issue on top of those - you may
want to do the same.

In the course of trying that, I'm likely to discover exactly why you
made the decisions you did, and arrive at commending your solution.

Hugh
