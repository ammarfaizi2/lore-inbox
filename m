Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268179AbTB1Vuk>; Fri, 28 Feb 2003 16:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268174AbTB1Vuj>; Fri, 28 Feb 2003 16:50:39 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:6628 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S268179AbTB1Vuf>; Fri, 28 Feb 2003 16:50:35 -0500
Date: Fri, 28 Feb 2003 17:00:54 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@redhat.com>
Subject: mkdep patch in 2.4.21-pre4-ac7 breaks pci/drivers
Message-ID: <Pine.LNX.4.50.0302281626530.1829-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alan and all!

If I compile linux 2.4.21-pre4-ac7, then run "make depend" and "make
clean", then "make bzImage" fails in pci/drivers:

gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
-pipe -mpreferred-stack-boundary=2 -march=athlon   -nostdinc -iwithprefix
include -DKBUILD_BASENAME=compat  -c -o compat.o compat.c
make[3]: *** No rule to make target
`/usr/local/src/linux/drivers/pci/devlist.h', needed by `names.o'.  Stop.
make[3]: Leaving directory `/usr/local/src/linux/drivers/pci'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/local/src/linux/drivers/pci'
make[1]: *** [_subdir_pci] Error 2
make[1]: Leaving directory `/usr/local/src/linux/drivers'
make: *** [_dir_drivers] Error 2

This is caused by the patch for scripts/mkdep.c (part of the
2.4.21-pre4-ac7 patch) which makes full names from the includes.  GNU
make 3.79.1 tries to compile names.o, notices that it depends on
/usr/local/src/linux/drivers/pci/devlist.h, but doesn't "realize" (I guess
it's an intentional limitation) that the devlist.h target would create
that file.

The old code would put "devlist.h" without path into the .depend file.
make can actually deal with it.  If there are any reasons to use the full
path (most likely the reason is to eliminate ".."), either "wildcard"
should be used on the local files, or the "cleanable" files should be
somehow marked as such.  Finally, the build system could require "make
depend" after "make clean", but that would be an annoyance.

Here's the patch that uses wildcards for the local includes.  By the way,
there is no need to suppress "/../" for local files - neither the filename
not the working directory can have it.  Sorry, I'm including both changes
together, but it's trivial to separate them.

=========================
--- linux.orig/drivers/pci/mkdep.c
+++ linux/drivers/pci/mkdep.c
@@ -205,11 +205,13 @@ void handle_include(int start, const cha
 		path->buffer[path->len+len] = '\0';
 		if (access(path->buffer, F_OK) == 0) {
 			int l = lcwd + strlen(path->buffer);
+			int need_wildcard = 0;
 			char name2[l+2], *p;
 			if (path->buffer[0] == '/') {
 				memcpy(name2, path->buffer, l+1);
 			}
 			else {
+				need_wildcard = 1;
 				memcpy(name2, cwd, lcwd);
 				name2[lcwd] = '/';
 				memcpy(name2+lcwd+1, path->buffer, path->len+len+1);
@@ -219,7 +221,11 @@ void handle_include(int start, const cha
 				strcpy(strrchr(name2, '/'), p+3);
 			}
 			do_depname();
-			printf(" \\\n   %s", name2);
+			if (need_wildcard) {
+				printf(" \\\n   $(wildcard %s)", name2);
+			} else {
+				printf(" \\\n   %s", name2);
+			}
 			return;
 		}
 	}
=========================

Just in case, I'm using Red Hat 8.0 (make 3.79.1, bash 2.05b, gcc 3.2) on
AMD Athlon.

-- 
Regards,
Pavel Roskin
