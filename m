Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267026AbTAaNru>; Fri, 31 Jan 2003 08:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbTAaNru>; Fri, 31 Jan 2003 08:47:50 -0500
Received: from [198.149.18.6] ([198.149.18.6]:42721 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S267026AbTAaNrs>;
	Fri, 31 Jan 2003 08:47:48 -0500
Date: Fri, 31 Jan 2003 07:52:30 -0600 (CST)
From: Eric Sandeen <sandeen@sgi.com>
X-X-Sender: sandeen@stout.americas.sgi.com
To: linux-kernel@vger.kernel.org
cc: viro@math.psu.edu, <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4.21-pre4 seq_read() fix backport
Message-ID: <Pine.LNX.4.44.0301310739560.1221-100000@stout.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro fixed a bug in seq_read for 2.5.31, still needs to be
backported to 2.4.x.  Allows uninitialized data to be read, I think.

You can observe this by adding many (75+, I think) lvm volumes
and do a cat of "/proc/partitions" with slab debugging turned on.

http://linux.bkbits.net:8080/linux-2.5/diffs/fs/seq_file.c@1.5?nav=index.html|src/|src/fs|hist/fs/seq_file.c

--- 1.4/fs/seq_file.c	Wed May 22 05:44:20 2002
+++ 1.5/fs/seq_file.c	Thu Aug  8 23:46:33 2002
@@ -94,8 +94,10 @@
 		m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);
 		if (!m->buf)
 			goto Enomem;
+		m->count = 0;
 	}
 	m->op->stop(m, p);
+	m->count = 0;
 	goto Done;
 Fill:
 	/* they want more? let's try to get some more */



