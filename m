Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbULBUQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbULBUQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbULBUQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:16:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:1678 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261746AbULBUPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:15:24 -0500
Date: Thu, 2 Dec 2004 12:19:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-Id: <20041202121938.12a9e5e0.akpm@osdl.org>
In-Reply-To: <20041202195232.GA26695@suse.de>
References: <20041202130457.GC10458@suse.de>
	<20041202134801.GE10458@suse.de>
	<20041202114836.6b2e8d3f.akpm@osdl.org>
	<20041202195232.GA26695@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> n Thu, Dec 02 2004, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > as:
> > > Reader: 27985KiB/sec (max_lat=34msec)
> > > Writer:    64KiB/sec (max_lat=1042msec)
> > > 
> > > cfq:
> > > Reader: 12703KiB/sec (max_lat=108msec)
> > > Writer:  9743KiB/sec (max_lat=89msec)
> > > 
> > > If you look at vmstat while running these tests, cfq and deadline give
> > > equal bandwidth for the reader and writer all the time, while as
> > > basically doesn't give anything to the writer (a single block per second
> > > only). Nick, is the write batching broken or something?
> > 
> > Looks like it.  We used to do 2/3rds-read, 1/3rd-write in that testcase.
> 
> But 'as' has had no real changes in about 9 months time, it's really
> strange. Twiddling with write expire and write batch expire settings
> make no real difference. Upping the ante to 4 clients, two readers and
> two writers work about the same: 27MiB/sec aggregate read bandwidth,
> ~100KiB/sec write.

Did a quick test here, things seem OK.

Writer:

	while true
	do
	dd if=/dev/zero of=foo bs=1M count=1000 conv=notrunc
	done

Reader:

	time cat 1-gig-file > /dev/null
	cat x > /dev/null  0.07s user 1.55s system 3% cpu 45.434 total

`vmstat 1' says:


 0  5   1168   3248    472 220972    0    0    28 24896 1249   212  0  7  0 94
 0  7   1168   3248    492 220952    0    0    28 28056 1284   204  0  5  0 96
 0  8   1168   3248    500 221012    0    0    28 30632 1255   194  0  5  0 95
 0  7   1168   2800    508 221344    0    0    16 20432 1183   170  0  3  0 97
 0  8   1168   3024    484 221164    0    0 15008 12488 1246   460  0  4  0 96
 1  8   1168   2252    484 221980    0    0 27808  6092 1270   624  0  4  0 96
 0  8   1168   3248    468 221044    0    0 32420  4596 1290   690  0  4  0 96
 0  9   1164   2084    456 222212    4    0 28964  1800 1285   596  0  3  0 96
 1  7   1164   3032    392 221256    0    0 23456  6820 1270   527  0  4  0 96
 0  9   1164   3200    388 221124    0    0 27040  7868 1269   588  0  3  0 97
 0  9   1164   2540    384 221808    0    0 21536  4024 1247   540  0  4  0 96
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1 10   1164   2052    392 222276    0    0 33572  5268 1298   745  0  4  0 96
 0  9   1164   3032    400 221316    0    0 28704  5448 1282   611  0  4  0 97
 1  9   1164   2076    388 222144    0    0  9992 17176 1229   325  0  2  0 98
 1  8   1164   3060    376 221136    0    0  9100 13168 1221   284  0  2  0 98
 0  8   1164   2628    384 221536    0    0 28964  3348 1280   635  0  4  0 97
 0  8   1164   2920    344 221372    0    0 27052  5744 1275   657  0  6  0 95
 1  8   1164   3072    328 221252    0    0 26664  5256 1270   653  0  5  0 95
 0  9   1160   2176    356 222100   12    0 26928  6320 1276   605  0  5  0 95
 0  9   1160   2268    332 221920    0    0 17300  9580 1242   428  0  3  0 98
 0  8   1160   3256    332 221036    0    0 23588  9280 1345   586  0  4  0 96
 0  8   1160   3220    320 221116    0    0 16916  9476 1251   425  0  3  0 97
 0 10   1160   3000    320 221388    0    0 21416  8168 1260   565  0  5  0 95
 0 11   1160   2020    324 222268    0    0 23580 10144 1269   528  0  3  0 97
 0 11   1160   2076    340 222252    0    0 20900  3896 1244   486  1  3  0 97
 0 10   1160   2656    356 221692    0    0 23968  8108 1272   564  0  5  0 95
 0 10   1160   3464    348 220892    0    0 26140 10272 1513   618  0  2  0 98
 0 10   1160   3124    320 221260    0    0 15512 11368 1227   442  0  3  0 97
 0 10   1156   3072    336 221148   32    0 22212  6776 1280   539  0  4  0 97
 0 11   1156   2544    352 221608    0    0 25004  7224 1262   596  0  4  0 95
 0 12   1156   2132    364 222140    0    0 20636  9500 1246   510  0  3  0 97
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1 12   1156   2132    372 222064    0    0 25880  6104 1291   550  0  3  0 97
 0 11   1156   3260    368 220980    0    0 19868 12860 1277   496  0  3  0 97
 0 12   1156   2328    360 221872    0    0 20764  7712 1256   513  0  4  0 97
 0 10   1156   3072    356 221128    0    0 17056  7800 1239   474  0  4  0 96
 0 11   1156   2180    336 221964    0    0 20252 10464 1252   520  0  4  0 96
 0 11   1156   2076    360 222144    0    0 22512  7448 1250   554  1  4  0 96
 0 10   1156   2620    364 221692    0    0 23372  4236 1256   543  0  4  0 96
 0 11   1156   2136    344 222120    0    0 22172  8060 1260   528  0  3  0 97
 0 10   1156   3340    316 221060    0    0 17688 12036 1242   474  0  3  0 97
 0 10   1156   2580    296 221760    0    0 18460  5608 1243   501  0  3  0 97
 0 10   1156   2960    308 221408    0    0 17176 10544 1233   462  0  3  0 97
 0 11   1156   2132    308 222224    0    0 32376  2048 1291   715  0  4  0 96
 0 10   1156   3280    300 221008    0    0 23628 10768 1278   556  0  4  0 96
 0 11   1156   2132    320 222144    0    0 18076 10888 1365   481  0  3  0 97
 0 11   1156   2504    312 221880    0    0 23448 10068 1256   526  0  3  0 97
 0 10   1156   2532    324 221664    0    0 18084  6012 1259   476  0  5  0 96
 0 10   1156   2580    332 221792    0    0 26400  6776 1279   626  0  4  0 96
 0 10   1156   3312    324 221052    0    0 22044  6036 1247   508  0  4  0 96
 0 10   1152   2144    328 222204    4    0 11996 15068 1235   394  0  4  0 97
 0  5   1152   3128    344 221236    0    0    20 24068 1200   172  0  3  2 95


So what are you doing different?

