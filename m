Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313132AbSDLBPB>; Thu, 11 Apr 2002 21:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313196AbSDLBPA>; Thu, 11 Apr 2002 21:15:00 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:63186 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313132AbSDLBO7>; Thu, 11 Apr 2002 21:14:59 -0400
Message-Id: <5.1.0.14.2.20020412015633.01f1f3c0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 12 Apr 2002 02:15:21 +0100
To: torvalds@transmeta.com (Linus Torvalds)
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [prepatch] address_space-based writeback
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a94r5k$m23$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:20 11/04/02, Linus Torvalds wrote:
>In article <5.1.0.14.2.20020410235415.03d41d00@pop.cus.cam.ac.uk>,
>Anton Altaparmakov  <aia21@cam.ac.uk> wrote:
> >
> >Um, NTFS uses address spaces for things where ->host is not an inode at all
> >so doing host->i_sb will give you god knows what but certainly not a super
> >block!
>
>Then that should be fixed in NTFS.
>
>The original meaning of "->host" was that it could be anything (and it
>was a "void *", but the fact is that all the generic VM code etc needed
>to know about host things like size, locking etc, so for over a year now
>"host" has been a "struct inode", and if you need to have something
>else, then that something else has to embed a proper inode.
>
> >As long as your patches don't break that is possible to have I am happy...
> >But from what you are saying above I have a bad feeling you are somehow
> >assuming that a mapping's host is an inode...
>
>It's not Andrew who is assuming anything: it _is_. Look at <linux/fs.h>,
>and notice the
>
>         struct inode            *host;
>
>part.

Yes I know that. Why not extend address spaces beyond being just inode 
caches? An address space with its mapping is a very useful generic data 
cache object.

Requiring a whole struct inode seems silly. I suspect (without in depth 
knowledge of the VM yet...) the actual number of fields in the struct inode 
being used by the generic VM code is rather small... They could be split 
away from the inode and moved into struct address_space instead if that is 
where they actually belong...

Just a very basic example: Inode 0 on ntfs is a file named $MFT. It 
contains two data parts: one containing the actual on-disk inode metadata 
and one containing the inode allocation bitmap. At the moment I have placed 
the inode metadata in the "normal" inode address_space mapping and of 
course ->host points back to inode 0. But for the inode allocation bitmap I 
set ->host to the current ntfs_volume structure instead and I am at present 
using a special readpage function to access this address space. Making 
->host point back to the original inode 0 makes no sense as i_size for 
example would be the size of the other address space - the inode data one. 
(And faking an inode is not fun, then I would have to keep track of fake 
inodes, etc, and the kernel already restricts us to only 32-bits worth of 
inodes while ntfs uses s64 for that... and inode locking than becomes even 
more interesting than it already is...)

The mere fact that the VM requires to know the size of the data in an 
address space just indicates to me that struct address_space ought to 
contain a size field in it.

So while something should be fixed I think it is the kernel and not ntfs. (-;

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

