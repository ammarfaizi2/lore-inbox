Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVKRQ3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVKRQ3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVKRQ3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:29:51 -0500
Received: from kirby.webscope.com ([204.141.84.57]:18109 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932358AbVKRQ3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:29:50 -0500
Message-ID: <437E0166.3000208@m1k.net>
Date: Fri, 18 Nov 2005 11:29:26 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-rc1-mm2
References: <20051117234645.4128c664.akpm@osdl.org>
In-Reply-To: <20051117234645.4128c664.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm2/
>
>
>- I'm releasing this so that Hugh's MM rework can get a spin.
>
>  Anyone who had post-2.6.14 problems related to the VM_RESERVED changes
>  (device drivers malfunctioning, obscure userspace hardware-poking
>  applications stopped working, etc) please test.
>
I gave it a quick test before leaving the house this morning... Here is 
an exerp from an oops I got after closing mplayer, watching an ATSC (dvb 
in USA) stream, using AverTVHD a180 (saa7134 + nxt200x).

[snip]

Bad page state at free_hot_cold_page (in process 'mplayer', page c15c03e0)
flags:0x80000414 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<c0103b53>] dump_stack+0x16/0x1a
 [<c0134db9>] bad_page+0x5f/0xe9
 [<c0135519>] free_hot_cold_page+0x58/0xf7
 [<c01355c2>] free_hot_page+0xa/0xc
 [<c0138367>] __page_cache_release+0xab/0xb0
 [<c0137fe0>] put_page+0x5c/0x5e
 [<c01428d7>] free_page_and_swap_cache+0x2c/0x32
 [<c013bd02>] zap_pte_range+0x1b1/0x249
 [<c013be5f>] unmap_page_range+0xc5/0xd6
 [<c013bf10>] unmap_vmas+0xa0/0x171
 [<c013f73c>] unmap_region+0x76/0xf2
 [<c013f9c8>] do_munmap+0xdd/0x100
 [<c013fa25>] sys_munmap+0x3a/0x56
 [<c0102d05>] syscall_call+0x7/0xb
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<c013bf92>] .... unmap_vmas+0x122/0x171
.....[<c013f73c>] ..   ( <= unmap_region+0x76/0xf2)
.. [<c013bb89>] .... zap_pte_range+0x38/0x249
.....[<c013be5f>] ..   ( <= unmap_page_range+0xc5/0xd6)

Hexdump:
000: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
010: 00 00 00 00 00 00 00 00 b8 03 5c c1 b8 03 5c c1
020: 04 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
030: 00 00 00 00 00 00 00 00 d8 03 5c c1 d8 03 5c c1
040: 14 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
050: 00 00 00 00 00 00 00 00 f8 03 5c c1 f8 03 5c c1
060: 00 04 00 80 00 00 00 00 ff ff ff ff 00 00 00 00
070: 00 00 00 00 00 00 00 00 00 01 10 00 00 02 20 00
080: 00 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
090: 00 00 00 00 00 00 00 00 38 04 5c c1 38 04 5c c1
0a0: 00 04 00 80 ff ff ff ff ff ff ff ff 00 00 00 00
0b0: 00 00 00 00 00 00 00 00 58 04 5c c1 58 04 5c c1
Trying to fix it up, but a reboot is needed

[snip]

More detailed log at:
http://techsounds.org/v4l/2.6.15-rc1-mm2-error.log

The oops spammed the entire log, so if you need to see what I have 
running on my system, here is a working dmesg (only v4l+dvb parts) from 
2.6.14 + hybrid (v4l+dvb) merged cvs, almost equivalent code to what we 
have in the current kernel:
http://techsounds.orgdotorg.org/v4l/dmesg.txt

I understand that you might need some more info.... Email me if you need 
something else... I'll be around for the next 5 hours.... After that, I 
will be away for the weekend, and I can do more tests on Monday 
evening.  This was on an intel p4, 2.53 GHz, 533 FSB, 768 MB ram, using 
Intel D845PEBT2 motherboard.

-Michael Krufky


-- 
Michael Krufky


