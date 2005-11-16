Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbVKPMvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbVKPMvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbVKPMvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:51:35 -0500
Received: from t111.niisi.ras.ru ([193.232.173.111]:39056 "EHLO
	t111.niisi.ras.ru") by vger.kernel.org with ESMTP id S965249AbVKPMvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:51:35 -0500
Subject: Re: [x86_64] 2.6.14-git13 mplayer fails with "v4l2: ioctl queue
	buffer failed: Bad address" (2 Nov 2005, 11 Nov 2005)
From: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       Junichi Uekawa <dancer@netfort.gr.jp>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Michael Krufky <mkrufky@m1k.net>,
       linux-kernel@vger.kernel.org, debian-amd64@lists.debian.org
In-Reply-To: <20051113025417.GN5706@mea-ext.zmailer.org>
References: <87fyqeicge.dancerj%dancer@netfort.gr.jp>
	 <87wtjg5gh2.dancerj%dancer@netfort.gr.jp> <4373D087.5050908@linuxtv.org>
	 <87psp859sd.dancerj%dancer@netfort.gr.jp> <43740F06.6030504@m1k.net>
	 <87y83vl780.dancerj%dancer@netfort.gr.jp>
	 <87ek5nb9ec.dancerj%dancer@netfort.gr.jp>
	 <Pine.LNX.4.61.0511111355080.16161@goblin.wat.veritas.com>
	 <1131834172.8368.6.camel@localhost.localdomain>
	 <20051113025417.GN5706@mea-ext.zmailer.org>
Content-Type: text/plain; charset=KOI8-R
Date: Wed, 16 Nov 2005 15:50:54 +0300
Message-Id: <1132145454.12638.8.camel@t94>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В Вск, 13/11/2005 в 04:54 +0200, Matti Aarnio пишет:
> On Sun, Nov 13, 2005 at 01:22:51AM +0300, Nickolay V. Shmyrev wrote:
> > Hello all.
> > 
> > We have even found the hack that fix that problem:
> 
> A hack, but working one..
> (for the small while that I tested it)
> 
> > Index: linux/drivers/media/video/video-buf.c
> > ===================================================================
> > RCS file: /cvs/video4linux/v4l-kernel/linux/drivers/media/video/video-buf.c,v
> > retrieving revision 1.21
> > diff -u -p -r1.21 video-buf.c
> > --- linux/drivers/media/video/video-buf.c       16 Oct 2005 12:13:58 -0000
> > +++ linux/drivers/media/video/video-buf.c       12 Nov 2005 22:19:13 -0000
> > @@ -1248,7 +1248,7 @@ int videobuf_mmap_mapper(struct videobuf
> >         map->end      = vma->vm_end;
> >         map->q        = q;
> >         vma->vm_ops   = &videobuf_vm_ops;
> > -       vma->vm_flags |= VM_DONTEXPAND | VM_RESERVED;
> > +       vma->vm_flags |= VM_DONTEXPAND;
> >         vma->vm_flags &= ~VM_IO; /* using shared anonymous pages */
> >         vma->vm_private_data = map;
> >         dprintk(1,"mmap %p: q=%p %08lx-%08lx pgoff %08lx bufs %d-%d\n",
> > 
> > Somehow since 2.6.15-rc1 VM_RESERVED makes get_user_pages return EFAULT.
> > I don't know the exact reason of that behavior and the correct way to fix
> > that problem. Just kernel interfaces changed once again, the old
> > point everyone knows. So if someone can explain it, that would be helpful.
> 
> This EFAULT rejection is due to change in  get_user_pages()  function
> in mm/memory.c  file of  2.6.14-git2
> 
> 
> @@ -945,8 +947,8 @@ int get_user_pages(struct task_struct *t
>                         continue;
>                 }
>  
> -               if (!vma || (vma->vm_flags & VM_IO)
> -                               || !(flags & vma->vm_flags))
> +               if (!vma || (vma->vm_flags & (VM_IO | VM_RESERVED))
> +                               || !(vm_flags & vma->vm_flags))
>                         return i ? : -EFAULT;
>  
>                 if (is_vm_hugetlb_page(vma)) {
> 
> 
> I don't know how to use git tools to see, whose patch actually
> did this particular change.
> 
> 
> /Matti Aarnio


It's sad, but I still don't understand the way it should be fixed.
Removal of VM_RESERVED is certainly not a solution, since we don't going
to swap mmaped pages and VM_RESERVED is used in other drivers (for
example, some sound drivers)

So, we need to find the problem itself. After looking at the code I've
found that the x86_64 dependency of that problem lies in the check in
memory.c:get_user_pages

if (vma && in_gate_area (task, start))

x86_64 defines it's own arch-dependant function in_gate_area which fails
in our case. Can someone trace that code and find why do we fail and
fail only on x86_64. It would be nice if someone could point me to
get_user_pages documentation, why it's so differently behaves for 64 bit
arch.

Also it seems that I had traces of video-buf module with debug enabled
on 64 bit, but lost them. Can someone just enable debug option to video-
buf module and collect those traces.



