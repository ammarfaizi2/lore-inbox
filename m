Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbUBWR3p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 12:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUBWR3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 12:29:44 -0500
Received: from village.ehouse.ru ([193.111.92.18]:61968 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261970AbUBWR1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 12:27:33 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1 IO lockup on SMP systems
Date: Mon, 23 Feb 2004 20:27:26 +0300
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, "Alexander Y. Fomichev" <gluk@php4.ru>,
       anton@megashop.ru
References: <200401311940.28078.rathamahata@php4.ru> <20040221113044.7deb60b9.akpm@osdl.org> <200402222039.58702.gluk@php4.ru>
In-Reply-To: <200402222039.58702.gluk@php4.ru>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402232027.26958.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Now this happens for the third time.

> > > I've just reproduced this lockup with 2.6.3.
> > >
> > > > You may need a serial console to be able to capture all the output.
> > > >
> > > > Also, it would be useful to know what sort of load the machines are
> > > > under, and what filesystems are in use.
> > >
> > > The machine is a http server. The main applications are:
> > > 1) apache 1.3 which serves php pages (mod_php):
> > > 	 15.3 requests/sec - 111.9 kB/second - 7.3 kB/request
> > > 	 54 requests currently being processed, 19 idle servers
> > > 2) mysql:
> > > 	Threads: 19  Questions: 26922012  Slow queries: 9799  Opens: 64980
> > > 	Flush tables: 1  Open tables: 630  Queries per second avg: 143.547
> > >
> > > This is an IO bound machine in general. All filesystems are reiserfs.
> > >
> > > Here is a sysrq-T output obtained from a locked box via serail console:
> >
> > OK, so everything is stuck trying to allocate memory.  Perhaps you ran out
> > of swapspace, or some process has gone berzerk allocating memory.

The memory exhaustion is indeed possible for this box. I'll double check
ulimit and /etc/security/limits.conf stuff. The only thing which worries
me that this box had been running for months without any problems with
2.4.23aa1.

I have added another 2Gb to swap space (hope this give enough time
to find the memory hungry process(es)).

> >
> > How much memory does the machine have, and how much swap space?
> >
> # free
>              total       used       free     shared    buffers     cached
> Mem:       2073868    2067508       6360          0     232708     897828
> -/+ buffers/cache:     936972    1136896
> Swap:      1535976       5228    1530748
> 
> > I suggest that you run a `vmstat 30' trace on a terminal somewhere, see
> > what it says prior to the hangs. 
> Ok.We'll try to get it next time.

Here it is:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0 551920   8108 203744 933532    0    0     4    68 1214   426  5  1 92  2
 0  0 551928   7140 203756 930316    0    0    17    61 1240   529  8  1 89  2
 0  0 551976   5788 203772 928224    1    6   360   139 1297   317  7  2 83  8
 0  0 551968   7588 203812 923504    0    0    19   125 1303   308  8  2 87  4
 0  1 551976  10444 203892 914100    0    0    25   127 1433   438 10  3 85  3
 0  0 551976   9220 204004 914804    0    0   123   126 1278   325  6  1 88  5
 0  0 551976   8108 204044 912248    0    0    38    69 1279   291  6  1 91  2
 0  1 551976  11828 204144 912320    1    0   135    94 1249   296  6  1 89  3
 0  5 562204   3280 203952 157084    1  566   305   674 1281   313  6  4 73 17
 0 18 598224   4276   1888  33356   91 2734   233  2761 1090   199  0  2  0 97
 1 38 662520   2760   2104  30520  110 3721   261  3738 1161   831  1  2  0 97
10 41 699936   2772   1920  28716  123 2924   249  2946 1103  1273  0  3  0 97
 0 39 748588   2956   1956  22668  160 3313   245  3331 1056  1047  0  2  0 98
 0 38 796100   3108   1888  21348  321 3191   430  3206 1045  1002  0  2  0 97
 4 43 844532   3308   1956  17644  518 3719   670  3733 1357   999  0  2  0 98
 0 51 882596   2940   2052  13960  520 2796   705  2810 1048  1182  0  2  0 98
 3 59 913392   2456   2048  10900 1013 2524  1308  2542 1144   601  0  2  0 98
 5 71 937816   2760   2072   8584 1534 2681  1860  2702 1234   607  0  2  0 97

> 
> > Also capture the sysrq-M output after it 
> > has hung.
> >
> This "showmem" && "showreg" have been taken just before
> "SysRq: Show State" from previous message.
> 
> SysRq : Show Memory
>     Mem-info:
>     DMA per-cpu:
>     cpu 0 hot: low 2, high 6, batch 1
>     cpu 0 cold: low 0, high 2, batch 1
>     cpu 1 hot: low 2, high 6, batch 1
>     cpu 1 cold: low 0, high 2, batch 1
>     Normal per-cpu:
>     cpu 0 hot: low 32, high 96, batch 16
>     cpu 0 cold: low 0, high 32, batch 16
>     cpu 1 hot: low 32, high 96, batch 16
>     cpu 1 cold: low 0, high 32, batch 16
>     HighMem per-cpu:
>     cpu 0 hot: low 32, high 96, batch 16
>     cpu 0 cold: low 0, high 32, batch 16
>     cpu 1 hot: low 32, high 96, batch 16
>     cpu 1 cold: low 0, high 32, batch 16
> 
>     Free pages:        3172kB (512kB HighMem)
>     Active:1783 inactive:87 dirty:0 writeback:0 unstable:0 free:793
>     DMA free:1292kB min:16kB low:32kB high:48kB active:3748kB inactive:0kB
>     Normal free:1368kB min:936kB low:1872kB high:2808kB active:1368kB 
> inactive:356kB
>     HighMem free:512kB min:512kB low:1024kB high:1536kB active:2008kB 
> inactive:0kB
>     DMA: 151*4kB 70*8kB 6*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 
> 0*2048kB 0*4096kB = B
>     Normal: 192*4kB 9*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 
> 0*1024kB 0*2048kB 0*4096kB B
>     HighMem: 0*4kB 2*8kB 3*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 
> 0*2048kB 0*4096kB =B
>     Swap cache: add 1140128, delete 1140063, find 459572/584559, race 145+217
>     Free swap:       384364kB
>     524288 pages of RAM
>     294912 pages of HIGHMEM
>     5821 reserved pages
>     976 pages shared
>     65 pages swap cached
> 
> 
> SysRq : Show Regs
> 
> Pid: 0, comm:              swapper
> EIP: 0060:[<c0106d1c>] CPU: 0
> EIP is at default_idle+0x2c/0x40
>  EFLAGS: 00000246    Not tainted
>  EAX: 00000000 EBX: c02e6000 ECX: c0106cf0 EDX: c02e6000
>  ESI: c02e6000 EDI: c0105000 EBP: 0008e000 DS: 007b ES: 007b
>  CR0: 8005003b CR2: bffff7e0 CR3: 2d021000 CR4: 00000690
>  Call Trace:
>   [<c0106dab>] cpu_idle+0x3b/0x50
>    [<c02e88e9>] start_kernel+0x179/0x1a0
>     [<c02e84a0>] unknown_bootoption+0x0/0x120

I forgot to switch output capture on in minicom, so the sysrq-M
was scrolled out of the terminal by subsequent sysrq-T, largest
part of which was in turn scrolled out. But the sysrq-T part
is almost the same as previous one.

> 
> > It would be useful to monitor the contents of /proc/vmstat also.

The last /proc/vmstat content is 5 minutes before a real lockup
(It looks like simple "while true; do date; cat /proc/vmstat; sleep 10; done"
script suffer from the same memory exhaustion problem.)

Mon Feb 23 17:41:34 MSK 2004
nr_dirty 136
nr_writeback 0
nr_unstable 0
nr_page_table_pages 987
nr_mapped 227018
nr_slab 13041
pgpgin 8593704
pgpgout 4349808
pswpin 169183
pswpout 183480
pgalloc 20244471
pgfree 20247061
pgactivate 548813
pgdeactivate 628769
pgfault 25756129
pgmajfault 67820
pgscan 4570640
pgrefill 2934423
pgsteal 2024118
pginodesteal 0
kswapd_steal 1886046
kswapd_inodesteal 891
pageoutrun 10047
allocstall 3930
pgrotated 178662

Mon Feb 23 17:41:44 MSK 2004
nr_dirty 339
nr_writeback 0
nr_unstable 0
nr_page_table_pages 991
nr_mapped 226443
nr_slab 13036
pgpgin 8593956
pgpgout 4351080
pswpin 169186
pswpout 183480
pgalloc 20250240
pgfree 20253382
pgactivate 549009
pgdeactivate 628769
pgfault 25764719
pgmajfault 67827
pgscan 4570640
pgrefill 2934423
pgsteal 2024118
pginodesteal 0
kswapd_steal 1886046
kswapd_inodesteal 891
pageoutrun 10047
allocstall 3930
pgrotated 178662

Mon Feb 23 17:41:54 MSK 2004
nr_dirty 505
nr_writeback 0
nr_unstable 0
nr_page_table_pages 993
nr_mapped 226477
nr_slab 13049
pgpgin 8594244
pgpgout 4352144
pswpin 169186
pswpout 183480
pgalloc 20256355
pgfree 20259400
pgactivate 549048
pgdeactivate 628769
pgfault 25772385
pgmajfault 67837
pgscan 4570640
pgrefill 2934423
pgsteal 2024118
pginodesteal 0
kswapd_steal 1886046
kswapd_inodesteal 891
pageoutrun 10047
allocstall 3930
pgrotated 178662

Mon Feb 23 17:42:15 MSK 2004
nr_dirty 0
nr_writeback 765
nr_unstable 0
nr_page_table_pages 1044
nr_mapped 209677
nr_slab 4672
pgpgin 8605592
pgpgout 4424120
pswpin 169454
pswpout 201127
pgalloc 20561829
pgfree 20563033
pgactivate 601317
pgdeactivate 778533
pgfault 25777874
pgmajfault 68001
pgscan 5399589
pgrefill 3543496
pgsteal 2300249
pginodesteal 0
kswapd_steal 2058168
kswapd_inodesteal 14284
pageoutrun 10114
allocstall 7008
pgrotated 193130
Mon Feb 23 17:42:47 MSK 2004
nr_dirty 1
nr_writeback 597
nr_unstable 0
nr_page_table_pages 1213
nr_mapped 190410
nr_slab 4640
pgpgin 8614032
pgpgout 4500108
pswpin 170334
pswpout 219922
pgalloc 20588517
pgfree 20589474
pgactivate 711818
pgdeactivate 908805
pgfault 25783157
pgmajfault 68204
pgscan 5667215
pgrefill 3774369
pgsteal 2322731
pginodesteal 0
kswapd_steal 2066149
kswapd_inodesteal 14352
pageoutrun 10167
allocstall 7383
pgrotated 209403

> >
> > And perhaps keep top running in `sort by memory usage' mode.
> ok, we'll try too.

Unfortunately the top output is kind of useless because mysql
hide the real problem, I'll try to run top in batch mode next time.

top - 17:47:03 up  7:10,  3 users,  load average: 124.72, 66.96, 27.71
Tasks: 219 total,   1 running, 218 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.2% us,  2.1% sy,  0.0% ni,  0.0% id, 97.6% wa,  0.1% hi,  0.0% si
Mem:   2073868k total,  2070796k used,     3072k free,     1996k buffers
Swap:  1535976k total,   944520k used,   591456k free,     6884k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  896 mysql     15   0 1013m  21m 4896 S  0.1  1.1   0:05.64 mysqld
  939 mysql     16   0 1013m  21m 4896 S  0.0  1.1   0:00.05 mysqld
  940 mysql     20   0 1013m  21m 4896 S  0.0  1.1   0:00.00 mysqld
  941 mysql     17   0 1013m  21m 4896 S  0.0  1.1   0:00.00 mysqld
  942 mysql     15   0 1013m  21m 4896 D  0.4  1.1   1:26.19 mysqld
  943 mysql     16   0 1013m  21m 4896 S  0.0  1.1   0:00.00 mysqld
  961 mysql     17   0 1013m  21m 4896 D  0.0  1.1   0:00.00 mysqld
  962 mysql     15   0 1013m  21m 4896 D  0.0  1.1   0:13.12 mysqld
  971 mysql     16   0 1013m  21m 4896 S  0.0  1.1   0:00.05 mysqld
  972 mysql     16   0 1013m  21m 4896 S  0.0  1.1   0:03.12 mysqld
27314 mysql     15   0 1013m  21m 4896 D  0.0  1.1   0:11.73 mysqld
27325 mysql     15   0 1013m  21m 4896 S  0.0  1.1   0:08.70 mysqld
27339 mysql     15   0 1013m  21m 4896 S  0.0  1.1   0:07.78 mysqld
27361 mysql     16   0 1013m  21m 4896 S  0.0  1.1   0:10.05 mysqld
27375 mysql     15   0 1013m  21m 4896 S  0.0  1.1   0:10.61 mysqld
27390 mysql     16   0 1013m  21m 4896 S  0.0  1.1   0:11.44 mysqld
27392 mysql     16   0 1013m  21m 4896 S  0.0  1.1   0:09.20 mysqld
27393 mysql     16   0 1013m  21m 4896 S  0.0  1.1   0:12.23 mysqld
 3671 mysql     16   0 1013m  21m 4896 D  0.0  1.1   0:00.04 mysqld
 3672 mysql     18   0 1013m  21m 4896 D  0.0  1.1   0:00.11 mysqld
 3691 mysql     16   0 1013m  21m 4896 D  0.1  1.1   0:00.02 mysqld
 3704 mysql     17   0 1013m  21m 4896 S  0.0  1.1   0:00.02 mysqld

Thank you for your help!

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
