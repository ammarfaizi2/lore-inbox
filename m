Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132559AbRDHNvP>; Sun, 8 Apr 2001 09:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132562AbRDHNvF>; Sun, 8 Apr 2001 09:51:05 -0400
Received: from ivanova.coker.com.au ([203.36.46.209]:59664 "HELO
	ivanova.coker.com.au") by vger.kernel.org with SMTP
	id <S132559AbRDHNuv> convert rfc822-to-8bit; Sun, 8 Apr 2001 09:50:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: linux-kernel@vger.kernel.org
Subject: struct stat{st_blksize} for /dev entries in 2.4.3
Date: Sun, 8 Apr 2001 23:49:19 +1000
X-Mailer: KMail [version 1.2]
Cc: herbert@gondor.apana.org.au
MIME-Version: 1.0
Message-Id: <01040823491919.25703@lyta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you stat() the files under /dev the st_blksize is returned as 1024 
bytes.  Currently cat will look at the input block size and the output block 
size and use the maximum of them as it's buffer size.  I believe that 
programs such as cat should never use a buffer size smaller than a page of 
memory and reported this as a bug in cat.
Herbert Xu (the maintainer of the Debian package textutils which contains 
cat) considers that the device should return a larger number in the 
st_blksize.

Here are some test results, first a P3-650 with 256M of RAM using a 300M 
partition of a 10G disk:
root@lyta:/#time cat /dev/ide/host0/bus0/target0/lun0/part1 > /dev/null
 
real    0m37.959s
user    0m0.220s
sys     0m4.910s
My patched cat uses 25% of the user CPU time and 90% the system CPU time of 
the unpatched cat:
root@lyta:/#time /usr/src/textutils-new/src/cat 
/dev/ide/host0/bus0/target0/lun0/part1 > /dev/null
 
real    0m35.502s
user    0m0.060s
sys     0m4.440s

Now here's an AMD K6-350 with 64M of RAM using a 2G RAID-1 partition across 
two 46G disks:
root@ivanova:~#time cat /dev/md/1 > /dev/null
 
real    2m25.906s
user    0m2.200s
sys     1m16.290s

My patched cat uses 30% the user CPU time and 95% the system CPU time:
root@ivanova:~#time /tmp/cat /dev/md/1 > /dev/null
 
real    2m14.845s
user    0m0.720s
sys     1m12.030s


On an AMD Athlon 800 machine I noticed an even more significant difference 
(the command "cat /dev/zero > /dev/hdc1" was using 100% CPU time but the disk 
was not at maximum speed before I patched cat).  But I don't have suitable 
test results with me at this time so I can't give you the details.  Another 
issue is that an Athlon 800 is a reasonably fast CPU, and it should probably 
be able to handle 33000 reads and 33000 writes per second easily without 
using any significant amount of CPU time.


Now I would like some comments on the following issues:
Is this a bug in cat regardless of whether the behaviour of the kernel is 
right or wrong?  I have attached a patch for cat in case it is determined 
that cat is buggy.


Regardless of whether cat is doing the right thing or not, does it make sense 
for the st_blksize of /dev/* to be 1024 bytes?  Or should it be 4096?

My understanding is that the st_blksize is the recommended IO size (not 
mandatory).  So it shouldn't break anything if this is set to a minimum of 
the page size.  But setting it to the page size will hint that applications 
should use a page as the minimum IO block size and cause some applications to 
deliver better performance.



diff -ru textutils-2.0/src/cat.c textutils-new/src/cat.c
--- textutils-2.0/src/cat.c     Sun Apr  8 22:55:10 2001
+++ textutils-new/src/cat.c     Sun Apr  8 23:23:54 2001
@@ -790,6 +790,9 @@
       if (options == 0)
        {
          insize = max (insize, outsize);
+#ifdef _SC_PHYS_PAGES
+         insize = max (insize, sysconf(_SC_PAGESIZE));
+#endif
          inbuf = (unsigned char *) xmalloc (insize);
 
          simple_cat (inbuf, insize);

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page
