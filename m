Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265425AbRFVOJV>; Fri, 22 Jun 2001 10:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265427AbRFVOJM>; Fri, 22 Jun 2001 10:09:12 -0400
Received: from smtp.compuserve.de ([62.52.27.101]:8762 "HELO
	desws061.mediaways.net") by vger.kernel.org with SMTP
	id <S265425AbRFVOI5>; Fri, 22 Jun 2001 10:08:57 -0400
Date: Fri, 22 Jun 2001 16:08:21 +0200
From: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Alan Cox <laughing@shared-source.org>
Subject: Re: Linux 2.4.5-ac15 / 2.4.6-pre5
Message-ID: <20010622160821.A7032@frodo.uni-erlangen.de>
In-Reply-To: <Pine.LNX.4.21.0106210127150.14247-100000@freak.distro.conectiva> <Pine.LNX.4.33.0106210836340.1043-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0106210836340.1043-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Thu, Jun 21, 2001 at 08:56:53AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith schrieb am Donnerstag, den 21. Juni 2001:

> On Thu, 21 Jun 2001, Marcelo Tosatti wrote:
> 
> > >  2  4  2  77084   1524  18396  66904   0 1876   108  2220 2464 66079   198   1
>                                                                    ^^^^^
> > Ok, I suspect that GFP_BUFFER allocations are fucking up here (they can't
> > block on IO, so they loop insanely).
> 
> Why doesn't the VM hang the syncing of queued IO on these guys via
> wait_event or such instead of trying to just let the allocation fail?
> (which seems to me will only cause the allocation to be resubmitted,
> effectively changing nothing but adding overhead)  Does failing the
> allocation in fact accomplish more than what I'm (uhoh:) assuming?

Ok, I managed to press SysRq-T this time ond got a trace for my hang.
Symbols are resolved by klog. If you prefer ksymopps please tell me, I
used klog because ksymopps seems to drop all lines without symbols.

There seem to be no kernel deamons in the trace? Is this normal, or is
the log buffer too small? If it is the latter, how can I increase its
size?

Kernel was 2.4.6pre5 plus Rik's patch (at the end). I see the same hangs
with the ac series.

Walter

Jun 22 15:42:09 frodo kernel: 2672  1021      1  1035  (NOTLB)    1050  1004
Jun 22 15:42:10 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:10 frodo kernel: mysqld    S 7FFFFFFF     0  1035   1021  1055  (NOTLB)        
Jun 22 15:42:10 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:10 frodo kernel: smbd      S 7FFFFFFF     0  1050      1        (NOTLB)    1051  1021
Jun 22 15:42:10 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:10 frodo kernel: sshd      S 7FFFFFFF     0  1051      1        (NOTLB)    1060  1050
Jun 22 15:42:10 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:10 frodo kernel: mysqld    R 00000000  5644  1055   1035  1056  (NOTLB)        
Jun 22 15:42:10 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [__pollwait+51/148] [pipe_poll+38/100] [do_pollfd+94/176] [do_poll+167/228] 
Jun 22 15:42:10 frodo kernel:        [sys_poll+603/884] [system_call+51/56] 
Jun 22 15:42:10 frodo kernel: mysqld    S C5C8A000  5704  1056   1055        (NOTLB)        
Jun 22 15:42:10 frodo kernel: Call Trace: [sys_rt_sigsuspend+255/284] [system_call+51/56] 
Jun 22 15:42:10 frodo kernel: wwwoffled  S C5F7BF10  2672  1060      1  4417  (NOTLB)    1064  1051
Jun 22 15:42:10 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:10 frodo kernel: cron      S C5F5DF7C     0  1064      1        (NOTLB)    1068  1060
Jun 22 15:42:10 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [sys_nanosleep+304/428] [system_call+51/56] 
Jun 22 15:42:10 frodo kernel: in.identd  S 7FFFFFFF     0  1068      1  1070  (NOTLB)    1083  1064
Jun 22 15:42:10 frodo kernel: Call Trace: [schedule_timeout+23/152] [wait_for_connect+308/420] [tcp_accept+134/408] [inet_accept+48/316] [sys_accept+102/244] [do_fork+1567/1756] [schedule+714/1064] 
Jun 22 15:42:10 frodo kernel:        [restore_sigcontext+273/312] [sys_socketcall+172/476] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: in.identd  R 00000000  3444  1070   1068  1081  (NOTLB)        
Jun 22 15:42:11 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [sys_poll+310/884] [handle_IRQ_event+49/92] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: in.identd  S C5B7A000    16  1071   1070        (NOTLB)    1076
Jun 22 15:42:11 frodo kernel: Call Trace: [sys_rt_sigsuspend+255/284] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: in.identd  S C7806000     0  1076   1070        (NOTLB)    1077  1071
Jun 22 15:42:11 frodo kernel: Call Trace: [sys_rt_sigsuspend+255/284] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: in.identd  S C7FBC000     0  1077   1070        (NOTLB)    1078  1076
Jun 22 15:42:11 frodo kernel: Call Trace: [sys_rt_sigsuspend+255/284] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: in.identd  S C7FB8000  2676  1078   1070        (NOTLB)    1081  1077
Jun 22 15:42:11 frodo kernel: Call Trace: [sys_rt_sigsuspend+255/284] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: in.identd  S C6964000     0  1081   1070        (NOTLB)          1078
Jun 22 15:42:11 frodo kernel: Call Trace: [sys_rt_sigsuspend+255/284] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: nscd      S C739BF14     0  1083      1  1085  (NOTLB)    1098  1068
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_poll+55/228] [sys_poll+603/884] [sys_newstat+103/116] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: nscd      R 00000000     0  1085   1083  1096  (NOTLB)        
Jun 22 15:42:11 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [__pollwait+51/148] [pipe_poll+38/100] [do_pollfd+94/176] [do_poll+167/228] 
Jun 22 15:42:11 frodo kernel:        [sys_poll+603/884] [handle_IRQ_event+49/92] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: nscd      S C5B91F14  5744  1089   1085        (NOTLB)    1090
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_poll+55/228] [sys_poll+603/884] [sys_newstat+103/116] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: nscd      S 7FFFFFFF  2676  1090   1085        (NOTLB)    1092  1089
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_poll+167/228] [do_poll+55/228] [sys_poll+603/884] [filp_close+88/96] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: nscd      S 7FFFFFFF     0  1092   1085        (NOTLB)    1093  1090
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_poll+167/228] [do_poll+55/228] [sys_poll+603/884] [filp_close+88/96] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: nscd      S 7FFFFFFF     4  1093   1085        (NOTLB)    1096  1092
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_poll+167/228] [do_poll+55/228] [sys_poll+603/884] [filp_close+88/96] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: nscd      S 7FFFFFFF    28  1096   1085        (NOTLB)          1093
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_poll+167/228] [do_poll+55/228] [sys_poll+603/884] [filp_close+88/96] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: su        S 00000000  2672  1098      1  1103  (NOTLB)    1110  1083
Jun 22 15:42:11 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: lamequeue  S 00000000  2672  1103   1098  4355  (NOTLB)        
Jun 22 15:42:11 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: junkbuster  S 7FFFFFFF     4  1110      1  4416  (NOTLB)     981  1098
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [wait_for_connect+308/420] [tcp_accept+134/408] [inet_accept+48/316] [sys_accept+102/244] [do_signal+554/628] [sys_socketcall+172/476] 
Jun 22 15:42:11 frodo kernel:        [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: kdeinit   R 00000000     0  1160      1        (NOTLB)    1198   981
Jun 22 15:42:11 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [__pollwait+51/148] [sock_poll+35/40] [do_select+287/520] [sys_select+1071/1436] 
Jun 22 15:42:11 frodo kernel:        [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: kdeinit   S 7FFFFFFF     0  1198      1        (NOTLB)    1216  1160
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: kdeinit   S 7FFFFFFF     0  1216      1  4413  (NOTLB)     963  1198
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: kdeinit   S 7FFFFFFF     0  1218      1  1225  (NOTLB)    1487   963
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: httpd     S 7FFFFFFF    16  1219    965        (NOTLB)        
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: cat       S 7FFFFFFF     0  1225   1218        (NOTLB)        
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [read_chan+932/1704] [tty_read+176/212] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: knotify   S 7FFFFFFF     0  1487      1        (NOTLB)    1930  1218
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: korn      R 00000000     0  1608    398        (NOTLB)    1609
Jun 22 15:42:11 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [__pollwait+51/148] [sock_poll+35/40] [do_select+287/520] [sys_select+1071/1436] 
Jun 22 15:42:11 frodo kernel:        [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: knetload  R 00000000  1648  1609    398        (NOTLB)    1614  1608
Jun 22 15:42:11 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [do_anonymous_page+52/140] [do_no_page+47/212] [handle_mm_fault+101/208] [do_page_fault+359/1228] [do_page_fault+0/1228] 
Jun 22 15:42:11 frodo kernel:        [vsprintf+897/956] [sprintf+20/24] [sprintf_stats+130/156] [error_code+52/60] [__generic_copy_to_user+48/64] [proc_file_read+337/456] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: ksmserver  S 7FFFFFFF     4  1614    398        (NOTLB)          1609
Jun 22 15:42:11 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:11 frodo kernel: kdeinit   S 7FFFFFFF    80  1724   1216        (NOTLB)    1945
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: mingetty  S 7FFFFFFF     4  1930      1        (NOTLB)    1931  1487
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [read_chan+932/1704] [tty_read+176/212] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: mingetty  S 7FFFFFFF  2672  1931      1        (NOTLB)    1932  1930
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [read_chan+932/1704] [tty_read+176/212] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: mingetty  S 7FFFFFFF     0  1932      1        (NOTLB)    1933  1931
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [read_chan+932/1704] [tty_read+176/212] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: mingetty  S 7FFFFFFF  2672  1933      1        (NOTLB)    1934  1932
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [read_chan+932/1704] [tty_read+176/212] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: mingetty  S 7FFFFFFF     0  1934      1        (NOTLB)    1935  1933
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [read_chan+932/1704] [tty_read+176/212] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: mingetty  S 7FFFFFFF     0  1935      1        (NOTLB)    2146  1934
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [read_chan+932/1704] [tty_read+176/212] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   R 00000000  2676  1945   1216  3834  (NOTLB)    1946  1724
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [read_swap_cache_async+53/164] [swapin_readahead+147/204] [do_swap_page+37/380] [handle_mm_fault+119/208] [do_page_fault+359/1228] 
Jun 22 15:42:12 frodo kernel:        [do_page_fault+0/1228] [schedule+714/1064] [error_code+52/60] 
Jun 22 15:42:12 frodo kernel: python    S 00000000     0  1946   1216  1947  (NOTLB)    1952  1945
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: python    R 00000000  2704  1947   1946  2860  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [do_anonymous_page+52/140] [do_no_page+47/212] [handle_mm_fault+101/208] [do_page_fault+359/1228] [do_page_fault+0/1228] 
Jun 22 15:42:12 frodo kernel:        [handle_IRQ_event+49/92] [end_8259A_irq+24/28] [do_IRQ+140/176] [error_code+52/60] [arp_find+204/336] [__generic_copy_to_user+48/64] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S 7FFFFFFF  1920  1952   1216  1953  (NOTLB)    1969  1946
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: screen    S C4578000     0  1953   1952  1960  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_pause+18/24] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: screen    S 7FFFFFFF     0  1960   1953  2986  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: bash      S 00000000     0  1961   1960  3353  (NOTLB)    2986
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S 7FFFFFFF   624  1969   1216  1970  (NOTLB)    2887  1952
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: screen    S C4380000   240  1970   1969  1977  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_pause+18/24] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: screen    S 7FFFFFFF     0  1977   1970  1978  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: bash      S 7FFFFFFF     0  1978   1977        (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [read_chan+932/1704] [tty_read+176/212] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: loop0     S C3288104  2604  2146      1        (L-TLB)    2971  1935
Jun 22 15:42:12 frodo kernel: Call Trace: [__down_interruptible+129/208] [__down_failed_interruptible+7/12] [do_readv_writev+304/596] [kernel_thread+35/48] 
Jun 22 15:42:12 frodo kernel: python    S 00000000     0  2859   1947  2861  (NOTLB)    2860
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: python    S 00000000     0  2860   1947  2862  (NOTLB)          2859
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: su        S 00000000     0  2861   2859  2864  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: fetchnews  R 00000000     0  2862   2860        (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [generic_file_write+925/1484] [sys_write+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: fetchmail  S 00000000     0  2864   2861  4418  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S 7FFFFFFF    24  2887   1216  2892  (NOTLB)    2969  1969
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: screen    S C367E000     0  2892   2887  2899  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_pause+18/24] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: screen    S 7FFFFFFF    48  2899   2892  2918  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: bash      S 00000000  1920  2900   2899  2915  (NOTLB)    2918
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: vmstat    R 00000000     0  2915   2900        (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [proc_info_read+57/296] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: bash      S 00000000     0  2918   2899  2931  (NOTLB)          2900
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: su        S 00000000     4  2931   2918  2932  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: bash      S 00000000     0  2932   2931  2940  (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: less      S C18B3F7C     0  2940   2932        (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [update_atime+68/72] [schedule_timeout+120/152] [process_timeout+0/76] [sys_nanosleep+304/428] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C7C95F10     0  2969   1216        (NOTLB)    3002  2887
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S 7FFFFFFF     0  2971      1        (NOTLB)    2974  2146
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdesud    R 00000000     0  2974      1        (NOTLB)          2971
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [__pollwait+51/148] [sock_poll+35/40] [do_select+287/520] [sys_select+1071/1436] 
Jun 22 15:42:12 frodo kernel:        [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: bash      S 00000000     0  2986   1960  2994  (NOTLB)          1961
Jun 22 15:42:12 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: mutt      S C1D53F14  4800  2994   2986        (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [normal_poll+259/288] [schedule_timeout+120/152] [process_timeout+0/76] [do_poll+55/228] [sys_poll+603/884] [sys_newstat+103/116] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C587DF10     8  3002   1216        (NOTLB)    3003  2969
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   R 00000000     0  3003   1216        (NOTLB)    3016  3002
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [__pollwait+51/148] [tcp_poll+47/344] [__free_pages+26/28] [sock_poll+35/40] 
Jun 22 15:42:12 frodo kernel:        [do_select+287/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C784BF10     0  3016   1216        (NOTLB)    3017  3003
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   R 00000000     0  3017   1216        (NOTLB)    3082  3016
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [__pollwait+51/148] [sock_poll+35/40] [do_select+287/520] [sys_select+1071/1436] 
Jun 22 15:42:12 frodo kernel:        [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C2401F10     0  3082   1216        (NOTLB)    3083  3017
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C6B41F10  1116  3083   1216        (NOTLB)    3127  3082
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C58A7F10     0  3127   1216        (NOTLB)    3132  3083
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C4F1DF10     0  3132   1216        (NOTLB)    3172  3127
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C1FD7F10     0  3172   1216        (NOTLB)    3200  3132
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S 7FFFFFFF     0  3200   1216        (NOTLB)    3201  3172
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [sock_recvmsg+65/180] [sock_read+143/152] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S 7FFFFFFF     0  3201   1216        (NOTLB)    3337  3200
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [sock_recvmsg+65/180] [sock_read+143/152] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C280FF10     0  3337   1216        (NOTLB)    3338  3201
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C7CDBF10  3444  3338   1216        (NOTLB)    3621  3337
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: wget      S C0511F10  4708  3353   1961        (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: junkbuster  S 7FFFFFFF     0  3354   1110        (NOTLB)    4334
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: wwwoffled  R 00000000     0  3355   1060        (NOTLB)    4335
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [__pollwait+51/148] [tcp_poll+47/344] [sock_poll+35/40] [do_select+287/520] 
Jun 22 15:42:12 frodo kernel:        [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C6C7BF10     0  3621   1216        (NOTLB)    3631  3338
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C2AE1F10     0  3631   1216        (NOTLB)    3644  3621
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: kdeinit   S C49D5F10     0  3644   1216        (NOTLB)    4413  3631
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: xosview.bin  R 00000000     0  3657    918        (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [do_anonymous_page+52/140] [do_no_page+47/212] [handle_mm_fault+101/208] [do_page_fault+359/1228] [do_page_fault+0/1228] 
Jun 22 15:42:12 frodo kernel:        [vsprintf+897/956] [vsprintf+897/956] [kstat_read_proc+703/716] [error_code+52/60] [__generic_copy_to_user+48/64] [proc_file_read+337/456] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: nspluginviewer  R 00000000     4  3834   1945        (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [__pollwait+51/148] [sock_poll+35/40] [do_select+287/520] [sys_select+1071/1436] 
Jun 22 15:42:12 frodo kernel:        [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: junkbuster  S 7FFFFFFF     0  4334   1110        (NOTLB)    4336  3354
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: wwwoffled  S C2619F10     0  4335   1060        (NOTLB)    4337  3355
Jun 22 15:42:12 frodo kernel: Call Trace: [__pollwait+141/148] [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: junkbuster  S 7FFFFFFF     0  4336   1110        (NOTLB)    4410  4334
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: wwwoffled  S C260FF10     0  4337   1060        (NOTLB)    4415  4335
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: sleep     S C5965F7C     0  4355   1103        (NOTLB)        
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+120/152] [process_timeout+0/76] [sys_nanosleep+304/428] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: junkbuster  S 7FFFFFFF     0  4410   1110        (NOTLB)    4416  4336
Jun 22 15:42:12 frodo kernel: Call Trace: [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: netscape  R 00000000     0  4413   1216        (NOTLB)          3644
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [read_cluster_nonblocking+152/256] [filemap_nopage+356/1024] [do_no_page+84/212] [handle_mm_fault+101/208] [do_page_fault+359/1228] 
Jun 22 15:42:12 frodo kernel:        [do_page_fault+0/1228] [do_munmap+88/648] [ide_intr+307/344] [do_brk+170/340] [sys_brk+195/240] [error_code+52/60] 
Jun 22 15:42:12 frodo kernel: wwwoffled  R 00000000  2672  4415   1060        (NOTLB)    4417  4337
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [do_generic_file_read+969/1268] [generic_file_read+99/128] [file_read_actor+0/88] [sys_read+142/196] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: junkbuster  S 7FFFFFFF  1172  4416   1110        (NOTLB)          4410
Jun 22 15:42:12 frodo kernel: Call Trace: [tcp_poll+47/344] [schedule_timeout+23/152] [do_select+153/520] [sys_select+1071/1436] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: wwwoffled  R 00000000  2676  4417   1060        (NOTLB)          4415
Jun 22 15:42:12 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [__get_free_pages+10/24] [kmem_cache_grow+198/560] [kmem_cache_alloc+73/88] [getname+26/156] [sys_rename+54/568] 
Jun 22 15:42:12 frodo kernel:        [path_release+13/44] [sys_newstat+103/116] [sys_close+67/84] [system_call+51/56] 
Jun 22 15:42:12 frodo kernel: procmail  S 00000000    16  4418   2864  4422  (NOTLB)        
Jun 22 15:42:13 frodo kernel: Call Trace: [sys_wait4+875/924] [system_call+51/56] 
Jun 22 15:42:13 frodo kernel: pgpenvelope_dec  R 00000000     0  4422   4418        (NOTLB)        
Jun 22 15:42:13 frodo kernel: Call Trace: [__alloc_pages+272/656] [_alloc_pages+24/28] [do_anonymous_page+52/140] [do_no_page+47/212] [handle_mm_fault+101/208] [do_page_fault+359/1228] [do_page_fault+0/1228] 
Jun 22 15:42:13 frodo kernel:        [do_munmap+88/648] [tqueue_bh+22/28] [do_brk+170/340] [sys_brk+195/240] [error_code+52/60] 

 3  0  0  76644   3764   2272  45112   0   0     0     0  398   448  56   8  36
 2  0  0  76644   4404   2276  44668  60   0    68     0  379   453  66   8  27
 0  0  0  76644   4388   2276  44684   0   0     0     0  416   451   4   5  92
 0  0  0  76644   4364   2276  44700   0   0     0     0  394   501   4   6  91
 2  0  0  76644   4732   2276  44712   0   0     0    80  444  2189  28  13  58
 6  0  0  76080   5256   2280  44304 112   0   140     0  396   831  87  11   2
 8  0  0  76080   4400   2284  44324   0   0     8     0  396   481  43   6  52
 2  0  0  76080   4612   2200  44348   0   0     4     0  391   486  76  13  11
 0  0  0  76080   4592   2204  44364   0   0     4    80  385   411   4   7  89
 0  0  0  76080   4572   2204  44380   0   0     0     0  418   436   5   6  90
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0  76080   4508   2204  44444  64   0    64     0  390   388   6   6  89
 2  0  0  76080   4720   2204  44444   0   0     0     0  471   462  25   7  68
 2  0  0  76080   4348   2204  44460   4   0     4     0  476   560  26  10  64
 4  0  0  76080   3756   2204  44468   0   0     0    20  545  1925  78  22   0
 0  0  0  76080   4424   2204  44532   0   0     4     0  500   720  63  11  26
 0  1  0  76080   3240   2256  45496 376   0  1004     0  540   664  13   5  82
 4  0  0  76080   2812   2248  45632 184   0   192     0  564   977  83  14   3
 7  0  0  76076   2808   2100  44532 500   0   656     0  538   780  89  11   0
 3  2  0  76068   4148   2120  44300 188   0   404  1024  697   761  53  12  34
 4  1  0  76068   2808   2196  45300 176   0  1784   256  619  1949  33  18  49
 7  2  1  76068   3116   2208  45588   0 284  1040   480  591  3665  75  25   0
 6  5  1  77232   2692   2136  47004 560 892  2048  1524 10428 285529   2  98   0
 2  9  1  77744   2688   2108  47468 580 408   964   812  506  2203  63  18  20
 2  2  1  82336   4052   2056  50560 380   0  1500   360  552   871  80  20   0
 3  2  1  82336   2808   2084  51644 280 1040  1376  1748  668  3213  35  21  44
 3  0  0  87184   2812   2108  55916 300 2012  1568  3360  860  1299  30  16  54
 4  0  0  87180   2812   2104  55544 128   0   420     0  415   786  82  10   9
 3  0  0  89528   2812   2104  57572   0   0     8     0  395   577  94   6   0
 2  0  0  92096   3080   1276  59616   0 1812  1120  2068  532   541  78   9  12
 1  1  1  93800   2916   1256  62152 796   0  2152     0  497   615  31  11  57
 4  1  0  95768   2808   1180  64800 1280   0  2776     0  508   522  59  12  29
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 3  2  0  99512   2808   1220  68336 860   0  2072     0  493   548  76  21   3
 3  0  0 101980   2812   1248  70800   0   0   288     0  454   437  88  12   0
 8  4  0 101980   2812   1272  70264 400   0   540     0  439   505  92   8   0
 3  0  0 102596   2812   1300  71296 1192   0  1700     0  335   536  91   9   0
 6  0  0 102596   2812   1316  71248  68   0   440     0  306   571  93   7   0
 4  3  1 102668   2812   1364  71140  64   0   756   768  402   897  84  11   5




--- linux/mm/swapfile.c.~1~	Thu May  3 16:34:46 2001
+++ linux/mm/swapfile.c	Thu May  3 16:36:07 2001
@@ -67,8 +67,14 @@
 	}
 	/* No luck, so now go finegrined as usual. -Andrea */
 	for (offset = si->lowest_bit; offset <= si->highest_bit ; offset++) {
-		if (si->swap_map[offset])
+		if (si->swap_map[offset]) {
+			/* Any full pages we find we should avoid
+			 * looking at next time. */
+			if (offset == si->lowest_bit)
+				si->lowest_bit++;
 			continue;
+		}
+
 	got_page:
 		if (offset == si->lowest_bit)
 			si->lowest_bit++;
@@ -79,6 +85,7 @@
 		si->cluster_next = offset+1;
 		return offset;
 	}
+	si->highest_bit = 0;
 	return 0;
 }


