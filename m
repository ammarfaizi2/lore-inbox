Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUDXUWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUDXUWc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 16:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbUDXUWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 16:22:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:47318 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262322AbUDXUWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 16:22:30 -0400
Date: Sat, 24 Apr 2004 13:21:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: page allocation failures with 2.6.5 on s390
Message-Id: <20040424132159.7cae4f54.akpm@osdl.org>
In-Reply-To: <20040424183711.GC28032@wavehammer.waldi.eu.org>
References: <20040424183711.GC28032@wavehammer.waldi.eu.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bastian Blank <bastian@waldi.eu.org> wrote:
>
> Today I see the following error message in the logs of two machines
> with 2.6.5 on s390, both 31 and 64 bit.
> 
> | swapper: page allocation failure. order:2, mode:0x20
> | 0072d8f0 00028b18 00405490 80028bbc 80028dac 0072d868 00392f00 0039068a
> |        00000002 00000001 0039a400 0000001a
> | Call Trace:
> |  [<0000000000049d30>] __alloc_pages+0x318/0x35c
> |  [<0000000000049dbe>] __get_free_pages+0x4a/0x78
> |  [<000000000004d838>] cache_grow+0xe0/0x39c
> |  [<000000000004dcc0>] cache_alloc_refill+0x1cc/0x2d8
> |  [<000000000004e1f2>] __kmalloc+0xaa/0xb8
> |  [<000000000023e810>] alloc_skb+0x5c/0xe4
> |  [<00000000002080ca>] qeth_read_in_buffer+0xd16/0xda0
> |  [<0000000000212e22>] qeth_qdio_input_handler+0x42a/0x57c
> |  [<00000000001de17c>] qdio_handler+0xad4/0x10f4
> |  [<00000000001d46da>] ccw_device_call_handler+0x8a/0x94
> |  [<00000000001d3922>] ccw_device_irq+0x7a/0xb4
> |  [<00000000001d42de>] io_subchannel_irq+0x7e/0xc4
> |  [<00000000001cfcd2>] do_IRQ+0x18a/0x1b0
> |  [<0000000000020072>] io_return+0x0/0x10

This is pretty much unavoidable - the kernel is looking for four
physically-contiguous free pages at interrupt time, and there aren't any.

You can reduce its frequency by increasing /proc/sys/vm/min_free_kbytes.

The best fix would be to alter the driver to use order-0 pages if that's
possible.

> It causes a lot of state-D processes on one machine.

This should not happen.  If it happens again, try to capture an all-task
backtrace into the logs with

	echo t > /proc/sysrq-trigger


