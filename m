Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264059AbTEGP21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbTEGP21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:28:27 -0400
Received: from rth.ninka.net ([216.101.162.244]:64427 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264053AbTEGP2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:28:17 -0400
Subject: Re: [ANNOUNCE] HFS+ driver
From: "David S. Miller" <davem@redhat.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-hfsplus-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0305071643030.5042-100000@serv>
References: <Pine.LNX.4.44.0305071643030.5042-100000@serv>
Content-Type: multipart/mixed; boundary="=-pUeidopqKuvo4oWj3ZC9"
Organization: 
Message-Id: <1052322035.9817.10.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 08:40:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pUeidopqKuvo4oWj3ZC9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-05-07 at 08:06, Roman Zippel wrote:
> The driver can be downloaded from http://www.ardistech.com/hfsplus/ .
> The README describes how to build the driver.

This patch fixes 64-bit bugs (in extent code) and warnings
(in directory handling).

-- 
David S. Miller <davem@redhat.com>

--=-pUeidopqKuvo4oWj3ZC9
Content-Disposition: attachment; filename=diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=diff; charset=UTF-8

--- extents.c.~1~	Fri May  2 04:25:09 2003
+++ extents.c	Wed May  7 08:34:55 2003
@@ -216,7 +216,7 @@
 					break;
 			}
 			data[off] =3D cpu_to_be32(~word);
-			m =3D 1 << (8 * sizeof(unsigned long) - 1);
+			m =3D 1UL << (8 * sizeof(unsigned long) - 1);
 		} while (++off < size);
 	done:
 		mark_buffer_dirty_inode(bh, anode);
@@ -341,7 +341,7 @@
 			word =3D be32_to_cpu(data[off]);
 			if (!~word)
 				continue;
-			m =3D 1 << (sizeof(unsigned long) * 8 - 1);
+			m =3D 1UL << (sizeof(unsigned long) * 8 - 1);
 			for (i =3D 0; m; i++, m >>=3D 1) {
 				if (word & m)
 					continue;
--- dir.c.~1~	Fri May  2 07:32:04 2003
+++ dir.c	Wed May  7 08:36:06 2003
@@ -69,14 +69,14 @@
 				inode =3D NULL;
 				goto out;
 			}
-			dentry->d_fsdata =3D (void *)cnid;
+			dentry->d_fsdata =3D (void *)(unsigned long)cnid;
 			linkid =3D be32_to_cpu(entry.file.permissions.dev);
 			str.len =3D sprintf(name, "iNode%d", linkid);
 			str.name =3D name;
 			hfsplus_fill_cat_key(fd.search_key, HFSPLUS_SB(sb).hidden_dir->i_ino, &=
str);
 			goto again;
 		} else if (!dentry->d_fsdata)
-			dentry->d_fsdata =3D (void *)cnid;
+			dentry->d_fsdata =3D (void *)(unsigned long)cnid;
 	} else {
 		printk("HFS+-fs: Illegal catalog entry type in lookup\n");
 		err =3D -EIO;
@@ -267,7 +267,7 @@
 	if (HFSPLUS_IS_RSRC(inode))
 		return -EPERM;
=20
-	if (inode->i_ino =3D=3D (u32)src_dentry->d_fsdata) {
+	if (inode->i_ino =3D=3D (u32)(unsigned long)src_dentry->d_fsdata) {
 		for (;;) {
 			get_random_bytes(&id, sizeof(cnid));
 			id &=3D 0x3fffffff;
@@ -283,7 +283,7 @@
 		}
 		HFSPLUS_I(inode).dev =3D id;
 		cnid =3D HFSPLUS_SB(sb).next_cnid++;
-		src_dentry->d_fsdata =3D (void *)cnid;
+		src_dentry->d_fsdata =3D (void *)(unsigned long)cnid;
 		res =3D hfsplus_create_cat(cnid, src_dir, &src_dentry->d_name, inode);
 		if (res)
 			/* panic? */
@@ -296,7 +296,7 @@
 		return res;
=20
 	inode->i_nlink++;
-	dst_dentry->d_fsdata =3D (void *)cnid;
+	dst_dentry->d_fsdata =3D (void *)(unsigned long)cnid;
 	d_instantiate(dst_dentry, inode);
 	atomic_inc(&inode->i_count);
 	inode->i_ctime =3D CURRENT_TIME;
@@ -319,7 +319,7 @@
 	if (HFSPLUS_IS_RSRC(inode))
 		return -EPERM;
=20
-	cnid =3D (u32)dentry->d_fsdata;
+	cnid =3D (u32)(unsigned long)dentry->d_fsdata;
 	if (inode->i_ino =3D=3D cnid &&
 	    atomic_read(&HFSPLUS_I(inode).opencnt)) {
 		str.name =3D name;

--=-pUeidopqKuvo4oWj3ZC9--
