Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132061AbRATCZK>; Fri, 19 Jan 2001 21:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132168AbRATCZB>; Fri, 19 Jan 2001 21:25:01 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:46600 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132061AbRATCYp>; Fri, 19 Jan 2001 21:24:45 -0500
Date: Fri, 19 Jan 2001 22:34:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: linux-kernel@vger.kernel.org
cc: Rajagopal Ananthanarayanan <ananth@sgi.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: [RFC] generic IO write clustering 
Message-ID: <Pine.LNX.4.21.0101192142060.6167-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I'm starting to implement a generic write clustering scheme and I would
like to receive comments and suggestions.

The write clustering issue has already been discussed (mainly at Miami)
and the agreement, AFAIK, was to implement the write clustering at the
per-address-space writepage() operation.

IMO there are some problems if we implement the write clustering in this
level:

  - The filesystem does not have information (and should not have) about
    limiting cluster size depending on memory shortage.
  - By doing the write clustering at a higher level, we avoid a ton of
    filesystems duplicating the code.

So what I suggest is to add a "cluster" operation to struct address_space
which can be used by the VM code to know the optimal IO transfer unit in
the storage device. Something like this (maybe we need an async flag but
thats a minor detail now):

        int (*cluster)(struct page *, unsigned long *boffset, 
		unsigned long *poffset);

"page" is from where the filesystem code should start its search for
contiguous pages. boffset and poffset are passed by the VM code to know
the logical "backwards offset" (number of contiguous pages going backwards
from "page") and "forward offset" (cont pages going forward from
"page") in the inode.

The idea is to work with delayed allocated pages, too. A filesystem which
has this feature can, at its "cluster" operation, allocate delayed pages
contiguously on disk, and then return to the VM code which now can
potentially write a bunch of dirty pages in a few big IO operations.

I'm sure that a bit of tuning to know the optimal cluster size will be
needed. Also some fs locking problems will appear.

But it seems worth to me since we're avoiding a lot of code replication in
the future and also the performance gain will be _nice_.

Comments, thoughts?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
