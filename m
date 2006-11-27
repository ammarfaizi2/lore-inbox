Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755314AbWK0AIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbWK0AIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 19:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755328AbWK0AIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 19:08:51 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:12264 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1755314AbWK0AIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 19:08:51 -0500
Date: Mon, 27 Nov 2006 00:08:45 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Build breakage ...
Message-ID: <20061127000845.GA23899@linux-mips.org>
References: <20061126224928.GA22285@linux-mips.org> <Pine.LNX.4.64.0611261459010.3483@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0611261459010.3483@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 03:06:10PM -0800, Linus Torvalds wrote:

> That said, Alexey did check it more than most patches like this get 
> checked (ie checking allmodconfig on i386, x86_64, alpha, arm), so it's a 
> bit unlucky that MIPS got bitten by this - it was not a badly tested 
> patch per se.
> 
> Does the obvious fix (to include <linux/kernel.h> in irqflags.h) fix it 
> for you?

It changes the sympthoms:

  CC      arch/mips/kernel/asm-offsets.s
In file included from include/linux/irqflags.h:14,
                 from include/asm/bitops.h:34,
                 from include/linux/bitops.h:9,
                 from include/linux/thread_info.h:20,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:46,
                 from arch/mips/kernel/asm-offsets.c:13:
include/linux/kernel.h: In function ‘roundup_pow_of_two’:
include/linux/kernel.h:169: warning: implicit declaration of function ‘fls_long’
In file included from include/linux/thread_info.h:20,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:46,
                 from arch/mips/kernel/asm-offsets.c:13:
include/linux/bitops.h: At top level:
include/linux/bitops.h:57: error: conflicting types for ‘fls_long’
include/linux/kernel.h:169: error: previous implicit declaration of ‘fls_long’ was here

So the new problem is circular includes:

   ... <linux/bitops.h> -> <asm/bitops.h> -> <linux/irqflags.h> ->
  <linux/kernel.h> -> <linux/bitops.h> ...

include/asm-mips/bitops.h needs to include irqflags because some older
MIPS variants do not have any atomic instructions.  So the fix needs to
to break that loop.

  Ralf
