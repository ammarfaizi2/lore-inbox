Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbUABVEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265642AbUABVEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:04:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:44231 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265640AbUABVEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:04:39 -0500
Date: Fri, 2 Jan 2004 13:05:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bart Samwel <bart@samwel.tk>
Cc: smackinlay@mail.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] laptop-mode-2.6.0, version 5
Message-Id: <20040102130543.36f61809.akpm@osdl.org>
In-Reply-To: <3FF56BC6.50201@samwel.tk>
References: <20040102025509.91753.qmail@mail.com>
	<3FF56BC6.50201@samwel.tk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel <bart@samwel.tk> wrote:
>
> Find attached version 5 of the laptop-mode patch. It includes the 
> following changes:
> 
> * Fix for supporting 64-bit sector_t (thanks hugang!)

%Lu expects an unsigned long long argument and nothing else, so we should
cast this sector_t to unsigned long long, not u64.

With u64 this code will generate a warning on ppc64 (at least), because
ppc64's u64 is unsigned long.

> * Simplified the design a bit, saved us a timer. It now only wakes up 
> kupdate to write back stuff: kupdate disregards age while laptop_mode is 
> active, so it writes back everything anyway.
> 
> * balance_dirty_pages does it's job again in laptop mode. However, when 
> it decides to write back pages, it now also calls disk_is_spun_up(), 
> which makes sure that the remainder of the dirty pages are written 
> immediately as well. That means that if a writer writes an amount of 
> data that is about 50% of memory, and dirty_ratio is 40%, that the disk 
> will spin up after 4/5ths of the data is written, will write the full 
> 4/5ths of the data at once, and then the disk can spin down again 
> because the remaining 10% will be not be written until the next spin-up.

hum, OK, I'll tkae a look at that, thanks.

> * The control script now sets dirty_background_ratio to the same value 
> as dirty_ratio, so that background writes are effectively disabled. This 
> enables a writer to fill up up to dirty_ratio (default 40%) of the 
> memory with dirty blocks before the disk is spun up.
> 
> * Includes control script (scripts/laptop_mode).
>
> * Includes docs (Documentation/laptop-mode.txt).

Can you please place the control script inside laptop-mode.txt rather than
in scripts/?  The scripts directory is for kernel build tools, not for
kernel runtime support things.

Thanks.
