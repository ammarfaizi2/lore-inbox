Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWH2ODA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWH2ODA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWH2OC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:02:59 -0400
Received: from brick.kernel.dk ([62.242.22.158]:46156 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S964984AbWH2OC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:02:59 -0400
Date: Tue, 29 Aug 2006 16:05:43 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: vmsplice can't work well
Message-ID: <20060829140542.GN12257@kernel.dk>
References: <44F4440F.1090300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F4440F.1090300@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29 2006, Yi Yang wrote:
> Hi, Jens
> 
> I try to trace vmsplice and find it can't work in both ppc64 and i386,
> it always return -EFAULT because of the address of iovec.iov_base no
> matter it is page alignment or not, I don't know if I should file a
> bug for it, do you test it on i386 or ppc64?

Please provide an strace of the problem, it works fine for me (on x86-64
and x86, I've previously also tested ppc64 and ia64). Also please see
the splice tools here for more examples:

http://brick.kernel.dk/snaps/splice-git-20060711102502.tar.gz

I patched your program to fix the x86-64 syscall number and one/two
bugs, diff attached. Output for me:

axboe@nelson:/home/axboe $ ./f | cat > /dev/null
getpagesize = 4096
page size: 4096 bytes
written len = 4096

--- f.c~	2006-08-29 16:02:21.000000000 +0200
+++ f.c	2006-08-29 16:04:41.000000000 +0200
@@ -22,7 +22,7 @@
 #elif defined(__x86_64__)
 #define __NR_splice 275
 #define __NR_tee 276
-#define __NR_vmsplice 277
+#define __NR_vmsplice 278
 #elif defined(__powerpc__) || defined(__powerpc64__)
 #define __NR_splice 283
 #define __NR_tee 284
@@ -71,23 +71,26 @@
 	v.iov_base = buffer;
 	v.iov_len = len;
 
-	while (len) {
+	while (v.iov_len) {
 		/*
 		 * in a real app you'd be more clever with poll of course,
 		 * here we are basically just blocking on output room and
 		 * not using the free time for anything interesting.
 		 */
 		if (poll(&pfd, 1, -1) < 0)
-		return xerror("poll");
+			return xerror("poll");
 
 		written = vmsplice(fd, &v, 1, 0);
 		printf("here: len = %d, written = %d\n", len, written);
 
-		if (written <= 0)
+		if (!written)
+			break;
+		else if (written < 0)
 			return xerror("vmsplice");
 		fprintf(stderr, "written len = %d\n", written);
 
-		len -= written;
+		v.iov_len -= written;
+		v.iov_base += written;
 	}
 
 	return 0;
@@ -98,7 +101,7 @@
 	unsigned char *buffer;
 	struct stat sb;
 	long page_size;
-	int i, ret;
+	int i;
 
 	if (fstat(STDOUT_FILENO, &sb) < 0)
 		return xerror("stat");
@@ -112,7 +115,7 @@
 		return xerror("_SC_PAGESIZE");
 
 	fprintf(stderr, "getpagesize = %d\n", getpagesize());
-	fprintf(stderr, "page size: %d bytes\n", page_size);
+	fprintf(stderr, "page size: %d bytes\n", (int) page_size);
 
 	buffer = malloc(2 * 65536);
 	buffer[0]='A';

-- 
Jens Axboe

