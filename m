Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313182AbSD3J1i>; Tue, 30 Apr 2002 05:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313184AbSD3J1h>; Tue, 30 Apr 2002 05:27:37 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:11504
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S313182AbSD3J1d>; Tue, 30 Apr 2002 05:27:33 -0400
Message-ID: <3CCE6381.7CEC4A8F@eyal.emu.id.au>
Date: Tue, 30 Apr 2002 19:27:29 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre7-ac3: ext2 compile failure
Content-Type: multipart/mixed;
 boundary="------------336EE4A25F364CC079B79957"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------336EE4A25F364CC079B79957
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The fourth hunk for balloc.c introduces a close brace without opening
one:

@@ -522,8 +520,12 @@
            in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
                      sb->u.ext2_sb.s_itb_per_group))
                ext2_error (sb, "ext2_new_block",
-                           "Allocating block in system zone - "
-                           "block = %u", tmp);
+                           "Allocating block in system zone - block =
%lu",
+                           tmp);
+               ext2_set_bit(j, bh->b_data);
+               DQUOT_FREE_BLOCK(inode, 1);
+               goto repeat;
+       }

In my case (Debian woody up-to-date) gcc actually crashes:

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-ac/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4    -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=balloc  -c
-o balloc.o balloc.c
balloc.c: In function `ext2_new_block':
balloc.c:524: warning: long unsigned int format, unsigned int arg (arg
4)
balloc.c:397: label `io_error' used but not defined
balloc.c:383: label `out' used but not defined
gcc: Internal compiler error: program cc1 got fatal signal 11
make[3]: *** [balloc.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-ac/fs/ext2'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------336EE4A25F364CC079B79957
Content-Type: text/plain; charset=us-ascii;
 name="2.4.19-pre7-ac3-balloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.19-pre7-ac3-balloc.patch"

--- linux/fs/ext2/balloc.c.orig	Tue Apr 30 19:17:01 2002
+++ linux/fs/ext2/balloc.c	Tue Apr 30 19:17:18 2002
@@ -518,7 +518,7 @@
 	if (tmp == le32_to_cpu(gdp->bg_block_bitmap) ||
 	    tmp == le32_to_cpu(gdp->bg_inode_bitmap) ||
 	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
-		      sb->u.ext2_sb.s_itb_per_group))
+		      sb->u.ext2_sb.s_itb_per_group)) {
 		ext2_error (sb, "ext2_new_block",
 			    "Allocating block in system zone - block = %lu",
 			    tmp);

--------------336EE4A25F364CC079B79957--

