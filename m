Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSJJBEK>; Wed, 9 Oct 2002 21:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSJJBEK>; Wed, 9 Oct 2002 21:04:10 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:61602 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262806AbSJJBEG>;
	Wed, 9 Oct 2002 21:04:06 -0400
Message-ID: <3DA4D34F.3070106@us.ibm.com>
Date: Wed, 09 Oct 2002 18:09:35 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Degraded I/O performance, since 2.5.41
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I run a certain large webserver benchmark, I prefer to warm the 
pagecache up with the file set first, to cheat a little :)  I grep 
through 20 different 500MB file sets in parallel to do this.  It is a 
_lot_ slower in the BK snapshot than in plain 2.5.41.

And, no, these numbers aren't inflated, I have a lot of fast disks. I 
  _can_ do 50MB/sec :)

A little snipped from vmstat (I cut out the boring columns):
good kernel: 2.5.41: vmstat 4
Cached        bi    bo   bi    cs  us s id
389280     53284     7 1625  3235 12 88  0
600580     53489    19 1599  3264 11 89  0
813428     53891     0 1587  3256 12 88  0
1027260    54093     0 1609  3239 12 88  0
1241448    54183     0 1611  3251 11 89  0
1454036    53790     0 1618  3267 12 88  0
doing the entire 10GB grep takes 192 seconds.
a dd produces: ~48000 bi/sec

exact same grep operation on kernel: 2.5.41+yesterday's bk: vmstat 4
Cached       bi    bo   bi    cs us sy id
4855948    9697     1 1408   846 20 80  0
4890464    8745     0 1398   800 18 82  0
4922392    8077    55 1364   676 21 79  0
4959164    9296     1 1399   798 18 82  0
4995936    9315     0 1407   830 19 81  0
5027208    7931     0 1351   638 22 78  0
5066256    9855     9 1416   856 19 81  0
I was too impatient to wait on the greps to complete.
a dd produces: ~37800 bi/sec

So, bi/sec goes from 54,000 in 2.5.41, to ~8700 in yesterday's 
snapshot.  It goes from around 50MB/sec to about 8MB/sec.

Although vmstat shows 0% idle time, the profilers show lots of idle 
time, 98%!  I tried oprofile and readprofile.  Is the 2.0.9 vmstat 
still broken?  I'm using idle=poll if that makes any difference.

-- 
Dave Hansen
haveblue@us.ibm.com

