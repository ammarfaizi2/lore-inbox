Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUGINCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUGINCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 09:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUGINCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 09:02:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:64906 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264542AbUGINCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 09:02:34 -0400
Subject: Re: Processes stuck in unkillable D state (now seen in 2.6.7-mm6)
From: Chris Mason <mason@suse.com>
To: Rob Mueller <robm@fastmail.fm>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00f601c46539$0bdf47a0$e6afc742@ROBMHP>
References: <00f601c46539$0bdf47a0$e6afc742@ROBMHP>
Content-Type: text/plain
Message-Id: <1089377936.3956.148.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Jul 2004 08:58:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-08 at 18:15, Rob Mueller wrote:
> This is an update to a thread I started last week about processes getting 
> stuck in D state.
> 
> About 2 days ago, we upgraded to 2.6.7-mm6. Things have generally been 
> running fine, but today again, some processes got stuck in an unkillable D 
> state. This time, rather than 1 process getting stuck however, about 20 got 
> stuck in a relatively short period of time (seems to have been over about 
> half an hour). All of processes are cyrus imapd processes.
> 
> I've tried to get sysreq-t output, but as this machine is still up and 
> running, it has about 2500 processes on it, and I can't seem to get 
> consistent sysreq-t output. I set the kernel log buffer size to 17 (128k) 
> but that definitely doesn't seem to be enough. I notice that it also seems 
> to dump to /var/log/messages, and I get more output there, but it still 
> doesn't seem to be a complete process list, and each time I do a sysreq-t, I 
> get a different number of procs (though always incomplete) in the output. 
> Anyway, I've done sysreq-t twice, and got the output from dmesg -s 1000000 
> and /var/log/messages. Since the output is so big, I've put them, and the 
> kernel config here:
> 

Things will be much easier for you if you configure a serial or network
console.

> Having a quick look myself, there are some odd things there though. For 
> instance, from sysreqmsglog1.txt
> 
>    imapd         D F1778660     0  3753   1906          3754   809 (NOTLB)
>    eb15adb8 00000086 00000020 f1778660 c0310318 c43fc600 08155888 0000002d
>           f567d380 f7b97480 c42c3d20 00000000 0001ece6 6051d45f 00007c67 
> c42c3d20
>           c03d8180 f1778660 f1778810 f78ad9cc 00000003 f78ad9cc f78ad9cc 
> c025d40c
>    Call Trace:
>     [<c0310318>] memcpy_fromiovec+0x38/0x60
>     [<c025d40c>] generic_unplug_device+0x2c/0x40
>     [<c037a288>] io_schedule+0x28/0x40
>     [<c012e17c>] __lock_page+0xbc/0xe0
>     [<c012deb0>] page_wake_function+0x0/0x50
>     [<c012deb0>] page_wake_function+0x0/0x50
>     [<c012f1a1>] filemap_nopage+0x231/0x360
>     [<c013dd58>] do_no_page+0xb8/0x3a0
>     [<c013bbbb>] pte_alloc_map+0xdb/0xf0
>     [<c013e1ee>] handle_mm_fault+0xbe/0x1a0
>     [<c0112c62>] do_page_fault+0x172/0x5ec
>     [<c012435b>] do_sigaction+0x19b/0x210
>     [<c0120dac>] update_process_times+0x2c/0x40
>     [<c0110230>] smp_apic_timer_interrupt+0x140/0x150
>     [<c0112af0>] do_page_fault+0x0/0x5ec
>     [<c0104b19>] error_code+0x2d/0x38
> 

> Those calls into "generic_unplug_device" look really strange to me...

It's just crud on the stack, you're really waiting in io_schedule() for
a page to get unlocked.  Why isn't the page unlocking?  Hard to say for
sure without seeing the whole sysrq-t.  If the network/serial console
doesn't work out, I can help you configure lkcd as well.

-chris


