Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbTJCTe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 15:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTJCTe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 15:34:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46032 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262681AbTJCTew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 15:34:52 -0400
Message-ID: <3F7DCEED.9080801@austin.ibm.com>
Date: Fri, 03 Oct 2003 14:33:01 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hannal@us.ibm.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Minutes from 10/1 LSE Call
References: <37940000.1065035945@w-hlinder>	<20031001162916.5fc2241b.akpm@osdl.org>	<3F7C7AA9.2050404@austin.ibm.com> <20031002123618.7947d232.akpm@osdl.org>
In-Reply-To: <20031002123618.7947d232.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Steven Pratt <slpratt@austin.ibm.com> wrote:
>  
>
>> Sure, but why do I only see this is the mm tree, and not the mainline 
>> tree.
>>    
>>
>
>Please send a full description of how to reproduce it and I'll take a look.
>
>  
>
Get the latest rawread from 
http://www-124.ibm.com/developerworks/opensource/linuxperf/rawread/rawread.html

mkfs devices and mount on /mnt/mntN  where N is increasing index.  
Create file 'foo'  in each filesystem of size 1GB (for this example).  
Unmount and remount the partitions/devices to flush the cache.  
Filesystems are also umounted and re-mounted between each test run.

The following rawread commands will run the tests for block sizes 
ranging from 1k-512k.  The "-d 1" parameters assumes that you mounted 
starting at /mnt/mnt1  and the "-m2 -p16" say to run 8 threads on each 
of 2 devices /mnt/mnt1 and /mnt/mnt2.

rawread -m 2 -p 16 -d 6 -n 20480 -f -c -t 0 -s 1024

rawread -m 2 -p 16 -d 6 -n 10240 -f -c -t 0 -s 2048

rawread -m 2 -p 16 -d 6 -n 5120 -f -c -t 0 -s 4096

rawread -m 2 -p 16 -d 6 -n 2560 -f -c -t 0 -s 8192

rawread -m 2 -p 16 -d 1 -n 1280 -f -c -t 0 -s 16384

rawread -m 2 -p 16 -d 1 -n 640 -f -c -t 0 -s 32768

rawread -m 2 -p 16 -d 1 -n 320 -f -c -t 0 -s 65536

rawread -m 2 -p 16 -d 1 -n 160 -f -c -t 0 -s 131072

rawread -m 2 -p 16 -d 1 -n 80 -f -c -t 0 -s 262144

rawread -m 2 -p 16 -d 1 -n 40 -f -c -t 0 -s 524288


2 devices is the smallest number I have been able to run which shows 
this problem.  With only 1 device I did not see it.  My original tests 
were done with 20 devices.  One thing of interest is that with only 2 
devices the point at which CPU starts to increase again is at 128k 
instead of at 32k which I saw with 20 devices.  This would support your 
theory that this is casued by cache misses with more/larger buffers.  
I'm still not sure this accounts for all of the extra CPU usage, but I 
am less worried about it.

But as long as I have your attention, there is one other thing about 
these runs which bothers me, which is that the mm tree is doing horribly 
on 1k and 2k block sizes.  I looks like readahead is not functioning 
properly for these requst sizes.

Here is a comparison for 2 devices between test6 and test6mm1.  You can 
see that the mm1 tree does great at larger block sizes, but poorly at 
small ones.


Results:seqread-_vs_.seqread-

                                          tolerance = 0.00 + 3.00% of A
                test6         test6-mm1
 Blocksize      KBs/sec      KBs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
      1024        44083        22641   -48.64    -21442.00      1322.49  *
      2048        45276        26371   -41.76    -18905.00      1358.28  *
      4096        44024        45260     2.81      1236.00      1320.72
      8192        44519        50073    12.48      5554.00      1335.57  *
     16384        46869        51528     9.94      4659.00      1406.07  *
     32768        47900        52231     9.04      4331.00      1437.00  *
     65536        42803        52183    21.91      9380.00      1284.09  *
    131072        36525        49724    36.14     13199.00      1095.75  *
    262144        34628        46192    33.39     11564.00      1038.84  *
    524288        28997        48005    65.55     19008.00       869.91  *


Results:seqread-_vs_.seqread-
                                          tolerance = 0.50 + 3.00% of A
               test6         test6-mm1
 Blocksize         %CPU         %CPU    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
      1024        27.87        11.72   -57.95       -16.15         1.34  *
      2048        13.77         8.84   -35.80        -4.93         0.91  *
      4096            9         9.99    11.00         0.99         0.77  *
      8192         8.07         8.31     2.97         0.24         0.74
     16384          5.7         6.63    16.32         0.93         0.67  *
     32768         4.93         5.59    13.39         0.66         0.65  *
     65536         3.76          4.7    25.00         0.94         0.61  *
    131072         3.25         4.53    39.38         1.28         0.60  *
    262144         3.23         6.15    90.40         2.92         0.60  *
    524288         2.97         8.19   175.76         5.22         0.59  *

Steve

