Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264720AbSKEPK2>; Tue, 5 Nov 2002 10:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSKEPK2>; Tue, 5 Nov 2002 10:10:28 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:52880 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264720AbSKEPK0>;
	Tue, 5 Nov 2002 10:10:26 -0500
Date: Tue, 5 Nov 2002 16:17:02 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Cc: tytso@mit.edu
Subject: naive but spectacular ext3 HTREE+Orlov benchmark
Message-ID: <20021105151702.GA5894@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org, tytso@mit.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a 192 megabyte 1.1GHz laptop with boring disk, 13G well worn partition -
this is not a stylized benchmark! Result is repeatable though.

Summary of HTREE ext3 Orlov vs non-Orlov, in real minute:seconds

                                2.5.45	2.5.46
----------------------------------------------
unpacking kernel tar.bz2:       1:26	1:16
cold traversal:                 1:01.5  0:42.9
hot traversal:                  0:51.0  0:34.5
delete                          0:05.3  <0:02

Congratulations everybody, this is a major result! You can in fact *hear*
the difference. With the Orlov allocator, seeks are much more higher pitched
as if they are generally over shorter distances - which they probably are.

The cold traversal boils down to 4.47 megabytes/second over 13035 files,
close to 303 files/second which is comfortably more than the number of
seeks/second I expect this disk to be able to do. Magic is being performed
here.

traverse script:
#!/bin/sh
find . -type f | xargs -n 500 cat > /dev/null

On Linux 2.5.45, ext3+HTREE:

# mount /dev/hda3 /mnt
$ cd mnt
$ time tar xjf linux-2.5.45.tar.bz2
real    1m26.640s
user    0m48.256s
sys     0m4.592s

*reboot*

# mount /dev/hda3 /mnt
$ cd mnt/linux-2.5.45
$ time ../traverse
real    1m1.518s
user    0m0.159s
sys     0m1.267s
$ time ../traverse
real    0m51.007s
user    0m0.143s
sys     0m1.236s

$ cd .. ; time rm -rf linux-2.5.45
real    0m5.248s
user    0m0.020s
sys     0m0.440s

Same on Linux 2.5.46, ext3+HTREE+Orlov:
# mount /dev/hda3 /mnt
$ cd mnt
$ time tar xjf linux-2.5.45.tar.bz2
real    1m16.071s
user    0m48.291s
sys     0m4.918s

*reboot*

# mount /dev/hda3 /mnt
$ cd mnt/linux-2.5.45
$ time ../traverse
real    0m42.869s
user    0m0.148s
sys     0m1.323s
$ time ../traverse
real    0m34.468s
user    0m0.151s
sys     0m1.358s
$ cd .. ; rm -rf linux-2.5.45
$ 

This last delete wasn't measured but it appeared to be <2 seconds.


-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
