Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312987AbSDLH53>; Fri, 12 Apr 2002 03:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSDLH52>; Fri, 12 Apr 2002 03:57:28 -0400
Received: from green.csi.cam.ac.uk ([131.111.8.57]:6586 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312987AbSDLH51>; Fri, 12 Apr 2002 03:57:27 -0400
Message-Id: <5.1.0.14.2.20020412080524.00ac6220@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 12 Apr 2002 08:57:17 +0100
To: torvalds@transmeta.com (Linus Torvalds)
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [prepatch] address_space-based writeback
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a95don$m5p$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:37 12/04/02, Linus Torvalds wrote:
>In article <5.1.0.14.2.20020412015633.01f1f3c0@pop.cus.cam.ac.uk>,
>Anton Altaparmakov  <aia21@cam.ac.uk> wrote:
> >At 21:20 11/04/02, Linus Torvalds wrote:
> >>
> >>It's not Andrew who is assuming anything: it _is_. Look at <linux/fs.h>,
> >>and notice the
> >>
> >>         struct inode            *host;
> >>
> >>part.
> >
> >Yes I know that. Why not extend address spaces beyond being just inode
> >caches? An address space with its mapping is a very useful generic data
> >cache object.
>
>Sure it is. And at worst you'll just have to have a dummy inode to
>attach to it.
>
>Could we split up just the important fields and create a new level of
>abstraction? Sure.  But since there are no major users, and since it
>would make the common case less readable, there simply isn't any point.

Ok, fair enough. While ntfs would not be the only fs to benefit, major fs 
like ext2/3 don't have named streams, EAs, bitmap attributes, and other 
data holding constructs except the traditial "file contents data stream" so 
they probably don't have the need for a new level of abstraction.

But that then leads to the question which fields in the dummy inode must be 
initialized. My biggest concern is whether i_ino needs to be unique or 
whether it can be copied from the real inode (or perhaps even better 
whether I can just set it to a value like minus one to signify to ntfs 
"treat as special").

ntfs will need to distinguish the dummies from the real inodes and not only 
that, it will need to know which ntfs attribute they signify. Admittedly 
that part is trivial as the ntfs specific part of the inode can contain a 
NI_Dummy flag in the ->state bits and that can then change the meaning of 
the remainder of the ntfs_inode structure.

A locking problem also arises. To write out a real inode, you need to lock 
down all the dummy inodes associated with it and vice versa, so you get 
into ab/ba deadlock country. Further, dirty inodes become interesting, what 
happens if the real inode is evicted from ram but the attached dummies are 
still around? Probably would lead to dereferencing random memory. )-: So 
one would need to extend ntfs_clear_inode to kill off all dummy inodes 
belonging to a real inode when the real inode is evicted. And that again 
brings the problems along of some of the dummies may be dirty and/or 
locked, so potential deadlocks again...

>Over-abstraction is a real problem - it makes the code less obvious, and
>if there is no real gain from it then over-abstracting things is a bad
>thing.

Fair comment but the current VM isn't exactly obvious either. </rant about 
lack of vm documentation> Understanding readpage and helpers was easy but 
the write code paths which I am trying to get my head round to are not 
funny once you get into the details...

> >Just a very basic example: Inode 0 on ntfs is a file named $MFT. It
> >contains two data parts: one containing the actual on-disk inode metadata
> >and one containing the inode allocation bitmap. At the moment I have placed
> >the inode metadata in the "normal" inode address_space mapping and of
> >course ->host points back to inode 0. But for the inode allocation bitmap I
> >set ->host to the current ntfs_volume structure instead and I am at present
> >using a special readpage function to access this address space.
>
>Why not just allocate a separate per-volume "bitmap" inode? It makes
>sense, and means that you can then use all the generic routines to let
>it be automatically written back to disk etc.

Yes, I could do. I guess I can grab one from fs/inode.c::new_inode(). Do I 
need to provide unique i_ino though?

>Also, don't you get the "ntfs_volume" simply through "inode->i_sb"? It
>looks like you're just trying to save off the same piece of information
>that you already have in another place. Redundancy isn't a virtue.

Yes, I can get it from there but I didn't want to use the original inode as 
->host as that would have had potential for breaking things in odd ways in 
the VM. Using "ntfs_volume" was more likely to give more obvious "BANG" 
type of errors instead... (-;

> >The mere fact that the VM requires to know the size of the data in an
> >address space just indicates to me that struct address_space ought to
> >contain a size field in it.
>
>It doesn't "require" it - in the sense that you can certainly use
>address spaces without using those routines that assume that it has an
>inode.  It just means that you don't get the advantage of the
>higher-level concepts.

Indeed. And that in turn means I have to duplicate a lot of functionality 
from the core kernel in ntfs which is always a Bad Thing.

For file access I can use block_read_full_page with only ONE line changed 
and that is the setting of the async io completion handler - NTFS requires 
its own as it has 3 different versions of i_size which need to be 
interpreted after the read from device in order to determine if any parts 
of the buffer head need to be zeroed out after the read (and there are 4 
i_size versions for compressed files). I don't see any way to do this at an 
earlier stage than io completion as some partial buffers need to be zeroed 
AFTER the io from disk has completed.

If there was a way to provide my custom handler to block_read_full_page or 
at least if end_buffer_is_async would allow a hook to be placed which would 
get run for each buffer head it is called with that would decrease the 
amount of code duplication quite a lot... But I guess this falls under the 
"there are no major users category"... )-:

> >So while something should be fixed I think it is the kernel and not 
> ntfs. (-;
>
>There are a few fundamental concepts in UNIX, and one of them is
>"everything is a file".
>
>And like it or not, the Linux concept of a file _requires_ an inode (it
>also requires a dentry to describe the path to that inode, and it
>requires the "struct file" itself).
>
>The notion of "struct inode" as the lowest level of generic IO entity is
>very basic in the whole design of Linux.  If you try to avoid it, you're
>most likely doing something wrong.  You think your special case is
>somehow independent and more important than one of the basic building
>blocks of the whole system.

Thanks for the reminder. I have obviously been digging around Windows/NTFS 
for too long so I had distanced myself from the concept. )-:

Yet, this really begs the question of defining the concept of a file. I am 
quite happy with files being the io entity in ntfs. It is just that each 
file in ntfs can contain loads of different data holding attributes which 
are all worth placing in address spaces. Granted, a dummy inode could be 
setup for each of those which just means a lot of wasted ram but ntfs is 
not that important so I have to take the penalty there. But if I also need 
unique inode numbers in those dummy inodes then the overhead is becoming 
very, very high...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

