Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265737AbUGHBgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265737AbUGHBgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 21:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUGHBgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 21:36:24 -0400
Received: from av9-1-sn4.m-sp.skanova.net ([81.228.10.108]:27034 "EHLO
	av9-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S265737AbUGHBgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 21:36:21 -0400
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Can't make use of swap memory in 2.6.7-bk19
From: Peter Osterlund <petero2@telia.com>
Date: 08 Jul 2004 03:36:10 +0200
Message-ID: <m2brir9t6d.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I created a test program that allocates a 300MB buffer and writes to
all bytes sequentially. On my computer, which has 256MB RAM and 512MB
swap, the program gets OOM killed after dirtying about 140-180MB, and
the kernel reports:

Out of Memory: Killed process 3421 (memalloc2).

I ran "vmstat 1" during the test:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0  89844 130624    676  22036  107  296   635   329 1214   452  4  3 63 30
 0  0  89844 130608    692  22036    0    0     0    72 1164   504  3  1 96  0
 0  0  89844 130608    692  22036    0    0     0     0 1067   256  0  0 100  0
 0  0  89844 130608    692  22036    0    0     0     0 1066   248  0  0 100  0
 2  1  99864   2576     80  10016    0    0     8     0 1065  1052 42 41 15  2
[~10s delay here, then all lines below are displayed very quickly]
 0 12 249332   2216    108   5304  164 19440  5280 19440 3572   846  1 24  0 75
 0 11 249332   1992    124   7028  152  372  2620   372 1167   221  0  2  0 98
 0 16  95972 145548    196   8668  216  508  1908   540 1165   248  0  3  0 97
 0 12  95972 143160    228  11124  120    0  2616     0 1184   249  0  1  0 99
 0  8  95972 141040    240  13136  208    0  2236     0 1167   263  0  1  0 99
 0  4  95972 139448    248  14464  252    0  1588     0 1168   248  1  2  0 97
 0  0  95924 138412    260  15400  184    0  1080     8 1187   259  2  0 11 87

"free" directly afterwards:

             total       used       free     shared    buffers     cached
Mem:        255460     119304     136156          0        332      17892
-/+ buffers/cache:     101080     154380
Swap:       530136      89916     440220

I tried setting swappiness to 0, 50, 100, tried changing
overcommit_memory, added an extra 300MB swap file, but I was still not
able to make the test program succeed.

I see this problem using 2.6.7-bk19. I haven't tried other 2.6
kernels, but 2.4.27-rc2 doesn't show the problem.

Here is the test program:

#include <stdio.h>
#include <stdlib.h>

#define MB (1024 * 1024)
#define SIZE (300 * MB)

int main()
{
    int i;
    char *ptr;

    ptr = malloc(SIZE);
    for (i = 0; i < SIZE; i++) {
	ptr[i] = i;
	if ((i % MB) == 0)
	    printf("%d\n", i / MB);
    }
    return 0;
}

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
