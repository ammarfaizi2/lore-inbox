Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbREZAmO>; Fri, 25 May 2001 20:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbREZAmE>; Fri, 25 May 2001 20:42:04 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:6396 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262268AbREZAlp>; Fri, 25 May 2001 20:41:45 -0400
Message-Id: <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 26 May 2001 01:42:20 +0100
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [Linux-NTFS-Dev] Re: ANN: NTFS new release available
  (1.1.15)
Cc: linux-kernel@vger.kernel.org, Linux-ntfs@tiger.informatik.hu-berlin.de,
        linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <3B0EF1DC.CD0DF4D7@mandrakesoft.com>
In-Reply-To: <5.1.0.14.2.20010526000503.04716ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:59 26/05/2001, Jeff Garzik wrote:
>Anton Altaparmakov wrote:
> > NTFS 1.1.15 - ChangeLog
> > =======================
> > - Support for more than 128kiB sized runlists (using vmalloc_32() instead
> > of kmalloc()).
>
>If you are running into kmalloc size limit, please consider some 
>alternative method of allocation.

Why? I was told that's what vmalloc is for. And anyway, Windows NT/2k 
operate on a 256kB sized memory allocation basis and NTFS has been designed 
with this in mind. Breaking away from that is a PITA. I was very happy to 
learn about vmalloc as it solved a lot of my headaches with regards to 
structures being >128kb.

btw. Maybe you, or someone else, can explain me whether vmalloc() will 
always work or whether vmalloc_32() is required? I am thinking of highmem 
pages which vmalloc could return. Would I have to make sure the pages were 
accessible by calling some function or is this done transparently?

>Can you map it into the page cache, as Al Viro has done in recent patches?

If someone would document how the page cache actually works from a kernel 
point of view, perhaps...<hint, hint> Sorry, but I haven't had the time to 
go through all the related source to understand it properly. I have an idea 
of how it works conceptually (well, kind of...) but not a deep enough 
understanding to start implementing anything that goes anywhere near the 
page cache.

I would love to move inode metadata to the page cache. That would simplify 
so much in the NTFS driver and would result in an incredible speed boost 
due to getting rid of all the silly copying of data back and forth inside 
the driver as we could just pass pointers around instead (to locked pages 
or other form of internal locking).

>Can you break your allocation into an array of pages, obtained via 
>get_free_page?

No thank you. I would rather have it contiguous or at least logically 
contiguous. I don't care if the pages are physically contiguous as long as 
I can see them as one piece... I mean, ok, I could break up run lists, as 
they are arrays of fixed size structs and the boundary cases would be 
predictable (but still would slow down the code with boundary checks) but 
this doesn't solve the generic problem later on as more things get 
implemented where we encounter variable width structures. It is much 
cleaner and easier to implement using a logically contiguous memory 
allocation IMHO. It's a shame Linux kernel doesn't support this kind of 
stuff (last time I read somewhere about this it said it doesn't anyway. I 
would be happy to be told wrong here).

>If runlists are on-disk structures, can you look at bh->b_data instead of 
>keeping them in memory?

They are not. They are derived from compressed on-disk structures (which 
are re-compressed when updating the inode). Runlists of such large size are 
only needed for A) huge files/directories, B) extremely fragmented 
files/directories, or C) a combination of A and B. (Remembering that 
metadata is stored as files, so the same applies for the metadata itself.)

Best regards,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

