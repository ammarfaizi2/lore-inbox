Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSEEKLq>; Sun, 5 May 2002 06:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSEEKLp>; Sun, 5 May 2002 06:11:45 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:25173 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S293135AbSEEKLo>; Sun, 5 May 2002 06:11:44 -0400
Message-Id: <5.1.0.14.2.20020505104136.048e1dc0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 05 May 2002 11:11:53 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [RFC][PATCH] Introduce fs/inode.c/init_address_space().
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD4A00E.7B709CC1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:59 05/05/02, Andrew Morton wrote:
>Anton Altaparmakov wrote:
> >
> > Hi, the below patch adds a new exported functon init_address_space() and
> > two inline helpers to share code between it and inode_init_once() and
> > alloc_inode().
> >
> > This function allows file systems to initialize private address spaces
> > without the need to know about the address space internals.
>
>Looks good to me, Anton.  Assuming it boots and runs and stuff ;)

Of course. I probably should have mentioned that I tested it both for 
compile, boot and run for a while before posting... (-8 The kernel then 
panic()ed in the ide code when I did a stress test but I don't think that 
is related to my patch considering the current "fragility" of the ide core 
and I am also using the new TCQ code... (The back trace being: 
blk_queue_invalidate_tags, tcq_invalidate_queue, ide_dmaq_complete, 
ide_dmaq_intr, ata_irq_request, ide_dmaq_intr, handle_IRQ_event, do_IRQ, 
ideprobe_init.)

>Maybe sometime we should allocate the address_space separately
>from the inode - may get better slab packing.  But that's a
>separate exercise.
>
> > Andrew, not sure what you have in mind for the future of ra_pages, so for
> > now I am just passing in the super block to init_address_space. Is that
> > ok?
>
>I'll test it a bit.

Cool.

During my good night's sleep I was thinking about the need for 
init_address_space a bit more. At the moment ntfs would be a user of it. 
However, Linus convinced me a while ago that the i/o entity is the struct 
inode, and not the struct address_space, so I have planned for ntfs to use 
fake inodes to back all private address spaces which of course means that 
the address_space initialization will move away from ntfs and be left to 
inode.c functionality at inode allocation time. Before I can do this, we 
will need to extend the VFS a bit (see recent threads on linux-fsdevel) so 
that I don't have to use the read_inode2 abomination. That way ntfs 
benefits from the init_once optimization at the same time. But for the 
interim init_address_space would be good so ntfs doesn't break with the 
next address space change. (-;

>The "future of ra_pages" is worth discussion.  We have all these
>lovely abstraction layers in the kernel but unfortunately, the
>real world sometimes comes up and whacks you in the head.  The very
>high-level code needs to know stuff about the very low-level device.
>
>The case in point is the chosen device readahead.  It lives in the
>request queue, so it is device-wide, which is logical.
>
>Also, the high-level code needs to know the answer to the question
>"is there currently a pdflush thread writing to this device"?  And
>again, that is a device-wide thing which needs visibility at very
>high levels.  It's a waste of resources to have more than one
>pdflush thread blocked against a request queue.
>
>At present I have all this dopey code in there with superblock flags
>and local flags and stuff which tries to prevent the kernel from
>launching multiple pdflush threads against the same device.  It doesn't
>work very well.  It needs a device-wide test-and-set flag in the request
>queue.
>
>So for this, `unsigned int ra_pages' will become `struct backing_device_info'
>or somesuch.  It will hold ra_pages and the pdflush exclusion flag.
>
>
>One other thing which high-level code needs to know about the underlying
>device is the nominal write bandwidth.  If we know this then we can start
>to make better writeback throttling decisions - avoid flooding the
>machine with data which is dirty against really slow devices.  That will
>be a complex task, but struct backing_device_info is the place to keep that
>information.
>
>So ra_pages is a damn great layering violation, one which we simply
>have to have.  The aim is to encapsulate that in as clean a way as
>we can, in a way which is also useful to non-request_queue-backed
>address_spaces.  Such as NFS.   At present, NFS shares default_ra_pages
>with all other non-request_queue-backed address_spaces.  But it could
>define its own ra_pages (later backing_device_info) and make its
>address_spaces point at that at inode init time.

It may be a layering violation but it makes sense. I think it was Andre who 
started this with his taskfile i/o and passing information from the bottom 
h/w layer up to the higher layers. You effectively want something similar. 
I like your current approach of using a pointer to backing device data 
rather than copying it. Allows for easy configuration of the backing device 
through the higher layers and no need to update anything if someone 
reconfigures the device at a lower level (or any level for that matter).

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

