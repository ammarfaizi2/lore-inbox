Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318787AbSH1Idn>; Wed, 28 Aug 2002 04:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSH1Idn>; Wed, 28 Aug 2002 04:33:43 -0400
Received: from fungus.teststation.com ([212.32.186.211]:58896 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S318787AbSH1Idm>; Wed, 28 Aug 2002 04:33:42 -0400
Date: Wed, 28 Aug 2002 10:36:29 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: jaharkes@cs.cmu.edu, <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Loop devices under NTFS
In-Reply-To: <200208280149.SAA07234@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0208280956070.26490-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002, Adam J. Richter wrote:

> On Tue, 27 Aug 2002 at 13:26:44 -0400, Jan Harkes wrote:
> >Not all filesystems use generic_read/generic_write. If they did we
> >wouldn't need those calls in the fops structure.
> 
> 	My loop.c patch supports files that do not provide
> aops->{prepare,commit}_write (derived from changes by Jari Ruusu
> and Andrew Morton).
> 
> 	Christoph was arguing that even if the file provides
> aops->{prepare,commit}_write, that there could be a problem using it.
> I am looking for a clear example of that.  I don't see the problem
> with using this facility if you first check that it is provided.

smbfs has aops but when used with the current loop.c it corrupts the file
it is using. I can't say that the error is in loop.c but it is the only
way I can trigger the corruption and the smbfs aops (locking) aren't all
that different from the nfs ones.

Here is an example:

# dd if=/dev/zero of=/opt/src/smbfs/share/iozone.tmp bs=1024 count=200000
(/opt/src/smbfs/share is exported by a localhost samba as tmp)
# mount -t -o guest //localhost/tmp /mnt/smb
# losetup /dev/loop0 /mnt/smb/iozone.tmp
# mke2fs /dev/loop0
# mount /dev/loop0 /mnt/tmp
# cp -a ~puw/src/linux/linux-2.4.18/* /mnt/tmp
<something>: Input/Output error
# dmesg
EXT2-fs error (device loop(7,0)): read_block_bitmap: Cannot read block 
bitmap - block_group = 0, block_bitmap = 3
EXT2-fs error (device loop(7,0)): read_block_bitmap: Cannot read block 
bitmap - block_group = 21, block_bitmap = 172033

I can't say that I understand the problem, and maybe it can be explained
by a need for revalidate as Christoph said earlier in this thread. But
there should be no size changes and any revalidate shouldn't change
anything.

When I asked what a filesystem must do to support loop on linux-fsdevel
(May) AM suggested changing loop to use file->read/write (yes, he cleverly
avoided answering my question :).

I made an ugly patch and it fixed the corruption (but broke encryption) to
see if anyone cared about loop. Jari does so he took the idea and included
it with the other things he wants from loop.


Maybe this problem is caused by loop.c not using the aops correctly and
maybe it is an example of what layering violation can do. I wish I
understood this well enough to make it a clear example.

/Urban

