Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbTGBWwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbTGBWwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:52:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:47862 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264896AbTGBWvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:51:06 -0400
Date: Wed, 02 Jul 2003 15:53:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>, Bill Irwin <wli@holomorphy.com>,
       haveblue@us.ibm.com
Subject: Overhead of highpte
Message-ID: <574790000.1057186404@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people were saying they couldn't see an overhead with highpte.
Seems pretty obvious to me still. It should help *more* on the NUMA
box, as PTEs become node-local.

The kmap_atomic is, of course, perfectly understandable. The increase
in the rmap functions is a bit of a mystery to me.

M.

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
               2.5.73-mm3       45.38      114.91      565.81     1497.75
       2.5.73-mm3-highpte       46.54      130.41      566.84     1498.00

(note system time)

      1480     9.1% total
      1236    52.7% page_remove_rmap
       113    18.5% page_add_rmap
        90   150.0% kmap_atomic
        89    54.6% kmem_cache_free
        45    15.0% zap_pte_range
        37     0.0% kmap_atomic_to_page
        28    87.5% __pte_chain_free
        26   216.7% kunmap_atomic
        17    13.4% release_pages
        12    10.5% file_move
        11    42.3% filemap_nopage
        10    13.7% handle_mm_fault
...
       -10   -16.1% generic_file_open
       -10    -5.2% atomic_dec_and_lock
       -13    -2.4% __copy_to_user_ll
       -13    -3.7% find_get_page
       -13    -7.0% path_lookup
       -21    -2.6% __d_lookup
       -36   -78.3% page_address
       -49   -74.2% pte_alloc_one
      -104    -2.2% default_idle


SDET 32  (see disclaimer)
                           Throughput    Std. Dev
               2.5.73-mm3       100.0%         0.8%
       2.5.73-mm3-highpte        95.3%         0.1%


(highpte hung above 32 load).

       971     5.5% total
       399     3.9% default_idle
       329    23.1% page_remove_rmap
       124    15.6% page_add_rmap
       119    94.4% kmem_cache_free
        39   205.3% kmap_atomic
        24     9.8% release_pages
        21   131.2% __pte_chain_free
        15  1500.0% kmap_atomic_to_page
        13    76.5% __kmalloc
        11   183.3% kunmap_atomic
...
       -10   -35.7% __copy_from_user_ll
       -10    -3.9% find_get_page
       -16   -11.7% .text.lock.filemap
       -16   -45.7% page_address
       -16   -18.2% atomic_dec_and_lock
       -40   -74.1% pte_alloc_one

