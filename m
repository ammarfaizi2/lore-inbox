Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131156AbQKXG1s>; Fri, 24 Nov 2000 01:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131736AbQKXG1i>; Fri, 24 Nov 2000 01:27:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:26582 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131156AbQKXG1f>;
        Fri, 24 Nov 2000 01:27:35 -0500
Date: Fri, 24 Nov 2000 00:57:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <3A1DFFD0.22C8CEC3@haque.net>
Message-ID: <Pine.GSO.4.21.0011240047020.12702-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Nov 2000, Mohammad A. Haque wrote:

> I got the error while I was compiling XFree86 4 CVS and kernel. So
> that's what I've been doing in multiples along witha couple otehr things
> thrown inthe mix to generate lots of disk i/o.

Error messages would be interesting... So far we have _both_ 2.95 and 2.91
involved, raid and non-raid alike. Just fscking peachy... OK, let's try
to eliminate ext2 changes (if that helps we have a big problem somewhere,
but that's at least something):

patch -p1 -R <<EOF
--- rc11-pre5/fs/ext2/ialloc.c	Wed Oct  4 03:44:54 2000
+++ rc11-pre6/fs/ext2/ialloc.c	Fri Nov 17 02:23:19 2000
@@ -274,15 +274,13 @@
 		return NULL;
 	}
 
-	inode = get_empty_inode ();
+	sb = dir->i_sb;
+	inode = new_inode(sb);
 	if (!inode) {
 		*err = -ENOMEM;
 		return NULL;
 	}
 
-	sb = dir->i_sb;
-	inode->i_sb = sb;
-	inode->i_flags = 0;
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
 repeat:
@@ -430,9 +428,6 @@
 	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
 	sb->s_dirt = 1;
 	inode->i_mode = mode;
-	inode->i_sb = sb;
-	inode->i_nlink = 1;
-	inode->i_dev = sb->s_dev;
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
EOF

Notice that if reverting that change stops the fs corruption we _still_
have a problem - the only case when it could help is if something touches
an inode allocated by get_empty_inode() before it gets included into the
hash.

BTW, folks, while we are looking at the configurations - how about highmem
and SMP vs. UP?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
