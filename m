Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTBFFTX>; Thu, 6 Feb 2003 00:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbTBFFTX>; Thu, 6 Feb 2003 00:19:23 -0500
Received: from dsl093-135-135.sfo2.dsl.speakeasy.net ([66.93.135.135]:640 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id <S262789AbTBFFTX>;
	Thu, 6 Feb 2003 00:19:23 -0500
Date: Wed, 5 Feb 2003 21:28:49 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: joshk@triplehelix.org
Cc: linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>
Subject: Re: 2.5 kernel + hostap_cs + X11 = scheduling while atomic
Message-ID: <20030206052849.GA1540@jm.kir.nu>
References: <20030205073637.GA10725@saltbox.argot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205073637.GA10725@saltbox.argot.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 11:36:37PM -0800, Joshua Kwan wrote:

> However, a combination of running said kernel, hostap_cs, and X11 produces
> this nasty infinite string of errors:
> 
> bad: scheduling while atomic!
> Call Trace:

>  [<d2948a30>] hfa384x_get_rid+0x36/0x2d6b7606 [hostap_cs]

That will sleep, so it better not be called while in interrupt context
or apparently also, while atomic with preemptive kernels(?).

>  [<d29388b5>] hostap_get_wireless_stats+0xa6/0x2d6c77f1 [hostap]

That's the dev->get_wireless_stats handler. I have assumed that it is
allowed to sleep there, but apparently that is not the case with Linux
2.5.x (at least with CONFIG_PREEMPT). I added a workaround for this into
Host AP CVS, but you will not get signal quality statistics in that
case. I'll do a proper fix if that function is indeed not allowed to
sleep (e.g., by collecting the statistics before and just copying the
values here).

Jean, do you have a comment on this? This happens, e.g., when executing
'cat /proc/net/wireless':

>  [<c0168f45>] seq_printf+0x45/0x56
>  [<c02bd9b6>] wireless_seq_show+0xd6/0xf7
>  [<c0141dd5>] do_mmap_pgoff+0x40e/0x6dc
>  [<c0168a56>] seq_read+0x1c9/0x2ee
>  [<c014d20f>] vfs_read+0xbc/0x127
>  [<c014d496>] sys_read+0x3e/0x55
>  [<c01093cb>] syscall_call+0x7/0xb

-- 
Jouni Malinen                                            PGP id EFC895FA
