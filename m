Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbSKFAQO>; Tue, 5 Nov 2002 19:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265421AbSKFAQO>; Tue, 5 Nov 2002 19:16:14 -0500
Received: from jdike.solana.com ([198.99.130.100]:11392 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S265423AbSKFAP7>;
	Tue, 5 Nov 2002 19:15:59 -0500
Message-Id: <200211060025.gA60P6V01413@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-rc1 - hang with processes stuck in D
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Nov 2002 19:25:06 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-rc1 reliably gets processes stuck in D, eventually wedging the whole
system.  This is by diffing two kernel pools, one of which has 9 138764288 
byte core files.

The diff itself is stuck in __wait_on_buffer:

	Trace; c0131608 <__wait_on_buffer+68/90>
	Trace; c0132258 <getblk+28/60>
	Trace; c0132269 <getblk+39/60>
	Trace; c01324d6 <bread+46/70>
	Trace; c0121918 <handle_mm_fault+58/c0>
	Trace; c0163b02 <ext2_get_branch+52/c0>
	Trace; c0163d99 <ext2_get_block+59/320>
	Trace; c01109fa <do_page_fault+17a/4ab>
	Trace; c01326b2 <create_buffers+62/f0>
	Trace; c01326b8 <create_buffers+68/f0>
	Trace; c0132fec <block_read_full_page+ec/240>
	Trace; c0123a3d <add_to_page_cache_unique+6d/80>
	Trace; c0123ad8 <page_cache_read+88/c0>
	Trace; c0163d40 <ext2_get_block+0/320>
	Trace; c01240b5 <generic_file_readahead+f5/130>
	Trace; c012430f <do_generic_file_read+1df/430>
	Trace; c012487c <generic_file_read+7c/110>
	Trace; c0124780 <file_read_actor+0/80>
	Trace; c0130796 <sys_read+96/f0>
	Trace; c010bafb <sys_mmap2+2b/30>
	Trace; c0106d8b <system_call+33/38>

kupdated and bdflush are both stuck in __wait_on_buffer called from timer_bh:

kupdated:
	Trace; c01a0595 <__get_request_wait+95/d0>
	Trace; c01a0b6b <__make_request+3db/570>
	Trace; c011b424 <timer_bh+274/390>
	Trace; c011817b <bh_action+1b/50>
	Trace; c0118084 <tasklet_hi_action+44/70>
	Trace; c01a0e0e <generic_make_request+10e/130>
	Trace; c010833c <do_IRQ+9c/b0>
	Trace; c01a0e7b <submit_bh+4b/70>
	Trace; c0131684 <write_locked_buffers+24/30>
	Trace; c0131731 <write_some_buffers+a1/f0>
	Trace; c013455c <sync_old_buffers+1c/40>
	Trace; c0134824 <kupdate+f4/120>
	Trace; c0105000 <_stext+0/0>
	Trace; c0105000 <_stext+0/0>
	Trace; c01055d6 <kernel_thread+26/30>
	Trace; c0134730 <kupdate+0/120>

bdflush:
	Trace; c01a0595 <__get_request_wait+95/d0>
	Trace; c01a0b6b <__make_request+3db/570>
	Trace; c011b1d7 <timer_bh+27/390>
	Trace; c011817b <bh_action+1b/50>
	Trace; c0118084 <tasklet_hi_action+44/70>
	Trace; c0110e0e <remap_area_pages+7e/1d0>
	Trace; c010833c <do_IRQ+9c/b0>
	Trace; c01a0e7b <submit_bh+4b/70>
	Trace; c0131684 <write_locked_buffers+24/30>
	Trace; c0131731 <write_some_buffers+a1/f0>
	Trace; c01346fe <bdflush+9e/d0>
	Trace; c0105000 <_stext+0/0>
	Trace; c01055d6 <kernel_thread+26/30>
	Trace; c0134660 <bdflush+0/d0>

