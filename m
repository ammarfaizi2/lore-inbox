Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbUJYMAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUJYMAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUJYMAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:00:49 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:21981 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261766AbUJYMA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:00:28 -0400
Date: Mon, 25 Oct 2004 15:00:21 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: Linux 2.6.9 latencies: scheduler bug?
Message-ID: <20041025120021.GA9917@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
References: <20041024212618.GA19377@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024212618.GA19377@m.safari.iki.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 12:26:18AM +0300, Sami Farin wrote:
...
> while that's running, "rtc_latencytest 1024" has max latencies of 253ms.
> $BLOCKLIST has around two thousand lines.
> http://safari.iki.fi/ip_tables_original_maxlat_253ms.png
> from pressing sysrq+p while it was running, I guesstimated one evil spot
> and added cond_resched() in there :)
> http://safari.iki.fi/ip_tables_cond_resched.png
> at 5s I started the script.

forget this stupid ip_tables.c patch, latencies have nothing to do with
netfilter code, but bad interaction between xmms, rtc_latencytest
and iptables.  I now get at max 3.1s (yup, 3100000us) latencies.
http://safari.iki.fi/2.6.9-xmms-fun-1.png
if you want to reproduce this:
1) run "rtc_latencytest 1024" (can't reproduce with "rtc_latencytest 512")
2) press play in xmms
3) start iptables-script

xmms has to be prepared first.
a) put it in repeat mode
b) start playing >= 2 files (like that short testcase.mp3 from lame)
c) remove the files while xmms is playing
d) wait till xmms has played all of the selected files
e) press stop [now then you press play in 2), xmms does silly infinite
   loop without delays while trying to open the songs]

please give me patches to try, 3.1s is really evil 8-)

the iptables-loop is
iptables -N FSCKMEHARDER
cat /service/rbldnsd/dsbl.org/rbldns-list.dsbl.org | while read ip;
  do iptables -A FSCKMEHARDER -p tcp -s $ip -j DROP;
done
alternatively, you can generate random IPs, doesn't probably
make any difference.

I have xorg-x11-6.8.1-12 and Matrox G200, if that matters.

xmms is doing these system calls...
$ awk '{print $3}' xmms-strace.txt |sort|uniq -c|sort -n
      1 close(-1
      1 setup(
      7 nanosleep({0,
     18 gettimeofday({1098704731,
     35 select(5,
     43 gettimeofday({1098704728,
     47 gettimeofday({1098704729,
     47 gettimeofday({1098704730,
     83 <...
    154 close(-1)
    155 ioctl(3,
    155 poll([{fd=3,
    155 readv(3,
    312 open("/var/temp/testcase.mp3",
    385 open("/var/temp/testcase.mp3.wav",
    465 write(3,
    466 select(4,
    930 read(3,

/proc/vmstat before and after running rtc_latencytest.

before
nr_dirty 0
nr_writeback 0
nr_unstable 0
nr_page_table_pages 919
nr_mapped 46485
nr_slab 4320
pgpgin 1235396
pgpgout 532242
pswpin 9795
pswpout 32253
pgalloc_high 0
pgalloc_normal 30934240
pgalloc_dma 18350
pgfree 30955504
pgactivate 187837
pgdeactivate 157183
pgfault 19090447
pgmajfault 7616
pgrefill_high 0
pgrefill_normal 3472213
pgrefill_dma 76329
pgsteal_high 0
pgsteal_normal 341889
pgsteal_dma 4460
pgscan_kswapd_high 0
pgscan_kswapd_normal 423918
pgscan_kswapd_dma 5894
pgscan_direct_high 0
pgscan_direct_normal 14982
pgscan_direct_dma 0
pginodesteal 0
slabs_scanned 397568
kswapd_steal 343850
kswapd_inodesteal 35158
pageoutrun 11989
allocstall 49
pgrotated 29549

after
nr_dirty 0
nr_writeback 0
nr_unstable 0
nr_page_table_pages 919
nr_mapped 46496
nr_slab 4334
pgpgin 1235396
pgpgout 532286
pswpin 9795
pswpout 32253
pgalloc_high 0
pgalloc_normal 31500853
pgalloc_dma 18771
pgfree 31522633
pgactivate 188101
pgdeactivate 157185
pgfault 19627511
pgmajfault 7616
pgrefill_high 0
pgrefill_normal 3474226
pgrefill_dma 76395
pgsteal_high 0
pgsteal_normal 342045
pgsteal_dma 4460
pgscan_kswapd_high 0
pgscan_kswapd_normal 424347
pgscan_kswapd_dma 5894
pgscan_direct_high 0
pgscan_direct_normal 14982
pgscan_direct_dma 0
pginodesteal 0
slabs_scanned 397696
kswapd_steal 344006
kswapd_inodesteal 35158
pageoutrun 11994
allocstall 49
pgrotated 29549

vmstat 1 wasn't very special.
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 4  1 119480  10384  11444  45444    0    0     0     4 2100  1837 49 51  0  0
 3  1 119480  10264  11444  45444    0    0     0     0 2095  2238 41 59  0  0
 3  1 119480   9424  11444  45444    0    0     0     0 2088  1923 37 63  0  0
 3  1 119480  10804  11444  45444    0    0     0     0 2087   998 40 60  0  0

-- 
