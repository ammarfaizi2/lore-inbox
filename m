Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130367AbQKWVoD>; Thu, 23 Nov 2000 16:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130340AbQKWVny>; Thu, 23 Nov 2000 16:43:54 -0500
Received: from laurin.munich.netsurf.de ([194.64.166.1]:13699 "EHLO
        laurin.munich.netsurf.de") by vger.kernel.org with ESMTP
        id <S129295AbQKWVQL>; Thu, 23 Nov 2000 16:16:11 -0500
Date: Thu, 23 Nov 2000 21:23:15 +0100
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Address translation
Message-ID: <20001123212315.C4886@storm.local>
Mail-Followup-To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E13yhcO-0003qy-00@wisbech.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13yhcO-0003qy-00@wisbech.cl.cam.ac.uk>; from Keir.Fraser@cl.cam.ac.uk on Wed, Nov 22, 2000 at 09:39:51PM +0000
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2000 at 09:39:51PM +0000, Keir Fraser wrote:
> > The reason that everyone else uses copy_{to,from}_user is that there
> > is no way to guarantee that the userspace pointer is valid. That
> > memory may have been swapped out. The copy macros are prepared to
> > fault the memory in. The rest of the kernel is not.
> >
> > Jeff
> 
> I may be wrong on this, but I thought that copy_{to,from}_user are
> only necessary if the address range you are accessing might cause a
> fault which Linux cannot handle (ie. one which would cause the
> application to segfault if it accessed that memory). If it is only a
> matter of paging the memory in (and you are _sure_ the address range is
> otherwise valid) I think the access macros are unnecessary. I would be
> *very* glad if someone could confirm this, or shoot me down. :)

It is wrong.  copy_*_user handle the page faults, whether they are good
faults (swapped out, copy on write) or bad faults (illegal access).
Without these macros you get the "unable to handle kernel page fault"
oops message if a fault occurs.

> For instance, a kernel module I am writing allocates some memory in
> the current process's address space as follows:
> 
>     down(&mm->mmap_sem);
>     s->table = (void **)get_unmapped_area(0, SIZEOF_TABLE);
>     if ( s->table != NULL )
>         do_brk((unsigned long)s->table, SIZEOF_TABLE);
>     up(&mm->mmap_sem);
> 
> Some questions:
>  (1) In a "top half" thread, can I now access this memory without the
>      access macros (since I know the address range is valid)?

The address is valid, the pages probably aren't.  In fact, extending the
address space only creates read-only mappings to the global zeroed page
if I remember right.

>  (2) Can I also access this memory from an interrupt/exception
>      context, or must I lock it? (ie. can faults be handled from such
>      a context) 

You can't even use copy_*_user in this context (since the current user
space might be any process, even kernel threads that have no user space
at all).

For access to user memory from interrupt context at all and to access
user memory without the uaccess macros, you have to lock them down in
memory, with map_user_kiobuf().  This is only recommended if you want
hardware to DMA to/from buffers provided by user space.

>  (3) Is the above code sensible at all, or barking? It took me a while
>      to figure that the above would work, and I think/hope it is the
>      most elegant way to share memory between kernel and a process.

It will fail quickly, probably taking the kernel down with it.

The most elegant way to share memory between user and kernel is to
allocate the memory in the kernel and map it to user space (by
implementing mmap  on the kernel side for the file used for
communication).

-- 
 Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
http://home.pages.de/~andreas.bombe/    http://linux1394.sourceforge.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
