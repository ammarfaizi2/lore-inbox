Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSIATEN>; Sun, 1 Sep 2002 15:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSIATEN>; Sun, 1 Sep 2002 15:04:13 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:2432 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S317349AbSIATEM>;
	Sun, 1 Sep 2002 15:04:12 -0400
Date: Sun, 1 Sep 2002 14:00:36 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Linus Torvalds <torvalds@transmeta.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.33-bk testing
In-Reply-To: <Pine.LNX.4.44.0209011057190.12138-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209011355030.1102-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Sep 2002, Linus Torvalds wrote:

> It looks like what your fix does is to force a 512-byte blocksize on the 
> floppy.
> 
> Which implies to me that the floppy driver is broken for other blocksizes.
> 
> Does your patch still leave the floppy driver broken for something like a 
> mounted minix or ext2 filesystem? Those have 1kB blocksizes, and will set 
> it to that. If the non-512B blocksize in the floppy driver is broken, then 
> such mounted filesystems should not work reliably either.

You are correct.  Making an ext2 filesystem on the floppy is indeed 
broken.  Attempting to read/write from the resulting filesystem results in 
the following type errors:

Sep  1 13:18:23 dad kernel: EXT2-fs error (device fd(2,0)): 
ext2_check_page: bad entry in directory #11: unaligned directory entry - 
offset=7168, inode=1431634935, rec_len=50, name_len=0
Sep  1 13:20:20 dad kernel: EXT2-fs error (device fd(2,0)): 
ext2_check_page: bad entry in directory #11: rec_len is smaller than 
minimal - offset=7168, inode=0, rec_len=0, name_len=0
Sep  1 13:22:29 dad kernel: EXT2-fs warning: mounting fs with errors, 
running e2fsck is recommended
Sep  1 13:23:09 dad kernel: EXT2-fs error (device fd(2,0)): 
ext2_check_page: bad entry in directory #11: directory entry across
blocks - offset=7168, inode=861697588, rec_len=12592, name_len=119
Sep  1 13:24:38 dad kernel: EXT2-fs error (device fd(2,0)): 
ext2_check_page: bad entry in directory #11: rec_len is smaller than 
minimal - offset=7168, inode=0, rec_len=0, name_len=0

Putting a text file on the floppy shows 512 byte chunks of the file being 
moved around depending on how many times the file is read/written.

