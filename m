Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318958AbSICWOx>; Tue, 3 Sep 2002 18:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318963AbSICWOx>; Tue, 3 Sep 2002 18:14:53 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:45467 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318958AbSICWOw>; Tue, 3 Sep 2002 18:14:52 -0400
Message-Id: <5.1.0.14.2.20020903230434.00ac6c50@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 03 Sep 2002 23:19:21 +0100
To: "Peter T. Breuer" <ptb@it.uc3m.es>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Cc: david.lang@digitalinsight.com, linux-kernel@vger.kernel.org
In-Reply-To: <200209032148.g83LmWU14950@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:48 03/09/02, Peter T. Breuer wrote:
>What one has to get rid of is cached metadata state. I'm open to suggestions.

This is crazy. I don't think you understand what that actually implies. I 
will give you a real world example below.

> > even for ext2 there are people (including linus I believe) that are saying
> > that major new features should not be added to ext2, but to a new
>
>I agree! But I wouldn't see adding VFS ops to replace FS-specific
>code as a new feature, rather a consolidation of common codes.

But you are not consolidating common code. There is no common code. Each fs 
performs allocations in completely different ways and according to 
completely different strategies because of the different methods of how the 
metadata is stored/organized.

And here is the promised example: what we need to do in order to read one 
single byte from the middle of a large file on an NTFS volume assuming that 
no metadata whatsoever is cached:

- read boot sector to find start of inode table
- read start of inode table, decompress mapping pairs array into memory (oh 
shit, we are caching something already! but how else will you make sense of 
compressed metadata?!?) in order to find out where on disk the inodes are 
stored
- unfortunately the inode we want is not described by the start of the 
inode table, drat, using the above metadata & decompressed metadata, we 
determine where the next piece of the inode table is described
- we read next piece of inode table, decompress the mapping pairs array, 
and finally we find where on disk the inode is located (yey!)
- we read the inode from disk
- we decompress the mapping pairs array telling us where the inode's data 
is stored
- unfortunately the data byte we want is not described by the base inode of 
the file, so we need to read an extent inode, but shit, we aren't caching 
anything!!!, so we don't know where the inode is stored on disk, so we have 
to repeat _the_whole_ procedure described above just to be able to read the 
extent inode
- having repeated all the above we read the extent inode, decompress the 
mapping pairs array and finally locate where on disk the data we want is 
located
- we read 1 byte from disk from the determined location

Ok, so to do a 1 byte read, we just had to perform over 10-20 reads from 
very different disk locations (we are talking several seconds _just_ in 
seek times, never mind read times!), we had to allocate a lot of memory 
buffers to store metadata which we have read from disk temporarily, as well 
as a lot of memory in order to be able to decompress the mapping pair 
arrays which tell us the logical to physical block mapping.

I am completely serious, we are talking at least hundreds of milliseconds 
possibly even several seconds to read that single byte.

What was that about 50GiB/sec performance again...?

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

