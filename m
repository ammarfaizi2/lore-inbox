Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWCQLRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWCQLRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 06:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWCQLRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 06:17:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751166AbWCQLRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 06:17:01 -0500
Date: Fri, 17 Mar 2006 03:14:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: i810 framebuffer - BUG: sleeping function called from invalid
 context
Message-Id: <20060317031410.2479d8e1.akpm@osdl.org>
In-Reply-To: <44186D30.4040603@imap.cc>
References: <44186D30.4040603@imap.cc>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tilman Schmidt <tilman@imap.cc> wrote:
>
> Thought I'd finally report this, seeing it still around with 2.6.16-rc6-mm1.
> 
>  With every 2.6.16-rc-mm version I can remember (sorry, no precise records)
>  my development machine (a Dell OptiPlex GX110, Intel P3/933, Intel chipset)
>  has been producing the following three BUG messages while booting:
> 
>  <6>[   36.528181] md: Autodetecting RAID arrays.
>  <3>[   36.528263] BUG: sleeping function called from invalid context at mm/slab.c:2758
>  <4>[   36.528270] in_atomic():1, irqs_disabled():1
>  <4>[   36.528277]  <c01503bb> kmem_cache_alloc+0x20/0x77   <c0259356> i810fb_cursor+0x1bd/0x2c9
>  <4>[   36.528317]  <c01a36ac> search_by_key+0x1a5/0xe04   <c020eec5> bit_cursor+0x467/0x48a
>  <4>[   36.528357]  <c020c25b> fbcon_cursor+0x226/0x25b   <c020ea5e> bit_cursor+0x0/0x48a
>  <4>[   36.528373]  <c024db82> hide_cursor+0x1d/0x53   <c0251766> vt_console_print+0x8b/0x21e
>  <4>[   36.528399]  <c02516db> vt_console_print+0x0/0x21e   <c0117a14> __call_console_drivers+0x34/0x40
>  <4>[   36.528422]  <c0117c14> release_console_sem+0xeb/0x185   <c011857a> vprintk+0x298/0x2d9
>  <4>[   36.528439]  <c0168e00> d_splice_alias+0xa5/0xe5   <c0191583> reiserfs_lookup+0xed/0xf8
>  <4>[   36.528461]  <c01185cd> printk+0x12/0x16   <c029f1bc> md_ioctl+0xc3/0x1289
>  <4>[   36.528492]  <c030c268> _spin_unlock+0xf/0x23   <c030c268> _spin_unlock+0xf/0x23
>  <4>[   36.528525]  <c0169453> inode_init_once+0x1a3/0x1cd   <c01f2113> blkdev_driver_ioctl+0x49/0x59
>  <4>[   36.528557]  <c01f2824> blkdev_ioctl+0x6b6/0x6d6   <c030b84a> __mutex_lock_slowpath+0x2ca/0x39a
>  <4>[   36.528576]  <c012ac64> debug_mutex_add_waiter+0x14/0x24   <c015aa46> do_open+0x5b/0x32a
>  <4>[   36.528607]  <c030b84a> __mutex_lock_slowpath+0x2ca/0x39a   <c015aa46> do_open+0x5b/0x32a
>  <4>[   36.528622]  <c030c268> _spin_unlock+0xf/0x23   <c030c34a> _read_unlock_irq+0x10/0x24
>  <4>[   36.528638]  <c0138721> find_get_page+0x35/0x3a   <c0139e2f> filemap_nopage+0x1a1/0x31f
>  <4>[   36.528655]  <c030c268> _spin_unlock+0xf/0x23   <c01436bf> __handle_mm_fault+0x3e5/0x757
>  <4>[   36.528688]  <c015a361> block_ioctl+0x13/0x16   <c015a34e> block_ioctl+0x0/0x16
>  <4>[   36.528701]  <c0163510> do_ioctl+0x1c/0x5d   <c01637a6> vfs_ioctl+0x255/0x268
>  <4>[   36.528727]  <c01637ff> sys_ioctl+0x46/0x5f   <c0102b3b> sysenter_past_esp+0x54/0x75

Yes, thanks - i810fb_cursor is called on the printk() path and it's doing a
GFP_KERNEL memory allocation(!).

Tony, can you think which patch might have caused this?  It's not
immediately obvious...

