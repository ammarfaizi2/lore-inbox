Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290933AbSASLK0>; Sat, 19 Jan 2002 06:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290932AbSASLKQ>; Sat, 19 Jan 2002 06:10:16 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:1800 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S290920AbSASLKH>; Sat, 19 Jan 2002 06:10:07 -0500
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: rm-ing files with open file descriptors
Date: Sat, 19 Jan 2002 11:10:06 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <a2bk6e$t2u$1@ncc1701.cistron.net>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com> <a2afsg$73g$2@ncc1701.cistron.net> <a2almg$vtl$1@cesium.transmeta.com>
X-Trace: ncc1701.cistron.net 1011438606 29790 195.64.65.67 (19 Jan 2002 11:10:06 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <a2almg$vtl$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>Followup to:  <a2afsg$73g$2@ncc1701.cistron.net>
>By author:    Miquel van Smoorenburg <miquels@cistron.nl>
>In newsgroup: linux.dev.kernel
>> 
>> There is no way to recreate a file with a nlink count of 0,
>> well that is until someone adds flink(fd, newpath) to the kernel.
>
>This *might* work:
>
>link("/proc/self/fd/40", newpath);

I used the following perl script to test this, and alas this
doesn't work (yet):

open(FD, ">flink-test.txt") || die;
print FD "flink-test\n";
unlink "flink-test.txt"|| die;
link("/proc/self/fd/" . fileno(FD), "flink-test2.txt") || die;
print "Success.\n";

It results in:

link("/proc/self/fd/3", "flink-test2.txt") = -1 EXDEV (Invalid cross-device link)

This is probably because link() doesn't look up the target of the
symlink, it links the symlink itself. Linux allows symlinks with
a nlink count of 2:

% ln -s a b
% ln b c
ln: `b': warning: making a hard link to a symbolic link is not portable
% ls -l
lrwxrwxrwx    2 miquels  staff           1 Jan 19 11:34 b -> a
lrwxrwxrwx    2 miquels  staff           1 Jan 19 11:34 c -> a

This could be hacked around ofcourse in fs/namei.c, so I tried
it for fun. And indeed, with a minor correction it works:

% perl flink.pl 
Success.

I now have a flink-test2.txt file. That is pretty cool ;)

Here's the patch:

--- linux-2.4.15-pre4/fs/namei.c.orig	Wed Oct 17 23:46:29 2001
+++ linux-2.4.15-pre4/fs/namei.c	Sat Jan 19 12:08:13 2002
@@ -22,6 +22,7 @@
 #include <linux/dnotify.h>
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
+#include <linux/proc_fs.h>
 
 #include <asm/namei.h>
 #include <asm/uaccess.h>
@@ -1640,6 +1641,16 @@
 			error = path_walk(from, &old_nd);
 		if (error)
 			goto exit;
+#if 1 /* flink()-like support */
+		if (old_nd.mnt->mnt_sb->s_magic == PROC_SUPER_MAGIC) {
+			path_release(&old_nd);
+			if (path_init(from, LOOKUP_POSITIVE|LOOKUP_FOLLOW,
+			    &old_nd))
+				error = path_walk(from, &old_nd);
+			if (error)
+				goto exit;
+		}
+#endif
 		if (path_init(to, LOOKUP_PARENT, &nd))
 			error = path_walk(to, &nd);
 		if (error)



Mike.

