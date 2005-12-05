Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbVLEURW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbVLEURW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVLEURV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:17:21 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:50611
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751430AbVLEURV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:17:21 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] update to the initramfs docs.
Date: Mon, 5 Dec 2005 14:17:07 -0600
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DBKlDwGoLf2VSdg"
Message-Id: <200512051417.07248.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_DBKlDwGoLf2VSdg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Rob Landley <rob@landley.net>

Based on questions people have asked me.  Repeatedly.

-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.

--Boundary-00=_DBKlDwGoLf2VSdg
Content-Type: text/x-diff;
  charset="us-ascii";
  name="initramfs2.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="initramfs2.patch"

--- linux-old/Documentation/filesystems/ramfs-rootfs-initramfs.txt	2005-12-05 13:09:32.140712872 -0600
+++ linux-2.6.15-rc4/Documentation/filesystems/ramfs-rootfs-initramfs.txt	2005-12-05 14:12:29.221509312 -0600
@@ -143,12 +143,26 @@
   dir /mnt 755 0 0
   file /init initramfs/init.sh 755 0 0
 
+Run "usr/gen_init_cpio" (after the kernel build) to get a usage message
+documenting the above file format.
+
 One advantage of the text file is that root access is not required to
 set permissions or create device nodes in the new archive.  (Note that those
 two example "file" entries expect to find files named "init.sh" and "busybox" in
 a directory called "initramfs", under the linux-2.6.* directory.  See
 Documentation/early-userspace/README for more details.)
 
+The kernel does not depend on external cpio tools, gen_init_cpio is created
+from usr/gen_init_cpio.c which is entirely self-contained, and the kernel's
+boot-time extractor is also (obviously) self-contained.  However, if you _do_
+happen to have cpio installed, the following command line can extract the
+generated cpio image back into its component files:
+
+  cpio -i -d -H newc -F initramfs_data.cpio --no-absolute-filenames
+
+Contents of initramfs:
+----------------------
+
 If you don't already understand what shared libraries, devices, and paths
 you need to get a minimal root filesystem up and running, here are some
 references:
@@ -161,13 +175,69 @@
 code against, along with some related utilities.  It is BSD licensed.
 
 I use uClibc (http://www.uclibc.org) and busybox (http://www.busybox.net)
-myself.  These are LGPL and GPL, respectively.
+myself.  These are LGPL and GPL, respectively.  (A self-contained initramfs
+package is planned for the busybox 1.2 release.)
 
 In theory you could use glibc, but that's not well suited for small embedded
 uses like this.  (A "hello world" program statically linked against glibc is
 over 400k.  With uClibc it's 7k.  Also note that glibc dlopens libnss to do
 name lookups, even when otherwise statically linked.)
 
+Why cpio rather than tar?
+-------------------------
+
+This decision was made back in December, 2001.  The discussion started here:
+
+  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1538.html
+
+And spawned a second thread (specifically on tar vs cpio), starting here:
+
+  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1587.html
+
+The quick and dirty summary version (which is no substitute for reading
+the above threads) is:
+
+1) cpio is a standard.  It's decades old (from the AT&T days), and already
+   widely used on Linux (inside RPM, Red Hat's device driver disks).  Here's
+   a Linux Journal article about it from 1996:
+
+      http://www.linuxjournal.com/article/1213
+
+   It's not as popular as tar because the traditional cpio command line tools
+   require _truly_hideous_ command line arguments.  But that says nothing
+   either way about the archive format, and there are alternative tools,
+   such as:
+
+     http://freshmeat.net/projects/afio/
+
+2) The cpio archive format chosen by the kernel is simpler and cleaner (and
+   thus easier to create and parse) than any of the (literally dozens of)
+   various tar archive formats.  The complete initramfs archive format is
+   explained in buffer-format.txt, created in usr/gen_init_cpio.c, and
+   extracted in init/initramfs.c.  All three together come to less than 26k
+   total of human-readable text.
+
+3) The GNU project standardizing on tar is approximately as relevant as
+   Windows standardizing on zip.  Linux is not part of either, and is free
+   to make its own technical decisions.
+
+4) Since this is a kernel internal format, it could easily have been
+   something brand new.  The kernel provides its own tools to create and
+   extract this format anyway.  Using an existing standard was preferable,
+   but not essential.
+
+5) Al Viro made the decision (quote: "tar is ugly as hell and not going to be
+   supported on the kernel side"):
+
+      http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1540.html
+
+   explained his reasoning:
+
+      http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1550.html
+      http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1638.html
+
+   and, most importantly, designed and implemented the initramfs code.
+
 Future directions:
 ------------------
 

--Boundary-00=_DBKlDwGoLf2VSdg--
