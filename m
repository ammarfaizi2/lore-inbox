Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTHXQzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 12:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTHXQzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 12:55:40 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:59112 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261338AbTHXQze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 12:55:34 -0400
Date: Sun, 24 Aug 2003 09:55:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy
Message-ID: <29760000.1061744102@[10.10.2.4]>
In-Reply-To: <3F48B12F.4070001@cyberone.com.au>
References: <3F48B12F.4070001@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to do badly with CPU intensive tasks:

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
              2.6.0-test3       46.00      115.49      571.94     1494.25
         2.6.0-test4-nick       49.37      131.31      611.15     1500.75

Oddly, schedule itself is significantly cheaper, but you seem
to end up with much more expense elsewhere. Thrashing tasks between
CPUs, maybe (esp given the increased user time)? I'll do a proper 
baseline against test4, but I don't expect it to be any different, really.

diffprofile {2.6.0-test3,2.6.0-test4-nick}/kernbench/0/profile
     12314     7.4% total
      3843    16.3% page_remove_rmap
      1657    20.8% __d_lookup
      1322     9.4% do_anonymous_page
      1143    21.5% __copy_to_user_ll
      1034    55.3% atomic_dec_and_lock
       683    48.4% free_hot_cold_page
       669   393.5% filp_close
       553   147.5% .text.lock.file_table
       484   479.2% file_ra_state_init
       409    24.3% buffered_rmqueue
       391    24.9% kmem_cache_free
       362    11.3% zap_pte_range
       304    16.5% path_lookup
       247    31.5% pte_alloc_one
       237    68.3% pgd_ctor
       229    19.0% file_move
       224    16.7% link_path_walk
       220    57.7% file_kill
       188     7.9% do_no_page
       164    24.6% __wake_up
       162     4.4% find_get_page
       146    24.4% generic_file_open
       141    87.6% .text.lock.dcache
       139    11.5% release_pages
       131    51.4% vfs_read
       127    40.2% dnotify_parent
...
      -144    -4.2% __copy_from_user_ll
      -149    -2.3% page_add_rmap
      -352   -25.1% schedule
     -3469    -6.8% default_idle

