Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318210AbSGWUUM>; Tue, 23 Jul 2002 16:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSGWUUM>; Tue, 23 Jul 2002 16:20:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:43452 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318210AbSGWUUL>;
	Tue, 23 Jul 2002 16:20:11 -0400
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Johannes Erdfelt <johannes@erdfelt.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <20020723194826.GH1117@dualathlon.random>
References: <20020719170359.E28941@sventech.com>
	<Pine.LNX.4.33.0207191722260.6698-100000@coffee.psychology.mcmaster.ca>
	<20020719174521.F28941@sventech.com> 
	<20020723194826.GH1117@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Jul 2002 13:22:35 -0700
Message-Id: <1027455756.11109.7.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running sequential write performance tests on 2.4.19rc3ac3 I see a
similar problem.  What happens is the page cache gets really big, then
the machine starts swapping and becomes unusable.

It seems like there needs to be some upper bound on the page cache or
flow control on file writes to not allow the cpu to get ahead of the
disk. 

This is vmstat output when running iozone, and it does first  .5 G file
then a 1G file. The machine has lots of memory but when it fills, it
goes off the deep end...

  procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  1      0 234456  12128 542360   0   0     0 32475 1044    29   0  11  89
 1  0  1      0 233744  12160 542360   0   0     0 62712 1065    79   0  18  82
 0  1  0      0 303008  12160 542360   0   0     0 21751 1042    21   0   3  97
 1  0  1      0 510140  12384 201112   0   0     0 11070 1042    18   0  14  86
 0  1  0      0 302280  12660 542360   0   0     0 77826 1034    54   0  18  82
 0  1  0      0 302280  12660 542360   0   0     0     0 1040     8   0   1  99
 1  0  1      0 176144  12660 542360   0   0     0 39073 1043    23   0  12  88
 0  1  0      0 302272  12660 542360   0   0     0 81925 1050    60   0  20  80
 0  1  0      0 302268  12660 542360   0   0     0     0 1044     6   0   0 100
 1  0  1      0 480496  12852 176408   0   0     0 10661 1043    18   0  14  86
 0  1  0      0 301456  13156 542360   0   0     0 81511 1035    37   0  19  81
 0  1  0      0 301452  13156 542360   0   0     0     0 1040     7   0   0 100
 1  0  1      0 181724  13156 542360   0   0     0 30479 1047    18   0  10  90
 0  1  0      0 301408  11864 543684   0   0     1 87331 1077    61   0  23  77
 0  1  0      0 301400  11872 543684   0   0     0     2 1043     8   0   0 100
 0  0  1      0 529624  11880 313604   0   0     0 26639 1043  1843   0   9  91
 0  0  2      0 137892  11880 700356   0   0     0 92110 1036  2424   0  10  90
 0  0  1      0  54688  11888 780868   0   0     0 29978 1038   515   0   2  98
 0  1  1   7900   7024    976 848600 747 1926  1277 22411 1242   730   0   8  92
 0  1  1   7900   7036    596 849352 1412 305  2351   738 1421   447   0   4  96
 0  2  1   7900   7040    596 849488 1453 162  3077   174 1799   821   0  14  86
 0  2  1   7900   7032    596 849772 888 150  1634   168 4111  1165   0  39  61

