Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266160AbUFIPX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266160AbUFIPX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUFIPX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:23:27 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:64486 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S266160AbUFIPXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:23:22 -0400
Message-ID: <40C72B68.1030404@metaparadigm.com>
Date: Wed, 09 Jun 2004 23:23:20 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040528 Debian/1.6-7
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in ide
References: <20040609122921.GG21168@wohnheim.fh-wedel.de>
In-Reply-To: <20040609122921.GG21168@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorn,

Noticed that try_to_free_pages, sync_inodes_sb and wakeup_bdflush features
in almost all of these traces and although at 284, 308 and 256 respectively
their not huge but together their neither that small (considering they
occur all in the same stack trace).

This is consumed mostly by a struct page_state which is 148 bytes big
although looking at the code get_page_state(struct page_state *ret)
only populates the first 6 fields or 24 bytes. get_full_page_state
which is hardly used updates these other fields.

Is this a candidate for splitting into 2 structs? 1 containing just the
first 6 fields needed by the majority of users: try_to_free_pages,
shrink_all_memory, kswapd, get_dirty_limits, wakeup_bdflush, sync_inodes_sb

mclark@monty:/usr/src/linux$ find . -name '*.c' | xargs grep get_page_state
./fs/proc/proc_misc.c:  get_page_state(&ps);
./fs/fs-writeback.c:    get_page_state(&ps);
./mm/page_alloc.c:void __get_page_state(struct page_state *ret, int nr)
./mm/page_alloc.c:void get_page_state(struct page_state *ret)
./mm/page_alloc.c:      __get_page_state(ret, nr + 1);
./mm/page_alloc.c:      __get_page_state(ret, sizeof(*ret) / sizeof(unsigned long));
./mm/page_alloc.c:      get_page_state(&ps);
./mm/vmscan.c:          get_page_state(&ps);
./mm/vmscan.c:          get_page_state(&ps);
./mm/vmscan.c:          get_page_state(&ps);
./mm/page-writeback.c:  get_page_state(ps);
./mm/page-writeback.c: * On really big machines, get_page_state is expensive, so try to avoid calling
./mm/page-writeback.c:          get_page_state(&ps);
./mm/page-writeback.c:  get_page_state(&ps);
./mm/page-writeback.c: * If it is too low then SMP machines will call the (expensive) get_page_state

mclark@monty:/usr/src/linux$ find . -name '*.c' | xargs grep get_full_page_state
./drivers/parisc/led.c: get_full_page_state(&pgstat); /* get no of sectors in & out */
./arch/s390/appldata/appldata_base.c:void get_full_page_state(struct page_state *ps)
./arch/s390/appldata/appldata_base.c:EXPORT_SYMBOL_GPL(get_full_page_state);
./arch/s390/appldata/appldata_mem.c:    get_full_page_state(&ps);
./mm/page_alloc.c:void get_full_page_state(struct page_state *ret)
./mm/page_alloc.c:      get_full_page_state(ps);

~mc

On 06/09/04 20:29, Jörn Engel wrote:
> Bartlomiej, can you put ide_config on a diet?
> 
> stackframes for call path too long (3052):
>     size  function
>        0  client_reg_t->event_handler
>     1168  ide_config
>       12  ide_register_hw
>       44  ide_unregister
>       12  ide_unregister_subdriver
>        0  pnpide_init
>        0  pnp_register_driver
>        0  driver_register
>       20  bus_add_driver
>       16  driver_attach
>       72  tty_register_device
>        0  class_simple_device_add
>        0  class_device_register
>       16  class_device_add
>        0  kobject_add
>        0  kobject_hotplug
>      132  call_usermodehelper
>       80  wait_for_completion
>       84  schedule
>       16  __put_task_struct
>       20  audit_free
>       36  audit_log_start
>       16  __kmalloc
>        0  __get_free_pages
>       28  __alloc_pages
>      284  try_to_free_pages
>        0  out_of_memory
>        0  mmput
>       16  exit_aio
>        0  __put_ioctx
>       16  do_munmap
>        0  split_vma
>       36  vma_adjust
>        0  fput
>        0  __fput
>        0  locks_remove_flock
>       12  panic
>        0  sys_sync
>        0  sync_inodes
>      308  sync_inodes_sb
>        0  do_writepages
>      128  mpage_writepages
>        4  write_boundary_block
>        0  ll_rw_block
>       28  submit_bh
>        0  bio_alloc
>       88  mempool_alloc
>      256  wakeup_bdflush
>       20  pdflush_operation
>        0  printk
>        0  preempt_schedule
>       84  schedule
> 
> Jörn
> 

-- 
Michael Clark,  . . . . . . . . . . . .  michael@metaparadigm.com
Managing Director,  . . . . . . . . . http://www.metaparadigm.com
Metaparadigm Pte. Ltd.  . . . . . . . . . .  phone: +65 6395 6277
25F Paterson Road,  . . . . . . . . . . . . mobile: +65 9645 9612
Singapore 238515  . . . . . . . . . . . . . .  fax: +65 6234 4043
