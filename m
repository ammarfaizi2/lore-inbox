Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282244AbRKWVWn>; Fri, 23 Nov 2001 16:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282246AbRKWVWd>; Fri, 23 Nov 2001 16:22:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:51125 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282244AbRKWVWY>;
	Fri, 23 Nov 2001 16:22:24 -0500
Date: Fri, 23 Nov 2001 16:22:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: 2.4.15-pre9 breakage (inode.c)
Message-ID: <Pine.GSO.4.21.0111231606150.2422-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Sigh...  Supposed fix to problems with stale inodes was completely
broken.

	What we need is "if we are doing last iput() on fs that is getting
shut, sync it and don't leave it in cache".  And yes, we have a similar
path in iput().  Similar, but not quite the same.

	Fix is
* new fs flag: "MS_ACTIVE".
* set after normal ->read_super().
* reset after we are done with fsync_super() in kill_super().
* iput() checking that and if it's set - doing write_inode_now() and kicking
it out of hash.

I'll send patch in ~10 minutes.

