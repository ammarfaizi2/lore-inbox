Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285919AbRLHLlZ>; Sat, 8 Dec 2001 06:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285921AbRLHLlG>; Sat, 8 Dec 2001 06:41:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5532 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285920AbRLHLlD>;
	Sat, 8 Dec 2001 06:41:03 -0500
Date: Sat, 8 Dec 2001 06:40:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] fix for idiocy in mount_root cleanups.
Message-ID: <Pine.GSO.4.21.0112080632020.6180-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Grr...  OK, that should be a lesson - never do obvious change
just before sending a patch.

	Change in question was s/do_mount/mount/.  Which is almost
the same thing, except for one little detail:  mount(2) in case of
error returns -1 and stores the error in errno.  do_mount(9), OTOH...

IOW, please apply the following and pass me a brown paperbag ;-/

--- C1-pre7/init/do_mounts.c	Fri Dec  7 20:48:43 2001
+++ linux/init/do_mounts.c	Sat Dec  8 06:29:20 2001
@@ -351,8 +351,9 @@
 		mount("devfs", ".", "devfs", 0, NULL);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
-		err = mount(name,"/root",p,root_mountflags,root_mount_data);
-		switch (err) {
+		errno = 0;
+		mount(name,"/root",p,root_mountflags,root_mount_data);
+		switch (-errno) {
 			case 0:
 				goto done;
 			case -EACCES:

