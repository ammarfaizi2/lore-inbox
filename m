Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSEEN3S>; Sun, 5 May 2002 09:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSEEN3R>; Sun, 5 May 2002 09:29:17 -0400
Received: from mons.uio.no ([129.240.130.14]:25853 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S312169AbSEEN3Q>;
	Sun, 5 May 2002 09:29:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15573.13225.450173.595060@charged.uio.no>
Date: Sun, 5 May 2002 15:29:13 +0200
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] NFS client changes - page kmap() in the RPC layer.
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  One of the reported problems that remain to be fixed in the client
RPC layer when using a HIGHMEM system, is that we can deadlock on
'kmap()'.

The problem is that there is a limited pool of addresses available to
the kmap() operation. The current design is based on the premise that
no single process will 'hold' more than one kmapped page for any
extended period of time.
The NFS layer breaks this premise, since each read/write kmap()s the
pages at the beginning of the RPC call, and only kunmap()s at the
end. If, say, a server is down for an extended period, so that all
RPC calls loop and retry, then we might end up exhausting the entire
resource pool.

The solution is to move the kmapping operation into the RPC
socket layer. There are only 2 places where we need kmap:

  - When calling sock_sendmsg()
  - When copying the reply from the server into pages.

Of course, in order to do so, we need to teach the RPC layer to deal
with pages, rather than page kmap() addresses.

The 2 patches in

  http://www.fys.uio.no/~trondmy/src/2.4.19-pre8/alpha

do precisely that. The patch linux-2.4.19-fix_kmap.dif introduces a
new 'RPC buffer' type defined as follows:

struct xdr_buf {
	struct iovec	head[1],	/* RPC header + non-page data */
			tail[1];	/* Appended after page data */

	struct page **	pages;		/* Array of contiguous pages */
	unsigned int	page_base,	/* Start of page data */
			page_len;	/* Length of page data */

	unsigned int	len;		/* Total length of data */
};

and applies it to the NFS write code.
The patch linux-2.4.19-fix_kmap2.dif changes the various NFS 'read'
operations (read, readdir, readlink) to use this structure.

The patches will apply on top of linux-2.4.19-NFS_ALL.dif, although
you will have to disable the NFS direct I/O code, as I haven't
yet gotten around to fixing that (Chuck?).

Comments please?

Please note: The two patches do not include code to make use of the
TCP_CORK + sendpage() zero copy socket interface, but doing so is
trivial if RPC were to use the above structure.

Cheers,
   Trond
