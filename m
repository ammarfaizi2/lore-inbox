Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272220AbRH3NuG>; Thu, 30 Aug 2001 09:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272219AbRH3Nt5>; Thu, 30 Aug 2001 09:49:57 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:50875 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S272218AbRH3Nto>;
	Thu, 30 Aug 2001 09:49:44 -0400
Message-ID: <3B8E4474.DA6D281F@linux-m68k.org>
Date: Thu, 30 Aug 2001 15:49:40 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        David Lang <david.lang@digitalinsight.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108292018380.1062-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------5B140DCE55D30B5F1455F45D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5B140DCE55D30B5F1455F45D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

> Please guys. The issue of sign in comparisons are a LOT more complicated
> than most of you seem to think.

So why won't you let the compiler help you, even if it's not perfect in
every case?

This is my last attempt to get things IMO right. Most of the arguments
for the new macro were about bugs of the past. No question about this,
this had to be fixed, I'm not arguing about this at all.

I'm trying to get your attention to the bugs of the future. I still
don't understand why you think the new macro will be any better. Why do
you think the average kernel hacker will think about the type of the
compare and will come to the correct conclusion? It's far to easy to use
an int as type argument and forget about it. gcc won't warn about this,
so someone first has to hit this bug, before it gets fixed.

Maybe I'm too dumb, but I still fail to see, what sense it should make
to turn a signed compare into an unsigned one. Either one knows both
signed values are only positive, then the sign of the compare and the
destination doesn't matter at all. If the value could be negative,
better test it explicit:

	if (len < 0 || len > MAX)
		len = MAX;

First, it's far more readable and makes the intention so clear, that
even your average kernel hacker understands it. Second, gcc produces
exactly the same code with this, so there is no need to play type tricks
with the min macro.

Just for fun I enabled -Wsign-compare, enabled most of the drivers and I
got this:

$ grep 'comparison between signed and unsigned' make.log | sort | uniq |
wc -l
   3211

So if you want to get people thinking about the types they are using,
here you have at least 3211 chances.

Please reconsider your decision. IMVHO the new macros are a mistake and
will cause only more trouble than they are worth. If you want to keep
the new macros, please apply the attached patch, as I prefer this
version in the source I'm responsible for.

bye, Roman
--------------5B140DCE55D30B5F1455F45D
Content-Type: text/plain; charset=us-ascii;
 name="affs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="affs.diff"

Index: include/linux/amigaffs.h
===================================================================
RCS file: /cvsroot/linux-apus/2.3/include/linux/amigaffs.h,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 amigaffs.h
--- include/linux/amigaffs.h	2001/07/22 23:22:24	1.1.1.3
+++ include/linux/amigaffs.h	2001/08/30 13:38:24
@@ -122,7 +122,7 @@
 }
 
 
-#define MIN(a, b) ({		\
+#define affs_min(a, b) ({	\
 	typeof(a) _a = (a);	\
 	typeof(b) _b = (b);	\
 	_a < _b ? _a : _b;	\
Index: fs/affs/amigaffs.c
===================================================================
RCS file: /cvsroot/linux-apus/2.3/fs/affs/amigaffs.c,v
retrieving revision 1.6
diff -u -r1.6 amigaffs.c
--- fs/affs/amigaffs.c	2001/08/20 13:23:07	1.6
+++ fs/affs/amigaffs.c	2001/08/30 13:38:24
@@ -507,7 +507,7 @@
 int
 affs_copy_name(unsigned char *bstr, struct dentry *dentry)
 {
-	int len = MIN(dentry->d_name.len, 30);
+	int len = affs_min(dentry->d_name.len, 30);
 
 	*bstr++ = len;
 	memcpy(bstr, dentry->d_name.name, len);
Index: fs/affs/dir.c
===================================================================
RCS file: /cvsroot/linux-apus/2.3/fs/affs/dir.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 dir.c
--- fs/affs/dir.c	2001/07/22 23:18:04	1.1.1.6
+++ fs/affs/dir.c	2001/08/30 13:38:24
@@ -135,7 +135,7 @@
 				goto readdir_done;
 			}
 
-			namelen = MIN(AFFS_TAIL(sb, fh_bh)->name[0], 30);
+			namelen = affs_min(AFFS_TAIL(sb, fh_bh)->name[0], 30);
 			name = AFFS_TAIL(sb, fh_bh)->name + 1;
 			pr_debug("AFFS: readdir(): filldir(\"%.*s\", ino=%u), hash=%d, f_pos=%x\n",
 				 namelen, name, ino, hash_pos, f_pos);
Index: fs/affs/file.c
===================================================================
RCS file: /cvsroot/linux-apus/2.3/fs/affs/file.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 file.c
--- fs/affs/file.c	2001/08/20 23:44:37	1.1.1.8
+++ fs/affs/file.c	2001/08/30 13:38:25
@@ -528,7 +528,7 @@
 		bh = affs_bread_ino(inode, bidx, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
-		tmp = MIN(bsize - boff, from - to);
+		tmp = affs_min(bsize - boff, from - to);
 		memcpy(data + from, AFFS_DATA(bh) + boff, tmp);
 		affs_brelse(bh);
 		bidx++;
@@ -558,7 +558,7 @@
 		bh = affs_bread_ino(inode, bidx, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
-		tmp = MIN(bsize - boff, newsize - size);
+		tmp = affs_min(bsize - boff, newsize - size);
 		memset(AFFS_DATA(bh) + boff, 0, tmp);
 		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(be32_to_cpu(AFFS_DATA_HEAD(bh)->size) + tmp);
 		affs_fix_checksum(sb, bh);
@@ -576,7 +576,7 @@
 		bh = affs_getzeroblk_ino(inode, bidx);
 		if (IS_ERR(bh))
 			goto out;
-		tmp = MIN(bsize, newsize - size);
+		tmp = affs_min(bsize, newsize - size);
 		AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
 		AFFS_DATA_HEAD(bh)->key = cpu_to_be32(inode->i_ino);
 		AFFS_DATA_HEAD(bh)->sequence = cpu_to_be32(bidx);
@@ -685,7 +685,7 @@
 		bh = affs_bread_ino(inode, bidx, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
-		tmp = MIN(bsize - boff, to - from);
+		tmp = affs_min(bsize - boff, to - from);
 		memcpy(AFFS_DATA(bh) + boff, data + from, tmp);
 		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(be32_to_cpu(AFFS_DATA_HEAD(bh)->size) + tmp);
 		affs_fix_checksum(sb, bh);
@@ -731,7 +731,7 @@
 		bh = affs_bread_ino(inode, bidx, 1);
 		if (IS_ERR(bh))
 			goto out;
-		tmp = MIN(bsize, to - from);
+		tmp = affs_min(bsize, to - from);
 		memcpy(AFFS_DATA(bh), data + from, tmp);
 		if (bh->b_state & (1UL << BH_New)) {
 			AFFS_DATA_HEAD(bh)->ptype = cpu_to_be32(T_DATA);
Index: fs/affs/namei.c
===================================================================
RCS file: /cvsroot/linux-apus/2.3/fs/affs/namei.c,v
retrieving revision 1.9
diff -u -r1.9 namei.c
--- fs/affs/namei.c	2001/08/21 17:57:27	1.9
+++ fs/affs/namei.c	2001/08/30 13:38:25
@@ -81,7 +81,7 @@
 		return i;
 
 	hash = init_name_hash();
-	i = MIN(qstr->len, 30);
+	i = affs_min(qstr->len, 30);
 	for (; i > 0; name++, i--)
 		hash = partial_name_hash(toupper(*name), hash);
 	qstr->hash = end_name_hash(hash);
@@ -172,7 +172,7 @@
 	toupper_t toupper = affs_get_toupper(sb);
 	int hash;
 
-	hash = len = MIN(len, 30);
+	hash = len = affs_min(len, 30);
 	for (; len > 0; len--)
 		hash = (hash * 13 + toupper(*name++)) & 0x7ff;
 

--------------5B140DCE55D30B5F1455F45D--

