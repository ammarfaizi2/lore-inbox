Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTAICMr>; Wed, 8 Jan 2003 21:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTAICMr>; Wed, 8 Jan 2003 21:12:47 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:27541 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261368AbTAICMo> convert rfc822-to-8bit; Wed, 8 Jan 2003 21:12:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Chris Wood <cwood@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Date: Wed, 8 Jan 2003 18:20:44 -0800
User-Agent: KMail/1.4.3
References: <3E1A12B5.4020505@xmission.com>
In-Reply-To: <3E1A12B5.4020505@xmission.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301081820.44930.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 January 2003 03:35 pm, Chris Wood wrote:
> Due to kswapd problems in Redhat's 2.4.9 kernel, I have had to upgrade
> to the 2.4.20 kernel with the IBM Summit Patches for our IBM x440.  It
> has run very well with one exception, between 8:00am and 9:00am our
> server will see a cpu usage hit under the system resources (in top) and
> start to drag the server to a very slow situation where people can't
> access the server.
>
> See the following jpg of top as an example of the system usage.  It
> doesn't seem to be any one program.
>
> http://www.wencor.com/slow2.4.20.jpg
>
> When we start to have users log off the server (we have 300 telnet users
> that login) the system usually bounces right back to normal.  We have
> had to reboot once or twice to get it fully working again (lpd went into
> limbo and wouldn't come back).  After the server bounces back to normal,
> we can run the rest of the day without any trouble and under full heavy
> load.  I have never seen it happen at any other time of day and it
> doesn't happen every day.
>
> With some tips from James Cleverdon (IBM), I turned on some kernel
> debugging and got the following from readprofile when the server was
> having problems (truncated to the first 22 lines):
> 16480 total                                      0.0138
>    6383 .text.lock.swap                          110.0517
>    4689 .text.lock.vmscan                         28.2470
>    4486 shrink_cache                               4.6729
>     168 rw_swap_page_base                          0.6176
>     124 prune_icache                               0.5167
>      81 statm_pgd_range                            0.1534
>      51 .text.lock.inode                           0.0966
>      38 system_call                                0.6786
>      31 .text.lock.tty_io                          0.0951
>      31 .text.lock.locks                           0.1435
>      18 .text.lock.sched                           0.0373
>      16 _stext                                     0.2000
>      15 fput                                       0.0586
>      11 .text.lock.read_write                      0.0924
>       9 strnicmp                                   0.0703
>       9 do_wp_page                                 0.0110
>       9 do_page_fault                              0.0066
>       9 .text.lock.namei                           0.0073
>       9 .text.lock.fcntl                           0.0714
>       8 sys_read                                   0.0294
>
> Here is a snapshot when the server is fine, no problems (truncated):
> 1715833 total                                      1.4317
> 1677712 default_idle                             26214.2500
>    4355 system_call                               77.7679
>    2654 file_read_actor                           11.0583
>    2159 bounce_end_io_read                         5.8668
>    1752 put_filp                                  18.2500
>    1664 do_page_fault                              1.2137
>    1294 fget                                      20.2188
>    1246 do_wp_page                                 1.5270
>    1233 fput                                       4.8164
>    1138 posix_lock_file                            0.7903
>    1120 kmem_cache_alloc                           3.6842
>    1098 do_softirq                                 4.9018
>    1042 statm_pgd_range                            1.9735
>     882 kfree                                      6.1250
>     732 __loop_delay                              15.2500
>     673 flush_tlb_mm                               6.0089
>     610 fcntl_setlk64                              1.3616
>     554 __kill_fasync                              4.9464
>     498 zap_page_range                             0.4716
>     414 do_generic_file_read                       0.3696
>     409 __free_pages                               8.5208
>     401 sys_semop                                  0.3530
>
> I have to admit that most of this doesn't make a lot of sense to me and
> I don't know what the .text.lock.* processes are doing.  Any ideas?
> Anything I can try?
>
> Chris Wood
> Wencor West, Inc.

Chris,

You're showing all the signs of the "kswapd" bug present in v2.4 kernels.  
Well, kswapd gets blamed for the problem.  It is actually caused by using up 
nearly all of low memory with the buffer header and/or inode slab caches.  
(Cat /proc/slabinfo when kswapd is running >= 99% and see if those two caches 
have grown extra large.)  Anyway, kswapd gets triggered because a zone has 
hit its low memory threshold.  But kswapd can't swap buffer headers or 
inodes.  The situation is hopeless, yet kswapd presses on anyway, scouring 
every memory zone for pages to free, all the while holding important memory 
locks.

Meanwhile, every program that wants more memory will spin on those locks.  
That's what the .text.lock.* entries are:  the out-of-line spin code for each 
lock; it is used when the lock is already owned by some other CPU.

Net result:  a computer that runs like molasses in January.

Of the several proposed patches for this bug, Andrea Archangeli's and Andrew 
Morton's worked best in our tests.  I believe that Andrea was going to add in 
some of Andrew's code for the final fix.  The kernel that is on the SLES 8 / 
UL 1.0 gold CDs works fine so I assume the Vulcan Mind Meld on the patches 
went well.

Unfortunately, I don't have any references to the final patch set.

> -----------------------------------
> System Info From Here Down:
> IBM x440 - Dual Xeon 1.4ghz MP, with Hyperthreading turned on
> 6 gig RAM
> 2 internal 36gig drives mirrored
> 1 additional intel e1000 network card
> 2 IBM fibre adapters (QLA2300s) connected to a FastT700 SAN
> RedHat Advanced Server 2.1
> 2.4.20 kernel built using the RH 2.4.9e8summit .config file as template
>
[ Snip! ]

Our customers have seen this on large Dell boxes too.  I strongly suspect that 
any v2.4 system with lots of physical memory and high I/O bandwidth can cause 
this bug.


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com


