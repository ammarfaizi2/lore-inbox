Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbRBSBEy>; Sun, 18 Feb 2001 20:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRBSBEe>; Sun, 18 Feb 2001 20:04:34 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:16388 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129257AbRBSBEa>; Sun, 18 Feb 2001 20:04:30 -0500
Date: Mon, 19 Feb 2001 01:04:28 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <kuznet@ms2.inr.ac.ru>
cc: <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
In-Reply-To: <200102181724.UAA24231@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.30.0102190025270.19003-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Feb 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > Unfortunately, I discovered a bug with SO_SNDTIMEO/sendfile():
>
> None of the options apply to sendfile(). It is not socket level
> operation. You have to use alarm for it.
>
> BTW, if you have enough fast network, you probably can observe
> that sendfile() is even not interrupted by signals. 8) But this
> is possible to fix at least. BTW the same fix will repair SO_*TIMEO
> partially, i.e. it will timeout after n*timeo, where n is an arbitrary
> number not exceeding size/sndbuf.

Hi Alexey,

You are right - our sendfile() implementation is broken. I have fixed it
(patch at end of mail).

However, I believe something is still wrong in the networking layer, even
with my fix applied.

Before I go into details, I want to step back and describe things from a
_users_ perspective. That is most important after all.

Take two different operations: write() to a socket and sendfile() down a
socket. In both cases, the socket has a send timeout of 10 seconds. From a
users' point of view, these are two socket write operations. The source of
data is different (a buffer or a file descriptor), but that is irrelevant.
The user has the right to expect a timeout after 10 seconds of no
progress, on both operations.

I have tried this on FreeBSD, and this is what happens: both sendfile()
and write() timeout in the same way.

On Linux, this is not the case => bug. I fixed a small sendfile() issue,
which did not recognise partial writes as an interruption, but as I said
above, the bug still remains.

Investigation shows that the Linux network layer is behaving oddly. It
seems that we are writing 4096 bytes to a socket. This proceeds in 4096
byte chunks until the send buffer on the socket is full, and a 4096 byte
write blocks. This blocking write is eventually interrupted by the
timeout, and the write call returns.. wait for it.. 4096! This suggests
there was socket space after all, and the call should not have blocked.

I wonder what is going on? I'd like to get this fixed. I think the FreeBSD
behaviour is definitely correct and we want it on Linux.

Cheers
Chris

--- filemap.c.old       Sun Feb 18 23:35:06 2001
+++ filemap.c   Mon Feb 19 00:13:38 2001
@@ -1062,7 +1062,7 @@

        for (;;) {
                struct page *page, **hash;
-               unsigned long end_index, nr;
+               unsigned long end_index, nr, actor_ret;

                end_index = inode->i_size >> PAGE_CACHE_SHIFT;
                if (index > end_index)
@@ -1110,13 +1110,13 @@
                 * "pos" here (the actor routine has to update the user
buffer
                 * pointers and the remaining count).
                 */
-               nr = actor(desc, page, offset, nr);
-               offset += nr;
+               actor_ret = actor(desc, page, offset, nr);
+               offset += actor_ret;
                index += offset >> PAGE_CACHE_SHIFT;
                offset &= ~PAGE_CACHE_MASK;

                page_cache_release(page);
-               if (nr && desc->count)
+               if (actor_ret == nr && desc->count)
                        continue;
                break;

