Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261435AbSIWV0o>; Mon, 23 Sep 2002 17:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSIWV0n>; Mon, 23 Sep 2002 17:26:43 -0400
Received: from packet.digeo.com ([12.110.80.53]:25487 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261435AbSIWVZE>;
	Mon, 23 Sep 2002 17:25:04 -0400
Message-ID: <3D8F87DD.E330A36E@digeo.com>
Date: Mon, 23 Sep 2002 14:30:05 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38bk2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nuno Monteiro <nuno@itsari.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sleeping function called from illegal context at slab.c:1378
References: <3D8F5DB2.A3E36E16@digeo.com> <1032811220.28332.24.camel@spc9.esa.lanl.gov> <3D8F77B4.A8B9DDC4@digeo.com> <20020923204916.GA915@hobbes.itsari.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 21:30:05.0771 (UTC) FILETIME=[624B91B0:01C26348]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Monteiro wrote:
> 
> On 23.09.02 21:21 Andrew Morton wrote:
> 
> <snip snip>
> 
> I got two more. Its 2.5.38-mm2 too. Just thought I'd throw them in:
> 
> Sleeping function called from illegal context at slab.c:1378
> c2e73f6c c0110251 c020b800 c020faf0 00000562 000001d0 c0129080 c020faf0
>         00000562 00000060 00000008 0000012c c11e3560 c010ac77 00000080
> 000001d0
>         c2e72000 00000000 0000012c bffff948 00000000 c0106ff7 00000060
> 00000008
> Call Trace: [<c0110251>] [<c0129080>] [<c010ac77>] [<c0106ff7>]
> 
> Trace; c0110251 <__might_sleep+55/64>
> Trace; c0129080 <kmalloc+4c/130>
> Trace; c010ac77 <sys_ioperm+7f/124>
> Trace; c0106ff7 <syscall_call+7/b>

sys_ioperm() is calling kmalloc(GFP_KERNEL) inside preempt_disable()
(via get_cpu()).  That's incorrect because the kmalloc could sleep,
and switch CPUs.

> ...
> 
> Trace; c0110251 <__might_sleep+55/64>
> Trace; c012ba45 <__alloc_pages+25/218>
> Trace; c012bc60 <__get_free_pages+28/78>
> Trace; c0143cb7 <__pollwait+33/98>
> Trace; c4b28deb <[snd-pcm-oss]snd_pcm_oss_poll+47/108>
> Trace; c0143ec5 <do_select+101/210>
> Trace; c0144342 <sys_select+346/4a0>
> Trace; c0143707 <sys_ioctl+23b/294>
> Trace; c0106ff7 <syscall_call+7/b>
> 

snd_pcm_oss_poll() calls poll_wait() inside runtime->lock.
poll_wait() does __get_free_page(GFP_KERNEL).

This is a bug in snd_pcm_oss_poll().
