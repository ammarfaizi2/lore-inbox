Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUCMWim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbUCMWim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:38:42 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:5074 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263204AbUCMWik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:38:40 -0500
Subject: Re: i386 very early memory detection cleanup patch breaks the build
From: James Bottomley <James.Bottomley@steeleye.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40538B39.90803@zytor.com>
References: <1079198139.2512.19.camel@mulgrave>
		<40538091.9050707@zytor.com> <1079215809.2513.39.camel@mulgrave> 
	<40538B39.90803@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Mar 2004 17:38:13 -0500
Message-Id: <1079217494.2512.48.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 17:29, H. Peter Anvin wrote:
> Actually, I just meant changing:
> 
> -obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o trampoline.o
> +obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o
> +obj-$(CONFIG_SMP)		+= trampoline.o
> 
> ... which is more like what the original code is doing, minus VISWS.

No, that looks more magical and even worse.  The idea of the subarch
code is to separate out pieces of i386/kernel that need to be added in
separately.  Having trampoline depend on CONFIG_X86_TRAMPOLINE which
then depends on (X86_SMP) || (VOYAGER && SMP) expresses exactly what's
going on.  The above code is begging for someone to try to "correct" it.

> Nope.  It shouldn't be using the boot page tables after paging_init, and 
> even so, the "new" boot page tables look just like the "old" ones except 
> there might be more of them, so there are two resaons that shouldn't be 
> happening.  I'd have been less surprised if you'd seen a problem with 
> boot_ioremap(), although even that shouldn't really be different...
> 
> My main guess would be a porting problem (_end -> init_pg_tables_end) in 
> discontig.c, which I believe Voyager uses, right?

Actually, no, it's not a discontig mem subarch.  It has a different SMP
setup (VICs instead of APICs...and the failing beast is the QIC which
uses cache line interference to transmit cross processor interrupts
using the last page of physical memory).

> I don't have access to any real subarchitectures (I have a visws now, 
> but I haven't actually been able to run it yet), so the discontig stuff 
> didn't get tested; on the other hand the change in there was quite trivial.
> 
> Sorry for not being able to be more helpful, but I'm surrounded by boxes 
> and this is the last weekend I have to pack before I move houses...

That's OK.  Subarch boot sequences are one of the most fragile things in
the kernel.  I suspect the ioremap problem is probably a manifestation
of something happening earlier ... I'll see if I can find it.

James


