Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131781AbRC0X6e>; Tue, 27 Mar 2001 18:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131833AbRC0X6P>; Tue, 27 Mar 2001 18:58:15 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:22646 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131736AbRC0X6H>;
	Tue, 27 Mar 2001 18:58:07 -0500
Message-Id: <200103272356.f2RNuT101368@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems 
In-Reply-To: Message from Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> 
   of "Tue, 27 Mar 2001 16:23:32 CST." <200103272223.QAA37189@tomcat.admin.navo.hpc.mil> 
Date: Tue, 27 Mar 2001 17:56:29 -0600
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Just a brief add to the discussion, besides which I have a vested interest
in this!

I do not believe that you can make the addressability of a device larger at
the expense of granularity of address space at the bottom end. Just because
ext2 has a single size for metadata does not mean everything you put on the
disks does. XFS filesystems, for example, can be made with block sizes from
512 bytes to 64Kbytes (ok not working on linux across this range yet, but it
will).

In all of these cases we have chunks of metadata which are 512 bytes
long, and we have chunks bigger than the blocksize.  The 512 byte chunks
are the superblock and the heads of the freespace structures, there
are multilples of them through the filesystem.

To top that, we have disk write ordering constraints that could mean that
for two of the 512 byte chunks next to each other one must be written to
disk now to free log space, the other must not be written to disk because it
is in a transaction. We would be forced to do read-modify-write down at
some lower level - wait the lower levels would not have the addressability.

There are probably other things which will not fly if you lose the
addressing granularity. Volume headers and such like would be one
possibility.

No I don't have a magic bullet solution, but I do not think that just
increasing the granularity of the addressing is the correct answer,
and yes I do agree that just growing the buffer_head fields is not
perfect either.

Steve Lord

p.s. there was mention of bigger page size, it is not hard to fix, but the
swap path will not even work with 64K pages right now.



