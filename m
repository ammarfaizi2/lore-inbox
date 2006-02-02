Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWBBFHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWBBFHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 00:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWBBFHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 00:07:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20448 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161085AbWBBFHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 00:07:22 -0500
Date: Thu, 2 Feb 2006 00:07:13 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16rc1-git4 slab corruption.
Message-ID: <20060202050713.GA2560@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060131180319.GA18948@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131180319.GA18948@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 01:03:19PM -0500, Dave Jones wrote:
 > Slab corruption: start=ffff81000057a360, len=88
 > Redzone: 0x5a2cf071/0x5a2cf071.
 > Last user: [<ffffffff80181cc0>](free_buffer_head+0x2a/0x43)
 > 
 > Call Trace: <ffffffff8017b4d0>{check_poison_obj+127}
 >        <ffffffff80181cea>{alloc_buffer_head+17} <ffffffff8017b638>{cache_alloc_debugcheck_after+48}
 >        <ffffffff8017b828>{kmem_cache_alloc+231} <ffffffff80181cea>{alloc_buffer_head+17}
 >        <ffffffff801824b1>{alloc_page_buffers+53} <ffffffff8018255c>{create_empty_buffers+20}
 >        <ffffffff801831c8>{__block_prepare_write+148} <ffffffff8807e5f4>{:ext3:ext3_get_block+0}
 >        <ffffffff8017b0cc>{poison_obj+38} <ffffffff8017b6f7>{cache_alloc_debugcheck_after+239}
 >        <ffffffff80183536>{block_prepare_write+26} <ffffffff8807fcd1>{:ext3:ext3_prepare_write+148}
 >        <ffffffff80340386>{_write_unlock_irq+9} <ffffffff8015e3b7>{generic_file_buffered_write+603}
 >        <ffffffff80137896>{current_fs_time+59} <ffffffff80137896>{current_fs_time+59}
 >        <ffffffff8015ea13>{__generic_file_aio_write_nolock+767}
 >        <ffffffff8015ee22>{generic_file_aio_write+78} <ffffffff80149d23>{debug_mutex_add_waiter+159}
 >        <ffffffff8033fb23>{__mutex_lock_slowpath+817} <ffffffff8015ee39>{generic_file_aio_write+101}
 >        <ffffffff8807be5e>{:ext3:ext3_file_write+22} <ffffffff8018054e>{do_sync_write+199}
 >        <ffffffff801464d6>{autoremove_wake_function+0} <ffffffff8015ae1f>{audit_syscall_entry+301}
 >        <ffffffff80180e48>{vfs_write+206} <ffffffff801813fa>{sys_write+69}
 >        <ffffffff8010aa78>{tracesys+209}
 > 020: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 01 00 00 00

I just hit corruption again (I had rebooted since), but this time with
a completely different trace.

Slab corruption: start=ffff81000057a000, len=4096

Call Trace: <ffffffff8017b4f0>{check_poison_obj+127}
        <ffffffff802dd12a>{__alloc_skb+92} <ffffffff8017b658>{cache_alloc_debugcheck_after+48}
        <ffffffff8017c271>{__kmalloc+294} <ffffffff802dd12a>{__alloc_skb+92}
        <ffffffff802d9ba3>{sock_alloc_send_skb+101} <ffffffff801dd163>{avc_has_perm+67}
        <ffffffff8017b340>{cache_free_debugcheck+554} <ffffffff8033952e>{unix_stream_sendmsg+348}
        <ffffffff801dd4c2>{socket_has_perm+93} <ffffffff802d70e2>{do_sock_write+193}
        <ffffffff802d90ad>{sock_writev+183} <ffffffff801464de>{autoremove_wake_function+0}
        <ffffffff801dd818>{inode_has_perm+86} <ffffffff802d7668>{sock_aio_read+81}
        <ffffffff801dd8bb>{file_has_perm+150} <ffffffff80180bf7>{do_readv_writev+381}
        <ffffffff801811a7>{sys_writev+69} <ffffffff8010a906>{system_call+126}
380: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 01 00 00 00

What I find interesting here is the corruption pattern is the same both times.
Strange, and very scary.

		Dave

