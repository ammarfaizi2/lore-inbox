Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135895AbRAGGld>; Sun, 7 Jan 2001 01:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135898AbRAGGlX>; Sun, 7 Jan 2001 01:41:23 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:3772 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135895AbRAGGlN>; Sun, 7 Jan 2001 01:41:13 -0500
Date: Sat, 6 Jan 2001 22:41:09 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: parsley@roanoke.edu
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Patch (repost): cramfs memory corruption fix
Message-ID: <20010106224109.A1601@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>From: "David L. Parsley" <parsley@roanoke.edu>
>
>Using root=/dev/ram0 and a cramfs initrd gives me 'wrong magic' when it
>tries to boot.  Even more bizarre, if cramfs is compiled in the kernel
>when I use a romfs root, it says 'wrong magic' then mounts the romfs but
>can't find init.  If I take cramfs out of the kernel, the romfs mounts &
>init runs fine.  I just saw this with ac3.
>
>ramfs croaks with 'kernel BUG in filemap.c line 2559' anytime I make a
>file in ac2 and ac3.  Works fine in 2.4.0 vanilla.  Should be quite
>repeatable...

	This sounds like a bug that I posted a fix for a long time ago.
cramfs calls bforget on the superblock area, destroying that block of
the ramdisk, even when the ramdisk does not contain a cramfs file system.
Normally, bforget is called on block that really can be trashed,
such as blocks release by truncate or unlink.  If it worked for
you before, you were just getting lucky.  Here is the patch.

	Linus, please consider applying this.  Thank you.

	By the way, the other approach to fixing this problem would
be to change bforget not to trash blocks marked with BH_Protected
(I think that is just ramdisk blocks), but that would waste memory,
because we really can release blocks from things like truncating
or unlinking files.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffs

--- /tmp/adam/linux-2.4.0/fs/cramfs/inode.c	Fri Dec 29 14:07:57 2000
+++ linux/fs/cramfs/inode.c	Sat Dec 30 02:12:06 2000
@@ -138,7 +138,7 @@
 		struct buffer_head * bh = bh_array[i];
 		if (bh) {
 			memcpy(data, bh->b_data, PAGE_CACHE_SIZE);
-			bforget(bh);
+			brelse(bh);
 		} else
 			memset(data, 0, PAGE_CACHE_SIZE);
 		data += PAGE_CACHE_SIZE;

--+HP7ph2BbKc20aGI--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
