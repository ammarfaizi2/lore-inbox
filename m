Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSIWUQL>; Mon, 23 Sep 2002 16:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSIWUQL>; Mon, 23 Sep 2002 16:16:11 -0400
Received: from packet.digeo.com ([12.110.80.53]:52620 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261353AbSIWUQJ>;
	Mon, 23 Sep 2002 16:16:09 -0400
Message-ID: <3D8F77B4.A8B9DDC4@digeo.com>
Date: Mon, 23 Sep 2002 13:21:08 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38bk2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Sleeping function called from illegal context at slab.c:1378
References: <3D8F5DB2.A3E36E16@digeo.com> <1032811220.28332.24.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 20:21:11.0808 (UTC) FILETIME=[C242E000:01C2633E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> ...
> I guess that traced warning was of interest, so here are two
> more from 2.5.38-mm2.

Well this is fun.
 
> 
> Trace; c0119986 <__might_sleep+56/5d>
> Trace; c0135166 <kmalloc+66/1f0>
> Trace; c0120048 <__request_region+18/c0>
> Trace; c0215ca2 <eata2x_detect+142/d60>
> Trace; c02037a4 <ahc_linux_alloc_device+14/70>
> Trace; c020298c <ahc_linux_queue+16c/1a0>
> Trace; c0117c71 <schedule+351/3e0>
> Trace; c01f1c6a <scsi_request_fn+13a/450>
> Trace; c0117fe2 <wait_for_completion+b2/110>
> Trace; c01f149d <scsi_queue_next_request+5d/140>
> Trace; c01ea9da <scsi_release_command+13a/150>
> Trace; c013432d <kmem_slab_destroy+dd/110>
> Trace; c0134f07 <free_block+b7/120>
> Trace; c013533a <kmem_cache_free+4a/80>
> Trace; c01c7b43 <elevator_exit+13/20>
> Trace; c01f3c06 <scan_scsis+96/a0>
> Trace; c01ec218 <scsi_register_host+48/340>
> Trace; c01b0133 <put_bus+13/57>
> Trace; c01050b1 <init+51/1d0>
> Trace; c0105060 <init+0/1d0>
> Trace; c01070b9 <kernel_thread_helper+5/c>
> 

eata2x_detect() calls port_detect() under driver_lock.
port_detect() calls request_region(), which can sleep.

> 
> Trace; c0119986 <__might_sleep+56/5d>
> Trace; c0135166 <kmalloc+66/1f0>
> Trace; c0271e03 <convert_ipfw+63/130>
> Trace; c027216a <ip_fw_ctl+29a/4d0>
> Trace; c017ab91 <ext3_reserve_inode_write+31/b0>
> Trace; c026a023 <sock_fn+63/80>
> Trace; c012ff2e <find_get_page+2e/60>
> Trace; c0130db5 <filemap_nopage+115/310>
> Trace; c012d8ef <do_no_page+2ef/390>
> Trace; c012b5ba <pte_alloc_map+ea/150>
> Trace; c023471a <nf_sockopt+fa/150>
> Trace; c0234790 <nf_setsockopt+20/30>
> Trace; c0242fda <ip_setsockopt+74a/910>
> Trace; c02255de <sock_map_fd+be/120>
> Trace; c022562a <sock_map_fd+10a/120>
> Trace; c0263995 <inet_setsockopt+25/30>
> Trace; c02269d6 <sys_setsockopt+56/70>
> Trace; c0227026 <sys_socketcall+1a6/200>
> Trace; c0114ea0 <do_page_fault+0/436>
> Trace; c01099b1 <error_code+2d/38>
> Trace; c0108f6f <syscall_call+7/b>
> 

That's the ip_fw_ctl() one.
