Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290664AbSAYMp7>; Fri, 25 Jan 2002 07:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290672AbSAYMpt>; Fri, 25 Jan 2002 07:45:49 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:14285 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S290671AbSAYMpe>;
	Fri, 25 Jan 2002 07:45:34 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15441.21347.214934.178562@harpo.it.uu.se>
Date: Fri, 25 Jan 2002 13:45:23 +0100
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem corruption with 2.5.2-dj5
In-Reply-To: <E16U2Og-0000qu-00@baldrick>
In-Reply-To: <E16U2Og-0000qu-00@baldrick>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands writes:
 > I just gave 2.5.2-dj5 a try.  On a subsequent reboot and fsck
 > (with a stable kernel), I got a slew of messages about bad inode
 > fsizes on files modified while using 2.5.2-dj5.  The partition uses
 > ext2.  This is a UP i386 (AMD K6) machine with no other patches.
 > What can I do to help track this down?

I reported this a couple of hours ago for 2.5.3-pre and Al Viro posted
this patch:

--- C3-pre4/fs/ext2/ialloc.c	Wed Jan 23 20:45:32 2002
+++ /tmp/ialloc.c	Thu Jan 24 21:41:52 2002
@@ -392,6 +392,7 @@
 		ei->i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
 	ei->i_faddr = 0;
 	ei->i_frag_no = 0;
+	ei->i_frag_size = 0;
 	ei->i_osync = 0;
 	ei->i_file_acl = 0;
 	ei->i_dir_acl = 0;
--- C3-pre4/fs/ext2/inode.c	Wed Jan 23 20:45:32 2002
+++ /tmp/inode.c	Thu Jan 24 21:44:48 2002
@@ -963,6 +963,7 @@
 	ei->i_frag_size = raw_inode->i_fsize;
 	ei->i_osync = 0;
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl);
+	ei->i_dir_acl = 0;
 	if (S_ISREG(inode->i_mode))
 		inode->i_size |= ((__u64)le32_to_cpu(raw_inode->i_size_high)) << 32;
 	else
