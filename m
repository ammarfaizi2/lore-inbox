Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTJXUm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTJXUm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 16:42:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55689 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262591AbTJXUm5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 16:42:57 -0400
Date: Fri, 24 Oct 2003 16:46:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John R Moser <jmoser5@student.ccbc.cc.md.us>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Avoid Pagefaults -- Variable Size Pages
In-Reply-To: <Pine.A32.3.91.1031024153626.27840C-100000@student.ccbc.cc.md.us>
Message-ID: <Pine.LNX.4.53.0310241614350.29678@chaos>
References: <Pine.A32.3.91.1031024153626.27840C-100000@student.ccbc.cc.md.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Oct 2003, John R Moser wrote:

> Is this possible?
>
[SNIPPED...]

>
> If pagefaults could be decreased, applications might run faster since
> they don't need to run so much code to check where the hell RAM is that
> they need.  At least, I think they might.
>
> --Bluefox Icy

First things first. What problem is it that you are trying to solve?
The only time you need contiguous pages is when DMA is being used.

This is because the DMA controller(s) don't use the CPUs paging
mechanism, so the starting offset in physical RAM needs to be put
into the bus-mastering devices and any overflow from one page needs
to be into another contiguous physical address.

The whole idea of virtual memory is so RAM can exist anywhere
and, to an executing task, it looks contiguous. The only time
there is any overhead is when real RAM doesn't exist as a page-
table entry, so some has to be faulted in.

So, making pages of physical RAM contiguous just wastes CPU
cycles for everybody instead of the few that need more RAM faulted
in.

Also, at least with Intel boxes, there is one page size, period.
There is no such thing as a large page and a small page.

Statements like this show that you are confused:
> When going beyond {A00,4}, pagefault is incurred via an interrupt.  The

Any attempt to access virtual memory that doesn't exist (it's
marked page-not-present by the OS) generates a page-fault. The
page-fault handler tries to find any available page to satisfy
that need. It usually removes one from a buffer, using a LRU
(least recently used) method. If nothing is available, it steals
a LRU page by writing its contents to swap, marking its PTE
as "page-not-present", and then it gives that page to the faulting
process by updating its PTE. Pages that have been written need
to be cleared for security reasons before being given to another
task.

Since there is no time-difference to access a page at 0x80000000 or
at 0x00010000, in physical address space, there is no reason to make
any RAM access contiguous. Nobody cares, unless you are doing
DMA. With DMA, if you are going to access more than one page
at a time, they need to be contiguous for the reasons cited.

Again, even in the kernel, all memory access is virtual. What
looks to a task (process) as contiguous RAM can consist of
pages mapped in from any physical address. The mapping, once
set up, incurs no overhead. It is done in hardware.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


