Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271701AbRHUPzC>; Tue, 21 Aug 2001 11:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271674AbRHUPyv>; Tue, 21 Aug 2001 11:54:51 -0400
Received: from nef.ens.fr ([129.199.96.32]:1287 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S271701AbRHUPyf>;
	Tue, 21 Aug 2001 11:54:35 -0400
Date: Tue, 21 Aug 2001 17:54:41 +0200
From: David Madore <david.madore@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Weird file corruption (448 bytes): FS? RAM?
Message-ID: <20010821175441.A26624@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is to report an almost paranormal phenomenon :-)

A few days ago I posted to this list because I had noticed a one-bit
corruption of one of my files.  This corruption was actually due to a
defective RAM, as memtest86 showed.  But memtest86 showed that only
*one* bit was wrong.  Now I am running Linux with "mem=" parameters
that tell it not to use the page with the defective bit.

Now I have just observed another file corruption.  This one is more
severe: 448 contiguous bytes were corrupted (details follow).  This
time I'm inclined to think the RAM is not to blame (448 defective
*bytes* do not go unnoticed), but the filesystem (ReiserFS).  However,
I would like expert opinion on this.  I would be grateful for any
ideas or suggestions.

Here are the details: the corrupted file was a shared library
(/opt/mozilla/components/libnsappshell.so).  It was in use at the time
when the corruption occurred (i.e. Mozilla was running), but
presumably swapped out to disk (to the filesystem, that is).  However,
corruption occurred in RAM only.  Specifically: Mozilla was idle and
probably swapped out, I exposed the window, causing it to swap in, and
it segfaulted immediately.  So I made a tar of the entire /opt/mozilla
directory, then purged my RAM's and buffers' content as well as I
could (by loading large files from disk, and by running programs that
need tremendous amounts of RAM).  When I was sure the /opt/mozilla
directory was no longer in disk cache, I compared the contents of the
tarball and the original files on disk, and the comparison showed that
the file in the tarball was corrupted.

Here is the diff between the original version (on disk) and the
corrupted version (in RAM, hence in the tarball) of the file, through
"od -A x -t x1 -t a":

--- right.dump	Mon Aug 20 22:14:40 2001
+++ wrong.dump	Mon Aug 20 22:14:28 2001
@@ -2532,62 +2532,24 @@
          |  ht   l   ]   C  cr   t   & nul  cr   <   ' nul nul nul nul
 004ff0 55 89 e5 83 ec 08 89 ec 5d c3 8d b6 00 00 00 00
          U  ht   e etx   l  bs  ht   l   ]   C  cr   6 nul nul nul nul
-005000 55 89 e5 53 83 ec 04 e8 44 ff ff ff 81 c3 90 78
-         U  ht   e   S etx   l eot   h   D del del del soh   C dle   x
-005010 01 00 8b 93 24 02 00 00 85 d2 74 19 83 ec 08 8d
-       soh nul  vt dc3   $ stx nul nul enq   R   t  em etx   l  bs  cr
-005020 83 28 07 00 00 50 8d 83 e4 ff ff ff 50 e8 1e fa
-       etx   ( bel nul nul   P  cr etx   d del del del   P   h  rs   z
-005030 ff ff 83 c4 10 8b 5d fc 89 ec 5d c3 8d 74 26 00
-       del del etx   D dle  vt   ]   |  ht   l   ]   C  cr   t   & nul
-005040 55 89 e5 83 ec 08 89 ec 5d c3 8d b6 00 00 00 00
-         U  ht   e etx   l  bs  ht   l   ]   C  cr   6 nul nul nul nul
-005050 55 89 e5 53 e8 00 00 00 00 5b 81 c3 43 78 01 00
-         U  ht   e   S   h nul nul nul nul   [ soh   C   C   x soh nul
-005060 8b 45 08 8b 8b 20 05 00 00 89 08 8b 93 d0 02 00
-        vt   E  bs  vt  vt  sp enq nul nul  ht  bs  vt dc3   P stx nul
-005070 00 89 10 89 48 04 8b 93 a8 02 00 00 89 50 04 89
-       nul  ht dle  ht   H eot  vt dc3   ( stx nul nul  ht   P eot  ht
-005080 48 08 8b 93 b8 02 00 00 89 50 08 89 48 0c 8b 93
-         H  bs  vt dc3   8 stx nul nul  ht   P  bs  ht   H  ff  vt dc3
-005090 c0 01 00 00 89 50 0c 89 48 10 8b 93 a0 05 00 00
-         @ soh nul nul  ht   P  ff  ht   H dle  vt dc3  sp enq nul nul
-0050a0 89 50 10 8b 93 34 03 00 00 89 50 10 c7 40 14 00
-        ht   P dle  vt dc3   4 etx nul nul  ht   P dle   G   @ dc4 nul
-0050b0 00 00 00 8b 93 94 05 00 00 89 10 8b 93 80 01 00
-       nul nul nul  vt dc3 dc4 enq nul nul  ht dle  vt dc3 nul soh nul
-0050c0 00 89 50 04 8b 93 a8 05 00 00 89 50 08 8b 93 dc
-       nul  ht   P eot  vt dc3   ( enq nul nul  ht   P  bs  vt dc3   \
-0050d0 03 00 00 89 50 0c 8b 93 40 02 00 00 89 50 10 c7
-       etx nul nul  ht   P  ff  vt dc3   @ stx nul nul  ht   P dle   G
-0050e0 40 1c 00 00 00 00 c7 40 18 00 00 00 00 8b 1c 24
-         @  fs nul nul nul nul   G   @ can nul nul nul nul  vt  fs   $
-0050f0 c9 c3 89 f6 55 89 e5 53 83 ec 04 e8 00 00 00 00
-         I   C  ht   v   U  ht   e   S etx   l eot   h nul nul nul nul
-005100 5b 81 c3 9c 77 01 00 8b 4d 08 8b 83 94 05 00 00
-         [ soh   C  fs   w soh nul  vt   M  bs  vt etx dc4 enq nul nul
-005110 89 01 8b 83 80 01 00 00 89 41 04 8b 83 a8 05 00
-        ht soh  vt etx nul soh nul nul  ht   A eot  vt etx   ( enq nul
-005120 00 89 41 08 8b 83 dc 03 00 00 89 41 0c 8b 83 40
-       nul  ht   A  bs  vt etx   \ etx nul nul  ht   A  ff  vt etx   @
-005130 02 00 00 89 41 10 8d 51 10 8b 83 34 03 00 00 89
-       stx nul nul  ht   A dle  cr   Q dle  vt etx   4 etx nul nul  ht
-005140 41 10 83 7a 04 00 74 11 8b 42 04 c7 40 08 00 00
-         A dle etx   z eot nul   t dc1  vt   B eot   G   @  bs nul nul
-005150 00 00 c7 42 04 00 00 00 00 f7 45 0c 01 00 00 00
-       nul nul   G   B eot nul nul nul nul   w   E  ff soh nul nul nul
-005160 74 0c 83 ec 0c 51 e8 d5 fc ff ff 83 c4 10 8b 5d
-         t  ff etx   l  ff   Q   h   U   | del del etx   D dle  vt   ]
-005170 fc c9 c3 90 55 89 e5 8b 55 08 8b 42 18 40 89 42
-         |   I   C dle   U  ht   e  vt   U  bs  vt   B can   @  ht   B
-005180 18 5d c3 90 55 89 e5 83 ec 08 8b 45 08 ff 48 18
-       can   ]   C dle   U  ht   e etx   l  bs  vt   E  bs del   H can
-005190 83 78 18 00 75 26 c7 40 18 01 00 00 00 85 c0 74
-       etx   x can nul   u   &   G   @ can soh nul nul nul enq   @   t
-0051a0 12 83 ec 08 8b 50 10 6a 03 83 c0 10 50 ff 52 18
-       dc2 etx   l  bs  vt   P dle   j etx etx   @ dle   P del   R can
-0051b0 83 c4 10 b8 00 00 00 00 eb 05 89 f6 8b 40 18 c9
-       etx   D dle   8 nul nul nul nul   k enq  ht   v  vt   @ can   I
+005000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+       nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
+*
+0050e0 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff
+       nul nul nul nul nul nul nul nul nul nul nul nul del del del del
+0050f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+       nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
+*
+005170 60 19 81 c8 00 82 85 c3 00 00 00 00 60 90 4e d1
+         `  em soh   H nul stx enq   C nul nul nul nul   ` dle   N   Q
+005180 00 00 00 00 00 00 00 00 00 00 00 00 58 65 36 c8
+       nul nul nul nul nul nul nul nul nul nul nul nul   X   e   6   H
+005190 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+       nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
+0051a0 00 00 00 00 00 00 00 00 00 00 00 00 0d 00 00 00
+       nul nul nul nul nul nul nul nul nul nul nul nul  cr nul nul nul
+0051b0 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+        si nul nul nul nul nul nul nul nul nul nul nul nul nul nul nul
 0051c0 c3 8d 76 00 55 89 e5 57 56 53 83 ec 0c e8 00 00
          C  cr   v nul   U  ht   e   W   V   S etx   l  ff   h nul nul
 0051d0 00 00 5b 81 c3 ca 76 01 00 8b 7d 0c b8 03 40 00

As you can see, 448 bytes were corrupted (*only* 448, mark, not 512),
and were replaced mostly by 0's, with a few random non-zero bytes.  I
searched for the byte string "60 19 81 c8 00 82 85 c3 00 00 00 00 60
90 4e d1" (which occurs in position 0x5170 in the corrupted version)
through all of my disk (well, only one of my disks, the one which
contained the /opt partition among other things, but not the tarball I
made) and I did not find it.  So I have no idea what these corrupted
bytes mean or where they came from.

The kernel is a 2.4.6 (with the international crypto patch 2.4.3.1,
but I doubt that matters), compiled with egcs-1.1.2.  The filesystem
is ReiserFS.  Overall distribution is RedHat-7.1 (Seawolf).

Let me repeat this in case I wasn't clear the first time:

* Mozilla was running fine.

* I do something else (play some sound files, in particular).  Mozilla
probably gets swapped out after a while.

* I expose Mozilla window.  It crashes immediately.

* I try to restart Mozilla.  It does not work, but segfaults
immediately on startup.

* I suspect file corruption, make tarball of /opt/mozilla directory.

* I do my best to purge the disk cache's content.

* I compare /opt/mozilla with the tarball: the files on disk are OK,
one file in the tarball are corrupted as shown above.

If there's anything I forgot to mention, please ask.

Happy hacking,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.eleves.ens.fr:8080/home/madore/ )
