Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265273AbUFOCJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbUFOCJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 22:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUFOCJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 22:09:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11657 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265274AbUFOCI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 22:08:29 -0400
Date: Mon, 14 Jun 2004 22:59:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: loop/highmem related 2.4.26 lockup
Message-ID: <20040615015942.GA10965@logos.cnet>
References: <20040531143915.GA20653@logos.cnet> <20040531151505.54f18f4a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20040531151505.54f18f4a.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 31, 2004 at 03:15:05PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > Proc;  loop2
> >  >>EIP; e5d145c0 <END_OF_CODE+2597a348/????>   <=====
> >  Trace; c0189ec8 <journal_alloc_journal_head+18/80>
> >  Trace; c0189fa2 <journal_add_journal_head+52/140>
> >  Trace; c0107b92 <__down+82/d0>
> >  Trace; c0107d2c <__down_failed+8/c>
> >  Trace; c01845fe <.text.lock.transaction+4/246>
> >  Trace; c018204a <new_handle+4a/70>
> >  Trace; c0182114 <journal_start+a4/c0>
> >  Trace; c017bc3c <ext3_writepage_trans_blocks+1c/a0>
> >  Trace; c01795ec <ext3_prepare_write+24c/260>
> >  Trace; c013349e <find_or_create_page+5e/150>
> >  Trace; c01d6f84 <lo_send+124/2e0>
> >  Trace; c01d7408 <do_bh_filebacked+b8/c0>
> >  Trace; c01d7b84 <loop_thread+224/250>
> >  Trace; c0109172 <ret_from_fork+6/20>
> >  Trace; c01d7960 <loop_thread+0/250>
> >  Trace; c010740e <arch_kernel_thread+2e/40>
> >  Trace; c01d7960 <loop_thread+0/250>
> 
> You've run out of memory and the loop thread is looping in
> journal_alloc_journal_head(), waiting for memory to come free.
> 
> Meanwhile, kswapd and bdflush are blocked waiting for I/O which requires
> loop thread services to complete.  Deadlock.
> 
> A proper fix for this might be fairly complex.  A kludgey fix like the
> below might work though.

Andrew, 

Attached is output of task backtraces, decoded by ksymoops, if you care.

We are in the process of moving this box to v2.6. 

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ex2

Trace; c01463ae <__wait_on_buffer+6e/a0>
Trace; c0149e48 <sync_page_buffers+78/d0>
Trace; c0149fe0 <try_to_free_buffers+140/160>
Trace; c013b45b <shrink_cache+35b/430>
Trace; c013b6da <shrink_caches+4a/60>
Trace; c013b752 <try_to_free_pages_zone+62/100>
Trace; c013c74f <balance_classzone+4f/1f0>
Trace; c013ca78 <__alloc_pages+188/290>
Trace; c01d46f9 <__make_request+589/820>
Trace; c01334cd <find_or_create_page+8d/150>
Trace; c0149b0e <grow_dev_page+2e/d0>
Trace; c0149d58 <grow_buffers+98/110>
Trace; c01474e6 <getblk+46/70>
Trace; c01888f4 <journal_get_descriptor_buffer+64/d0>
Trace; c0185899 <journal_commit_transaction+fb9/1300>
Trace; c01880f4 <kjournald+184/230>
Trace; c0187f50 <commit_timeout+0/10>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c0187f70 <kjournald+0/230>
Proc;  kjournald

>>EIP; f586c000 <_end+354d1d88/38472de8>   <=====

Trace; c011b05e <interruptible_sleep_on+4e/80>
Trace; c01880bc <kjournald+14c/230>
Trace; c0187f50 <commit_timeout+0/10>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c0187f70 <kjournald+0/230>
Proc;  syslogd

>>EIP; 00000000 Before first symbol

Trace; c017b63b <ext3_do_update_inode+19b/420>
Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c0135d00 <do_generic_file_write+d0/4a0>
Trace; c013645f <generic_file_write+13f/160>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c0176549 <ext3_file_write+39/d0>
Trace; c01451f4 <do_readv_writev+274/300>
Trace; c0176510 <ext3_file_write+0/d0>
Trace; c0145370 <sys_writev+60/90>
Trace; c01091bf <system_call+33/38>
Proc;  klogd

>>EIP; 00000058 Before first symbol   <=====

>>EIP; 00000002 Before first symbol   <=====

Trace; c01463ae <__wait_on_buffer+6e/a0>
Trace; c0149e48 <sync_page_buffers+78/d0>
Trace; c0149fe0 <try_to_free_buffers+140/160>
Trace; c013b45b <shrink_cache+35b/430>
Trace; c013b6da <shrink_caches+4a/60>
Trace; c013b752 <try_to_free_pages_zone+62/100>
Trace; c013c74f <balance_classzone+4f/1f0>
Trace; c013ca78 <__alloc_pages+188/290>
Trace; c022469a <sys_recvfrom+da/110>
Trace; c013cb9c <__get_free_pages+1c/20>
Trace; c01574c1 <__pollwait+41/c0>
Trace; c0229e7e <datagram_poll+e/da>
Trace; c022388c <sock_poll+c/40>
Trace; c0157877 <do_select+247/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  spamd

>>EIP; f5468dc0 <_end+350ceb48/38472de8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c018298c <do_get_write_access+31c/620>
Trace; c0252577 <wait_for_connect+197/1f0>
Trace; c02526f5 <tcp_accept+125/260>
Trace; c02706e5 <inet_accept+15/1e0>
Trace; c0224196 <sys_accept+66/140>
Trace; c0223345 <sock_sendmsg+55/c0>
Trace; c02235de <sock_write+8e/c0>
Trace; c0224de9 <sys_socketcall+b9/270>
Trace; c0144f29 <sys_write+109/160>
Trace; c01091bf <system_call+33/38>
Proc;  gpm

>>EIP; f7bbc008 <_end+37821d90/38472de8>   <=====

Trace; c013c955 <__alloc_pages+65/290>
Trace; c011a878 <schedule_timeout+58/b0>
Trace; c011a800 <process_timeout+0/20>
Trace; c022388c <sock_poll+c/40>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  cannaserver

>>EIP; 00000010 Before first symbol   <=====

Trace; c011a878 <schedule_timeout+58/b0>
Trace; c011a800 <process_timeout+0/20>
Trace; c022388c <sock_poll+c/40>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; 00030002 Before first symbol   <=====

Trace; c011a878 <schedule_timeout+58/b0>
Trace; c011a800 <process_timeout+0/20>
Trace; c0128463 <sys_nanosleep+d3/170>
Trace; c01091bf <system_call+33/38>
Proc;  jserver

>>EIP; c013aecc <__lru_cache_del+8c/90>   <=====

Trace; c013aecc <__lru_cache_del+8c/90>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c028209e <unix_poll+e/a0>
Trace; c022388c <sock_poll+c/40>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  xfs

>>EIP; 00000010 Before first symbol   <=====

Trace; c011a878 <schedule_timeout+58/b0>
Trace; c011a800 <process_timeout+0/20>
Trace; c022388c <sock_poll+c/40>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  atd

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c0176372 <ext3_readdir+312/430>
Trace; c014dd63 <cp_new_stat64+f3/120>
Trace; c015693e <vfs_readdir+ae/110>
Trace; c01570a0 <filldir64+0/110>
Trace; c015720b <sys_getdents64+5b/c0>
Trace; c01570a0 <filldir64+0/110>
Trace; c0155f2d <sys_fcntl64+5d/c0>
Trace; c01091bf <system_call+33/38>
Proc;  mingetty

>>EIP; f4857000 <_end+344bcd88/38472de8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c0131aa3 <sys_munmap+43/70>
Trace; c01091bf <system_call+33/38>
Proc;  mingetty

>>EIP; f50ff000 <_end+34d64d88/38472de8>   <=====

Trace; c013aecc <__lru_cache_del+8c/90>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c0131aa3 <sys_munmap+43/70>
Trace; c01091bf <system_call+33/38>
Proc;  mingetty

>>EIP; f53da000 <_end+3503fd88/38472de8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c0131aa3 <sys_munmap+43/70>
Trace; c01091bf <system_call+33/38>
Proc;  mingetty

>>EIP; f53d3000 <_end+35038d88/38472de8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c0131aa3 <sys_munmap+43/70>
Trace; c01091bf <system_call+33/38>
Proc;  mingetty

>>EIP; f51d9000 <_end+34e3ed88/38472de8>   <=====

Trace; c013aecc <__lru_cache_del+8c/90>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c0131aa3 <sys_munmap+43/70>
Trace; c01091bf <system_call+33/38>
Proc;  agetty

>>EIP; f7b4bb00 <_end+377b1888/38472de8>   <=====

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c013413d <generic_file_read+bd/1c0>
Trace; c0133f80 <file_read_actor+0/100>
Trace; c010ff3f <old_mmap+df/120>
Trace; c0144d63 <sys_read+a3/160>
Trace; c014def9 <sys_fstat64+49/80>
Trace; c01091bf <system_call+33/38>
Proc;  mingetty

>>EIP; f5825000 <_end+3548ad88/38472de8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c0131aa3 <sys_munmap+43/70>
Trace; c01091bf <system_call+33/38>
Proc;  cupsd

>>EIP; c02e471c <contig_page_data+dc/3b8>   <=====

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c0150d62 <vfs_permission+82/140>
Trace; c017e430 <ext3_unlink+260/270>
Trace; c012c283 <in_group_p+23/30>
Trace; c0150d62 <vfs_permission+82/140>
Trace; c0153510 <vfs_unlink+160/2e0>
Trace; c01537a9 <sys_unlink+119/120>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c0189fa3 <journal_add_journal_head+33/140>   <=====

Trace; c0189fa3 <journal_add_journal_head+33/140>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c0181de1 <get_transaction+c1/150>
Trace; c028198f <unix_stream_data_wait+af/120>
Trace; c0281dd1 <unix_stream_recvmsg+3d1/460>
Trace; c02233e8 <sock_recvmsg+38/f0>
Trace; c0145b71 <chrdev_open+71/b0>
Trace; c0223527 <sock_read+87/b0>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c02e48d4 <contig_page_data+294/3b8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01bacbd <normal_poll+fd/180>
Trace; c010b898 <wait_on_irq+f8/10b>
Trace; c010aa42 <__global_cli+62/70>
Trace; c01ca6db <rs_timer+1b/160>
Trace; c01ca6a0 <do_softint+50/70>
Trace; c01287fe <run_timer_list+12e/1b7>
Trace; c0123cd4 <bh_action+54/80>
Trace; c0123b77 <tasklet_hi_action+67/a0>
Trace; c0123939 <do_softirq+d9/e0>
Trace; c010ae49 <do_IRQ+f9/120>
Trace; c0106f90 <default_idle+0/50>
Trace; c010d9a8 <call_do_IRQ+5/d>
Trace; c0106f90 <default_idle+0/50>
Trace; c0106fb9 <default_idle+29/50>
Trace; c0107052 <cpu_idle+52/70>
Trace; c011e6b5 <call_console_drivers+65/120>
Trace; c011e920 <printk+140/180>
Trace; c0150447 <pipe_poll+37/80>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  bash

>>EIP; 5d626c65 Before first symbol   <=====

Trace; c01ba1b7 <n_tty_set_termios+197/210>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c0189fa3 <journal_add_journal_head+33/140>   <=====

Trace; c0189fa3 <journal_add_journal_head+33/140>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c028198f <unix_stream_data_wait+af/120>
Trace; c0281dd1 <unix_stream_recvmsg+3d1/460>
Trace; c02233e8 <sock_recvmsg+38/f0>
Trace; c0145b71 <chrdev_open+71/b0>
Trace; c0223527 <sock_read+87/b0>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c02e48d4 <contig_page_data+294/3b8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01bacbd <normal_poll+fd/180>
Trace; c0150447 <pipe_poll+37/80>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  bash

>>EIP; 5f78756e Before first symbol   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  loop0

>>EIP; 00000000 Before first symbol

Trace; c0107c69 <__down_interruptible+89/f0>
Trace; c0107d37 <__down_failed_interruptible+7/c>
Trace; c01d8ae6 <.text.lock.loop+9b/135>
Trace; c0109172 <ret_from_fork+6/20>
Trace; c01d7960 <loop_make_request+250/270>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c01d7960 <loop_make_request+250/270>
Proc;  sshd

>>EIP; c0189fa3 <journal_add_journal_head+33/140>   <=====

Trace; c0189fa3 <journal_add_journal_head+33/140>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c0181de1 <get_transaction+c1/150>
Trace; c028198f <unix_stream_data_wait+af/120>
Trace; c0281dd1 <unix_stream_recvmsg+3d1/460>
Trace; c02233e8 <sock_recvmsg+38/f0>
Trace; c0145b71 <chrdev_open+71/b0>
Trace; c0223527 <sock_read+87/b0>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c02e48d4 <contig_page_data+294/3b8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01bacbd <normal_poll+fd/180>
Trace; c01b7415 <tty_poll+65/b0>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  bash

>>EIP; c02fc000 <init_task_union+0/2000>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; e1f8e000 <_end+21bf3d88/38472de8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c028198f <unix_stream_data_wait+af/120>
Trace; c0281dd1 <unix_stream_recvmsg+3d1/460>
Trace; c02233e8 <sock_recvmsg+38/f0>
Trace; c0145b71 <chrdev_open+71/b0>
Trace; c0223527 <sock_read+87/b0>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c02e48d4 <contig_page_data+294/3b8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c024d8d6 <tcp_poll+16/190>
Trace; c022388c <sock_poll+c/40>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  bash

>>EIP; 20245d78 Before first symbol   <=====

Trace; c01ba1b7 <n_tty_set_termios+197/210>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c0189fa3 <journal_add_journal_head+33/140>   <=====

Trace; c0189fa3 <journal_add_journal_head+33/140>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c028198f <unix_stream_data_wait+af/120>
Trace; c0281dd1 <unix_stream_recvmsg+3d1/460>
Trace; c02233e8 <sock_recvmsg+38/f0>
Trace; c0145b71 <chrdev_open+71/b0>
Trace; c0223527 <sock_read+87/b0>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c02e48d4 <contig_page_data+294/3b8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c024d8d6 <tcp_poll+16/190>
Trace; c022388c <sock_poll+c/40>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  bash

>>EIP; 20245d78 Before first symbol   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c0189fa3 <journal_add_journal_head+33/140>   <=====

Trace; c0189fa3 <journal_add_journal_head+33/140>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c014751c <balance_dirty_state+c/60>
Trace; c028198f <unix_stream_data_wait+af/120>
Trace; c0281dd1 <unix_stream_recvmsg+3d1/460>
Trace; c02233e8 <sock_recvmsg+38/f0>
Trace; c0145b71 <chrdev_open+71/b0>
Trace; c0223527 <sock_read+87/b0>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c02e48d4 <contig_page_data+294/3b8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01bacbd <normal_poll+fd/180>
Trace; c01b7415 <tty_poll+65/b0>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  bash

>>EIP; 5d78756e Before first symbol   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  loop1

>>EIP; 00000000 Before first symbol

Trace; c0107c69 <__down_interruptible+89/f0>
Trace; c0107d37 <__down_failed_interruptible+7/c>
Trace; c01d8ae6 <.text.lock.loop+9b/135>
Trace; c0109172 <ret_from_fork+6/20>
Trace; c01d7960 <loop_make_request+250/270>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c01d7960 <loop_make_request+250/270>
Proc;  sshd

>>EIP; c0189fa3 <journal_add_journal_head+33/140>   <=====

Trace; c0189fa3 <journal_add_journal_head+33/140>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c028198f <unix_stream_data_wait+af/120>
Trace; c0281dd1 <unix_stream_recvmsg+3d1/460>
Trace; c02233e8 <sock_recvmsg+38/f0>
Trace; c0145b71 <chrdev_open+71/b0>
Trace; c0223527 <sock_read+87/b0>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c02e48d4 <contig_page_data+294/3b8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01bacbd <normal_poll+fd/180>
Trace; c01b7415 <tty_poll+65/b0>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  bash

>>EIP; 5d78756e Before first symbol   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c0189fa3 <journal_add_journal_head+33/140>   <=====

Trace; c0189fa3 <journal_add_journal_head+33/140>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c028198f <unix_stream_data_wait+af/120>
Trace; c0281dd1 <unix_stream_recvmsg+3d1/460>
Trace; c02233e8 <sock_recvmsg+38/f0>
Trace; c0145b71 <chrdev_open+71/b0>
Trace; c0223527 <sock_read+87/b0>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; c02e48d4 <contig_page_data+294/3b8>   <=====

Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01bacbd <normal_poll+fd/180>
Trace; c01b7415 <tty_poll+65/b0>
Trace; c015775d <do_select+12d/250>
Trace; c0157bfe <sys_select+34e/4e0>
Trace; c01091bf <system_call+33/38>
Proc;  bash

>>EIP; c013d7c1 <can_share_swap_page+61/70>   <=====

Trace; c013d7c1 <can_share_swap_page+61/70>
Trace; c011a8cb <schedule_timeout+ab/b0>
Trace; c01baae2 <write_chan+142/220>
Trace; c01ba598 <read_chan+268/670>
Trace; c01b60f3 <tty_read+f3/150>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; f39f28c8 <_end+33658650/38472de8>   <=====

Trace; c01463c3 <__wait_on_buffer+83/a0>
Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c01517c2 <link_path_walk+502/730>
Trace; c0151bf9 <path_lookup+39/40>
Trace; c0151f49 <__user_walk+49/60>
Trace; c014ddaf <sys_stat64+1f/90>
Trace; c01091bf <system_call+33/38>
Proc;  sshd


>>EIP; c02e48d4 <contig_page_data+294/3b8>   <=====

Trace; c017c92f <ext3_find_entry+29f/3a0>
Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017ca30 <ext3_lookup+0/d0>
Trace; c017d2f0 <ext3_create+130/140>
Trace; c015206d <vfs_create+10d/1e0>
Trace; c0152785 <open_namei+645/6a0>
Trace; c0143c73 <filp_open+43/70>
Trace; c0144073 <sys_open+53/c0>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; c0119998 <do_page_fault+188/534>   <=====

Trace; c0119998 <do_page_fault+188/534>
Trace; c014fea8 <pipe_wait+88/c0>
Trace; c014ffa4 <pipe_read+c4/200>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  run-parts

>>EIP; 00000246 Before first symbol   <=====

Proc;  updatedb

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c0176372 <ext3_readdir+312/430>
Trace; c014dd63 <cp_new_stat64+f3/120>
Trace; c015693e <vfs_readdir+ae/110>
Trace; c01570a0 <filldir64+0/110>
Trace; c015720b <sys_getdents64+5b/c0>
Trace; c01570a0 <filldir64+0/110>
Trace; c015b970 <dput+30/190>
Trace; c014368b <sys_fchdir+4b/110>
Trace; c01091bf <system_call+33/38>
Proc;  sshd
>>EIP; 00000246 Before first symbol   <=====

>>EIP; e5d145c0 <_end+2597a348/38472de8>   <=====

Trace; c0189ec8 <journal_alloc_journal_head+18/a0>
Trace; c0189fa3 <journal_add_journal_head+33/140>
Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bc3c <ext3_writepage_trans_blocks+1c/a0>
Trace; c01795ec <ext3_prepare_write+24c/260>
Trace; c013349f <find_or_create_page+5f/150>
Trace; c01d6f84 <lo_send+104/2e0>
Trace; c01d7408 <do_bh_filebacked+98/c0>
Trace; c01d7b84 <loop_thread+204/250>
Trace; c0109172 <ret_from_fork+6/20>
Trace; c01d7960 <loop_make_request+250/270>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c01d7960 <loop_make_request+250/270>
Proc;  cp

>>EIP; c0123b77 <tasklet_hi_action+67/a0>   <=====

Trace; c0123b77 <tasklet_hi_action+67/a0>
Trace; c01463ae <__wait_on_buffer+6e/a0>
Trace; c0149e48 <sync_page_buffers+78/d0>
Trace; c0149fe0 <try_to_free_buffers+140/160>
Trace; c013b45b <shrink_cache+35b/430>
Trace; c013b6da <shrink_caches+4a/60>
Trace; c013b752 <try_to_free_pages_zone+62/100>
Trace; c013c74f <balance_classzone+4f/1f0>
Trace; c013ca78 <__alloc_pages+188/290>
Trace; c0147d36 <unmap_underlying_metadata+26/90>
Trace; c013cb9c <__get_free_pages+1c/20>
Trace; c0139ae8 <kmem_cache_grow+c8/260>
Trace; c0148394 <__block_commit_write+84/d0>
Trace; c013aa0d <__kmem_cache_alloc+6d/140>
Trace; c0150c41 <getname+31/d0>
Trace; c0151f1f <__user_walk+1f/60>
Trace; c0143203 <sys_utime+23/110>
Trace; c015b970 <dput+30/190>
Trace; c014603a <fput+ea/140>
Trace; c014419e <filp_close+8e/d0>
Trace; c0144246 <sys_close+66/80>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; f7b59400 <_end+377bf188/38472de8>   <=====

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c013413d <generic_file_read+bd/1c0>
Trace; c0133f80 <file_read_actor+0/100>
Trace; c010ff3f <old_mmap+df/120>
Trace; c0144d63 <sys_read+a3/160>
Trace; c014def9 <sys_fstat64+49/80>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c013413d <generic_file_read+bd/1c0>
Trace; c0133f80 <file_read_actor+0/100>
Trace; c010ff3f <old_mmap+df/120>
Trace; c0144d63 <sys_read+a3/160>
Trace; c014def9 <sys_fstat64+49/80>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; c034e484 <aligned_data+104/200>   <=====

Trace; c011afd0 <wait_for_completion+80/c0>
Trace; c011d345 <do_fork+585/870>
Trace; c0107827 <sys_vfork+27/30>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; c034e484 <aligned_data+104/200>   <=====

Trace; c011afd0 <wait_for_completion+80/c0>
Trace; c011d345 <do_fork+585/870>
Trace; c0107827 <sys_vfork+27/30>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c013413d <generic_file_read+bd/1c0>
Trace; c0133f80 <file_read_actor+0/100>
Trace; c010ff3f <old_mmap+df/120>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c01517c2 <link_path_walk+502/730>
Trace; c0151bf9 <path_lookup+39/40>
Trace; c014e857 <open_exec+27/f0>
Trace; c014f4e7 <do_execve+27/220>
Trace; c013c9e8 <__alloc_pages+f8/290>
Trace; c0119810 <do_page_fault+0/534>
Trace; c01092b0 <error_code+34/3c>
Trace; c013aecc <__lru_cache_del+8c/90>
Trace; c015b970 <dput+30/190>
Trace; c015188f <link_path_walk+5cf/730>
Trace; c012a3f7 <do_sigaction+117/160>
Trace; c012a7b9 <sys_rt_sigaction+a9/d0>
Trace; c0150ca7 <getname+97/d0>
Trace; c0107880 <sys_execve+50/80>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c013413d <generic_file_read+bd/1c0>
Trace; c0133f80 <file_read_actor+0/100>
Trace; c010ff3f <old_mmap+df/120>
Trace; c0144d63 <sys_read+a3/160>
Trace; c014def9 <sys_fstat64+49/80>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c01517c2 <link_path_walk+502/730>
Trace; c0151bf9 <path_lookup+39/40>
Trace; c014e857 <open_exec+27/f0>
Trace; c014f4e7 <do_execve+27/220>
Trace; c013c9e8 <__alloc_pages+f8/290>
Trace; c0119810 <do_page_fault+0/534>
Trace; c01092b0 <error_code+34/3c>
Trace; c013aecc <__lru_cache_del+8c/90>
Trace; c015b970 <dput+30/190>
Trace; c015188f <link_path_walk+5cf/730>
Trace; c012a3f7 <do_sigaction+117/160>
Trace; c012a7b9 <sys_rt_sigaction+a9/d0>
Trace; c0150ca7 <getname+97/d0>
Trace; c0107880 <sys_execve+50/80>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c013413d <generic_file_read+bd/1c0>
Trace; c0133f80 <file_read_actor+0/100>
Trace; c010ff3f <old_mmap+df/120>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; c034e484 <aligned_data+104/200>   <=====

Trace; c011afd0 <wait_for_completion+80/c0>
Trace; c011d345 <do_fork+585/870>
Trace; c0107827 <sys_vfork+27/30>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c013413d <generic_file_read+bd/1c0>
Trace; c0133f80 <file_read_actor+0/100>
Trace; c0145dca <get_empty_filp+5a/150>
Trace; c014e992 <kernel_read+72/80>
Trace; c014efc6 <prepare_binprm+136/150>
Trace; c014f5a5 <do_execve+e5/220>
Trace; c0107880 <sys_execve+50/80>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; c034e484 <aligned_data+104/200>   <=====

Trace; c011afd0 <wait_for_completion+80/c0>
Trace; c011d345 <do_fork+585/870>
Trace; c0107827 <sys_vfork+27/30>
Trace; c01091bf <system_call+33/38>
Proc;  crond

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c013413d <generic_file_read+bd/1c0>
Trace; c0133f80 <file_read_actor+0/100>
Trace; c010ff3f <old_mmap+df/120>
Trace; c0144d63 <sys_read+a3/160>
Trace; c01091bf <system_call+33/38>
Proc;  sshd

>>EIP; 00000000 Before first symbol

Trace; c0107b92 <__down+82/d0>
Trace; c0107d2c <__down_failed+8/c>
Trace; c01845ff <.text.lock.transaction+5/246>
Trace; c018204b <new_handle+4b/70>
Trace; c0182115 <journal_start+a5/c0>
Trace; c017bfa0 <ext3_dirty_inode+120/140>
Trace; c015d435 <__mark_inode_dirty+b5/c0>
Trace; c015ef0b <update_atime+6b/70>
Trace; c013413d <generic_file_read+bd/1c0>
Trace; c0133f80 <file_read_actor+0/100>
Trace; c010ff3f <old_mmap+df/120>


1496 warnings and 6 errors issued.  Results may not be reliable.

--Nq2Wo0NMKNjxTN9z--
