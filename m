Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266934AbRGMGZi>; Fri, 13 Jul 2001 02:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266935AbRGMGZ1>; Fri, 13 Jul 2001 02:25:27 -0400
Received: from smtp1.libero.it ([193.70.192.51]:55706 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S266934AbRGMGZT>;
	Fri, 13 Jul 2001 02:25:19 -0400
Message-ID: <3B4E93E9.F6506CC0@alsa-project.org>
Date: Fri, 13 Jul 2001 08:23:37 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: neilb@cse.unsw.edu.au, nfs-devel@linux.kernel.org,
        nfs@lists.sourceforge.net
Subject: [PATCH] Bug in NFS
Content-Type: multipart/mixed;
 boundary="------------81C1B6873E2B8874ED9E1D76"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------81C1B6873E2B8874ED9E1D76
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


I have found a bug in NFSv2.

[root@igor /tmp]# mount igor:/u u
[root@igor /tmp]# cd u
[root@igor u]# umask 000
[root@igor u]# ls -l q
ls: q: File o directory inesistente
[root@igor u]# touch q
[root@igor u]# ls -l q
-rw-r--r--    1 root     root            0 lug 13 07:56 q

This seems to be caused by use of unitialized current->fs->umask via
vfs_create called by nfsd_create.

Patch for 2.4.6 follows.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
--------------81C1B6873E2B8874ED9E1D76
Content-Type: text/plain; charset=us-ascii;
 name="nfs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfs.diff"

--- linux-2.4/fs/nfsd/auth.c.~1~	Mon Jul 24 08:04:10 2000
+++ linux-2.4/fs/nfsd/auth.c	Fri Jul 13 08:00:10 2001
@@ -34,6 +34,7 @@
 				cred->cr_groups[i] = exp->ex_anon_gid;
 	}
 
+	current->fs->umask = 0;
 	if (cred->cr_uid != (uid_t) -1)
 		current->fsuid = cred->cr_uid;
 	else


--------------81C1B6873E2B8874ED9E1D76--

