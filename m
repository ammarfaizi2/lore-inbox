Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282691AbRK0AyY>; Mon, 26 Nov 2001 19:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282693AbRK0AyP>; Mon, 26 Nov 2001 19:54:15 -0500
Received: from gw.sw-stusie.uni-freiburg.de ([132.230.131.220]:58617 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S282691AbRK0AyG>; Mon, 26 Nov 2001 19:54:06 -0500
Date: Tue, 27 Nov 2001 01:53:59 +0100 (CET)
From: Jochen Eisinger <jochen.eisinger@gmx.de>
X-X-Sender: <charles@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.14-pre7+ fs/proc/inode.c breaks chardevs in /proc
Message-ID: <Pine.LNX.4.33.0111270114140.30432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Since 2.4.15-pre7 char-major devices located in the proc fs report
major/minor 0 instead of the correct values.

I figured out this is due to an incorrect patch in fs/proc/inode.c which
allows inode and/or file operations to be set for character device. The
problem occured with alsa which provides in /proc/asound/dev/ character
devices for accessing the sound cards. Since -pre7 these where all
char major/minor 0, although the sound driver still worked through the
oss/lite interface.

reverting the function proc_get_inode to -pre6 solves this problem:

- --- ./fs/proc/inode.c   Tue Nov 27 00:21:06 2001
+++ ./fs/proc/inode.c-pre6      Sun Sep 30 21:26:08 2001
@@ -160,12 +160,14 @@
                        inode->i_nlink = de->nlink;
                if (de->owner)
                        __MOD_INC_USE_COUNT(de->owner);
- -               if (de->proc_iops)
- -                       inode->i_op = de->proc_iops;
- -               if (de->proc_fops)
- -                       inode->i_fop = de->proc_fops;
- -               else if (S_ISBLK(de->mode)||S_ISCHR(de->mode)||S_ISFIFO(de->mode))
+               if (S_ISBLK(de->mode)||S_ISCHR(de->mode)||S_ISFIFO(de->mode))
                        init_special_inode(inode,de->mode,kdev_t_to_nr(de->rdev));
+               else {
+                       if (de->proc_iops)
+                               inode->i_op = de->proc_iops;
+                       if (de->proc_fops)
+                               inode->i_fop = de->proc_fops;
+               }
        }

 out:

regards
- -- jochen

- -- 
  "I'd rather die before using Micro$oft Word"
    -- Donald E. Knuth
     (asked whether he'd reinvent TeX in the light of M$ Word)

  GnuGP public key for jochen.eisinger@gmx.de:
      http://home.nexgo.de/jochen.eisinger/pubkey.asc (0x8AEB7AE3)


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE8AuQr8OF76YrreuMRAv5MAJwKvauDrXe5LCgAW5uEvoI0jCO6rgCfZnln
GrVAbUMTjo72mv8Bqj6dDNU=
=RevS
-----END PGP SIGNATURE-----

