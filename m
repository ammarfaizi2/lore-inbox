Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312483AbSC0NzM>; Wed, 27 Mar 2002 08:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313014AbSC0NzA>; Wed, 27 Mar 2002 08:55:00 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:9225 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S312483AbSC0Nyt>; Wed, 27 Mar 2002 08:54:49 -0500
Date: Wed, 27 Mar 2002 13:54:48 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: <linux-kernel@vger.kernel.org>
Subject: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
Message-ID: <Pine.LNX.4.33.0203271323330.24894-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A while ago, I did some longish runs of OSDB (osdb.sf.net)
against PostgreSQL 7.2.  All runs were on kernel 2.5.6 + the
dc395x driver and the futexes patch.  I'd have included
reiserfs too, but in 2.5.6 it seemed to oops on mount.  2.5.7
doesn't boot for me, but I'll run these again when a more
interesting kernel appears.

Hardware is: 2 x P3-450, 384Mb, 3 x 9Gb Quantum disks on
internal aic7xxx (new driver).  Except for a "vmstat 1", the
system was otherwise unused during the tests.  There was no
other mounted filesystem on the disk with the test partition.
The numbers seem pretty consistent -- if they're more than 5%
different, that's probably a valid comparision (no, I'm not a
statistician and can't justify that).

The scripts I used are available on request, but they do
roughly:

	stop postgres
	umount
	mkfs
	mount
	create postgres data directories
	start postgres (incl. creating postgres database)
	"osdb-pg --datadir /scratch/data-40mb/ --short"


"Tuning" key:
"dd"	-- default PG, default FS opts
"dn"	-- default PG, "noatime"
"bn"	-- big PG buffers, "noatime"

		PostgreSQL
	tuning?	single	ir	mx-ir	oltp	mixed-oltp
		(sec)	(tps)	(sec)	(tps)	(sec)
ext2	dd	1304.72	66.64	214.25	188.50	230.55
	dn	1288.31	65.93	209.57	234.08	213.75
	bn	1283.50	77.90	1867.71	192.43	226.77

ext3	dd	1303.84	66.87	212.49	66.06	361.04
	dn	1288.03	64.62	209.27	111.41	278.54
	bn	1285.32	65.98	1996.41	90.05	307.79

ext3-wb	dn	1291.68	66.06	209.94	138.25	242.28
	bn	1287.31	98.42	2149.38	125.13	236.02

jfs	dd	1308.97	66.82	212.59	117.28	273.08
	dn	1288.60	65.08	211.56	116.18	218.22
	bn	1279.89	81.00	2059.26	114.20	225.56

minix	dd	1305.26	67.38	207.74	193.90	228.81
	dn	1331.27	67.14	210.07	223.70	214.33
	bn	1299.24	89.58	1988.31	231.17	231.17


My conclusions:

1. I'll have to spend more time learning to tune postgres,
   but clearly something went wrong there -- the
   "agg_simple_report" test accounted for almost all of the
   differences.

2. "noatime" is very useful switch for these circumstances.

3. The journalled filesystems do have measurable overhead
   for this workload.

Questions:

1. Is there anything else I should try in the way of fs
   options, etc?

2. What does jfs do in the way of data journalling?  Is it
   "ordered" or "writeback", in ext3-speak?  (I assume
   fully journalled data would give much worse performance.)


Cheers,
Matthew.

