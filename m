Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbTEPX0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbTEPX0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:26:50 -0400
Received: from corky.net ([212.150.53.130]:49370 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S264622AbTEPX0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:26:48 -0400
Date: Sat, 17 May 2003 02:39:35 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Ahmed Masud <masud@googgun.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.] 
In-Reply-To: <Pine.LNX.4.44.0305170140520.32047-100000@marcellos.corky.net>
Message-ID: <Pine.LNX.4.44.0305170211180.32047-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's still something I'm unsure of.  I'm not familiar with the mm
> subsystem.  Do you know whether vma structs are shared among processes
> with shared mapping ?  I'd think the answer is yes, in which case the
> above is the right way, but if it works that way, how come vm_area_struct
> doesn't have a refcount yet ?  Who keeps track of it ?  Who frees it when
> the last mapper unmaps it ?  Is the vma->shared in charge of all that ?
> If so, what lock protects it ?
>

Answering myself here.  Sanity-check me :)

According to mm/mmap.c, vma's are indeed shared among processes.
vma->shared is the list, and is maintained by __remove_shared_vm_struct()
and __vma_link_file().

The semaphore we should probably grab when messing with the key of a
shared area is actually its inode's sem, since vma doesn't have one.
inode->i_mapping->i_shared_sem, in the inode pointed by vma->vm_file.
If it doesn't exist, it probably means this vma has only one user.

Invalidating the vma key should probably occur in any place that
calls vma->vm_ops->close(), after this call.  We may want to add our own
refcount in vma, in case vm_file isn't available for extracting the
inode.

Just a thought: If we encrypt per-area, it might make more sense to go
down another level, to mm_struct.  It already has its refcount and
backpoints its users.  The key is valid iff the mm_struct is valid anyway,
so we may not have to track so many things ourselves.  Just allocate a
random key whenever mm_struct is allocated, and overwrite the key before
mm_struct is freed.  Any mm experts care to comment ?

	Yoav

