Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289349AbSAKLlj>; Fri, 11 Jan 2002 06:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289588AbSAKLla>; Fri, 11 Jan 2002 06:41:30 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:21005 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S289349AbSAKLlS>; Fri, 11 Jan 2002 06:41:18 -0500
Date: Fri, 11 Jan 2002 11:40:47 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
In-Reply-To: <20020111165516.61ede3f8.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0201111114250.24025-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002, Rusty Russell wrote:

> > Both user and kernel bits are, of course, improvable, but
> > this should at least show that the approach works.

> 	Prefer the "char device" approach myself.  open = create, read =
> down, write = up.  Following (completely untested) patch stole your
> work to implement "/dev/usem". Added bonus is the ability to mmap the
> fd to map in the shared page, which means the fd carries a shared
> region with it (hey, it was 14 more lines).

Nice hack.  I'm not particularly attached to my implementation
but:
 * Dedicating a whole page per semaphore seems rather
   expensive for a "lightweight" primitive.
 * Possibly ditto even file descriptors.  I may want
   several thousand of these.
 * Are there any numbers for the VFS overheads?  There
   are quite a few lock acquires in there, even if the
   paths are fairly short.
 * It would be nice to keep the userspace structure
   opaque (except for the counter) and able to share
   it transparently between processes.

Actually, the more I look at Linus's original idea, the more
sense it seems to make (and the more I regret scrapping my
almost-complete implementation of it for the fd idea :)

(Oh, and you forgot:

> +static struct file_operations usem_fops = {
> +	read:		read_usem,
> +	write:		write_usem,
> +	open:		open_usem,
> +	release:	release_usem,
	mmap:		mmap_usem,
> +};

)

Cheers,
Matthew.

