Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVDJKCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVDJKCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 06:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVDJKCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 06:02:25 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:33263 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261459AbVDJKCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 06:02:17 -0400
Date: Sun, 10 Apr 2005 02:53:07 -0400
From: Christopher Li <lkml@chrisli.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
Message-ID: <20050410065307.GC13853@64m.dyndns.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 04:31:10PM -0700, Linus Torvalds wrote:
> 
> Done, and pushed out. The current git.git repository seems to do all of 
> this correctly.
> 
> NOTE! This means that each "tree" file basically tracks just a single
> directory. The old style of "every file in one tree file" still works, but 
> fsck-cache will warn about it. Happily, the git archive itself doesn't 
> have any subdirectories, so git itself is not impacted by it.

That is really cool stuff. My way to read it, correct me if I am wrong,
git is a user space version file system. "tree" <--> directory and
"blob" <--> file.  "commit" to describe the version history.

Git always write out a full new version of blob when there is any
update to it. At first I think that waste a lot of space, especially
when there is only tiny change to it. But the more I think about it,
it make more sense. Kernel source is usually small objects and file is
compressed store any way. A very useful thing to gain form it is that,
we can truncate the older history. e.g. We can have option not to sync
the pre 2.4 change set, only grab it if we need to. Most of the time we
only interested in the recent change set.

There is one problem though. How about the SHA1 hash collision?
Even the chance is very remote, you don't want to lose some data do due
to "software" error. I think it is OK that no handle that
case right now. On the other hand, it will be nice to detect that
and give out a big error message if it really happens.

Some thing like the following patch, may be turn off able.

Chris

Index: git-0.03/read-cache.c
===================================================================
--- git-0.03.orig/read-cache.c	2005-04-09 18:42:16.000000000 -0400
+++ git-0.03/read-cache.c	2005-04-10 02:48:36.000000000 -0400
@@ -210,8 +210,22 @@
 	int fd;
 
 	fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
-	if (fd < 0)
-		return (errno == EEXIST) ? 0 : -1;
+	if (fd < 0) {
+		void *map;
+		static int error(const char * string);
+
+		if (errno != EEXIST)
+			return -1;
+		fd = open(filename, O_RDONLY);
+		if (fd < 0)
+			return -1;
+		map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (map == MAP_FAILED)
+			return -1;
+		if (memcmp(buf, map, size))
+			return error("Ouch, Strike by lighting!\n");
+		return 0;
+	}
 	write(fd, buf, size);
 	close(fd);
 	return 0;
