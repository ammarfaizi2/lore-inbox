Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRHAHkx>; Wed, 1 Aug 2001 03:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263416AbRHAHkn>; Wed, 1 Aug 2001 03:40:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52233 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262355AbRHAHkj>; Wed, 1 Aug 2001 03:40:39 -0400
Date: Wed, 1 Aug 2001 03:10:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Tridgell <tridge@valinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8preX VM problems
In-Reply-To: <20010801060942.ABC16440B@lists.samba.org>
Message-ID: <Pine.LNX.4.21.0108010232100.8866-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tue, 31 Jul 2001, Andrew Tridgell wrote:

> Marcelo,
> 
> I've narrowed it down some more. If I apply the whole zone patch
> except for this bit:
> 
> +		/* 
> +		 * If we are doing zone-specific laundering, 
> +		 * avoid touching pages from zones which do 
> +		 * not have a free shortage.
> +		 */
> +		if (zone && !zone_free_shortage(page->zone)) {
> +			list_del(page_lru);
> +			list_add(page_lru, &inactive_dirty_list);
> +			continue;
> +		}
> +
> 
> then the behaviour is much better:
> 
> [root@fraud trd]# ~/readfiles /dev/ddisk 
> 202 MB    202.125 MB/sec
> 394 MB    192.525 MB/sec
> 580 MB    185.487 MB/sec
> 755 MB    175.319 MB/sec
> 804 MB    41.3387 MB/sec
> 986 MB    182.5 MB/sec
> 1115 MB    114.862 MB/sec
> 1297 MB    182.276 MB/sec
> 1426 MB    128.983 MB/sec
> 1603 MB    164.939 MB/sec
> 1686 MB    82.9556 MB/sec
> 1866 MB    179.861 MB/sec
> 1930 MB    63.959 MB/sec
> 
> Even given that, the performance isn't exactly stunning. The
> "dummy_disk" driver doesn't even do a memset or memcpy so it should
> really run at the full memory bandwidth of the machine. We are only
> getting a fraction of that (it is a dual PIII/800 server). If I get
> time I'll try some profiling.
> 
> I also notice that the system peaks at a maximum of just under 750M in
> the buffer cache. The system has 1.2G of completely unused memory
> which I really expected to be consumed by something that is just
> reading from a never-ending block device.

Thats expected: we cannot allocate buffercache pages on highmem.

> For example:
> 
> CPU0 states:  0.0% user, 67.1% system,  0.0% nice, 32.3% idle
> CPU1 states:  0.0% user, 65.3% system,  0.0% nice, 34.1% idle
> Mem:  2059660K av,  842712K used, 1216948K free,       0K shrd,  740816K buff
> Swap: 1052216K av,       0K used, 1052216K free                    9496K cached
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE LC STAT %CPU %MEM   TIME COMMAND
>   615 root      14   0   452  452   328  1 R    99.9  0.0   3:52 readfiles
>     5 root       9   0     0    0     0  1 SW   31.3  0.0   1:03 kswapd
>     6 root       9   0     0    0     0  0 SW    0.5  0.0   0:04 kreclaimd
> 
> I know this is a *long* way from a real world benchmark, but I think
> it is perhaps indicative of our buffer cache system getting a bit too
> complex again :)

do_page_launder() stops the laundering loop (which frees pages), in case
it freed a buffercache page, as soon as there is no more global free
shortage (in the global scan case), or as soon as there is no more free
shortage for the specific zone we're scanning.

Thats wrong: we should keep laundering pages if there is _any_ zone under
shortage. 

Could you please try the patch below ? (against 2.4.8pre3)

--- linux.orig/mm/vmscan.c	Wed Aug  1 04:26:36 2001
+++ linux/mm/vmscan.c	Wed Aug  1 04:33:22 2001
@@ -593,13 +593,9 @@
 			 * If we're freeing buffer cache pages, stop when
 			 * we've got enough free memory.
 			 */
-			if (freed_page) {
-				if (zone) {
-					if (!zone_free_shortage(zone))
-						break;
-				} else if (!free_shortage()) 
-					break;
-			}
+			if (freed_page && !total_free_shortage())
+				break;
+
 			continue;
 		} else if (page->mapping && !PageDirty(page)) {
 			/*

