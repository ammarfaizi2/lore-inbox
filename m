Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSJWMHj>; Wed, 23 Oct 2002 08:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSJWMHj>; Wed, 23 Oct 2002 08:07:39 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:11727 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264877AbSJWMHh>;
	Wed, 23 Oct 2002 08:07:37 -0400
Date: Wed, 23 Oct 2002 14:13:47 +0200
From: bert hubert <ahu@ds9a.nl>
To: riel@conectiva.com.br, akpm@digeo.com, linux-kernel@vger.kernel.org
Cc: albert@users.sf.net
Subject: 2.5.44 io accounting weirdness, bi & bo swapped?
Message-ID: <20021023121347.GA31763@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, riel@conectiva.com.br,
	akpm@digeo.com, linux-kernel@vger.kernel.org, albert@users.sf.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears as if the kernel does its accounting wrong in some places. For
example, with procps 3.0.4, dd if=/dev/zero of=/mnt/100mb bs=1024
count=100000 causes large 'bi' readings:

$ vmstat 1
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  0  0  14340   7356   2372 146784    4    2   332   290 1102   223  2 24 74
 0  0  0  14340   7344   2372 146784    0    0     0     0 1013    87  1  0 99
 0  0  0  14340   7332   2372 146784    0    0     0     0 1011   233  1  1 98
 2  0  1  14320   3932   2292 150428    0    0  5504   144 2104   333  3 65 32
 2  0  1  14320   4448   1772 150436    0    0  7208     0 1999    89  2 98  0
 3  0  3  14320   2812   1740 152060    0    0  8664    20 2541   372  4 87  9

However, mmapping a file and touching 100mb of pages does the following,
which looks sane:

$ vmstat 1
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  0  0  14320   9956   1940 144660    0    0     0     0 1017   155  1  0 99
 1  0  1  14320   7972   1952 146560    0    0     0  1912 1279   277  2 53 45
 0  1  0  14320   4048   1744 150708    0    0   360  6024 1858   412  1 99  0
 1  0  1  14320   4096   1612 151020    0    0     0  5252 1741   338  2 98  0
 1  0  1  14320   3396   1612 151864    0    0     0  7144 2057   896  2 97  1
 1  0  1  14320   3696   1612 151644    0    0     0  7192 2087   982  1 99  0
 1  0  1  14320   3240   1548 152220    0    0     4  6940 2062   984  2 98  0
 0  0  0  14320   2472   1544 153072    0    0     0  7008 2059  1010  2 98  0
 0  0  0  14320   2464   1544 153072    0    0     0     0 1005    57  1  1 98

Interestingly, running sync then causes this, which does not look sane:

 0  0  0  14316   3792   1680 151688    0    0     0     0 1014   146  1  2 97
 3  0  3  14316   3572   1692 151696    0    0 10456    12 3510   260  2 65 33
 1  0  2  14316   3456   1700 151696    0    0 12516     0 2136   164  4 96  0
 2  0  2  14316   3452   1700 151696    0    0  6412     0 2983    66  3 97  0
 6  0  4  14316   3120   1700 151696    0    0 26152     0 6880    71  1 99  0
 1  0  1  14316   3488   1708 151704    0    0 14664    12 3859    94  2 98  0
11  0  5  14316   3112   1708 151704    0    0 29892     0 7747    28  1 99  0
 1  0  0  14316   3732   1728 151704    0    0    72     0 1049   176  1  4 95
 1  0  0  14316   3720   1728 151704    0    0     0     0 1068   172  1  0 99

This shown with 'vmloader':
vmloader> mmap /mnt/blah
mmap()ing 375000 pages (1500 mbytes). Done
vmloader> touch 100
Touching from mbyte 0 to 100, 25000 pages. Done
vmloader> quit
$ sync

http://ds9a.nl/vmloader-0.1.tar.gz

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
