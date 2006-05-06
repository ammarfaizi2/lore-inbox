Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWEFXmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWEFXmd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 19:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWEFXmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 19:42:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751140AbWEFXmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 19:42:33 -0400
Date: Sat, 6 May 2006 16:42:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: minixfs bitmaps and associated lossage
In-Reply-To: <20060506231054.GR27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0605061633020.16343@g5.osdl.org>
References: <44560796.8010700@gmail.com> <20060506162956.GO27946@ftp.linux.org.uk>
 <20060506163737.GP27946@ftp.linux.org.uk> <20060506220451.GQ27946@ftp.linux.org.uk>
 <Pine.LNX.4.64.0605061524420.16343@g5.osdl.org> <20060506231054.GR27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 May 2006, Al Viro wrote:
> 
> FWIW, the only way to really deal with such structure would be to treat
> on-disk values as "fs-endian" and make the conversion to and from
> host-endian check the superblock.  That would _really_ consolidate
> minix_..._bit() (turning them into __test_bit(nr ^ sbi->mangle, p), etc.)

Yeah, especially for bitmaps, it really _should_ be pretty simple, since 
it's literally a bitwise xor of the bit number. It's actually worse for 
things that truly have byte order dependencies where the values span bytes 
and need re-ordering. For bits, that obviously will never be the case.

> If somebody wants to play with that code, they could just merge fs/minix
> into fs/sysv - that might very well turn out to be the right thing and
> a fun exercise.  Codebases are very close - minixfs is a derivative of
> v7 filesystem, after all, and our fs/minix and fs/sysv had been kept
> mostly in sync.

Heh. Yes. The physical filesystem layout of minix is close to the old sysv 
one, and the implementation ends up being pretty closely related too, 
although the genealogy there is the other way around.

However, I thought the direct sysv descendants used linked lists of 
free-block lists, not bitmaps? So while a lot of the _other_ part of the 
filesystem layout is similar, the actual free-block handling is very 
different. No?

So there are things that are very similar (directory layout, inode 
format), and could probably be share, while other things (free block and 
inode handling) are fundamentally different, no?

			Linus
