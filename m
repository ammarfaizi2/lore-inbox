Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284251AbRLPGAX>; Sun, 16 Dec 2001 01:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284253AbRLPGAO>; Sun, 16 Dec 2001 01:00:14 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:5897 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284251AbRLPGAB>; Sun, 16 Dec 2001 01:00:01 -0500
Message-ID: <3C1C382A.946EA61B@zip.com.au>
Date: Sat, 15 Dec 2001 21:59:06 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>
CC: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: O_DIRECT wierd behavior..
In-Reply-To: <Pine.GSO.4.02A.10112151947010.14453-100000@aramis.rutgers.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh Gopalakrishnan wrote:
> 
> I tried this small piece of code from an old post in the archive:
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <fcntl.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <unistd.h>
> 
> #define O_DIRECT         040000 /* direct disk access hint */
> 
> int main()
> {
>         char buf[16384];
>         int fd;
>         char *p;
> 
>         p = (char *)((((unsigned long)buf) + 8191) & ~8191L);
>         fd = open("/tmp/blah", O_CREAT | O_RDWR | O_DIRECT);
> 
>         printf("write returns %i\n", write(fd, buf, 8192));
>         printf("write returns %i\n", write(fd, p, 1));
> 
>         return 0;
> }
> 

The app has a bug in it (I think); but the kernel has four.
Your first write fails because `buf' is not page-aligned.

Then the kernel screws up the error handling, and ends up
setting the file size to -EINVAL (ie: rather large).



1: We're testing `written >= 0', but it is unsigned (!).  In two
   places.

   This one, IMO is a gcc shortcoming.  The compiler is capable of warning
   about expressions which always evaluate to true or false in `if' statements,
   but turning this on also enables lots of things you don't want it to warn about.
   gcc needs to provide finer control of its warning capabilities.  I patched
   gcc-2.7.2.3 to do this ages back and it was very useful.

2: If generic_osync_inode() returns an error, we fail to report it.  In
   two places.

Here's a quick fix.  It needs a review.



--- linux-2.4.17-rc1/mm/filemap.c	Thu Dec 13 14:07:55 2001
+++ linux-akpm/mm/filemap.c	Sat Dec 15 21:52:06 2001
@@ -3038,8 +3038,11 @@ unlock:
 	/* For now, when the user asks for O_SYNC, we'll actually
 	 * provide O_DSYNC. */
 	if (status >= 0) {
-		if ((file->f_flags & O_SYNC) || IS_SYNC(inode))
+		if ((file->f_flags & O_SYNC) || IS_SYNC(inode)) {
 			status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
+			if (status < 0)
+				written = 0;	/* Return the right thing */
+		}
 	}
 	
 out_status:	
@@ -3054,7 +3057,8 @@ fail_write:
 
 o_direct:
 	written = generic_file_direct_IO(WRITE, file, (char *) buf, count, pos);
-	if (written > 0) {
+	status = written;
+	if (status > 0) {
 		loff_t end = pos + written;
 		if (end > inode->i_size && !S_ISBLK(inode->i_mode)) {
 			inode->i_size = end;
@@ -3067,8 +3071,11 @@ o_direct:
 	 * Sync the fs metadata but not the minor inode changes and
 	 * of course not the data as we did direct DMA for the IO.
 	 */
-	if (written >= 0 && file->f_flags & O_SYNC)
+	if (status >= 0 && file->f_flags & O_SYNC) {
 		status = generic_osync_inode(inode, OSYNC_METADATA);
+		if (status < 0)
+			written = 0;	/* Return the right thing */
+	}
 	goto out_status;
 }
