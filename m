Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbUKSHks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUKSHks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 02:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbUKSHks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 02:40:48 -0500
Received: from dp.samba.org ([66.70.73.150]:39083 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261269AbUKSHkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 02:40:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16797.41728.984065.479474@samba.org>
Date: Fri, 19 Nov 2004 18:38:40 +1100
To: linux-kernel@vger.kernel.org
Subject: performance of filesystem xattrs with Samba4
In-Reply-To: <1098383538.987.359.camel@new.localdomain>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been developing the posix backend for Samba4 over the last few
months. It has now reached the stage where it is passing most of the
test suites, so its time to start some performance testing.

The biggest change from the kernels point of view is that Samba4 makes
extensive use of filesystem xattrs. Almost every file with have a
user.DosAttrib xattr containing file attributes and additional
timestamp fields. A lot of files will also have a system.NTACL
attribute containing a NT ACL, and many files will have a
user.DosStreams xattr for NT alternate data streams. Some rare files
will have a user.DosEAs xattr for DOS extended attribute
support. Files with streams will also have separate xattrs for each NT
stream.

I started some simple benchmarking today using the BENCH-NBENCH
smbtorture benchmark, with 10 simulated clients and loopback
networking on a dual Xeon server with 2G ram and a 50G scsi partition.
I used a 2.6.10-rc2 kernel. This benchmark only involves a
user.DosAttrib xattr of size 44 on every file (that will be the most
common situation in production use).

ext2                68 MB/sec
ext2+xattr          64 MB/sec

ext3                67 MB/sec
ext3+xattr          58 MB/sec

xfs                 62 MB/sec
xfs+xattr           40 MB/sec
xfs+2Kinode         63 MB/sec
xfs+xattr+2Kinode   58 MB/sec

tmpfs               69 MB/sec
tmpfs+xattr         ?? MB/sec (failed)

jfs                 36 MB/sec
jfs+xattr           29 MB/sec

reiser              58 MB/sec
reiser+xattr        44 MB/sec

To get the ext2/ext3 results I needed to add "return NULL;" at the
start of ext3_xattr_cache_find() to avoid a bug in the xattr sharing
code that causes a oops (I've reported the oops separately).

The tmpfs+xattr failure above is because tmpfs didn't seem to allow
user xattrs, despite having CONFIG_TMPFS_XATTR=y.

I'm very impressed that ext3 has improved so much since I last did
Samba benchmarks. It used to always be the slowest in my tests, but
now it is the fastest journaled filesystem for Samba4. almost matching
tmpfs. 

The XFS results with default options are rather disappointing, as XFS
has usually been a good performer for Samba workloads. Increasing the
inode size to 2k brought it back to a more reasonable level.

The high cost of xattr support is a bit of a problem. In the above,
xattrs were enabled in the filesystems for all runs, the difference
being whether I told Samba4 to use them or not. I hope we can reduce
the cost of xattrs as otherwise Samba4 is going to be seriously
disadvantaged when full windows compatibility is needed. I'm guessing
that nearly all Samba installs will be using xattrs by this time next
year, as we can't do basic security features like WinXP security zones
without them, so making them perform well will be important.

To make it easier to benchmark with xattrs, I'm planning on doing a
new version of dbench with optional xattr support. That will allow
others to play with xattr performance for the above workload without
having to delve into the esoteric world of Samba4 development.

Apart from the 2k inode with XFS I haven't tried any filesystem tuning
options. I'll probably wait till I have xattr support in dbench for
that, to make large numbers of runs with different options easier.

If anyone wants to see in detail what we are sticking in these xattrs,
then look at
  http://samba.org/ftp/unpacked/samba4/source/librpc/idl/xattr.idl 
for an IDL specification of the xattr format we are using.

Soon we'll be starting to integrate the xattr support with a LSM
module, to allow the kernel to interpret the NT ACLs directly to avoid
races, make things a little more efficient (using a xattr cache
holding unpacked ACLs), and allowing for the possibility of non-Samba
file access to obey the NT ACLs.

Cheers, Tridge
