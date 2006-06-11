Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWFKX0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWFKX0X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 19:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWFKX0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 19:26:23 -0400
Received: from [198.99.130.12] ([198.99.130.12]:54938 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751138AbWFKX0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 19:26:23 -0400
Date: Sun, 11 Jun 2006 19:25:58 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       jamagallon@ono.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore smp_locks section warnings from init/exit code
Message-ID: <20060611232558.GB20639@ccure.user-mode-linux.org>
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060608003153.36f59e6a@werewolf.auna.net> <20060607154054.cf4f2512.akpm@osdl.org> <20060607162326.3d2cc76b.rdunlap@xenotime.net> <20060608021149.GA5567@ccure.user-mode-linux.org> <20060608183549.GB18815@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608183549.GB18815@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 08:35:49PM +0200, Sam Ravnborg wrote:
> As for .bss this is a much more generic section - so for now this is not
> added. Can you explain why there is a reference to do_mount_root from
> .bss or is this a bug in modpost pointing out something wrong?

For me, the ld complaints are completely opaque.  Can you give me a
clue how you go about figuring out where the complaint is coming from?

This is what I get with UML/x86_64 with rc6-mm2:
	WARNING: vmlinux - Section mismatch: reference to .init.text:huft_free from .bss between 'stdout@@GLIBC_2.2.5' (at offset 0x6027b748) and 'completed.6111'

gdb tells me:
	(gdb) x/4xa 0x6027b748
	0x6027b748 <stdout@@GLIBC_2.2.5>:       0x0     0x0
	0x6027b758 <completed.6111+8>:  0x0     0x0

So, with stdout@@GLIBC_2.2.5 at 0x6027b748 and completed.6111 at
0x6027b750 - right next to each other - there would seem to be nothing
between them to reference anything.

In any case, with bss containing zero-initialized stuff, I don't see
how anything here can refer to anything anywhere else.

> With the above patch we are down to two section mismatch warnings for
> a defconfig build on x86_64.

I see one (the one quoted above).  Thanks for adding .plt - that made
the build much more pleasant.

				Jeff
