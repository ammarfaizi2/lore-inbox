Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129248AbQKVWKO>; Wed, 22 Nov 2000 17:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129385AbQKVWKE>; Wed, 22 Nov 2000 17:10:04 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:41994 "EHLO
        wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
        id <S129248AbQKVWJ5>; Wed, 22 Nov 2000 17:09:57 -0500
To: linux-kernel@vger.kernel.org
cc: Keir.Fraser@cl.cam.ac.uk
Subject: Re: Address translation
Date: Wed, 22 Nov 2000 21:39:51 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E13yhcO-0003qy-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason that everyone else uses copy_{to,from}_user is that there
> is no way to guarantee that the userspace pointer is valid. That
> memory may have been swapped out. The copy macros are prepared to
> fault the memory in. The rest of the kernel is not.
>
> Jeff

I may be wrong on this, but I thought that copy_{to,from}_user are
only necessary if the address range you are accessing might cause a
fault which Linux cannot handle (ie. one which would cause the
application to segfault if it accessed that memory). If it is only a
matter of paging the memory in (and you are _sure_ the address range is
otherwise valid) I think the access macros are unnecessary. I would be
*very* glad if someone could confirm this, or shoot me down. :)

For instance, a kernel module I am writing allocates some memory in
the current process's address space as follows:

    down(&mm->mmap_sem);
    s->table = (void **)get_unmapped_area(0, SIZEOF_TABLE);
    if ( s->table != NULL )
        do_brk((unsigned long)s->table, SIZEOF_TABLE);
    up(&mm->mmap_sem);

Some questions:
 (1) In a "top half" thread, can I now access this memory without the
     access macros (since I know the address range is valid)?
 (2) Can I also access this memory from an interrupt/exception
     context, or must I lock it? (ie. can faults be handled from such
     a context) 
 (3) Is the above code sensible at all, or barking? It took me a while
     to figure that the above would work, and I think/hope it is the
     most elegant way to share memory between kernel and a process.

 Thanks in advance for any info!
 -- Keir Fraser

PS. Please cc me directly (kaf24@cl.cam.ac.uk) with any replies.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
