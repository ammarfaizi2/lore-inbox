Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154292-8100>; Fri, 15 Jan 1999 02:42:07 -0500
Received: by vger.rutgers.edu id <153682-8100>; Fri, 15 Jan 1999 02:41:55 -0500
Received: from apollo.is.co.za ([196.4.160.2]:50886 "EHLO apollo.is.co.za" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154250-8100>; Fri, 15 Jan 1999 02:41:18 -0500
Date: Fri, 15 Jan 1999 09:40:45 +0200 (SAST)
From: Craig Schlenter <craig@is.co.za>
To: linux-kernel@vger.rutgers.edu
Subject: Review and report of linux kernel VM (fwd)
Message-ID: <Pine.LNX.4.04.9901150936240.464-100000@flashy.is.co.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


I don't know if anyone has forwarded this to the list yet but I haven't
seen it ... some commentry from the linux MM guru's would be valuable.

Thank you,

--Craig

Date: Wed, 13 Jan 1999 23:20:22 -0800 (PST)
From: Matthew Dillon <dillon@apollo.backplane.com>
Message-Id: <199901140720.XAA22609@apollo.backplane.com>
To: "John S. Dyson" <root@dyson.iquest.net>, dg@root.com, jkh@FreeBSD.ORG
Cc: hackers@FreeBSD.ORG
Subject: Review and report of linux kernel VM
Sender: owner-freebsd-hackers@FreeBSD.ORG
Precedence: bulk
X-Loop: FreeBSD.ORG

				General Overview

    I've been looking at the linux kernel VM - mainly just to see what they've
    changed since I last looked at it.  It's quite interesting... not bad at
    all though it is definitely a bit more memory-resource-intensive then
    FreeBSD's.  However, it needs a *lot* of work when it comes to freeing 
    up pages. 

    I apologize in advance for any mistakes I've made!

    Basically, the linux kernel uses persistent hardware-level page tables
    in a mostly platform-independant fashion.  The function of the persistent
    page tables is roughly equivalent to the function of FreeBSD's vm_object's.
    That is, the page tables are used to manage sharing and copy-on-write
    functions for VM objects.

    For example, when a process fork()'s, pages are duplicated literally by
    copying pte's.  Writeable MAP_PRIVATE pages are write-protected and marked
    for copy-on-write.  A global resident-page array is used to keep track
    of shared reference counts.  

    Swapped-out pages are also represented by pte's and also marked for 
    copy-on-write as appropriate.  The swap block is stored in the PFN 
    area of the pte (as far as I can tell).  The swap system keeps a separate
    shared reference count to manage swap usage.  The overhead is around 
    3 bytes per swap page (whether it is in use or not), and another pte-sized
    (int usually) field when storing the swap block in the pagetable.

    Linux cannot swap out its page tables, mainly due to the direct use of
    the page tables in handling VM object sharing.

    In general terms, linux's VM system is much cleaner then FreeBSD's... and
    I mean a *whole lot* cleaner, but at the cost of eating some extra memory.
    It isn't a whole lot of extra memory - maybe a meg or two for a typical
    system managing a lot of processes, and much less for typical 'small'
    systems.  They are able to completely avoid the vm_object stacking
    (and related complexity) that we do, and they are able to completely
    avoid most of the pmap complexity in FreeBSD as well.

    Linux appears to implement a unified buffer cache.  It's pretty 
    straight forward except the object relationship is stored in
    the memory-map management structures in each process rather then
    in a vm_object type of structure.

    Linux appears to map all of physical memory into KVM.  This avoids
    FreeBSD's (struct buf) complexity at the cost of not being able to 
    deal with huge-memory configurations.  I'm not 100% sure of this, but
    its my read of the code until someone corrects me.

				Problems

    Swap allocation is terrible.  Linux uses a linear array which it scans
    looking for a free swap block.  It does a relatively simple swap
    cluster cache, but eats the full linear scan if that fails which can be
    terribly nasty.  The swap clustering algorithm is a piece of crap, 
    too -- once swap becomes fragmented, the linux swapper falls on its face.
    It does read-ahead based on the swapblk which wouldn't be bad if it
    clustered writes by object or didn't have a fragmentation problem.
    As it stands, their read clustering is useless.  Swap deallocation is 
    fast since they are using a simple reference count array. 

    File read-ahead is half-hazard at best.

    The paging queues ( determing the age of the page and whether to 
    free or clean it) need to be written... the algorithms being used
    are terrible.

     * For the nominal page scan, it is using a one-hand clock algorithm.  
       All I can say is:  Oh my god!  Are they nuts?  That was abandoned
       a decade ago.  The priority mechanism they've implemented is nearly
       useless.

     * To locate pages to swap out, it takes a pass through the task list. 
       Ostensibly it locates the task with the largest RSS to then try to
       swap pages out from rather then select pages that are not in use.
       From my read of the code, it also botches this badly.

    Linux does not appear to do any page coloring whatsoever, but it would
    not be hard to add it in.

    Linux cannot swap-out its page tables or page directories.  Thus, idle
    tasks can eat a significant amount of memory.  This isn't a big deal for
    most systems ( small systems: no problem.  Big systems: probably have lots
    of memory anyway ).  But, mmap()'d files can create a significant burden
    if you have a lot of forked processes ( news, sendmail, web server, 
    etc...).  Not only does Linux have to scan the page tables for all the
    processes mapping the file, whether or not they are actively using the
    page being checked for, but Linux's swapout algorithm scans page tables
    and, effectively, makes redundant scans of shared objects.

			     What FreeBSD can learn

    Well, the main thing is that the Linux VM system is very, very clean
    compared to the FreeBSD implementation.  Cleaning up FreeBSD's VM system
    complexity is what I've been concentrating on and will continue to 
    concentrate on.   However, part of the reason that FreeBSD's VM system 
    is more complex is because it does not use the page tables to store 
    reference information.  Instead, it uses the vm_object and pmap modules.
    I actually like this feature of FreeBSD.  A lot. 

    The biggest thing we need to do to clean up our VM system is, basically,
    to completely rewrite the struct buf filesystem buffering mechanism to
    make it much, much less complex - basically it should only be used as
    placeholders for read and write ops and not used to cache block number
    mappings between the files and the VM system, nor should it be used to
    map pages into KVM.  Separating out these three mechanisms into three
    different subsystems would simplify the code enormously, I think.  For
    example, we could implement a simple vm_object KVM mapping mechanism
    using FreeBSD's existing vm_object stacking model to map portions of a
    vm_object (aka filesystem partition) into KVM.

    Linux demarks interrupts from supervisor code much better then we do.
    If we move some of the more sophisticated operational capabilities
    out of our interrupt subsystem, we could get rid of most of the spl*()
    junk we currently have to do.  This is a real sore spot in current
    FreeBSD code.  Interrupts are just too complex.  I'd also get rid of
    FreeBSD's intermediate 'software interrupt' layer, which is able to
    do even more complex things then hard interrupt code.  The latency
    considerations just don't make any sense verses running pending software
    interrupts synchronously in tsleep(), prior to actually sleeping.  We 
    need to do this anyway ( or move softints to kernel threads ) to be able
    to take advantage of SMP mechanisms.  The *only* thing our interrupts
    should be allowed to do is finish I/O on a page or use zalloc().  

						-Matt

					Matthew Dillon 
					<dillon@backplane.com>


To Unsubscribe: send mail to majordomo@FreeBSD.org
with "unsubscribe freebsd-hackers" in the body of the message

----- End of forwarded message from Matthew Dillon -----



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
