Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292045AbSBYRiH>; Mon, 25 Feb 2002 12:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293397AbSBYRh6>; Mon, 25 Feb 2002 12:37:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58896 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292045AbSBYRhl>; Mon, 25 Feb 2002 12:37:41 -0500
Subject: Re: [PATCH] Lightweight userspace semaphores...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 25 Feb 2002 17:50:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rusty@rustcorp.com.au (Rusty Russell),
        mingo@elte.hu, matthew@hairy.beasts.org (Matthew Kirkwood),
        bcrl@redhat.com (Benjamin LaHaise), david@mysql.com (David Axmark),
        wli@holomorphy.com (William Lee Irwin III),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202250919580.4567-100000@home.transmeta.com> from "Linus Torvalds" at Feb 25, 2002 09:20:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fPGp-0005bj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 25 Feb 2002, Alan Cox wrote:
> >
> > As opposed to adding special cases to the kernel which are unswappable and
> > stand to tangle up bits of the generic vfs - eg we would have a vma with
> > a vm_file but that file would not be in the dcache ?
> 
> Why should they be unswappable?

Any kernel special cases it adds will be unswappable because they are in
kernel space (not the semaphores here - we want them to be swappable and
they can be)

> It's the same thing as giving a -1 to mmap. That doesn't make it
> unswappable.

When you create a shared mapping by passing -1 to mmap we do

        } else if (flags & MAP_SHARED) {
                error = shmem_zero_setup(vma);

shmem_zero_setup does

        file = shmem_file_setup("dev/zero", size);
        if (IS_ERR(file))
                return PTR_ERR(file);

        if (vma->vm_file)
                fput (vma->vm_file);
        vma->vm_file = file;
        vma->vm_ops = &shmem_vm_ops;

and we are back creating file names. Basically because a shared mmap in
Linux needs vma->vm_file, and vma->vm_file needs all the rest of the logic
behind it

Thats why I am saying that magic name picking is something that user space
might as well do for unnamed objects. We end up with names and vm_file
however we do it
