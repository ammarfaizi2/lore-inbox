Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291733AbSBHS4y>; Fri, 8 Feb 2002 13:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291736AbSBHS4s>; Fri, 8 Feb 2002 13:56:48 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44201 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291733AbSBHS4h>;
	Fri, 8 Feb 2002 13:56:37 -0500
Date: Fri, 8 Feb 2002 21:54:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Tigran Aivazian <tigran@veritas.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [patch] larger kernel stack (8k->16k) per task
In-Reply-To: <Pine.LNX.3.95.1020208123843.1974A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0202082150040.15826-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Feb 2002, Richard B. Johnson wrote:

> Could someone please tell me why you should make a function call to
> allocate, and then later on free, some temporary space for variables
> when allocation on the stack involves simply subtracting a value,
> calculated by the compiler at compile-time, from the stack-pointer?

because if you need that much stack space then you shouldnt care about
kmalloc() overhead anymore.

> This takes 42 clocks, not including the thousands used up by kmalloc
> and kfree.

kmalloc()+kfree() is not thousands. At least on SMP it has a nice frontend
cache and batch allocator component, which makes it much cheaper.

32 bytes you can allocate on the stack no problem. If you need to allocat
and *fill* 2K then kmalloc() overhead will not matter to you.

> If the kernel does not provide sufficient stack-space for small
> buffers and structures, it is a kernel problem, not a driver-coding
> problem. [...]

we will not add significant overhead to *every part* of the kernel just to
keep a ridiculously large stack around for those few drivers who should
use kmalloc() to begin with. And believe me, some people will then want to
do recursion on the stack and would complain even about a 1MB stack. There
is a limit to draw, and on Linux it's 'no bigger than a few hundred bytes,
allocate dynamically otherwise'.

	Ingo

