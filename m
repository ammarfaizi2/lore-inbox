Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135314AbRDLVCQ>; Thu, 12 Apr 2001 17:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135317AbRDLVCH>; Thu, 12 Apr 2001 17:02:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14626 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135314AbRDLVBt>; Thu, 12 Apr 2001 17:01:49 -0400
Date: Thu, 12 Apr 2001 23:09:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: O_DIRECT
Message-ID: <20010412230944.A930@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I wrote the O_DIRECT zerocopy raw I/O support (dma from disk to the userspace
memory through the filesystem). The patch against 2.4.4pre2 + rawio-3 is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre2/o_direct-1

Only ext2 is supported at the moment, but extending it to the other fses that
use the common code helper functions is trivial (I guess Chris will take care
of reiserfs, it may be an option to not do tail packing for files opened with
O_DIRECT so you can dma from userspace the tail as well).

The above patch depends on the rawio performance improvement patch posted to
the list a few days ago here (latest version here):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre2/rawio-3

The rawio-3 patch is suggested for integration, certainly it's saner and faster
than mainline 2.4 (a note of credit: part of the fixes in the rawio-3 patch
are merged from SCT's patch).

To benchmark the improvement given by O_DIRECT, I hacked bonnie to open the
file with O_DIRECT in the "block" tests and I changed the chunk size to 1MB (so
that the blkdev layer will send large requests the hardware). Then I made a
comparision between the bonnie numbers w/o and w/ O_DIRECT (the -o_direct param
to bonnie now selects the O_DIRECT or standard behaviour, I also added
a -fast param to skip the slow seek test).  I cutted out the numbers that
aren't using O_DIRECT to make the report more readable.

Those are still preliminary results on a mid machine: 2-way SMP PII 450mhz with
128mbyte of ram on a lvm volume (physical volume is a single IDE disk, so not
striped and all in the same harddisk) using a working set of 400mbytes.

without using o_direct:
              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
           MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
          400  xxxx xxxx 12999 12.1  5918 10.8  xxxx xxxx 13412 12.1   xxx  xxx
          400  xxxx xxxx 12960 12.3  5896 11.1  xxxx xxxx 13520 13.3   xxx  xxx

with o_direct:
              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
           MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
          400  xxxx xxxx 12810  1.8  5855  1.6  xxxx xxxx 13529  1.2   xxx  xxx
          400  xxxx xxxx 12814  1.8  5866  1.7  xxxx xxxx 13519  1.3   xxx  xxx

As you can see there's a small performance drop in writes and I guess it's
beause we are some more synchronous and it takes a bit more of time between the
completion of one I/O request and the the sumbission of a new one and that's ok.
(if you really care that litte difference can be covered by using async-io)

The most interesting part is the cpu load that just decreases down to 1/2%
during all the I/O and this is ""only"" a 13mbyte/sec harddisk and on
top of lvm. I didn't run any benchmark on any faster disk and without lvm but
O_DIRECT is the obvious way to go for streaming endless data to disk (possibly
at 100mbyte/sec or more) like in multimedia or scientific apps and of course
with DBMS that do their own userspace management of the I/O cache in shm.

>From a DBMS point of view the only downside of the O_DIRECT compared to the
rawio device is: 1) walking of the meatadata in the fs [but that is in turn
_the_ feature that gives more flexibility to the administrator] and 2) O_DIRECT
cannot be done on a shared disk without also using a filesystem like GFS
because the regular fs doesn't know how to keep the metadata coherent across
multiple hosts.

Programming-wise the coherency of the cache under the direct I/O is the only
non obvious issue, what I did is been simply to flush the data (nothing of the
metadata!) before starting the direct I/O and to discard all the unmapped
pagecache from the inode after any direct write or to invalidate them (clear
all dirty bits in the pagecache and on the overlapped buffers if the page was
mapped so the next read through the cache will hit the disk again). This seems
safe even if it somehow breaks the semantics of mmaps (for example if the file
is mmaped during the o_direct the mmap view won't be updated, but o_direct
after all is magic anyways in the way it requires alignment of address and size
of the user buffer so this doesn't seem to be a problem... and not keeping
perfect coherency of the not useful cases increases performance of the useful
cases. I didn't see a value in updating the cache, if you want to update the
cache in a mapping simply don't use O_DIRECT ;).

To invalidate the cache I couldn't use the invalidate_inode_pages and
truncate_inode_pages, the former was too weak (I cannot simply skip the
stuff that is not just clean and unmapped or the user could never see
the updates afterwards when he stops using O_DIRECT), and the latter was too
aggressive (it can be used only once the inode is getting released and we know
there are no active mmaps on the file, the set_page_dirty was oopsing on me
because the page->i_mapping become null in a shared mapping for example). So I
wrote a third invalidate_inode_pages2 that also seems attractive from a NFS
point of view though I didn't changed nfs to use it, if we change the VM to be
robust about mapped pages getting removed by the pagecache I could use
truncate_inode_pages() in the future.

One important detail is that the invalidate_inode_pages2 doesn't get
a "range" of addresses in the address_space but it invalidates the whole
address_space instead. At first I was invalidating only the modified range and
after the putc test (that loads the cache) the rewrite tests was overloading
the cpu (around 30% of cpu usage). After I started to cut all the address space
the cpu load during rewrite test returned to the early numbers without cache
coherency in O_DIRECT.  (I was also browsing the list in the less optimal order
but I preferred to drop the range option to not force people to always
read physically consecutive to avoid the quadratic behaviour :)

As mentioned above if somebody keeps mmaps on the file the
invalidate_inode_pages2 won't be able to drop the pages from the list and it
will waste some CPU in kernel space. Only thing I did is to put the reschedule
points in the right places so the machine will remain perfectly responsive if
somebody tries to exploit it.

Some other explanation on the i_dirty_data_buffers list (probably you are
wondering why I added it): in the early stage I didn't flush the cache before
starting the direct I/O and I was getting performance like now in the final
patch. When the thing started working and I started to care about having
something that works with mixed O_DIRECT and non direct I/O I added a
generic_osync_inode (ala generic_file_write) to flush the cache to disk before
starting the direct I/O. This degraded significantly the performance because
the generic_osync_inode goes down and writes synchronously all the metadata as
well. More precisely I was getting those numbers:

              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
           MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
          400  xxxx xxxx 11138  1.7  5880  3.2  xxxx xxxx 13519  1.7  xxxx xxxx
			 ^^^^^		   ^^^
(I am writing only one line but the numbers were very stable and it was really a
noticeable slowdown)

To resurrect the performance of the original patch so I had to split the inode buffer
list in two, one for the data and one for the metadata, and now I only flush and
wait synchronously I/O completion of the i_dirty_data_buffers list before
starting the direct I/O and this fixed the performance problem completly.

If O_SYNC is used in combination of O_DIRECT I in turn skip the i_dirty_data_buffers
list and I only flush the metadata (i_dirty_buffers list) and the inode if
there was metadata dirty (this is why I introduced a third case in the
generic_osync_inode, this in practice probably doesn't make any difference though).

Another change I did in the brw_kiovec is that in the block[] array the
blocknumber -1UL is reserved and it's used during reads from disk to indicate
that the destination memory should be cleared (it's used to handle holes in the
files).

Andrea

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bonnie-o_direct-1

--- bonnie-1.orig/bonnie.c	Tue Sep  3 00:59:11 1996
+++ bonnie/bonnie-o_direct.c	Thu Apr 12 20:26:14 2001
@@ -95,6 +95,7 @@
 #else
 #include <sys/resource.h>
 #endif
+#include <asm/page.h>
 
 #define IntSize (4)
 
@@ -109,7 +110,11 @@
 #define Seeks (4000)
 #define UpdateSeek (10)
 #define SeekProcCount (3)
-#define Chunk (8192)
+#define Chunk (1<<20)
+
+#if defined(__alpha__) || defined(__i386__)
+#define O_DIRECT	040000	/* direct disk access - should check with OSF/1 */
+#endif
 
 static double cpu_so_far();
 static void   doseek();
@@ -146,7 +151,8 @@
   int    argc;
   char * argv[];
 {
-  int    buf[Chunk / IntSize];
+  char   __buf[Chunk+~PAGE_MASK];
+  int    *buf = (int *) ((unsigned long) (__buf + ~PAGE_MASK) & PAGE_MASK);
   int    bufindex;
   int    chars[256];
   int    child;
@@ -164,24 +170,28 @@
   int    size;
   FILE * stream;
   int    words;
+  int    o_direct = 0, fast = 0;
 
   fd = -1;
   basetime = (int) time((time_t *) NULL);
   size = 100;
   dir = ".";
 
-  for (next = 1; next < argc - 1; next++)
+   for (next = 1; next < argc; next++)
     if (argv[next][0] == '-')
     { /* option? */
       if (strcmp(argv[next] + 1, "d") == 0)
-        dir = argv[next + 1];
+	      dir = argv[next + 1], next++;
       else if (strcmp(argv[next] + 1, "s") == 0)
-        size = atoi(argv[next + 1]);
+	      size = atoi(argv[next + 1]), next++;
       else if (strcmp(argv[next] + 1, "m") == 0)
-        machine = argv[next + 1];
+	      machine = argv[next + 1], next++;
+      else if (strcmp(argv[next] + 1, "o_direct") == 0)
+	o_direct = 1, printf("Using O_DIRECT for block based I/O\n");
+      else if (strcmp(argv[next] + 1, "fast") == 0)
+	fast = 1, printf("Will skip the seek test\n");
       else
         usage();
-      next++;
     } /* option? */
     else
       usage();
@@ -194,12 +204,13 @@
 
   /* Fill up a file, writing it a char at a time with the stdio putc() call */
   fprintf(stderr, "Writing with putc()...");
-  newfile(name, &fd, &stream, 1);
+  newfile(name, &fd, &stream, 1, 0);
   timestamp();
   for (words = 0; words < size; words++)
     if (putc(words & 0x7f, stream) == EOF)
       io_error("putc");
   
+  fsync(fd);
   /*
    * note that we always close the file before measuring time, in an
    *  effort to force as much of the I/O out as we can
@@ -210,13 +221,13 @@
   fprintf(stderr, "done\n");
 
   /* Now read & rewrite it using block I/O.  Dirty one word in each block */
-  newfile(name, &fd, &stream, 0);
+  newfile(name, &fd, &stream, 0, o_direct);
   if (lseek(fd, (off_t) 0, 0) == (off_t) -1)
     io_error("lseek(2) before rewrite");
   fprintf(stderr, "Rewriting...");
   timestamp();
   bufindex = 0;
-  if ((words = read(fd, (char *) buf, Chunk)) == -1)
+  if ((words = read(fd, buf, Chunk)) == -1)
     io_error("rewrite read");
   while (words == Chunk)
   { /* while we can read a block */
@@ -230,13 +241,14 @@
     if ((words = read(fd, (char *) buf, Chunk)) == -1)
       io_error("rwrite read");
   } /* while we can read a block */
+  fsync(fd);
   if (close(fd) == -1)
     io_error("close after rewrite");
   get_delta_t(ReWrite);
   fprintf(stderr, "done\n");
 
   /* Write the whole file from scratch, again, with block I/O */
-  newfile(name, &fd, &stream, 1);
+  newfile(name, &fd, &stream, 1, o_direct);
   fprintf(stderr, "Writing intelligently...");
   for (words = 0; words < Chunk / IntSize; words++)
     buf[words] = 0;
@@ -249,13 +261,14 @@
     if (write(fd, (char *) buf, Chunk) == -1)
       io_error("write(2)");
   } /* for each word */
+  fsync(fd);
   if (close(fd) == -1)
     io_error("close after fast write");
   get_delta_t(FastWrite);
   fprintf(stderr, "done\n");
 
   /* read them all back with getc() */
-  newfile(name, &fd, &stream, 0);
+  newfile(name, &fd, &stream, 0, 0);
   for (words = 0; words < 256; words++)
     chars[words] = 0;
   fprintf(stderr, "Reading with getc()...");
@@ -278,7 +291,7 @@
     sprintf((char *) buf, "%d", chars[words]);
 
   /* Now suck it in, Chunk at a time, as fast as we can */
-  newfile(name, &fd, &stream, 0);
+  newfile(name, &fd, &stream, 0, o_direct);
   if (lseek(fd, (off_t) 0, 0) == -1)
     io_error("lseek before read");
   fprintf(stderr, "Reading intelligently...");
@@ -295,6 +308,11 @@
   get_delta_t(FastRead);
   fprintf(stderr, "done\n");
 
+  if (fast) {
+	  delta[Lseek][Elapsed] = 1;
+	  delta[Lseek][CPU] = 0;
+	  goto finish;
+  }
   /* use the frequency count */
   for (words = 0; words < 256; words++)
     sprintf((char *) buf, "%d", chars[words]);
@@ -334,8 +352,8 @@
       /* set up and wait for the go-ahead */
       close(seek_feedback[0]);
       close(seek_control[1]);
-      newfile(name, &fd, &stream, 0);
-      srandom(getpid());
+      newfile(name, &fd, &stream, 0, 0);
+      srandom(next); /* must always generate the same sequence or you'll compare orange to apples */
       fprintf(stderr, "Seeker %d...", next + 1);
 
       /* wait for the go-ahead */
@@ -411,6 +429,7 @@
   fprintf(stderr, "\n");
   delta[(int) Lseek][Elapsed] = last_stop - first_start;
 
+ finish:
   report(size);
   unlink(name);
 }
@@ -448,20 +467,21 @@
 }
 
 static void
-newfile(name, fd, stream, create)
+newfile(name, fd, stream, create, o_direct)
   char *   name;
   int *    fd;
   FILE * * stream;
   int      create;
+  int      o_direct;
 {
   if (create)
   { /* create from scratch */
     if (unlink(name) == -1 && *fd != -1)
       io_error("unlink");
-    *fd = open(name, O_RDWR | O_CREAT | O_EXCL, 0777);
+    *fd = open(name, O_RDWR | O_CREAT | O_EXCL | (o_direct ? O_DIRECT : 0), 0777);
   } /* create from scratch */
   else
-    *fd = open(name, O_RDWR, 0777);
+    *fd = open(name, O_RDWR | (o_direct ? O_DIRECT : 0), 0777);
 
   if (*fd == -1)
     io_error(name);
@@ -474,7 +494,7 @@
 usage()
 {
   fprintf(stderr,
-    "usage: Bonnie [-d scratch-dir] [-s size-in-Mb] [-m machine-label]\n");
+    "usage: Bonnie [-d scratch-dir] [-s size-in-Mb] [-m machine-label] [-o_direct]\n");
   exit(1);
 }
 
@@ -544,8 +564,7 @@
 io_error(message)
   char * message;
 {
-  char buf[Chunk];
-
+  char buf[8192];
   sprintf(buf, "Bonnie: drastic I/O error (%s)", message);
   perror(buf);
   exit(1);

--opJtzjQTFsWo+cga--
