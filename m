Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280665AbRKSTqJ>; Mon, 19 Nov 2001 14:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280670AbRKSTqB>; Mon, 19 Nov 2001 14:46:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25526 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280665AbRKSTpu>;
	Mon, 19 Nov 2001 14:45:50 -0500
Date: Mon, 19 Nov 2001 14:45:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [RFC] problem with grow_dev_page()/readpage()
Message-ID: <Pine.GSO.4.21.0111191435090.19969-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, looks like the logics with "if we got stale buffer_heads -
no problem, grow_dev_page() will get rid of them" is broken.

	Look at block_read_full_page().  If it sees ->buffers != NULL, it
assumes that buffer size corresponds to ->i_blkbits.  IOW, if we ever
trigger the "let's free old buffer heads" path in grow_dev_page() - we
were in trouble; if somebody would read(2) from that place he'd end up
calling block_read_full_page() and it would screw up.

	So either we need to replace if (!try_to_free_buffers(page, GFP_NOFS))
with unconditional BUG() and make sure that it doesn't get triggered, or
we need to start pulling similar bh resizing code into block_read_full_page()
and friends.

	Comments?

