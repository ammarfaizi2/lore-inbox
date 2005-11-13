Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbVKMCyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVKMCyT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 21:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVKMCyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 21:54:19 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:36312 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S1751034AbVKMCyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 21:54:18 -0500
Date: Sun, 13 Nov 2005 04:54:17 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       Junichi Uekawa <dancer@netfort.gr.jp>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Michael Krufky <mkrufky@m1k.net>,
       linux-kernel@vger.kernel.org, debian-amd64@lists.debian.org
Subject: Re: [x86_64] 2.6.14-git13 mplayer fails with "v4l2: ioctl queue buffer failed: Bad address" (2 Nov 2005, 11 Nov 2005)
Message-ID: <20051113025417.GN5706@mea-ext.zmailer.org>
References: <87fyqeicge.dancerj%dancer@netfort.gr.jp> <87wtjg5gh2.dancerj%dancer@netfort.gr.jp> <4373D087.5050908@linuxtv.org> <87psp859sd.dancerj%dancer@netfort.gr.jp> <43740F06.6030504@m1k.net> <87y83vl780.dancerj%dancer@netfort.gr.jp> <87ek5nb9ec.dancerj%dancer@netfort.gr.jp> <Pine.LNX.4.61.0511111355080.16161@goblin.wat.veritas.com> <1131834172.8368.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131834172.8368.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 01:22:51AM +0300, Nickolay V. Shmyrev wrote:
> Hello all.
> 
> We have even found the hack that fix that problem:

A hack, but working one..
(for the small while that I tested it)

> Index: linux/drivers/media/video/video-buf.c
> ===================================================================
> RCS file: /cvs/video4linux/v4l-kernel/linux/drivers/media/video/video-buf.c,v
> retrieving revision 1.21
> diff -u -p -r1.21 video-buf.c
> --- linux/drivers/media/video/video-buf.c       16 Oct 2005 12:13:58 -0000
> +++ linux/drivers/media/video/video-buf.c       12 Nov 2005 22:19:13 -0000
> @@ -1248,7 +1248,7 @@ int videobuf_mmap_mapper(struct videobuf
>         map->end      = vma->vm_end;
>         map->q        = q;
>         vma->vm_ops   = &videobuf_vm_ops;
> -       vma->vm_flags |= VM_DONTEXPAND | VM_RESERVED;
> +       vma->vm_flags |= VM_DONTEXPAND;
>         vma->vm_flags &= ~VM_IO; /* using shared anonymous pages */
>         vma->vm_private_data = map;
>         dprintk(1,"mmap %p: q=%p %08lx-%08lx pgoff %08lx bufs %d-%d\n",
> 
> Somehow since 2.6.15-rc1 VM_RESERVED makes get_user_pages return EFAULT.
> I don't know the exact reason of that behavior and the correct way to fix
> that problem. Just kernel interfaces changed once again, the old
> point everyone knows. So if someone can explain it, that would be helpful.

This EFAULT rejection is due to change in  get_user_pages()  function
in mm/memory.c  file of  2.6.14-git2


@@ -945,8 +947,8 @@ int get_user_pages(struct task_struct *t
                        continue;
                }
 
-               if (!vma || (vma->vm_flags & VM_IO)
-                               || !(flags & vma->vm_flags))
+               if (!vma || (vma->vm_flags & (VM_IO | VM_RESERVED))
+                               || !(vm_flags & vma->vm_flags))
                        return i ? : -EFAULT;
 
                if (is_vm_hugetlb_page(vma)) {


I don't know how to use git tools to see, whose patch actually
did this particular change.


/Matti Aarnio
