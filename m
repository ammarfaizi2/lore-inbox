Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUHXH2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUHXH2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 03:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbUHXH2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 03:28:13 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:9913 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S266615AbUHXH1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 03:27:17 -0400
Message-ID: <043101c489ab$bf6fe1d0$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "James Morris" <jmorris@redhat.com>
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
References: <Xine.LNX.4.44.0408201052160.22200-100000@dhcp83-76.boston.redhat.com>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Date: Tue, 24 Aug 2004 16:27:01 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James, Thanks for your comments.

> Do you have figures for 1 and 2 CPU?

The results of 1CPU and 2CPU  are following:  (2.6.8.1-RCU by take2 patch)
[write() to files on tmpfs Loop=500000 Parallel=<Num of CPU>]
                 -- 1CPU-- -- 2CPU-- -- 4CPU-- -- 8CPU-- --16CPU-- --32CPU--
2.6.8.1(disable)    8.2959    8.0430    8.0158    8.0183    8.0146    8.0037
2.6.8.1(enable)    11.8427   14.0358   78.0957  319.0451 1322.0313  too long
2.6.8.1.rwlock     11.2485   13.8688   20.0100   49.0390   90.0200  177.0533
2.6.8.1.rcu        11.3435   11.3319   11.0464   11.0205   11.0372   11.0496


> Also, can you run some more benchmarks, e.g. lmbench, unixbench, dbench 
> etc?

The results of unixbench and dbench are following:

o UNIXbench

* INDEX value comparison
                                       2.6.8.1   2.6.8.1   2.6.8.1   2.6.8.1
                                     (Disable)  (Enable)  (rwlock)     (RCU)
Dhrystone 2 using register variables    268.9     268.8     269.2     269.0
Double-Precision Whetstone               94.2      94.2      94.2      94.2
Execl Throughput                        388.3     379.0     377.8     377.9
File Copy 1024 bufsize 2000 maxblocks   606.6     526.6     515.6     504.8
File Copy 256 bufsize 500 maxblocks     508.9     417.0     410.4     395.2
File Copy 4096 bufsize 8000 maxblocks   987.1     890.4     876.0     857.9
Pipe Throughput                         525.1     406.4     404.5     408.8
Process Creation                        321.2     317.8     315.9     316.3
Shell Scripts (8 concurrent)           1312.8    1276.2    1278.8    1282.8
System Call Overhead                    467.1     468.7     464.1     467.2
                                    ========================================
     FINAL SCORE                        445.8     413.2     410.1     407.7


o dbench [ 4 processes run parallely on 4-CPUs / 10 times trials ]
                  ---- mean ----  - STD -
2.6.8.1(disable)  860.249 [MB/s]   44.683
2.6.8.1(enable)   714.254 [MB/s]   32.359
2.6.8.1(+rwlock)  767.904 [MB/s]   27.968
2.6.8.1(+RCU)     830.678 [MB/s]   16.352


> > > + hvalue = atomic_inc_return(&avc_cache.lru_hint) % AVC_CACHE_SLOTS;
> 
> atomic_inc_return() is not implemented on ia32 or x86-64.  Is there a 
> workaround, or do we need to implement it?  (Andi Kleen suggested using 
> the xadd instruction and altinstructions for i386).

Oops!
In IA-32 or x86_64, can anybady implement atomic_inc_return()?
If it can not, I'll try to make alternative macros or inline functions.

Thanks.
--------
Kai Gai <kaigai@ak.jp.nec.com>

