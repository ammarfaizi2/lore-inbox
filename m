Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272977AbSISUtt>; Thu, 19 Sep 2002 16:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272979AbSISUtt>; Thu, 19 Sep 2002 16:49:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37859 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272977AbSISUtp>; Thu, 19 Sep 2002 16:49:45 -0400
From: "Mingming Cao" <mcao@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async--performance numbers
To: Benjamin LaHaise <bcrl@redhat.com>, akpm@digeo.com
Cc: suparna@linux.ibm.com, badari@beaverton.ibm.com,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFA7076911.0B671E1D-ON87256C39.00691995@boulder.ibm.com>
Date: Thu, 19 Sep 2002 13:52:09 -0700
X-MIMETrack: Serialize by Router on D03NM043/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/19/2002 02:53:01 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Ben & Andrew,

I run sync raw I/O tests and Narasimha's async I/O tests on a 8 way PIII to
measure the I/O performance before/after the dio async patch.  All the
tests (sync and async) did 4000 * 256K I/O on 40 disks.

Basically, sync RAW read/write performance has no affect with the dio async
patch. Async I/O seems to be slower than the sync I/O.  Async RAW I/O got
better performance when the queue length for io_submit() is set to be 4.

I measured the time per test.  vmstat infos are also listed below.

sync RAW read w/o async dio patch:
-----------------------------------------------
- time
real  1m54.165s
user  0m0.153s
sys   0m24.369s

- vmstat
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0 39  0      0 3795352      0  37752   0   0 384371     0 3980  6361   0
5  95
 0 39  0      0 3795344      0  37756   0   0 384832     7 3974  6356   0
5  95
 0 39  0      0 3795340      0  37756   0   0 384090     0 3982  6349   0
5  95
 1 38  0      0 3795336      0  37756   0   0 384320     0 3971  6335   0
5  95

sync RAW write w/o async dio patch
-----------------------------------------------
- time

real  2m19.465s
user  0m0.138s
sys   0m19.837s

- vmstat
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 1 38  0      0 3805916      0  37516   0   0     0 302963 3383  4882   0
3  97
 1 38  0      0 3805904      0  37516   0   0     0 302413 3376  4880   0
3  97
 0 39  0      0 3805892      0  37516   0   0     0 302912 3373  4877   0
3  97
 0 39  0      0 3805920      0  37516   0   0     0 303512 3390  4886   0
3  97

sync RAW read w/ async dio patch
----------------------------------------------
- time
real  1m53.405s
user  0m0.152s
sys   0m23.402sp

- vmstat 5
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0 39  0      0 3795576      0  37592   0   0 384115     0 3929  3476   0
5  95
 0 39  0      0 3795568      0  37592   0   0 383834     0 3931  3464   0
5  95
 0 39  0      0 3795564      0  37592   0   0 384474     0 3941  3485   0
5  95
 0 39  0      0 3795560      0  37592   0   0 384013     0 3931  3488   0
5  95

sync RAW write w/ async dio patch
----------------------------------------------
- time
real  2m19.295s
user  0m0.147s
sys   0m17.754s

- vmstat 5
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0 39  0      0 3805224      0  37660   0   0     0 303168 3360  2492   0
4  96
 0 39  0      0 3805212      0  37664   0   0     0 301427 3348  2486   0
4  96
 0 39  0      0 3805208      0  37664   0   0     0 304435 3371  2490   0
3  97
 0 39  0      0 3805204      0  37664   0   0     0 303072 3360  2476   0
3  97

async RAW read (queue lenth =1)
----------------------
- time
real  2m8.860s
user  0m0.472s
sys   0m24.020s

- vmstat 5
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 1  0  0      0 3779912      0  39660   0   0 347520     0 3663  3057   0
5  95
 0  0  0      0 3779664      0  39660   0   0 346854     0 3664  3062   0
5  95
 1  0  0      0 3779400      0  39660   0   0 348045     0 3663  3046   0
5  95
 0  0  0      0 3779124      0  39660   0   0 346278     0 3662  3038   0
5  95

asyn RAW write (queue lenth =1)
---------------------
- time

real  2m17.140s
user  0m0.410s
sys   0m22.317s

- vmstat 5
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 1  0  0      0 3789096      0  39692   0   0     0 304704 3371  2599   0
4  96
 1  0  0      0 3788884      0  39692   0   0     0 306918 3390  2602   0
4  96
 0  0  0      0 3788644      0  39692   0   0     0 304662 3376  2584   0
4  96
 0  0  0      0 3788408      0  39692   0   0     0 304334 3371  2573   0
4  96

async RAW read (queue lenth =4)
----------------------
- time

real  2m6.453s
user  0m0.344s
sys   0m23.802s

- vmstat 5
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0  0  0      0 3715372      0  39988   0   0 354528     0 3690  3200   0
5  95
 0  0  0      0 3715288      0  39988   0   0 352032     0 3692  3198   0
5  95
 0  0  0      0 3715188      0  39988   0   0 356096     0 3670  3184   0
5  95
 0  0  0      0 3715104      0  39988   0   0 350816     0 3664  3165   0
5  95

async RAW write (queue lenth =4)
----------------------
- time

real  2m15.452s
user  0m0.318s
sys   0m21.715s

- vmstat 5
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0  0  1      0 3754736      0  40048   0   0     0 306547 3367  2747   0
4  96
 0  0  0      0 3754564      0  40048   0   0     0 306970 3360  2758   0
4  96
 3  0  0      0 3754408      0  40048   0   0     0 307994 3365  2765   0
4  96
 0  0  0      0 3754100      0  40048   0   0     0 307162 3367  2763   0
4  96


Mingming Cao


