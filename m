Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbTEFTua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTEFTua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:50:30 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:21255 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261248AbTEFTu2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:50:28 -0400
To: Peder Stray <peder@ifi.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Files truncate on vfat filesystem
References: <wa1ade0gkl3.fsf@tyrfing.ifi.uio.no>
	<87k7d4t1ay.fsf@devron.myhome.or.jp>
	<Pine.SOL.4.51.0305062018090.25815@tyrfing.ifi.uio.no>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 07 May 2003 05:02:46 +0900
In-Reply-To: <Pine.SOL.4.51.0305062018090.25815@tyrfing.ifi.uio.no>
Message-ID: <87addzu9ll.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peder Stray <peder@ifi.uio.no> writes:

> > What partition size do you use? And does that FAT use what logical
> > sector size?  The directory entry pointer may be overflowed...
> 
> 250GB partition, FAT32 LBA (partition type 0x0c i think).
> 
> The problem is verry inconsistent as i said earlier, so the number of
> files in a directory doesn't seem to matter, nor do the depth in the
> directory structure. Some files i manage to copy yo the disk, some files i
> don't... I havent managed to find any pattern in what files this affects.

I meant, "directory entry pointer" is position of the directory entry
in the _partition_. like the following,

in fs/fat/misc.c:fat__get_entry()

		offset &= sb->s_blocksize - 1;
		*de = (struct msdos_dir_entry *) ((*bh)->b_data + offset);
		*ino = (sector << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
                 ^^^

This is used for _updates_ (not create) of the directory entry. And
there is a possibility of cause of the problem which you said.  If my
guess is right and a partition will be splited small, a problem will
not occur.

In short, I think it's the bug of fat driver and it's needed the fix.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
