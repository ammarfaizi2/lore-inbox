Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRALQfi>; Fri, 12 Jan 2001 11:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRALQf3>; Fri, 12 Jan 2001 11:35:29 -0500
Received: from swing.yars.free.net ([193.233.48.88]:54953 "EHLO
	swing.yars.free.net") by vger.kernel.org with ESMTP
	id <S129763AbRALQfP>; Fri, 12 Jan 2001 11:35:15 -0500
Date: Fri, 12 Jan 2001 19:34:38 +0300
From: "Alexander V. Lukyanov" <lav@yars.free.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: O_NONBLOCK, read(), select(), NFS, Ext2, etc.
Message-ID: <20010112193437.A26510@swing.yars.free.net>
In-Reply-To: <200101120327.f0C3Rxc02512@513.holly-springs.nc.us> <E14H0hc-00043X-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E14H0hc-00043X-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 12, 2001 at 09:40:55AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 09:40:55AM +0000, Alan Cox wrote:
> > be true; but perhaps I am doing something wrong. If I open() a file (on
> > 2.2.18) from a floppy or NFS mount (to test in a slow environment) with
> > O_NONBLOCK|O_RDONLY, read() will still block. If I try to select() on
> > the file descriptor, select() always returns 0.
>
> The definition of immediate is not 'instant'. Otherwise no I/O system would
> ever return anything but -EWOULDBLOCK. Its that it won't wait when there is
> no data pending. On a floppy there is always data pending

I have a long standing idea on modifying poll/read/write behavior on
regular files opened in O_NONBLOCK mode. How about the following scheme:

   * poll returns POLLIN/POLLOUT on regular files only if the data are
   in buffer cache/there is room for write().
   * read returns EAGAIN if the data are not in buffer cache.
   * write returns EAGAIN if there is no room (yet) to store the data.

All the operation should signal to IO subsystem that the data are
needed in cache/the room has to be freed.

--
   Alexander.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
