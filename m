Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280980AbRKYSst>; Sun, 25 Nov 2001 13:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280982AbRKYSsm>; Sun, 25 Nov 2001 13:48:42 -0500
Received: from mk-smarthost-3.mail.uk.tiscali.com ([212.74.112.73]:28688 "EHLO
	mk-smarthost-3.mail.uk.worldonline.com") by vger.kernel.org
	with ESMTP id <S280980AbRKYSse>; Sun, 25 Nov 2001 13:48:34 -0500
To: linux-kernel@vger.kernel.org
From: <jonathan@daria.co.uk (Jonathan R. Hudson)>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: E Justin M Rowles
In-Reply-To: <20011123113747.A17823@xyzzy.clara.co.uk> <3C00FD3D.426A90B8@aug24.co.uk> <01112516385100.00791@gaz> <3C0138EF.8675BED@aug24.co.uk>
Subject: Re: [hants] 2.5.0 kernel available - DO NOT USE!!
X-Newsgroups: local.site.hants
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed; boundary="=-=-=__ywr1g487/4PUAoZrLEY53nNT7__=-=-="
NNTP-Posting-Host: daria.co.uk
Message-ID: <18f9.3c013ced.6fc75@trespassersw.daria.co.uk>
Date: Sun, 25 Nov 2001 18:48:13 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=__ywr1g487/4PUAoZrLEY53nNT7__=-=-=
Content-Type: text/plain; charset=iso-8859-1

In article <3C0138EF.8675BED@aug24.co.uk>,
	E Justin M Rowles <justin@aug24.co.uk> writes:
EJMR> Gareth Owen wrote:
>> 
>> YOU SHOULD NOT USE 2.5.0 or 2.4.15 AS THEY HAVE A SERIOUS FILESYSTEM
>> CORRUPTION BUG, try 2.4.16pre1, but no guarantees.
EJMR> 
EJMR> Right, thanks for that.  I have now rebooted to my old 2.4.1 kernel.
EJMR> 
EJMR> I dled the whole 2.4.15 tarball cos I hadn't upgraded for ages (I wanted
EJMR> the new VM manager).  Can anyone make and mail me a diff to take 2.4.15
EJMR> back to 2.4.14?  Offer onlist please, so I don't get multiples!
EJMR> 
EJMR> Alternatively, does anyone know how to reverse apply the 2.4.15 patch? 
EJMR> patch -R looks hopeful, but I'm not convinced.
EJMR> 

Just get the 2.14.16-pre1 patch (or apply the attached to 2.4.15)

 cd /usr/src/linux
 patch -p1 <2415.fs.patch

Next time you want to apply an official patch, remove it again:

 patch -p1 -R <2415.fs.patch
--=-=-=__ywr1g487/4PUAoZrLEY53nNT7__=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename="2415.fs.patch"

>From viro@math.psu.edu Fri Nov 23 22:08:21 2001
Path: trespassersw.daria.co.uk!uni-berlin.de!fu-berlin.de!feedme.news.mediaways.net!shale.ftech.net!news.ftech.net!diablo.netcom.net.uk!netcom.net.uk!news.tele.dk!small.news.tele.dk!129.240.148.23!uio.no!nntp.uio.no!ifi.uio.no!internet-mailinglist
X-Newsgroups: fa.linux.kernel
Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Authentication-Warning: weyl.math.psu.edu: viro owned process doing -bs
Original-Date:  Fri, 23 Nov 2001 17:06:46 -0500 (EST)
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][CFT] Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <Pine.GSO.4.21.0111231634310.2422-100000@weyl.math.psu.edu>
Original-Message-ID: <Pine.GSO.4.21.0111231701440.2422-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
X-Mailing-List:  linux-kernel@vger.kernel.org
Organization: Internet mailing list
Date: Fri, 23 Nov 2001 22:08:21 GMT
Message-ID: <fa.louqolv.cnooa9@ifi.uio.no>
In-Reply-To: <fa.loeipdv.f7goic@ifi.uio.no>
Bytes: 3068
Lines: 102
Xref: trespassersw.daria.co.uk fa.linux.kernel:70018



On Fri, 23 Nov 2001, Alexander Viro wrote:

> 	Untested fix follows.  And please, pass the brown paperbag... ;-/

...... and now for something that really builds:

diff -urN S15/fs/inode.c S15-fix/fs/inode.c
--- S15/fs/inode.c	Fri Nov 23 06:45:43 2001
+++ S15-fix/fs/inode.c	Fri Nov 23 17:04:05 2001
@@ -1065,24 +1065,27 @@
 			if (inode->i_state != I_CLEAR)
 				BUG();
 		} else {
-			if (!list_empty(&inode->i_hash) && sb && sb->s_root) {
+			if (!list_empty(&inode->i_hash)) {
 				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
 					list_del(&inode->i_list);
 					list_add(&inode->i_list, &inode_unused);
 				}
 				inodes_stat.nr_unused++;
 				spin_unlock(&inode_lock);
-				return;
-			} else {
-				list_del_init(&inode->i_list);
+				if (!sb || sb->s_flags & MS_ACTIVE)
+					return;
+				write_inode_now(inode, 1);
+				spin_lock(&inode_lock);
+				inodes_stat.nr_unused--;
 				list_del_init(&inode->i_hash);
-				inode->i_state|=I_FREEING;
-				inodes_stat.nr_inodes--;
-				spin_unlock(&inode_lock);
-				if (inode->i_data.nrpages)
-					truncate_inode_pages(&inode->i_data, 0);
-				clear_inode(inode);
 			}
+			list_del_init(&inode->i_list);
+			inode->i_state|=I_FREEING;
+			inodes_stat.nr_inodes--;
+			spin_unlock(&inode_lock);
+			if (inode->i_data.nrpages)
+				truncate_inode_pages(&inode->i_data, 0);
+			clear_inode(inode);
 		}
 		destroy_inode(inode);
 	}
diff -urN S15/fs/super.c S15-fix/fs/super.c
--- S15/fs/super.c	Fri Nov 23 06:45:43 2001
+++ S15-fix/fs/super.c	Fri Nov 23 16:56:50 2001
@@ -462,6 +462,7 @@
 	lock_super(s);
 	if (!type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 		goto out_fail;
+	s->s_flags |= MS_ACTIVE;
 	unlock_super(s);
 	/* tell bdcache that we are going to keep this one */
 	if (bdev)
@@ -614,6 +615,7 @@
 	lock_super(s);
 	if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 		goto out_fail;
+	s->s_flags |= MS_ACTIVE;
 	unlock_super(s);
 	get_filesystem(fs_type);
 	path_release(&nd);
@@ -695,6 +697,7 @@
 		lock_super(s);
 		if (!fs_type->read_super(s, data, flags & MS_VERBOSE ? 1 : 0))
 			goto out_fail;
+		s->s_flags |= MS_ACTIVE;
 		unlock_super(s);
 		get_filesystem(fs_type);
 		return s;
@@ -739,6 +742,7 @@
 	dput(root);
 	fsync_super(sb);
 	lock_super(sb);
+	sb->s_flags &= ~MS_ACTIVE;
 	invalidate_inodes(sb);	/* bad name - it should be evict_inodes() */
 	if (sop) {
 		if (sop->write_super && sb->s_dirt)
diff -urN S15/include/linux/fs.h S15-fix/include/linux/fs.h
--- S15/include/linux/fs.h	Fri Nov 23 06:45:44 2001
+++ S15-fix/include/linux/fs.h	Fri Nov 23 17:01:18 2001
@@ -110,6 +110,7 @@
 #define MS_BIND		4096
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
 /*

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


--=-=-=__ywr1g487/4PUAoZrLEY53nNT7__=-=-=--
