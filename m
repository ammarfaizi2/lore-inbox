Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272116AbRIEL5S>; Wed, 5 Sep 2001 07:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272115AbRIEL5J>; Wed, 5 Sep 2001 07:57:09 -0400
Received: from picard.csihq.com ([204.17.222.1]:43953 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S272109AbRIEL5D>;
	Wed, 5 Sep 2001 07:57:03 -0400
Message-ID: <024f01c13601$c763d3c0$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.8 NFS Problems
Date: Wed, 5 Sep 2001 07:56:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting random NFS EIO errors for a few months but now it's
repeatable.
Trying to copy a large file from one 2.4.8 SMP box to another is
consistently failing (at different offsets each time).
This doesn't appear to be a network problem as the last comm between the
machines looks OK.
By the timestamps it appears that a read() is taking too long and causing a
timeout?
I dropped the rsize and wsize on the mount from 8192 to 4096 and this solved
the problem (I had repeated this problem at least a dozen times before doing
this).
With the 4096 wsize there was one 5 second read delay and 3 at approx 2
seconds each.
So...it appears wsize 8192 was causing a timeout of some sort?

Here's a tail of the strace of the "cp" process with relative time stamps:
     0.000103 read(3,
"\307\3173-\226k\252-/]VU\261o\227x)\211c\362\370ZR\340"..., 8192) = 8192
     0.000099 write(4,
"\307\3173-\226k\252-/]VU\261o\227x)\211c\362\370ZR\340"..., 8192) = 8192
     0.000102 read(3,
"bh\0\31]U\"\307Eh\302Qp\324\313\345i\350\17\261\330\376"..., 8192) = 8192
     0.000100 write(4,
"bh\0\31]U\"\307Eh\302Qp\324\313\345i\350\17\261\330\376"..., 8192) = 8192
     0.000104 read(3, ",M\322\236h
\335\34e;L\275\221\326e\324\306y\200\310uD"..., 8192) = 8192
     0.000100 write(4, ",M\322\236h
\335\34e;L\275\221\326e\324\306y\200\310uD"..., 8192) = 8192
     0.000233 read(3,
"\315\240)\324~\315\373gJ}\272\263~\200\306\374i\215\246"..., 8192) = 8192
     0.000100 write(4,
"\315\240)\324~\315\373gJ}\272\263~\200\306\374i\215\246"..., 8192) = 8192
     0.000110 read(3,
"\222\362\357\315\3072\352\367\316\304\376wL\304.\346\375"..., 8192) = 8192
     0.000099 write(4,
"\222\362\357\315\3072\352\367\316\304\376wL\304.\346\375"..., 8192) = 8192
    10.535725 read(3,
"\3371f}g\314\372w\207A\v\253q\353\371S\23?\221\2752D\360"..., 8192) = 8192
     0.000182 write(4,
"\3371f}g\314\372w\207A\v\253q\353\371S\23?\221\2752D\360"..., 8192) = -1
EIO (Input/output error)
     0.000155 write(2, "cp: ", 4cp: )       = 4
     0.000046 write(2, "/picard/tmp/glibc.tgz", 21/picard/tmp/glibc.tgz) =
21
     0.000077 write(2, ": Input/output error", 20: Input/output error) = 20
     0.000054 write(2, "\n", 1
)         = 1
     0.000041 close(4)                  = 0
     0.001030 close(3)                  = 0
     0.000087 _exit(1)                  = ?

And here's the tail of the network traffic:
07:01:57.048590 yeti.csihq.com.652632144 > picard.csihq.com.nfs: 1472 write
[|nfs] (frag 28944:1480@0+)
07:01:57.048720 yeti.csihq.com > picard.csihq.com: (frag 28944:1480@1480+)
07:01:57.048841 yeti.csihq.com > picard.csihq.com: (frag 28944:1480@2960+)
07:01:57.048963 yeti.csihq.com > picard.csihq.com: (frag 28944:1480@4440+)
07:01:57.049090 yeti.csihq.com > picard.csihq.com: (frag 28944:1480@5920+)
07:01:57.049159 yeti.csihq.com > picard.csihq.com: (frag 28944:916@7400)
07:01:57.049520 picard.csihq.com.nfs > yeti.csihq.com.652632144: reply ok
136 write [|nfs] (DF)
07:02:01.910476 arp who-has picard.csihq.com tell yeti.csihq.com
07:02:01.910526 arp reply picard.csihq.com is-at 0:e0:29:2a:db:e9
07:02:07.480364 yeti.csihq.com.669409360 > picard.csihq.com.nfs: 108 commit
[|nfs] (DF)
07:02:07.480568 picard.csihq.com.nfs > yeti.csihq.com.669409360: reply ok
128 commit (DF)
07:02:07.481323 yeti.csihq.com.686186576 > picard.csihq.com.nfs: 1472 write
[|nfs] (frag 28948:1480@0+)
07:02:07.481446 yeti.csihq.com > picard.csihq.com: (frag 28948:1480@1480+)
07:02:07.481569 yeti.csihq.com > picard.csihq.com: (frag 28948:1480@2960+)
07:02:07.481692 yeti.csihq.com > picard.csihq.com: (frag 28948:1480@4440+)
07:02:07.481814 yeti.csihq.com > picard.csihq.com: (frag 28948:1480@5920+)
07:02:07.481886 yeti.csihq.com > picard.csihq.com: (frag 28948:916@7400)
07:02:07.482321 picard.csihq.com.nfs > yeti.csihq.com.686186576: reply ok
136 write [|nfs] (DF)
07:02:07.482511 yeti.csihq.com.702963792 > picard.csihq.com.nfs: 108 commit
[|nfs] (DF)
07:02:07.482642 picard.csihq.com.nfs > yeti.csihq.com.702963792: reply ok
128 commit (DF)


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

