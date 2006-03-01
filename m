Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWCAQXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWCAQXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 11:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWCAQXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 11:23:25 -0500
Received: from gold.veritas.com ([143.127.12.110]:15638 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750941AbWCAQXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 11:23:25 -0500
X-IronPort-AV: i="4.02,157,1139212800"; 
   d="scan'208"; a="56472520:sNHT33456036"
Date: Wed, 1 Mar 2006 16:24:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kamran Karimi <kamrankarimi@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: why VM_SHM has been removed from mm.h?
In-Reply-To: <BAY104-F540D2AB4A73950CA9891BC0F40@phx.gbl>
Message-ID: <Pine.LNX.4.61.0603011601360.11678@goblin.wat.veritas.com>
References: <BAY104-F540D2AB4A73950CA9891BC0F40@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Mar 2006 16:23:24.0930 (UTC) FILETIME=[76F64E20:01C63D4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2006, Kamran Karimi wrote:
> 
> Thank you Hugh for the reply. Last time I used VM_SHM was in 2.2.x kernels. 
> I have a programme called DIPC which makes System V shared memory segments 
> (and also messages and semaphores) work over a network.
> 
> In the arch/xyz/mm/fault.c file, it checks the VM_SHM flag and then calls 
> its logic. As a substitute I've been trying this ad-hoc code to see if a vma 
> represents a Sys V shm:
> 
>       file = vma->vm_file;
>       if(file && (file->f_dentry) && (file->f_dentry->d_inode) &&
>          (id = file->f_dentry->d_inode->i_ino)) {
>               shp = shm_lock(id);
>               if(shp == NULL)
>                       return 0; // not a Sys V shm
>       }
>       else return 0; // not a Sys V shm
> 
> But the kernel hangs with an invalid-pointer error message. Any suggestions?

It's not obvious to me why the kernel would hang with an invalid pointer
error message there: ipc_lock appears to have good safety against being
passed a random id.  Perhaps the invalid pointer message comes from
other code you've not shown (for example, I hope you shm_unlock(shp)
and return 1 when shm_lock succeeds), or perhaps I'm misreading.

But what you're doing there looks entirely weird and meaningless to me:
if shm_lock happens to succeed or fail on the inode number of some file
on some filesystem, that tells you nothing about whether that file is
SysV shm or not.  Ah, I see ipc/shm.c saves id in i_ino: so if you're
dealing with a SysV shm file, then indeed that ought to tell whether
you're dealing with a SysV shm file - but that hasn't helped much!

Since you're already patching base kernel source (you mention
arch/xyz/mm/fault.c), why don't you just patch your own VM_SYSVSHM
into include/linux/mm.h, and set it on the vma in ipc/shm.c?

Hugh
