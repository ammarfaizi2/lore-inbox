Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265904AbSKFSH3>; Wed, 6 Nov 2002 13:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265905AbSKFSH3>; Wed, 6 Nov 2002 13:07:29 -0500
Received: from 205-158-62-91.outblaze.com ([205.158.62.91]:49383 "HELO
	ws3-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S265904AbSKFSH1>; Wed, 6 Nov 2002 13:07:27 -0500
Message-ID: <20021106181358.11684.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 06 Nov 2002 13:13:57 -0500
Subject: [2.4.19] read(2) and page aligned buffers
X-Originating-Ip: 172.193.84.197
X-Originating-Server: ws3-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(synopsis: read() is returning a short read of
a disk file without setting errno when passed
a malloc()ed buffer that is not page-aligned, while
working correctly when passed a buffer of the
same size directly allocated with mmap()).

[I suppose the page alignment thing is just a guess,
 and I should really malloc() an oversized buffer,
 step through it to the next page boundary, and
 pass that to read() to see if the problem goes
 away. But I just thought of that a couple of
 sentences ago, so here is the description anyway.]

I have a function that opens a file O_RDONLY,
mmap()s it PROT_READ, MAP_SHARED, then passes it to
a checksum function, and finally munmap()s it.

This is working fine.

In a fit of magnanimity, I decided to make an OPM-friendly
version that doesn't use mmap(). So I replaced the
mmap() with malloc()+read() (with the usual error
checking, retry on EINTR||EAGAIN, incremental read to
incremented buffer offsets with decremented counts,
not incorporating -1 returns into the accumulated
read count, yada yada.)

After making this change, the function randomly
returns error from the read() wrapper. Delving
into it with gdb, I discovered that read() returns
a short count with errno == 0, the wrapper loops
and tries to read the rest of the file to the
offset into the buffer past what it already read,
read() returns 0 with errno still == 0, and of
course the wrapper decides that it must be at
EOF (read() == 0 && errno == 0) and returns.

I wondered if it was a page fault race (unlikely,
since it should have the same problem with an
mmap() buffer), but "memset(buf, 0, size);"
in between the malloc()and the read()does not fix it.

One thing I did notice: the buffer address when
read fails is 0x....08, which is a normal malloc()
alignment and really shouldn't bother read() (which
AFAIK doesn't need an aligned buffer in the first
place.)

Lately it has been running 11 bytes short when it
happens. Last night, in a slightly different version
of the same code, it was running 4 bytes short when
it happened. It isn't every file, but then malloc()
doesn't come up with start addresses at the same
page offset every time, either.

(gdb-5.2 found __libc_read in libg.a (2.2.5)
impenetrable, so this was as deep as I went into it.)

(gcc-2.95.3, binutils-2129009, -O2 -march=k6, cpu
is k6-II/450, SIS-5513/530, generally stable mb that
compiles kernels and X without hiccups).

[Intuition: it's not the lack of page alignment
generically, but rather an exactly 8-byte offset
from beginning of page that is the source of the problem.]

HTH,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Single & ready to mingle? lavalife.com:  Where singles click. Free to Search!
http://www.lavalife.com/mailcom.epl?a=2116

