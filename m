Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263181AbSJ1ITJ>; Mon, 28 Oct 2002 03:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSJ1ITJ>; Mon, 28 Oct 2002 03:19:09 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:63244 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263181AbSJ1ITG>; Mon, 28 Oct 2002 03:19:06 -0500
Message-Id: <200210280819.g9S8Jfp25782@Port.imtp.ilyichevsk.odessa.ua>
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Momchil Velikov <velco@fadata.bg>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: New csum and csum_copy routines - and a test/benchmark program
Date: Mon, 28 Oct 2002 11:12:01 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1O0PKCL9EBHICL9OPYT1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_1O0PKCL9EBHICL9OPYT1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I took some time to develop a little test/benchmark program
for csum and csum_copy routines (used in networking).
It has grown to include following features:

* Total buffer size #define-selectable, hence you can measure
  cache-hot and cache-cold performance.

* It does not simply checksum entire buffer, you can do it in 'chunks'.
  Chunk size is a #define too. Chunk order is randomized for eash run
  (this is done to stop fooling us with prefetch from prev chunk to next).
  But you are guaranteed to walk entire buffer.

* Buffer contents are randomized at each run. Csum correctness is checked.

* Buffer copy correctness verified for csum_copy.

* You can set random (up to a #defined value) start and end offset for each
  chunk. Gaps are poisoned before each csum_copy and verified afterwards.
  This has already caught two bugs.

* It benchmarks each routine by running it #defined number of times
  and reporting min/max cycles per kb taken.

* It is easy to add/remove C and asm test routines.

* Easily adaptable for SSE and MMX instruction sets.

* It can make coffee for you. ;)

I'm thinking on how to collect 2-5 best routines and
make 'em compete at kernel init time for the right
to be used for blazing network performance, but did not
even start to code this. Similar approach can be taken
for page clear/copy and copy to/from user routines.

Election of 'best' routine by lkml posts is:
1. Slow
2. Doesn't fit given combination of CPU/mem/mobo
so do _not_ send your results to lkml unless you think
you found something interesting.

FYI, my last results below. kpf_XXX routines are newest'n'greatest.
I found out to my surprize that shortening unrolled loop
on Duron has positive effect.

Coders with 'prefetchless' CPUs are encouraged to write up
their own versions of prefetch-like routines (you may use
mov [mem],reg as a prefetch in the hopes CPU will reorder
instructions and will happily csum older data while such mov
is waiting for data to be fetched. But this needs testing.
That's what this program is for! :-)
--
vda

Duron 650
=========
Csum benchmark program
buffer size: 4 Mb
Each test tried 32 times, max and min CPU cycles are reported.
Please disregard max values. They are due to system interference only.
csum tests:
                     kernel_csum - took  2612 max, 1887 min cycles per kb. sum=0xfad28968
                     kernel_csum - took  2654 max, 1887 min cycles per kb. sum=0xfad28968
                     kernel_csum - took  2105 max, 1887 min cycles per kb. sum=0xfad28968
                    kernel2_csum - took  2636 max, 1925 min cycles per kb. sum=0xfad28968
                  kernelpii_csum - took 11879 max, 1735 min cycles per kb. sum=0xaeffd53b
                kernelpiipf_csum - took  2565 max, 1642 min cycles per kb. sum=0xaeffd53b
                        kpf_csum - took  1280 max, 1037 min cycles per kb. sum=0xaeffd53b
                        kpf_csum - took  1298 max, 1037 min cycles per kb. sum=0xaeffd53b
                        kpf_csum - took  1285 max, 1035 min cycles per kb. sum=0xaeffd53b
                        kpf_csum - took  1893 max, 1037 min cycles per kb. sum=0xaeffd53b
copy tests:
                     kernel_copy - took  5812 max, 4854 min cycles per kb. sum=0xfad28968
                     kernel_copy - took  5741 max, 4854 min cycles per kb. sum=0xfad28968
                     kernel_copy - took 17680 max, 4859 min cycles per kb. sum=0xfad28968
                  kernelpii_copy - took  7204 max, 6381 min cycles per kb. sum=0xe3bca07e
                kernelpiipf_copy - took  8429 max, 7477 min cycles per kb. sum=0xe3bca07e
                        kpf_copy - took 12806 max, 2471 min cycles per kb. sum=0xfad28968
                        kpf_copy - took  3181 max, 2470 min cycles per kb. sum=0xfad28968
                        kpf_copy - took  3327 max, 2471 min cycles per kb. sum=0xfad28968
                        kpf_copy - took 11967 max, 2471 min cycles per kb. sum=0xfad28968
Done

Celeron 1200
============
Csum benchmark program
buffer size: 4 Mb
Each test tried 32 times, max and min CPU cycles are reported.
Please disregard max values. They are due to system interference only.
csum tests:
                     kernel_csum - took  7368 max, 6833 min cycles per kb. sum=0x291132e0
                     kernel_csum - took  9038 max, 6845 min cycles per kb. sum=0x291132e0
                     kernel_csum - took  7112 max, 6836 min cycles per kb. sum=0x291132e0
                    kernel2_csum - took  7254 max, 6871 min cycles per kb. sum=0x291132e0
                  kernelpii_csum - took  4696 max, 4109 min cycles per kb. sum=0x484713aa
                kernelpiipf_csum - took  4715 max, 4271 min cycles per kb. sum=0x484713aa
                        kpf_csum - took  3295 max, 2780 min cycles per kb. sum=0x484713aa
                        kpf_csum - took  3091 max, 2793 min cycles per kb. sum=0x484713aa
                        kpf_csum - took 14580 max, 2833 min cycles per kb. sum=0x484713aa
                        kpf_csum - took  3292 max, 2833 min cycles per kb. sum=0x484713aa
copy tests:
                     kernel_copy - took 13927 max,13450 min cycles per kb. sum=0x291132e0
                     kernel_copy - took 14009 max,13406 min cycles per kb. sum=0x291132e0
                     kernel_copy - took 13957 max,13447 min cycles per kb. sum=0x291132e0
                  kernelpii_copy - took 15039 max,11335 min cycles per kb. sum=0x5474077d
                kernelpiipf_copy - took 14137 max,13059 min cycles per kb. sum=0x5474077d
                        kpf_copy - took  8226 max, 7857 min cycles per kb. sum=0x291132e0
                        kpf_copy - took 20698 max, 7886 min cycles per kb. sum=0x291132e0
                        kpf_copy - took  8504 max, 7897 min cycles per kb. sum=0x291132e0
                        kpf_copy - took  8245 max, 7893 min cycles per kb. sum=0x291132e0
Done

--------------Boundary-00=_1O0PKCL9EBHICL9OPYT1
Content-Type: application/x-bzip2;
  name="timing_csum_copy.3.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="timing_csum_copy.3.tar.bz2"

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

--------------Boundary-00=_1O0PKCL9EBHICL9OPYT1--
