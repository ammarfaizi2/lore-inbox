Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSHTW04>; Tue, 20 Aug 2002 18:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSHTW04>; Tue, 20 Aug 2002 18:26:56 -0400
Received: from p020.as-l031.contactel.cz ([212.65.234.212]:25472 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S317468AbSHTW0z>;
	Tue, 20 Aug 2002 18:26:55 -0400
Date: Wed, 21 Aug 2002 00:28:59 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: riel@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Kernel BUG in try_to_free_buffers
Message-ID: <20020820222859.GC34144@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,
  today I stressed my current 2.5.31-bk489 a bit, and kswapd
was killed by kernel bug in spinlock.h at line 123, where
spinlock signature is checked. Stack trace was

  try_to_free_buffers
  try_to_release_page
  shrink_list
  shrink_dcache
  kmem_cache_reap
  shrink_caches
  try_to_free_pages
  kswap_balance_pgdat
  kswap_balance

In try_to_free_buffers it died in spin_lock(&mapping->private_lock)
(fs/buffers.c, line 2487). Because of I did not found any code
path which does not initalize mapping's private_lock, I assume
that bug was triggered by asm-generic/rmap.h:pgtable_add_rmap - this
code assigns mm_struct into page's mapping field, and maybe that
such page was passed down to try_to_release_page and everything
went downhill...

Unfortunately my kernel does not have kdb, and 'gdb vmlinux /proc/kcore'
after some time revealed that mapping contents is neither address_space 
nor mm_struct (first two fields of structure contained pointer to the 
beginning of structure itself, like if structure begins with empty list_t, 
and neither of address_space nor mm_struct begins with such field).

Of course it is also possible that mapping was simple released and
memory was reused before all pages using it were destroyed, but I hope that
we do not have such problem in kernel.

System was running XFree, bk export -tplain and diff -urN kernel-tree-1 kernel-tree-2
when BUG happened. Filesystem is ext2, but XFree use also shm. 384MB RAM,
UP system running non-preemptible SMP kernel. After BUG system worked fine 
(for hours), only kswapd was zombie.

BTW, mapping was 0xd7c6ecdc. 
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz
