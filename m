Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUGLUMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUGLUMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUGLUMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:12:10 -0400
Received: from holomorphy.com ([207.189.100.168]:33424 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262322AbUGLUMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:12:03 -0400
Date: Mon, 12 Jul 2004 13:11:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rob Mueller <robm@fastmail.fm>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: Processes stuck in unkillable D state (now seen in 2.6.7-mm6)
Message-ID: <20040712201154.GI21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rob Mueller <robm@fastmail.fm>, Chris Mason <mason@suse.com>,
	linux-kernel@vger.kernel.org
References: <00f601c46539$0bdf47a0$e6afc742@ROBMHP> <1089377936.3956.148.camel@watt.suse.com> <009e01c46849$f2e85430$9aafc742@ROBMHP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009e01c46849$f2e85430$9aafc742@ROBMHP>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone's attribution was removed from:
>> Things will be much easier for you if you configure a serial or network
>> console.
>> It's just crud on the stack, you're really waiting in io_schedule() for
>> a page to get unlocked.  Why isn't the page unlocking?  Hard to say for
>> sure without seeing the whole sysrq-t.  If the network/serial console
>> doesn't work out, I can help you configure lkcd as well.

On Mon, Jul 12, 2004 at 12:53:44PM -0700, Rob Mueller wrote:
> Well, I tried compiling in the network console, but it seems to be way too 
> buggy. Basically the machine would crash (hard lockup) within about 12-24 
> hours after booting, nothing on the network console itself or in any log 
> file. Not much help there.
> Anyway, after rebooting back into a non-netconsole enabled kernel, we did 
> get another stuck process. This time there was only 1, and I was able to 
> shutdown all the other processes, so that there were only about 50 procs 
> running when I did the sysreq-t command, so I should have been able to 
> capture all the output this time??? I've put the dumps here:
> http://robm.fastmail.fm/kernel/t2/
> Here's the relevant stuck proc.

I have also experienced no end of aggravation at the hands of hardware
vendors who saw fit to remove serial in the interest of legacy free
-ness with no adequate replacement whatsoever.


On Mon, Jul 12, 2004 at 12:53:44PM -0700, Rob Mueller wrote:
> imapd         D E17BE6E0     0  3761      1               10291 (NOTLB)
> e11c3bc8 00000086 00000020 e17be6e0 c1372d20 00000246 00000220 f7e12380
>       00000020 c0136667 c42c6da0 00000001 00000d74 bbfe8a6a 0000040d 
> c42c6da0
>       f7f91140 e17be6e0 e17be890 f78cd9cc 00000003 f78cd9cc f78cd9cc 
> c025d2cc
> Call Trace:
> [<c0136667>] kmem_cache_alloc+0x57/0x70
> [<c025d2cc>] generic_unplug_device+0x2c/0x40
> [<c037a148>] io_schedule+0x28/0x40
> [<c012e03c>] __lock_page+0xbc/0xe0
> [<c012dd70>] page_wake_function+0x0/0x50
> [<c012f061>] filemap_nopage+0x231/0x360
> [<c013dc18>] do_no_page+0xb8/0x3a0
> [<c013ba7b>] pte_alloc_map+0xdb/0xf0
> [<c013e0ae>] handle_mm_fault+0xbe/0x1a0
> [<c025d292>] __generic_unplug_device+0x32/0x40
> [<c0112af2>] do_page_fault+0x172/0x5ec
> [<c014cab0>] bh_wake_function+0x0/0x40
> [<c018ec9f>] reiserfs_prepare_file_region_for_write+0x94f/0x9b0
> [<c0112980>] do_page_fault+0x0/0x5ec
> [<c0104b19>] error_code+0x2d/0x38
> [<c018dc0f>] reiserfs_copy_from_user_to_file_region+0x8f/0x100
> [<c018f2b1>] reiserfs_file_write+0x5b1/0x750
> [<c0186719>] reiserfs_link+0x159/0x190
> [<c016134c>] dput+0x1c/0x1b0
> [<c01581a0>] path_release+0x10/0x40
> [<c015a9bc>] sys_link+0xcc/0xe0
> [<c014bb9a>] vfs_write+0xaa/0xe0
> [<c014b610>] default_llseek+0x0/0x110
> [<c014bc4f>] sys_write+0x2f/0x50
> [<c010406b>] syscall_call+0x7/0xb
> Is that in lock_page again?
> Hopefully there's some helpful information there. If the dump there isn't 
> complete, can you give me an idea why it might not be? I've set the kernel 
> buffer to 17 (128k), and the proc list was definitely small enough to fit 
> in the buffer. When I did "dmesg -s 1000000 > foo", the first part of the 
> file was still the original boot sequence. Any other suggestions on what to 
> do?

Nice, deep stack there; however, this appears to only be one process. It
may be helpful to see the others.


-- wli
