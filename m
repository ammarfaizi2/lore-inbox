Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268156AbUIPSV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268156AbUIPSV4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUIPSTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:19:01 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46979 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268162AbUIPSOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:14:07 -0400
Date: Thu, 16 Sep 2004 14:13:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Having problem with mmap system call!!!
In-Reply-To: <1095350240.22750.37.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0409161404001.13362@chaos>
References: <4EE0CBA31942E547B99B3D4BFAB348111078FE@mail.esn.co.in> 
 <Pine.LNX.4.53.0409160958070.12146@chaos>  <1095341494.22744.26.camel@localhost.localdomain>
  <Pine.LNX.4.53.0409161050200.12305@chaos> <1095350240.22750.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Alan Cox wrote:

> On Iau, 2004-09-16 at 15:54, Richard B. Johnson wrote:
> > > SHM_FAIL is the wrong error check btw.
> > >
> >
> > MAP_FAILED only appeared in real late 'C' runtime library headers.
> > That's why the code defines SHM_FAIL, which is also correct, but
> > doesn't cause a redefinition error.
>
> SuS doesn't permit the use of SHM_FAIL. And you don't get redefinition
> errors if you use ds
>
> > Well that's really nice. Now, how do you do that? The kernel DS
> > is not the user DS so you end up with a kernel hack instead of
> > a user hack?
>
> Who cares about DS ? the user space page tables get mapped, its how all
> mmap functions work. A simple example is the sound drivers (2.4
> drivers/sound) which kmalloc a buffer of kernel space then make it
> mappable to the user
>

Alan,
Here is some code from a video driver.

static int vino_mmap(struct file *file, struct vm_area_struct *vma)
{
	struct video_device *dev = video_devdata(file);
	struct vino_device *v = dev->priv;
	unsigned long start = vma->vm_start;
	unsigned long size  = vma->vm_end - vma->vm_start;
	int i, err = 0;

	if (down_interruptible(&v->sem))
		return -EINTR;
	if (size > v->page_count * PAGE_SIZE) {
		err = -EINVAL;
		goto out;
	}
	for (i = 0; i < v->page_count; i++) {
		unsigned long page = virt_to_phys((void *)v->desc[i]);
		if (remap_page_range(start, page, PAGE_SIZE, PAGE_READONLY)) {
			err = -EAGAIN;
			goto out;
		}
		start += PAGE_SIZE;
		if (size <= PAGE_SIZE) break;
		size -= PAGE_SIZE;
	}
out:
	up(&v->sem);
	return err;

}

I deliberately used this as a sample so you can't say what
you usually say... Anyway are you aware that ...

	unsigned long size  = vma->vm_end - vma->vm_start;

... ends up being 32 bytes longer than the length the user-mode
code put into mmap()?

That's why I use a driver ioctl() to return the physical address
and the length so user-mode code can mmap() without the hassle
of "optimizations" (read kernel bugs) mucking with buffers,
especially those then end up overlapping because of bugs like
above.

Now, if somebody is having trouble with mmap(), it is quite
a bit better I believe, to reduce the basic user-mode mem-mapping
to its lowest common denominator. Therefore, I showed what was
guaranteed to work.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

