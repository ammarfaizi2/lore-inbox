Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbTCHQCJ>; Sat, 8 Mar 2003 11:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbTCHQCI>; Sat, 8 Mar 2003 11:02:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29714 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262061AbTCHQCH>; Sat, 8 Mar 2003 11:02:07 -0500
Date: Sat, 8 Mar 2003 08:10:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 6/6 cacheline align files_lock
In-Reply-To: <20030308155456.B28797@infradead.org>
Message-ID: <Pine.LNX.4.44.0303080801020.2954-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Mar 2003, Christoph Hellwig wrote:
> 
> The free list should go away - we have slab for that.  The tty stuff should
> get a per-tty lock.

I doubt either of these would actually fix the lock contention, though.

The tty stuff is not likely to be a real issue for any real load (just how
often do you kill off sessions etc?) And the free list isn't the reason
for the file lock - ues, the file lock protects it, but every time we
touch the free list we touch _real_ lists too (ie either we move a file
from the free list to another list, _or_ we move a unused entry from a
real list to the free list), so we'd need the lock anyway.

So to actually fix file_lock, you need to do something else. I _think_
that "something else" may be to make it be a per-super-block lock, since I
think that's the only thing the f_list thing is actually used for. Then
you should probably pass in the superblock pointer to "get_empty_filp()", 
and _then_ you can get rid of the free list and the current global lock.

Oh, and you need to make the "tty" stuff be a superblock too. Of course, 
it might actually be a perfectly fine thing to make that tty stuff use a 
totally separate pointer chain anyway, the current thing makes me worry 
that "umount()" actually might do the wrong thing if the only file open on 
a filesystem are tty files.

		Linus

