Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267219AbUHOW7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267219AbUHOW7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267214AbUHOW7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:59:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:20405 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267198AbUHOW7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:59:09 -0400
Date: Sun, 15 Aug 2004 15:58:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "David S. Miller" <davem@redhat.com>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte locks?
In-Reply-To: <20040815130919.44769735.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <20040815130919.44769735.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2004, David S. Miller wrote:

>
> Is the read lock in the VMA semaphore enough to let you do
> the pgd/pmd walking without the page_table_lock?
> I think it is, but just checking.

That would be great.... May I change the page_table lock to
be a read write spinlock instead?

I would then convert all spin_locks to write_locks and
then use read locks to switch to a "pte locking mode". The read
lock would allow simultanous threads operating on the page table
that will only modify individual pte's via pte locks. Write locks
still exclude the readers and thus the whole scheme should allow
a gradual transition.

Maybe such a locking policy could do some good.

However, performance is only increased somewhat. Scalability
is still bad with more than 32 CPUs despite my hack. More
extensive work is needed <sigh>:

Regular kernel 512 CPU's 16G allocation per thread:

 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 16   3    1    0.748s     67.200s  67.098s 46295.921  46270.533
 16   3    2    0.899s    100.189s  52.021s 31118.426  60242.544
 16   3    4    1.517s    103.467s  31.021s 29963.479 100777.788
 16   3    8    1.268s    166.023s  26.035s 18803.807 119350.434
 16   3   16    6.296s    453.445s  33.082s  6842.371  92987.774
 16   3   32   22.434s   1341.205s  48.026s  2306.860  65174.913
 16   3   64   54.189s   4633.748s  81.089s   671.026  38411.466
 16   3  128  244.333s  17584.111s 152.026s   176.444  20659.132
 16   3  256  222.936s   8167.241s  73.018s   374.930  42983.366
 16   3  512  207.464s   4259.264s  39.044s   704.258  79741.366

Modified kernel:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 16   3    1    0.884s     64.241s  65.014s 48302.177  48287.787
 16   3    2    0.931s     99.156s  51.058s 31429.640  60979.126
 16   3    4    1.028s     88.451s  26.096s 35155.837 116669.999
 16   3    8    1.957s     61.395s  12.099s 49654.307 242078.305
 16   3   16    5.701s     81.382s   9.039s 36122.904 334774.381
 16   3   32   15.207s    163.893s   9.094s 17564.021 316284.690
 16   3   64   76.056s    440.771s  13.037s  6086.601 235120.800
 16   3  128  203.843s   1535.909s  19.084s  1808.145 158495.679
 16   3  256  274.815s    755.764s  12.058s  3052.387 250010.942
 16   3  512  205.505s    381.106s   7.060s  5362.531 413531.352


