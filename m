Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266196AbSKRX05>; Mon, 18 Nov 2002 18:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbSKRX05>; Mon, 18 Nov 2002 18:26:57 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:32649 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266196AbSKRXZz>; Mon, 18 Nov 2002 18:25:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 15:33:21 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dave Hansen <haveblue@us.ibm.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>, <rml@tech9.net>, <riel@surriel.com>, <akpm@zip.com.au>
Subject: Re: unusual scheduling performance
In-Reply-To: <3DD96EE6.1080603@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0211181531500.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Dave Hansen wrote:

> As Andrew suggested, I put a dump_stack() in rwsem_down_write_failed().
>
> This was actually in a 2.5.47 bk snapshot, so it has eventpoll in it.
> kksymoops is broken, so:
> dmesg | tail -20 | sort | uniq | ksymoops -m /boot/System.map
>
> Trace; c01c5757 <rwsem_down_write_failed+27/170>
> Trace; c01220c6 <update_wall_time+16/50>
> Trace; c01223ee <do_timer+2e/c0>
> Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
> Trace; c0146568 <__fput+18/c0>
> Trace; c010ae9a <handle_IRQ_event+2a/60>
> Trace; c0144a05 <filp_close+85/b0>
> Trace; c0144a8d <sys_close+5d/70>
> Trace; c0108fab <syscall_call+7/b>
>
> Trace; c01c5757 <rwsem_down_write_failed+27/170>
> Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
> Trace; c0146568 <__fput+18/c0>
> Trace; c011e90b <do_softirq+6b/d0>
> Trace; c0144a05 <filp_close+85/b0>
> Trace; c0144a8d <sys_close+5d/70>
> Trace; c0108fab <syscall_call+7/b>
>
> Trace; c01c5757 <rwsem_down_write_failed+27/170>
> Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
> Trace; c0146568 <__fput+18/c0>
> Trace; c0144c2d <generic_file_llseek+2d/e0>
> Trace; c0144a05 <filp_close+85/b0>
> Trace; c0144a8d <sys_close+5d/70>
> Trace; c0108fab <syscall_call+7/b>
>
> Trace; c01c5757 <rwsem_down_write_failed+27/170>
> Trace; c0166bd3 <.text.lock.eventpoll+6/f3>
> Trace; c0146568 <__fput+18/c0>
> Trace; c01553fa <sys_getdents64+4a/98>
> Trace; c0144a05 <filp_close+85/b0>
> Trace; c0144a8d <sys_close+5d/70>
> Trace; c0108fab <syscall_call+7/b>
>
> Mystery solved?

Could you pls put this in eventpoll_release() :


        if (list_empty(lsthead))
                return;

	printk("[%p] head=%p prev=%p next=%p\n", current, lsthead,
		lsthead->prev, lsthead->next);





- Davide


