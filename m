Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSJYGnN>; Fri, 25 Oct 2002 02:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbSJYGnN>; Fri, 25 Oct 2002 02:43:13 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:18183 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261292AbSJYGnK>; Fri, 25 Oct 2002 02:43:10 -0400
Message-Id: <200210250643.g9P6hop13980@Port.imtp.ilyichevsk.odessa.ua>
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Russell King <rmk@arm.linux.org.uk>,
       Roy Sigurd Karlsbakk <roy@karlsbakk.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Csum and csum copyroutines benchmark
Date: Fri, 25 Oct 2002 09:36:22 -0200
X-Mailer: KMail [version 1.3.2]
Cc: libc-alpha@sources.redhat.com
References: <200210231218.18733.roy@karlsbakk.net> <20021024125030.A7529@flint.arm.linux.org.uk> <200210241249.g9OCnOp09750@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200210241249.g9OCnOp09750@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_M8CJKWOO7ADE2Z7MBTJ3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_M8CJKWOO7ADE2Z7MBTJ3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

/me said:
> I'm experimenting with different csum_ routines in userspace now.

Short conclusion: 
1. It is possible to speed up csum routines for AMD processors by 30%.
2. It is possible to speed up csum_copy routines for both AMD and Intel
   three times or more. Roy, do you like that? ;)

Tests: they checksum 4MB block and csum_copy 2MB into second 2MB.
POISON=0/1 controls whether to perform correctness tests or not.
That slows down test very noticeably. What does glibc use for
memset/memcmp? for() loop?!!

With POISON=1 ntqpf2_copy bugs out, see its source. I left it in
to save repeating my work by others. BTW, i do NOT understand why
it does not work. ;) Anyone with cluebat?

IMHO the only way to make it optimal for all CPUs is to make these
functions race at kernel init and pick the best one.

tests on Celeron 1200 (100 MHz, x12 core)
=========================================
Csum benchmark program
buffer size: 4 Mb
Each test tried 16 times, max and min CPU cycles are reported.
Please disregard max values. They are due to system interference only.
csum tests:
                     kernel_csum - took   717 max,  704 min cycles per kb. sum=0x44000077
                     kernel_csum - took  4760 max,  704 min cycles per kb. sum=0x44000077
                     kernel_csum - took   722 max,  704 min cycles per kb. sum=0x44000077
                  kernelpii_csum - took   539 max,  528 min cycles per kb. sum=0x44000077
                kernelpiipf_csum - took   573 max,  529 min cycles per kb. sum=0x44000077
                        pfm_csum - took  1411 max, 1306 min cycles per kb. sum=0x44000077
                       pfm2_csum - took   875 max,  762 min cycles per kb. sum=0x44000077
copy tests:
                     kernel_copy - took  5738 max, 3423 min cycles per kb. sum=0x99aaaacc
                     kernel_copy - took  3517 max, 3431 min cycles per kb. sum=0x99aaaacc
                     kernel_copy - took  4385 max, 3432 min cycles per kb. sum=0x99aaaacc
                  kernelpii_copy - took  2912 max, 2752 min cycles per kb. sum=0x99aaaacc
                      ntqpf_copy - took  2010 max, 1700 min cycles per kb. sum=0x99aaaacc
                     ntqpfm_copy - took  1749 max, 1701 min cycles per kb. sum=0x99aaaacc
                        ntq_copy - took  2218 max, 2141 min cycles per kb. sum=0x99aaaacc
BAD copy! <-- ntqpf2_copy is buggy :) see its source
'copy tests' above are with POISON=1
These are with POISON=0:
                     kernel_copy - took  2009 max, 1935 min cycles per kb. sum=0x44000077
                     kernel_copy - took  2240 max, 1959 min cycles per kb. sum=0x44000077
                     kernel_copy - took  2197 max, 1936 min cycles per kb. sum=0x44000077
                  kernelpii_copy - took  2121 max, 1939 min cycles per kb. sum=0x44000077
                      ntqpf_copy - took   667 max,  548 min cycles per kb. sum=0x44000077
                     ntqpfm_copy - took   651 max,  546 min cycles per kb. sum=0x44000077
                        ntq_copy - took   660 max,  545 min cycles per kb. sum=0x44000077
                     ntqpf2_copy - took   644 max,  548 min cycles per kb. sum=0x44000077
Done

Tests on Duron 650 (100 MHz, x6,5 core)
=======================================
Csum benchmark program
buffer size: 4 Mb
Each test tried 16 times, max and min CPU cycles are reported.
Please disregard max values. They are due to system interference only.
csum tests:
                     kernel_csum - took  1090 max, 1051 min cycles per kb. sum=0x44000077
                     kernel_csum - took  1080 max, 1052 min cycles per kb. sum=0x44000077
                     kernel_csum - took  1178 max, 1058 min cycles per kb. sum=0x44000077
                  kernelpii_csum - took  1614 max, 1052 min cycles per kb. sum=0x44000077
                kernelpiipf_csum - took   976 max,  962 min cycles per kb. sum=0x44000077
                        pfm_csum - took   755 max,  746 min cycles per kb. sum=0x44000077
                       pfm2_csum - took   749 max,  745 min cycles per kb. sum=0x44000077
copy tests:
                     kernel_copy - took  1251 max, 1072 min cycles per kb. sum=0x99aaaacc
                     kernel_copy - took  1363 max, 1072 min cycles per kb. sum=0x99aaaacc
                     kernel_copy - took  1352 max, 1072 min cycles per kb. sum=0x99aaaacc
                  kernelpii_copy - took  1132 max, 1014 min cycles per kb. sum=0x99aaaacc
                      ntqpf_copy - took   514 max,  480 min cycles per kb. sum=0x99aaaacc
                     ntqpfm_copy - took   495 max,  482 min cycles per kb. sum=0x99aaaacc
                        ntq_copy - took  1153 max,  948 min cycles per kb. sum=0x99aaaacc
BAD copy! <-- ntqpf2_copy is buggy :) see its source
'copy tests' above are with POISON=1
These are with POISON=0:
                     kernel_copy - took  1145 max,  871 min cycles per kb. sum=0x44000077
                     kernel_copy - took   879 max,  871 min cycles per kb. sum=0x44000077
                     kernel_copy - took   876 max,  871 min cycles per kb. sum=0x44000077
                  kernelpii_copy - took  1019 max,  845 min cycles per kb. sum=0x44000077
                      ntqpf_copy - took  2972 max,  229 min cycles per kb. sum=0x44000077
                     ntqpfm_copy - took   248 max,  245 min cycles per kb. sum=0x44000077
                        ntq_copy - took   460 max,  452 min cycles per kb. sum=0x44000077
                     ntqpf2_copy - took   390 max,  340 min cycles per kb. sum=0x44000077
Done
--
vda
--------------Boundary-00=_M8CJKWOO7ADE2Z7MBTJ3
Content-Type: application/x-bzip2;
  name="timing_csum_copy.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="timing_csum_copy.tar.bz2"

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

--------------Boundary-00=_M8CJKWOO7ADE2Z7MBTJ3--
