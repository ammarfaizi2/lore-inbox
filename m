Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131180AbQLRS6C>; Mon, 18 Dec 2000 13:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131210AbQLRS5x>; Mon, 18 Dec 2000 13:57:53 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:32241 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S131180AbQLRS5r>; Mon, 18 Dec 2000 13:57:47 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012181823.eBIINRo28087@webber.adilger.net>
Subject: Re: [patch-2.4.0-test13-pre3] rootfs (2nd attempt)
In-Reply-To: <Pine.LNX.4.21.0012181547500.830-100000@penguin.homenet>
 "from Tigran Aivazian at Dec 18, 2000 04:00:45 pm"
To: Tigran Aivazian <tigran@veritas.com>
Date: Mon, 18 Dec 2000 11:23:27 -0700 (MST)
CC: torvalds@transmeta.com, Andries.Brouwer@cwi.nl,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran, you write:
> Thanks to suggestions from Andries and Peter I enhanced the rootfs patch
> to do the same it did before + panic when rootfs= is given but failed to

If I could add one thing here (we have had a 2.2 patch like this for testing
with ext3) - if you specify the rootfstype parameter don't use the "quiet"
option to read_super, so you know why it couldn't mount a specific filesystem
as root, and/or print rootfs type in the panic message.

This is especially useful if you have something in LILO that you forgot about...

Cheers, Andreas
=============================================================================
diff -urN -X dontdiff linux/fs/super.c rootfs/fs/super.c
--- linux/fs/super.c	Tue Dec 12 09:25:22 2000
+++ rootfs/fs/super.c	Mon Dec 18 14:49:08 2000
@@ -1600,7 +1600,7 @@
 	if (*rootfs) {
 		fs_type = get_fs_type(rootfs);
 		if (fs_type) {
-  			sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
+  			sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,0);
 			if (sb)
 				goto mount_it;
 		} 
@@ -1622,7 +1622,8 @@
 	}
 	read_unlock(&file_systems_lock);
 fail:
-	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
+	panic("VFS: Unable to mount root %s on %s", *rootfs ? rootfs : "fs",
+	      kdevname(ROOT_DEV));
 
 mount_it:
 	printk ("VFS: Mounted root (%s filesystem)%s.\n",

-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
