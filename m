Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSG1RoH>; Sun, 28 Jul 2002 13:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316969AbSG1RoH>; Sun, 28 Jul 2002 13:44:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52747 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316614AbSG1RoG>;
	Sun, 28 Jul 2002 13:44:06 -0400
Message-ID: <3D44302C.1082D6DC@zip.com.au>
Date: Sun, 28 Jul 2002 10:55:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 11/13] don't hold i_sem during O_DIRECT writes to blockdevs
References: <3D439E43.5F2DEE3D@zip.com.au> <20020728120611.A7332@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Sun, Jul 28, 2002 at 12:33:23AM -0700, Andrew Morton wrote:
> > This patch changes O_DIRECT writes to blockdevs so that they no longer
> > run under i_sem.
> 
> Please don't make this depenend on S_ISBLK().  There are filesystems (like
> XFS) that are designed to safely allow concurrent O_DIRECT writes to
> regular files.
> 
> Toe implement this properly we should drop i_sem in the ->direct_IO method
> of the filesystem/blockdevice.  The only question remaining is whether the
> method has to reqacquire it before returing (and it'll be imediately
> released again or whether we should change semantics of ->direct_IO to
> always drop the lock.
> 
> The third options would be to never call ->direct_IO with the i_sem held
> and let filesystems that need it (only ext2 in 2.5 mainline) do
> synchronization themselves.
> 
> I think I prefer option 3, it's the cleanest way of doing it.

It could be time to separate out a __generic_file_write() which
doesn't take i_sem at all.  The ext3 tree was doing that for a
while, to permit multipage transactions in journalled data mode.

> A little unrelated, but as you touch the code:  what about removing the two
> existing special cases for S_ISBLK() in generic_file_write()?  they're
> present only to provide the old (pre-LFS) blockdevice semantics on 2.4,
> we shouldn't keept them around forever..

hm.  Are you sure about that?  They look fairly useful to me?

-
