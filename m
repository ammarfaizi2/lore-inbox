Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUDDMRv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 08:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUDDMRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 08:17:51 -0400
Received: from linuxhacker.ru ([217.76.32.60]:22703 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S262337AbUDDMRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 08:17:48 -0400
Date: Sun, 4 Apr 2004 15:17:56 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.4] NMI WD detected lockup during page alloc
Message-ID: <20040404121756.GA8854@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   One of my servers started to experience mystic hangs after upgrade to
   dual P4 Xeon (before that it was running on UP kernel) (HT enabled now).
   So I enabled NMI watchdog and finally it triggered recently.
   The kernel is 2.4.25+ (pulled from 2.4 bitkeeper tree on XX/XX, but
   it seems related files in mm/ have not changed since at least January 2004
   anyway). 
   So the HW is Duap P4-Xeon on some Intel-branded server (E7501-based or
   something), 2G Eóó RAM (highmem enabled).

   That's what I got on the serial console:
NMI Watchdog detected LOCKUP on CPU2, eip c013b527, registers:
CPU:    2
EIP:    0010:[<c013b527>]    Not tainted
EFLAGS: 00000086
eax: 00000000   ebx: c02dca38   ecx: 000048ce   edx: c02dca38
esi: c02dca74   edi: 00000000   ebp: d34b1e5c   esp: d34b1e30
ds: 0018   es: 0018   ss: 0018
Process mrtg (pid: 14663, stackpage=d34b1000)
Stack: 00038000 00000282 00000000 00015006 00015006 00000286 00000000 c02dca38
       c02dca38 c02dcb38 00000002 d34b1ea0 c013adfa c0139395 d34b1ea0 00000202
       c02dcaec 32353530 d34b1e7c c02dca38 c02dca38 c02dcb34 00000000 000001d2
Call Trace:    [<c013adfa>] [<c0139395>] [<c012dc0d>] [<c012e6d7>] [<c0119330>
]
  [<c014bca5>] [<c0159301>] [<c014ee56>] [<c014bd1b>] [<c0153b3b>] [<c0118f70>
]
  [<c01076b0>]
Code: f3 90 7e f9 e9 11 f4 ff ff 80 3f 00 f3 90 7e f9 e9 8e fd ff
>>EIP; c013b527 <.text.lock.page_alloc+f/28>   <=====
Trace; c013adfa <__alloc_pages+6a/270>
Trace; c0139395 <lru_cache_del+15/20>
Trace; c012dc0d <do_wp_page+6d/2e0>
Trace; c012e6d7 <handle_mm_fault+f7/110>
Trace; c0119330 <do_page_fault+3c0/586>
Trace; c014bca5 <cp_new_stat64+e5/110>
Trace; c0159301 <dput+31/190>
Trace; c014ee56 <path_release+16/40>
Trace; c014bd1b <sys_stat64+4b/80>
Trace; c0153b3b <sys_fcntl64+5b/c0>
Trace; c0118f70 <do_page_fault+0/586>
Trace; c01076b0 <error_code+34/3c>


So it seems it was blocked trying to take zone->lock in
mm/page_alloc.c::rmqueue()
The actual calltrace seems to be (lots of stale entries seems to be on
actual stack).

rmqueue
__alloc_pages+6a
do_wp_page+6d
handle_mm_fault+f7 (this is in fact handle_pte_fault())
do_page_fault+3c0
error_code+34

I fail to see a path where we can take lock on the same zone twice on same
CPU, so may be the zone structure was somehow corrupted (I do not have
spinlock debugging enabled yet). I do not think there are problems with
memory in that box that might explain this as well.
Probability of hangs vary over time, I got the first one on the next day after
upgrade (not even sure if it was the same as this one since I had no traces
from it), but this second one happened after 2-3 weeks of uptime.

May be it will help someone to find out what happens.

Bye,
    Oleg
