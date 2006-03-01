Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWCAO6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWCAO6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWCAO6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:58:42 -0500
Received: from bay104-f5.bay104.hotmail.com ([65.54.175.15]:39447 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932335AbWCAO6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:58:42 -0500
Message-ID: <BAY104-F540D2AB4A73950CA9891BC0F40@phx.gbl>
X-Originating-IP: [137.207.140.83]
X-Originating-Email: [kamrankarimi@hotmail.com]
In-Reply-To: <Pine.LNX.4.61.0603010741200.7184@goblin.wat.veritas.com>
From: "Kamran Karimi" <kamrankarimi@hotmail.com>
To: hugh@veritas.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: why VM_SHM has been removed from mm.h?
Date: Wed, 01 Mar 2006 08:58:39 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 01 Mar 2006 14:58:41.0777 (UTC) FILETIME=[A12AB610:01C63D40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Hugh for the reply. Last time I used VM_SHM was in 2.2.x kernels. 
I have a programme called DIPC which makes System V shared memory segments 
(and also messages and semaphores) work over a network.

In the arch/xyz/mm/fault.c file, it checks the VM_SHM flag and then calls 
its logic. As a substitute I've been trying this ad-hoc code to see if a vma 
represents a Sys V shm:

      file = vma->vm_file;
      if(file && (file->f_dentry) && (file->f_dentry->d_inode) &&
         (id = file->f_dentry->d_inode->i_ino)) {
              shp = shm_lock(id);
              if(shp == NULL)
                      return 0; // not a Sys V shm
      }
      else return 0; // not a Sys V shm

But the kernel hangs with an invalid-pointer error message. Any suggestions?

-Kamran


>On Tue, 28 Feb 2006, Kamran Karimi wrote:
> >
> > VM_SHM is used by DIPC to quickly recognise when we are dealing with a 
>System
> > V IPC segment. It has been "removed" from recent kernels (set to 0).
>
>Curious: VM_SHM wasn't set on a System V IPC shm vma in any 2.4 or 2.6
>kernel that I know of; but was set on the vmas of a random collection
>of drivers.  Perhaps you've been using your own patch to set it on
>SysV IPC shm vmas, and clear it from drivers' vmas?
>
>(We'll remove VM_SHM entirely once I've trawled through those drivers.)
>
> > Is there an easy way to find out if a segment is a Sys V shm?
>
>Nothing easy and reliable springs immediately to mind - from a VM point
>of view, they're treated much the same as tmpfs files; but there
>probably is some hacky way if we think about it long enough.
>
> > if not, I suggest we re-activate it.
>
>It seems that either you've been doing the wrong thing up to now,
>and never noticed it; or that you've been using your own flag in
>your own patch, and can continue to do so.  No need for vanilla
>kernel to reinstate VM_SHM.
>
>Are you sure you need to recognize them?
>
>Hugh


