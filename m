Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292930AbSBVRBr>; Fri, 22 Feb 2002 12:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292931AbSBVRBi>; Fri, 22 Feb 2002 12:01:38 -0500
Received: from [80.224.211.167] ([80.224.211.167]:8520 "EHLO head.redvip.net")
	by vger.kernel.org with ESMTP id <S292930AbSBVRB2>;
	Fri, 22 Feb 2002 12:01:28 -0500
Message-ID: <3C767970.50009@zaralinux.com>
Date: Fri, 22 Feb 2002 18:01:36 +0100
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: es-es, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS problem with ne.o
Content-Type: multipart/mixed;
 boundary="------------080700090303060500020405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080700090303060500020405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

First of all, I'm pretty sure this bug is in ne.c, the reason is that 
the only change in my machine is a died 3c509 to a ne clone (ne.o), from 
that point my nfs has become flacky.

Description:
One machine (head) the server, 486dx4, ne clone,  2.4.15-pre9, knfsd
The other machine (quartz) client, 2x200mmx, old 3c503 (3c503.o), 2.5.3 
& 2.4.17-rc1.

Both machines have a crossover clable using a realtek 8139C (head) and a 
3c905B (quartz) wich works ok, but the old ne card is in a coax network 
with other clients, so nfs over ne.o should work ok.

As I said the problem is easy, and I have logs on both ends, the only 
change that caused this problem is a died 3c509 -> EISA ne clone so 
being this the only change it should be easy, but I can't find it.

The problem seems to be that the end packet of a multi-packet UDP 
transfer never gets send, TCP works realiable and fast, but I didn't try 
hard to reproduce it, only some http transfers.

An excerpt of the log:

first the server (head):
17:29:54.910504 < quartz.4216423526 > head.nfs: 116 read fh Unknown/1 
8192 bytes @ 102400 (DF) (ttl 64, id 0)
17:29:54.950484 > head.nfs > quartz.4216423526: reply ok 1472 read REG 
100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 
a/m/ctime 1014395394.000000 1011347457.000000 1011347457.000000  (frag 
4075:1480@0+) (ttl 64)
17:29:54.950484 > head > quartz: (frag 14075:1480@1480+) (ttl 64)
17:29:54.950484 > head > quartz: (frag 14075:1480@2960+) (ttl 64)
17:29:54.950484 > head > quartz: (frag 14075:1480@4440+) (ttl 64)
17:29:54.950484 > head > quartz: (frag 14075:1480@5920+) (ttl 64)
17:29:54.950484 > head > quartz: (frag 14075:900@7400) (ttl 64)
17:29:55.610156 < quartz.4216423526 > head.nfs: 116 read fh Unknown/1 
8192 bytes @ 102400 (DF) (ttl 64, id 0)

then what the client (quartz) sees:
17:30:11.268447 > quartz.4216423526 > head.nfs: 116 read fh Unknown/1 
8192 bytes @ 102400 (DF) (ttl 64, id 0)
17:30:11.308348 < head.nfs > quartz.4216423526: reply ok 1472 read REG 
100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 
a/m/ctime 1014395394.000000 1011347457.000000 1011347457.000000  (frag 
4075:1480@0+) (ttl 64)
17:30:11.310481 < head > quartz: (frag 14075:1480@1480+) (ttl 64)
17:30:11.312078 < head > quartz: (frag 14075:1480@2960+) (ttl 64)
17:30:11.313692 < head > quartz: (frag 14075:1480@4440+) (ttl 64)
17:30:11.962381 > quartz.4216423526 > head.nfs: 116 read fh Unknown/1 
8192 bytes @ 102400 (DF) (ttl 64, id 0)

The last packet from the server (head) never arrives,
17:29:54.950484 > head > quartz: (frag 14075:900@7400) (ttl 64)
^ This never reaches the other end.

The error is fairly easy to reproduce, just trying to read a file 
contents dumps an input/output error.

As I said TCP works reliable and fast, so does doing an ls -la of the 
/etc directory, I'm open to more attemps, so if one sees the ligth 
please mail me ;)

P.S. I know the ne driver is a old one, but the machine is a 486, and I 
don't have free pci slots, and as I said the card works ok because tcp 
is fast and don't ask for retransmits. I mount with 
rsize=8192,wsize=8192 but without it it also fails.

-- 
Jorge Nerin
<comandante@zaralinux.com>

--------------080700090303060500020405
Content-Type: text/plain;
 name="nfs-head.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfs-head.txt"

17:29:54.880518 < quartz.4149314662 > head.nfs: 112 lookup fh Unknown/1 "JR" (DF) (ttl 64, id 0)
17:29:54.880518 > head.nfs > quartz.4149314662: reply ok 128 lookup fh Unknown/1 DIR 40755 ids 0/0 sz 144 nlink 2 rdev ffffffff fsid 302 nodeid 9947b a/m/ctime 1011347135.000000  [|nfs] (DF) (ttl 64, id 0)
17:29:54.880518 < quartz.4166091878 > head.nfs: 124 lookup fh Unknown/1  [|nfs] (DF) (ttl 64, id 0)
17:29:54.880518 > head.nfs > quartz.4166091878: reply ok 128 lookup fh Unknown/1 REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395265.000000  [|nfs] (DF) (ttl 64, id 0)
17:29:54.890513 < quartz.4182869094 > head.nfs: 116 read fh Unknown/1 4096 bytes @ 90112 (DF) (ttl 64, id 0)
17:29:54.890513 > head.nfs > quartz.4182869094: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395394.000000 1011347457.000000 1011347457.000000  (frag 14073:1480@0+) (ttl 64)
17:29:54.890513 > head > quartz: (frag 14073:1480@1480+) (ttl 64)
17:29:54.890513 > head > quartz: (frag 14073:1244@2960) (ttl 64)
17:29:54.900508 < quartz.4199646310 > head.nfs: 116 read fh Unknown/1 4096 bytes @ 94208 (DF) (ttl 64, id 0)
17:29:54.900508 > head.nfs > quartz.4199646310: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395394.000000 1011347457.000000 1011347457.000000  (frag 14074:1480@0+) (ttl 64)
17:29:54.900508 > head > quartz: (frag 14074:1480@1480+) (ttl 64)
17:29:54.910504 > head > quartz: (frag 14074:1244@2960) (ttl 64)
17:29:54.910504 < quartz.4216423526 > head.nfs: 116 read fh Unknown/1 8192 bytes @ 102400 (DF) (ttl 64, id 0)
17:29:54.950484 > head.nfs > quartz.4216423526: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395394.000000 1011347457.000000 1011347457.000000  (frag 14075:1480@0+) (ttl 64)
17:29:54.950484 > head > quartz: (frag 14075:1480@1480+) (ttl 64)
17:29:54.950484 > head > quartz: (frag 14075:1480@2960+) (ttl 64)
17:29:54.950484 > head > quartz: (frag 14075:1480@4440+) (ttl 64)
17:29:54.950484 > head > quartz: (frag 14075:1480@5920+) (ttl 64)
17:29:54.950484 > head > quartz: (frag 14075:900@7400) (ttl 64)
17:29:55.610156 < quartz.4216423526 > head.nfs: 116 read fh Unknown/1 8192 bytes @ 102400 (DF) (ttl 64, id 0)
17:29:55.610156 > head.nfs > quartz.4216423526: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395395.000000 1011347457.000000 1011347457.000000  (frag 14076:1480@0+) (ttl 64)
17:29:55.610156 > head > quartz: (frag 14076:1480@1480+) (ttl 64)
17:29:55.610156 > head > quartz: (frag 14076:1480@2960+) (ttl 64)
17:29:55.610156 > head > quartz: (frag 14076:1480@4440+) (ttl 64)
17:29:55.620151 > head > quartz: (frag 14076:1480@5920+) (ttl 64)
17:29:55.620151 > head > quartz: (frag 14076:900@7400) (ttl 64)
17:29:57.009461 < quartz.4216423526 > head.nfs: 116 read fh Unknown/1 8192 bytes @ 102400 (DF) (ttl 64, id 0)
17:29:57.009461 > head.nfs > quartz.4216423526: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395397.000000 1011347457.000000 1011347457.000000  (frag 14077:1480@0+) (ttl 64)
17:29:57.009461 > head > quartz: (frag 14077:1480@1480+) (ttl 64)
17:29:57.009461 > head > quartz: (frag 14077:1480@2960+) (ttl 64)
17:29:57.009461 > head > quartz: (frag 14077:1480@4440+) (ttl 64)
17:29:57.009461 > head > quartz: (frag 14077:1480@5920+) (ttl 64)
17:29:57.019456 > head > quartz: (frag 14077:900@7400) (ttl 64)
17:29:59.808071 < quartz.4216423526 > head.nfs: 116 read fh Unknown/1 8192 bytes @ 102400 (DF) (ttl 64, id 0)
17:29:59.818066 > head.nfs > quartz.4216423526: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395399.000000 1011347457.000000 1011347457.000000  (frag 14078:1480@0+) (ttl 64)
17:29:59.818066 > head > quartz: (frag 14078:1480@1480+) (ttl 64)
17:29:59.818066 > head > quartz: (frag 14078:1480@2960+) (ttl 64)
17:29:59.818066 > head > quartz: (frag 14078:1480@4440+) (ttl 64)
17:29:59.818066 > head > quartz: (frag 14078:1480@5920+) (ttl 64)
17:29:59.818066 > head > quartz: (frag 14078:900@7400) (ttl 64)
17:29:59.878036 > arp who-has quartz tell head (0:20:18:70:82:4f)
17:29:59.878036 < arp reply quartz is-at 2:60:8c:a0:48:e1 (0:20:18:70:82:4f)
17:30:05.405291 < quartz.4233200742 > head.nfs: 116 read fh Unknown/1 4096 bytes @ 110592 (DF) (ttl 64, id 0)
17:30:05.445272 > head.nfs > quartz.4233200742: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395405.000000 1011347457.000000 1011347457.000000  (frag 14079:1480@0+) (ttl 64)
17:30:05.445272 > head > quartz: (frag 14079:1480@1480+) (ttl 64)
17:30:05.445272 > head > quartz: (frag 14079:1244@2960) (ttl 64)
17:30:10.402809 < arp who-has head tell quartz
17:30:10.402809 > arp reply head (0:20:18:70:82:4f) is-at 0:20:18:70:82:4f (2:60:8c:a0:48:e1)

--------------080700090303060500020405
Content-Type: text/plain;
 name="nfs-quartz.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfs-quartz.txt"

17:30:11.234105 > quartz.4149314662 > head.nfs: 112 lookup fh Unknown/1 "JR" (DF) (ttl 64, id 0)
17:30:11.236933 < head.nfs > quartz.4149314662: reply ok 128 lookup fh Unknown/1 DIR 40755 ids 0/0 sz 144 nlink 2 rdev ffffffff fsid 302 nodeid 9947b a/m/ctime 1011347135.000000  [|nfs] (DF) (ttl 64, id 0)
17:30:11.238197 > quartz.4166091878 > head.nfs: 124 lookup fh Unknown/1  [|nfs] (DF) (ttl 64, id 0)
17:30:11.241169 < head.nfs > quartz.4166091878: reply ok 128 lookup fh Unknown/1 REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395265.000000  [|nfs] (DF) (ttl 64, id 0)
17:30:11.244341 > quartz.4182869094 > head.nfs: 116 read fh Unknown/1 4096 bytes @ 90112 (DF) (ttl 64, id 0)
17:30:11.253147 < head.nfs > quartz.4182869094: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395394.000000 1011347457.000000 1011347457.000000  (frag 14073:1480@0+) (ttl 64)
17:30:11.254770 < head > quartz: (frag 14073:1480@1480+) (ttl 64)
17:30:11.256124 < head > quartz: (frag 14073:1244@2960) (ttl 64)
17:30:11.256946 > quartz.4199646310 > head.nfs: 116 read fh Unknown/1 4096 bytes @ 94208 (DF) (ttl 64, id 0)
17:30:11.264355 < head.nfs > quartz.4199646310: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395394.000000 1011347457.000000 1011347457.000000  (frag 14074:1480@0+) (ttl 64)
17:30:11.265963 < head > quartz: (frag 14074:1480@1480+) (ttl 64)
17:30:11.267318 < head > quartz: (frag 14074:1244@2960) (ttl 64)
17:30:11.268447 > quartz.4216423526 > head.nfs: 116 read fh Unknown/1 8192 bytes @ 102400 (DF) (ttl 64, id 0)
17:30:11.308348 < head.nfs > quartz.4216423526: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395394.000000 1011347457.000000 1011347457.000000  (frag 14075:1480@0+) (ttl 64)
17:30:11.310481 < head > quartz: (frag 14075:1480@1480+) (ttl 64)
17:30:11.312078 < head > quartz: (frag 14075:1480@2960+) (ttl 64)
17:30:11.313692 < head > quartz: (frag 14075:1480@4440+) (ttl 64)
17:30:11.962381 > quartz.4216423526 > head.nfs: 116 read fh Unknown/1 8192 bytes @ 102400 (DF) (ttl 64, id 0)
17:30:11.971597 < head.nfs > quartz.4216423526: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395395.000000 1011347457.000000 1011347457.000000  (frag 14076:1480@0+) (ttl 64)
17:30:11.973734 < head > quartz: (frag 14076:1480@1480+) (ttl 64)
17:30:11.975335 < head > quartz: (frag 14076:1480@2960+) (ttl 64)
17:30:11.976934 < head > quartz: (frag 14076:1480@4440+) (ttl 64)
17:30:13.362405 > quartz.4216423526 > head.nfs: 116 read fh Unknown/1 8192 bytes @ 102400 (DF) (ttl 64, id 0)
17:30:13.370429 < head.nfs > quartz.4216423526: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395397.000000 1011347457.000000 1011347457.000000  (frag 14077:1480@0+) (ttl 64)
17:30:13.372573 < head > quartz: (frag 14077:1480@1480+) (ttl 64)
17:30:13.374177 < head > quartz: (frag 14077:1480@2960+) (ttl 64)
17:30:13.375776 < head > quartz: (frag 14077:1480@4440+) (ttl 64)
17:30:16.168758 > quartz.4216423526 > head.nfs: 116 read fh Unknown/1 8192 bytes @ 102400 (DF) (ttl 64, id 0)
17:30:16.178462 < head.nfs > quartz.4216423526: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395399.000000 1011347457.000000 1011347457.000000  (frag 14078:1480@0+) (ttl 64)
17:30:16.180764 < head > quartz: (frag 14078:1480@1480+) (ttl 64)
17:30:16.182821 < head > quartz: (frag 14078:1480@2960+) (ttl 64)
17:30:16.184426 < head > quartz: (frag 14078:1480@4440+) (ttl 64)
17:30:16.186025 < head > quartz: (frag 14078:1480@5920+) (ttl 64)
17:30:16.231661 < arp who-has quartz tell head
17:30:16.231794 > arp reply quartz (2:60:8c:a0:48:e1) is-at 2:60:8c:a0:48:e1 (0:20:18:70:82:4f)
17:30:21.769688 > quartz.4233200742 > head.nfs: 116 read fh Unknown/1 4096 bytes @ 110592 (DF) (ttl 64, id 0)
17:30:21.807108 < head.nfs > quartz.4233200742: reply ok 1472 read REG 100744 ids 0/0 sz 645911 nlink 1 rdev ffffffff fsid 302 nodeid 9c8d2 a/m/ctime 1014395405.000000 1011347457.000000 1011347457.000000  (frag 14079:1480@0+) (ttl 64)
17:30:21.808728 < head > quartz: (frag 14079:1480@1480+) (ttl 64)
17:30:21.810081 < head > quartz: (frag 14079:1244@2960) (ttl 64)

--------------080700090303060500020405--

