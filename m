Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWFQRFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWFQRFt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 13:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWFQRFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 13:05:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750727AbWFQRFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 13:05:48 -0400
Date: Sat, 17 Jun 2006 10:05:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: x86_64: x86-64 mailing lists / posting patchkits / x86-64
 releases
Message-Id: <20060617100543.ae21d6d9.akpm@osdl.org>
In-Reply-To: <200606121307.54556.ak@suse.de>
References: <200606121307.54556.ak@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 13:07:54 +0200
Andi Kleen <ak@suse.de> wrote:

> Also I'll probably start x86_64-* patchkit releases again. Currently
> my working dir on ftp.firstfloor.org is directly going into -mm* and 
> that sometimes causes problems because it is not as well tested as it would
> be if a larger audience has run it. Also there are often non trivial
> interactions with the many patches in -mm* and it's hard to figure
> out where a problem comes from. So it looks like some separate 
> testing would be better.

It's a bit sad to do this - reducing the amount of external testing can only
reduce the code quality and the development speed.

It would, of course, be better to work out _why_ the x86_64 tree has been
more problematic than others, and fix that up.  One way of doing that would
be to do a bit of a post-mortem on previous problems, see if we can come up
with a process fix which would have prevented them.

<does a bit of data collection>

>From the below, a lot of the problems I'm having to fix are simply x86
build/link/depmod breakage.  So more careful build checking on x86-32 would
improve things quite a lot.

There has been some runtime breakage too in Don and Jan's recent patches. 
No magic solution presents itself there - the only way we'll improve things
here is more review and testing by both the originators and the merger(s).




Subject: x86_64: check_addr() cleanups

- Use DMA_32BIT_MASK

- Use %z for size_t

- 80-cols

Subject: x86_64-mm-add-smp-support-on-i386-to-reservation-framework-fix

arch/i386/kernel/nmi.c: In function `setup_p6_watchdog':
arch/i386/kernel/nmi.c:506: `P6_EVNTSEL_ENABLE' undeclared (first use in this function)
arch/i386/kernel/nmi.c:506: (Each undeclared identifier is reported only once
arch/i386/kernel/nmi.c:506: for each function it appears in.)

Subject: x86_64-mm-alternatives-fix

make[1]: *** No rule to make target `arch/x86_64/kernel/alternative.o', needed by `arch/x86_64/kernel/built-in.o'.  Stop.

Subject: x86_64-mm-compat-printk fix

fs/compat.c: In function `compat_printk':
fs/compat.c:65: warning: `return' with no value, in function returning non-void

Subject: x86_64-mm-i386-numa-summit-check fix

arch/i386/kernel/srat.c: In function `get_memcfg_from_srat':
arch/i386/kernel/srat.c:273: error: parse error before "early_printk"

Subject: x86_64-mm-mce_amd-support-for-family-0x10-processors fix

Small compilation fix needed for x86_64 without SMP.

Subject: x86_64-mm-new-northbridge fix

WARNING: "k8_nb_ids" [drivers/char/agp/amd64-agp.ko] undefined!
WARNING: "k8_northbridges" [drivers/char/agp/amd64-agp.ko] undefined!

Subject: x86_64-mm-reliable-stack-trace-support-fix

init/built-in.o(.init.text+0x94a): In function `start_kernel':
: undefined reference to `unwind_init'

Subject: x86_64-mm-reliable-stack-trace-support-non-x86-fix-fix

hack, make it compile.

Subject: x86_64-mm-reliable-stack-trace-support-non-x86-fix

powerpc:

In file included from init/main.c:41:
include/linux/unwind.h:16:24: asm/unwind.h: No such file or directory

Subject: x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86_64-fix

Subject: x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix-fix

notify_die() can be called for various reasons and we don't seem to have an
NMI-specific call back now.  Handle that.

Subject: x86_64-mm-remove-un-set_nmi_callback-and-reserve-release_lapic_nmi-functions-x86-fix

Andi, will you please stop committing patches which break the x86 build?  It's
a fairly popular architecture..

Vivek, I never know who maintains the kdump stuff.  Some MAINTAINERS entries
would be nice.

Don, your patch consistently does

	struct die_args *args = (struct die_args *)data;

which is consistently wrong.  `data' is void* and does not need a cast - in
fact it's harmful.

And this patch may simply be wrong - crash_nmi_callback() wants the `cpu'
argument, but we've lost that, so I resorted to raw_smp_processor_id(). 
Calling that on the crashed CPU sounds like a bad idea.

Subject: x86_64-reliable-stack-trace-support-i386 fix


