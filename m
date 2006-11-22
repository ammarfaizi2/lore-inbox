Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756965AbWKVHvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756965AbWKVHvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 02:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756966AbWKVHvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 02:51:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:9013 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756967AbWKVHvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 02:51:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=hiWSe86pcOT+qOqL8OprxOkw61VZCgWFUKvztw/88/AUhhBUFkit0Y2g7n6p8PCL6uFt1NYP23DogUObGrHEVgqsWlLuLXKu8Zh0L1dKDBpOThARBo+jZcNY3sl+m90b2aYTuRLq8FL7xUjuAUOCfd3mn6lDp7+2HEDSG40vgWQ=
Message-ID: <6d6a94c50611212351if1701ecx7b89b3fe79371554@mail.gmail.com>
Date: Wed, 22 Nov 2006 15:51:06 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: The VFS cache is not freed when there is not enough free memory to allocate
Cc: linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_67747_12127413.1164181866877"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_67747_12127413.1164181866877
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

We are working on the blackfin uClinux platform and we encountered the
following problem.
The attached patch can work around this issue and I post it here to
find better solution.

Here is a test application:
---------------------------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#define N 8

int main (void){
        void *p[N];
        int i;

        printf("Alloc %d MB !\n", N);

        for (i = 0; i < N; i++) {
                p[i] = malloc(1024 * 1024);
                if (p[i] == NULL)
                        printf("alloc failed\n");
        }

                printf("alloc successful \n");
        for (i = 0; i < N; i++)
                free(p[i]);
}

When there is not enough free memory to allocate:
==============================
root:/mnt> cat /proc/meminfo
MemTotal:        54196 kB
MemFree:          5520 kB <== only 5M free
Buffers:            76 kB
Cached:          44696 kB <== cache eat 40MB
SwapCached:          0 kB
Active:          21092 kB
Inactive:        23680 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        54196 kB
LowFree:          5520 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
AnonPages:           0 kB
Mapped:              0 kB
Slab:             3720 kB
PageTables:          0 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     27096 kB
Committed_AS:        0 kB
VmallocTotal:        0 kB
VmallocUsed:         0 kB
VmallocChunk:        0 kB
==========================================

I run the test application and get the following message:
---------------------------------------
root:/mnt> ./t
Alloc 8 MB !
t: page allocation failure. order:9, mode:0x40d0
Hardware Trace:
 0 Target : <0x00004de0> { _dump_stack + 0x0 }
   Source : <0x0003054a> { ___alloc_pages + 0x17e }
 1 Target : <0x0003054a> { ___alloc_pages + 0x17e }
   Source : <0x0000dbc2> { _printk + 0x16 }
 2 Target : <0x0000dbbe> { _printk + 0x12 }
   Source : <0x0000da4e> { _vprintk + 0x1a2 }
 3 Target : <0x0000da42> { _vprintk + 0x196 }
   Source : <0xffa001ea> { __common_int_entry + 0xd8 }
 4 Target : <0xffa00188> { __common_int_entry + 0x76 }
   Source : <0x000089bc> { _return_from_int + 0x58 }
 5 Target : <0x000089bc> { _return_from_int + 0x58 }
   Source : <0x00008992> { _return_from_int + 0x2e }
 6 Target : <0x00008964> { _return_from_int + 0x0 }
   Source : <0xffa00184> { __common_int_entry + 0x72 }
 7 Target : <0xffa00182> { __common_int_entry + 0x70 }
   Source : <0x00012682> { __local_bh_enable + 0x56 }
 8 Target : <0x0001266c> { __local_bh_enable + 0x40 }
   Source : <0x0001265c> { __local_bh_enable + 0x30 }
 9 Target : <0x00012654> { __local_bh_enable + 0x28 }
   Source : <0x00012644> { __local_bh_enable + 0x18 }
10 Target : <0x0001262c> { __local_bh_enable + 0x0 }
   Source : <0x000128e0> { ___do_softirq + 0x94 }
11 Target : <0x000128d8> { ___do_softirq + 0x8c }
   Source : <0x000128b8> { ___do_softirq + 0x6c }
12 Target : <0x000128aa> { ___do_softirq + 0x5e }
   Source : <0x0001666a> { _run_timer_softirq + 0x82 }
13 Target : <0x000165fc> { _run_timer_softirq + 0x14 }
   Source : <0x00023eb8> { _hrtimer_run_queues + 0xe8 }
14 Target : <0x00023ea6> { _hrtimer_run_queues + 0xd6 }
   Source : <0x00023e70> { _hrtimer_run_queues + 0xa0 }
15 Target : <0x00023e68> { _hrtimer_run_queues + 0x98 }
   Source : <0x00023eae> { _hrtimer_run_queues + 0xde }
Stack from 015a7dcc:
        00000001 0003054e 00000000 00000001 000040d0 0013c70c 00000009 000040d0
        00000000 00000080 00000000 000240d0 00000000 015a6000 015a6000 015a6000
        00000010 00000000 00000001 00036e12 00000000 0023f8e0 00000073 00191e40
        00000020 0023e9a0 000040d0 015afea9 015afe94 00101fff 000040d0 0023e9a0
        00000010 00101fff 000370de 00000000 0363d3e0 00000073 0000ffff 04000021
        00000000 00101000 00187af0 00035b44 00000000 00035e40 00000000 00000000
Call Trace:
[<0000fffe>] _do_exit+0x12e/0x7cc
[<00004118>] _sys_mmap+0x54/0x98
[<00101000>] _fib_create_info+0x670/0x780
[<00008828>] _system_call+0x68/0xba
[<000040c4>] _sys_mmap+0x0/0x98
[<0000fffe>] _do_exit+0x12e/0x7cc
[<00008000>] _cplb_mgr+0x8/0x2e8
[<00101000>] _fib_create_info+0x670/0x780
[<00101000>] _fib_create_info+0x670/0x780

Mem-info:
DMA per-cpu:
cpu 0 hot: high 18, batch 3 used:5
cpu 0 cold: high 6, batch 1 used:5
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:       21028kB (0kB HighMem)
Active:2549 inactive:3856 dirty:0 writeback:0 unstable:0 free:5257
slab:1833 mapped:0 pagetables:0
DMA free:21028kB min:948kB low:1184kB high:1420kB active:10196kB
inactive:15424kB present:56320kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 43*4kB 35*8kB 28*16kB 17*32kB 18*64kB 20*128kB 16*256kB 11*512kB
6*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB 0*32768kB = 21028kB
DMA32: empty
Normal: empty
HighMem: empty
14080 pages of RAM
5285 free pages
531 reserved pages
11 pages shared
0 pages swap cached
Allocation of length 1052672 from process 57 failed
DMA per-cpu:
cpu 0 hot: high 18, batch 3 used:5
cpu 0 cold: high 6, batch 1 used:5
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:       21028kB (0kB HighMem)
Active:2549 inactive:3856 dirty:0 writeback:0 unstable:0 free:5257
slab:1833 mapped:0 pagetables:0
DMA free:21028kB min:948kB low:1184kB high:1420kB active:10196kB
inactive:15424kB present:56320kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 43*4kB 35*8kB 28*16kB 17*32kB 18*64kB 20*128kB 16*256kB 11*512kB
6*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB 0*32768kB = 21028kB
DMA32: empty
Normal: empty
HighMem: empty
-----------------------------

When there is no enough free memory, kernel crash instead of freeing VFS cache,
no matter how big the value of /proc/sys/vm/vfs_cache_pressure is set.

Here is my patch,
=====================================
>From a8a03f1fed672cc310feb3f5fafdc9e0e7a6546f Mon Sep 17 00:00:00 2001
From: Aubrey.Li <aubrey.li@analog.com>
Date: Wed, 22 Nov 2006 15:10:18 +0800
Subject: [PATCH] Drop VFS cache when there is not enough free memory to allocate

Signed-off-by: Aubrey.Li <aubrey.li@analog.com>
---
 mm/page_alloc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bf2f6cf..62559fd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1039,6 +1039,11 @@ restart:
        if (page)
                goto got_pg;

+#if defined(CONFIG_EMBEDDED) && !defined(CONFIG_MMU)
+       drop_pagecache();
+       drop_slab();
+#endif
+
        /* This allocation should allow future memory freeing. */

        if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
--
1.4.2
========================================

The patch drop the page cache and slab and then give a new chance to
get more free pages. Applied this patch, my test application can
allocate memory sucessfully and drop the cache and slab as well. See
below:
================================
root:/mnt> ./t
Alloc 8 MB !
alloc successful
root:/mnt> cat /proc/meminfo
MemTotal:        54196 kB
MemFree:         43684 kB
Buffers:            36 kB
Cached:            440 kB
SwapCached:          0 kB
Active:             32 kB
Inactive:          432 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        54196 kB
LowFree:         43684 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               8 kB
Writeback:           0 kB
AnonPages:           0 kB
Mapped:              0 kB
Slab:             9812 kB
PageTables:          0 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     27096 kB
Committed_AS:        0 kB
VmallocTotal:        0 kB
VmallocUsed:         0 kB
VmallocChunk:        0 kB
=============================

I know performance is important for linux, and VFS cache obviously
improve the performance when implement file operation. But for
embedded system, we'll try our best to make the application executable
rather than hanging system to guarantee the system performance.

Any suggestions and solutions are really appreciated!

Thanks,
-Aubrey

------=_Part_67747_12127413.1164181866877
Content-Type: text/plain; name="0001-Drop-VFS-cache-when-there-is-not-enough-free-memory-to-allocate.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Drop-VFS-cache-when-there-is-not-enough-free-memory-to-allocate.txt"
X-Attachment-Id: f_eutggk2u

RnJvbSBhOGEwM2YxZmVkNjcyY2MzMTBmZWIzZjVmYWZkYzllMGU3YTY1NDZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBdWJyZXkuTGkgPGF1YnJleUBTVVNFMTAuQU5BTE9HPgpEYXRl
OiBXZWQsIDIyIE5vdiAyMDA2IDE1OjEwOjE4ICswODAwClN1YmplY3Q6IFtQQVRDSF0gRHJvcCBW
RlMgY2FjaGUgd2hlbiB0aGVyZSBpcyBub3QgZW5vdWdoIGZyZWUgbWVtb3J5IHRvIGFsbG9jYXRl
CgpTaWduZWQtb2ZmLWJ5OiBBdWJyZXkuTGkgPGF1YnJleUBTVVNFMTAuQU5BTE9HPgotLS0KIG1t
L3BhZ2VfYWxsb2MuYyB8ICAgIDUgKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL3BhZ2VfYWxsb2MuYyBiL21tL3Bh
Z2VfYWxsb2MuYwppbmRleCBiZjJmNmNmLi42MjU1OWZkIDEwMDY0NAotLS0gYS9tbS9wYWdlX2Fs
bG9jLmMKKysrIGIvbW0vcGFnZV9hbGxvYy5jCkBAIC0xMDM5LDYgKzEwMzksMTEgQEAgcmVzdGFy
dDoKIAlpZiAocGFnZSkKIAkJZ290byBnb3RfcGc7CiAKKyNpZiBkZWZpbmVkKENPTkZJR19FTUJF
RERFRCkgJiYgIWRlZmluZWQoQ09ORklHX01NVSkKKwlkcm9wX3BhZ2VjYWNoZSgpOworCWRyb3Bf
c2xhYigpOworI2VuZGlmCisKIAkvKiBUaGlzIGFsbG9jYXRpb24gc2hvdWxkIGFsbG93IGZ1dHVy
ZSBtZW1vcnkgZnJlZWluZy4gKi8KIAogCWlmICgoKHAtPmZsYWdzICYgUEZfTUVNQUxMT0MpIHx8
IHVubGlrZWx5KHRlc3RfdGhyZWFkX2ZsYWcoVElGX01FTURJRSkpKQotLSAKMS40LjIKCg==
------=_Part_67747_12127413.1164181866877--
