Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbSIPWeR>; Mon, 16 Sep 2002 18:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbSIPWeR>; Mon, 16 Sep 2002 18:34:17 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:4736 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S263225AbSIPWeP>;
	Mon, 16 Sep 2002 18:34:15 -0400
Date: Mon, 16 Sep 2002 15:39:11 -0700
From: Simon Kirby <sim@netnation.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 throughput woes on certain (possibly heavily fragmented) files
Message-ID: <20020916223911.GA1658@netnation.com>
References: <20020903092419.GA5643@vitelus.com> <20020906170614.A7946@redhat.com> <15736.57972.202889.872554@laputa.namesys.com> <20020906182457.F3029@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020906182457.F3029@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 06:24:57PM +0100, Stephen C. Tweedie wrote:

> Ext2 has a preallocation mechanism so that if you have multiple
> writes, they get dealt with to some extent as a single allocation.
> However, that doesn't work over close(): the preallocated blocks are
> discarded wheneven we close the file.
> 
> The problem with mail files, though, is that they tend to grow quite
> slowly, so the writes span very many transactions and we don't have
> that opportunity for coalescing the writes.  Actively defragmenting on
> writes is an alternative in that case.

We recently switched a large mail spool from ext2 to ext3 with default
journalling, and we are now having huge problems with disk I/O load.

We have fsync and friends disabled for performance reasons.  With ext2,
the machine would happily hum along with an average load of 0.2 and a
usual 400 kB - 800 kB write every 5 seconds, with about 10 kB/sec read in
every second.

Now with ext3, the machine has a load average of about 15 and writing
happens almost all of the time.  "vmstat 1" output:

   procs                    memory   swap       io     system       cpu
 r  b  w  swpd  free   buff  cache  si so  bi   bo   in    cs  us sy id
 0 42  2 79368 47196 100456 1080348  0  0   0 3036 2514  2077  18 21 60
 0 76  2 79368 44264 100456 1080348  0  0   0 1776 1266   823   4  3 92
 0 111 3 79368 41248 100456 1080348  0  0   0 1952 1176   722   4  5 91
 0 132 2 79368 39432 100460 1080348  0  0   0 1368 1007   612   1  3 96
 0 67  3 79368 34412 100460 1080628  0  0   0 2884 1968  1246  18 13 69
 0 41  2 79368 36572 100468 1080828  0  0  24 4020 2661  1530  16 21 64
 0 32  3 79368 31736 100500 1081456  0  0   0 3688 2696  2061  26 22 52
 0 39  3 79368 24588 100528 1082164  0  0   4 3800 2636  2643  30 21 50
 0 32  4 79368 21500 100536 1082832  0  0  24 3216 2404  2419  32 15 54
 5 28  2 79368 18160 100536 1083360  0  0   0 3416 2372  2164  24 19 57
 0 25  4 79368 19748 100552 1082896  0  0   4 4120 2544  2421  17 21 62
 4 16  4 79368 18216 100560 1083284  0  0   0 3532 2115  2361  20 17 63
 0 37  2 79368 17240 100568 1083456  0  0  16 2376 1817  1691   8 12 80
 1 67  3 79368 15112 100568 1083456  4  0   4 1644 1051   723   6  4 90
 1 88  3 79368 12028 100572 1083464  0  0   8 1884 1102   684   6  3 91
 0 108 3 79368 10132 100572 1083468  0  0   0 1716  924   503   3  3 94
15  0  2 79368 14460 100548 1081996  0  0  12 3852 2609  2000  17 25 59
 0 39  3 79368 13252 100576 1082220  0  0  52 4288 2740  2095  19 19 62

This box is primarily running a POP3 server (written in-house to cache
mbox offsets, so that it can handle a huge volume of mail), and also
exports the mail spool via NFS to other servers which run exim (-fsync). 
nfsd is exported async.  Everything is mounted noatime, nodiratime.  No
applications should be calling sync/fsync/fdatasync or using O_SYNC. 
It's a mail server, so everything is fragmented.

We're using dotlocking.  Would this cause metadata journalling?  We had
to hash the mail spool a long time ago do to system time eating all CPU
(the ext2 linear directory scan to find a slot available in the spool
directory to add the dotlock file).  I estimate about 200 - 300 dotlock
files are created per second, but these should all be asynchronous. 
Would switching to fctnl() locking (if this works over NFS) solve the
problem?

A "ps -eo pid,stat,args,wchan | grep simpopd | grep ' D '" shows POP3
processes stuck in either "down" or in "do_get_write_access", which
appears to be a journal function.

We notice there are some ext3 updates included as a patch to vanilla
2.4.18 in the newest Red Hat kernel, including changes to the
do_get_write_access function.  Have improvements in this area been made?

Thanks!

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
