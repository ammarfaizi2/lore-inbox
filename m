Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUEEL7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUEEL7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 07:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264597AbUEEL7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 07:59:48 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:39324 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264585AbUEEL7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 07:59:40 -0400
Subject: Re: [BUG] 2.6.5 ntfs
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Marcin =?iso-8859-2?Q?Gibu=B3a?= <m.gibula@conecto.pl>
Cc: ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200405041957.38185.m.gibula@conecto.pl>
References: <200405031407.46408.m.gibula@conecto.pl>
	 <1083660979.6490.5.camel@imp.csi.cam.ac.uk>
	 <200405041957.38185.m.gibula@conecto.pl>
Content-Type: text/plain; charset=iso-8859-2
Organization: University of Cambridge Computing Service
Message-Id: <1083758242.916.42.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 12:57:23 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-04 at 18:57, Marcin Gibu³a wrote:
> > Could you do the following inside the configured kernel source directory
> > corresponding to the compiled kernel that produced this oops:
> >
> > make fs/ntfs/attrib.s
> 
> The kernel was compiled with gcc version 3.4.0 20040414 (prerelease), and I 
> have gcc 3.4 now, so I'm not sure if the results are the same... so, I 
> attached both new attrib.s and dissassembled attrib.o from previous 
> compilation (with this older gcc).

Thanks.  Using the attrib.o.asm you sent me, I can see where the oops
happened.  It is on line 566 in fs/ntfs/attrib.c:

for (dend = di; drl[dend].length; dend++)
	;

The oops happened when drl[dend].length is accessed and from the
register dump in the oops I can see that this came after a dend++ was
executed, i.e. not on the first access to drl[dend].length.

Also, ecx is e0b12010 which is is 0x10 bytes into a page boundary
(assuming your system uses 4kib pages which is likely to be the case).

Further, from eax and edx it would imply that the last drl[dend].length
was equal to 0xff807362ff746957 which is a non-sense value.

The only way this could happen is if drl was not terminated (i.e.
drl[last element].length was not set to zero) and hence the for loop
just kept going accessing random memory contents until it hit the end of
the page and overflowed into the next one which caused the oops.

The run list code was very heavily tested at the time it was written and
it hasn't been touched since, so I doubt very much that this was caused
in the run list code of ntfs.  Doubly so as you say that you cannot
reproduce the bug so the driver would have needed to manage to do two
different things with the same data at two different times which seems
extremely unlikely to me...

If I am correct and there is no bug in the run list code of ntfs, the
only possible explanation is that either other kernel code caused memory
corruption (i.e. a bug in some other kernel code trampled over ntfs
allocated memory) or what is much more likely is that you have flakey
memory and a flipped bit caused the length of the last element of drl to
not be zero any more.  Have you ever run memtest on your machine?

> > Also could you tell me which Windows version the ntfs partition was
> > created with and which windows version last accessed the files?
> 
> It was created with Windows 2000 or Windows XP, I really don't remember which 
> was that, is there some utility to check this?
> 
> Windows XP last accessed this partition.
> 
> > Finally is this bug reproducible when you access a particular file or is
> > it a once off event?  If a particular file, then would you mind running
> > a utility that I can email you (source or binary or both whichever you
> > prefer) so I can capture the metadata for the inode of the file?
> 
> I was trying to reproduce this bug with cat * > /dev/null but the only thing 
> I've triggered was this warning:
> 
> NTFS-fs error: ntfs_decompress(): Failed. Returning -EOVERFLOW.
> NTFS-fs error (device hde4): ntfs_read_compressed_block(): ntfs_decompress() 
> failed in inode 0x78a with error code 75. Skipping this compression block.
> 
> But no oops ... 
> If you want I can run whatever is necessary.

If you run "chkdsk /f" from windows on this partition, does it detect
any errors?

Assuming chkdsk doesn't detect and fix any errors, this would definitely
be worth investigating.  I don't think it has anything to do with the
oops but I would very much like a copy of this inode because it might
mean our decompression code has a bug in it and I want to check this
out.  To create a copy, I will assume you have the latest ntfsprogs
installed, then use ntfscat to dump your $MFT like this:

ntfscat -i 0 /dev/hde4 > ~/mymftdump

This will create a rather large file.  You can compress it with bzip -9
and if this is small enough, please email it to me (my email will accept
up to 10Mib attachments) or make it available for me to download on the
internet.  If this is not workable for you then proceed as follows to
copy the specific inode 0x78a (= 1930 in decimal) out of the file:

dd if=~/mymftdump of=~/inode0x78a bs=1024 count=1 skip=1930

And then email me the file ~/inode0x78a (this is only 1kiB in size).

Once this is done I will email you with more instructions on how to get
the rest of the data I need (i.e. the compressed data of the file which
is causing the overflow).

I am afraid I am too busy at work at the moment to write a utility to
get the data automatically...  Your help is very much appreciated.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/


