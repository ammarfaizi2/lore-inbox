Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030614AbWF0DEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614AbWF0DEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 23:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933331AbWF0DEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 23:04:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60841 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933296AbWF0DEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 23:04:41 -0400
Date: Mon, 26 Jun 2006 20:04:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
 uninitialised data
Message-Id: <20060626200433.bf0292af.akpm@osdl.org>
In-Reply-To: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 21:45:13 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> The basic problem with this function is that on most architectures
> smp_processor_id() is an alias for current_thread_info()->cpu which
> isn't given its correct value until setup_arch(), so adding a
> boot_cpu_init() that uses it *before* setup_arch() is called is plain
> wrong.  You manage to get away with it 99% of the time because its
> uninitialised value is zero and mostly the id of the booting CPU is
> zero ... but guess who's got a box currently booting on CPU 1 with no
> CPU 0?

preexisting bug, really.  printk() uses smp_processor_id().  Things like
spin_lock() will probably do so in certain debug modes.  We finally got
caught.

> Unfortunately, I can't think of a good solution for what you want to do.
> The thing that looks most plausible is hard_smp_processor_id() which
> reads the actual register value of the processor id.  However, on x86
> (and any other architectures that renumber their CPUs in setup_arch())
> this will ultimately turn out wrong again.

I think arch code should do it before calling start_kernel(), really.  It's
just such a basic part of the kernel framework.

A less wholesome but perhaps simpler solution would be to call the new
setup_smp_processor_id() on entry to start_kernel().

