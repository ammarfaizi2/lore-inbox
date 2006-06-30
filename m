Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932767AbWF3Qb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbWF3Qb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWF3Qb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:31:57 -0400
Received: from relay01.pair.com ([209.68.5.15]:25349 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932767AbWF3Qb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:31:56 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 30 Jun 2006 11:31:54 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Magnus Damm <magnus.damm@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: .exit.text section in vmlinux
In-Reply-To: <aec7e5c30606292354x3831f550y9ac2387f2fa56679@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606301111370.21298@turbotaz.ourhouse>
References: <aec7e5c30606292354x3831f550y9ac2387f2fa56679@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006, Magnus Damm wrote:

> Hi guys,
>
> I understand why ".exit.text" is present in the case of modules, but I
> can't get my head around why it is included in the vmlinux file.
> Functions like the ones below puzzle me:
>
> kernel/configs.c: static void __exit ikconfig_cleanup(void)
> drivers/net/ne2k-pci.c: static void __exit ne2k_pci_cleanup(void)
> drivers/net/ne2k-pci.c: static void __devexit ne2k_pci_remove_one
> (struct pci_dev *pdev)
>
> I can see how the last "__devexit" function might be called during
> some hotplug event, but are the two "__exit" functions ever going to
> be called from the kernel? Since my kernel is configured without
> CONFIG_HOTPLUG both both "__exit" and "__devexit"  end up in the
> ".exit.text" section.
>
> The linker script arch/i386/kernel/vmlinux.lds.S mentions the following:
>
>  /* .exit.text is discard at runtime, not link time, to deal with references
>     from .altinstructions and .eh_frame */

.altinstructions is for alternatives code (code that is rewritten at 
runtime based on some factor such as UP-vs-SMP). .eh_frame has call 
framing information used for unwinding. I think it's copied into the 
vsyscall page (not entirely familiar with this mechanism though).

> The text above seems to answer my question, but I cannot say I fully
> understand the comment. I'd appreciate if someone could explain a bit
> more if possible.
>
> Ok, so the section should be discarded at runtime. Sounds ok. But
> where in the code is this section discarded? -ENOSYS?

When you see "Freeing unused kernel memory", the memory between 
__init_begin and __init_end (as marked in vmlinux.ld.S) is released. See 
arch-specific mm/init.c.

> Thanks,
>
> / magnus

Thanks,
Chase
