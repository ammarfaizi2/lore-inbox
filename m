Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLBQE0>; Sat, 2 Dec 2000 11:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLBQEQ>; Sat, 2 Dec 2000 11:04:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:58008 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129436AbQLBQEJ>;
	Sat, 2 Dec 2000 11:04:09 -0500
Date: Sat, 2 Dec 2000 10:33:36 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <3A29008E.F05E5C95@uow.edu.au>
Message-ID: <Pine.GSO.4.21.0012021015310.28923-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Dec 2000, Andrew Morton wrote:

> It appears that this problem is not fixed.

Sure, it isn't. Place where the shit hits the fan: fs/buffer.c::unmap_buffer().
Add the call of remove_inode_queue(bh) there and see if it helps. I.e.

ed fs/buffer.c <<EOF
/unmap_buffer/
/}/i
		remove_inode_queue(bh);
.
wq
EOF

Linus, could you apply that? We are leaving the unmapped buffers on the
inode queue. I.e. every truncate_inode_pages() leaves a lot of junk around.
Now, guess what happens when we destroy the last link to inode that nobody
keeps open...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
