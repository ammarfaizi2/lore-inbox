Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIOBz>; Tue, 9 Jan 2001 09:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130231AbRAIOBp>; Tue, 9 Jan 2001 09:01:45 -0500
Received: from [216.101.162.242] ([216.101.162.242]:38786 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S129324AbRAIOB3>;
	Tue, 9 Jan 2001 09:01:29 -0500
Date: Tue, 9 Jan 2001 05:42:48 -0800
Message-Id: <200101091342.FAA02414@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <shs4rz8vnmf.fsf@charged.uio.no> (message from Trond Myklebust on
	09 Jan 2001 14:52:40 +0100)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101080124.RAA08134@pizda.ninka.net> <shs4rz8vnmf.fsf@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Trond Myklebust <trond.myklebust@fys.uio.no>
   Date: 09 Jan 2001 14:52:40 +0100

   I don't really want to be chiming in with another 'make it a kiobuf',
   but given that you already have written 'do_tcp_sendpages()' why did
   you make sock->ops->sendpage() take the single page as an argument
   rather than just have it take the 'struct page **'?

It was like that to begin with.  But to do it cleanly you have to pass
in not a vector of "pages" but a vector of "page+offset+len" triplets.

Linus hated it, and I understood why, so I reverted the API to be
single page based.

   I would have thought one of the main interests of doing something
   like this would be to allow us to speed up large writes to the
   socket for ncpfs/knfsd/nfs/smbfs/...

This is what TCP_CORK/MSG_MORE et al. are all for, things get
coalesced perfectly.  Sending in a vector of pages seems nice, but
none of the page cache infrastructure works like this, all of the core
routines work on a page at a time.  It actually simplifies a lot.

The writepage interface optimizes large file writes to a socket just
fine.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
