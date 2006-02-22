Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWBVBdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWBVBdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbWBVBdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:33:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64234 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161148AbWBVBdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:33:44 -0500
Date: Tue, 21 Feb 2006 17:31:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: 2.6.16-rc4-mm1 (bugs and lockups)
Message-Id: <20060221173157.209a182b.akpm@osdl.org>
In-Reply-To: <43FB5317.60501@aknet.ru>
References: <43FB5317.60501@aknet.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> Hi.
> 
> The history is that -mm kernels do not work for me
> for a few months already. The things started from
> crashing somewhere after starting init, and for the
> last month - no boot at all, just
> "Uncompressing... OK, booting kernel", and silence.
> Early console didn't work too.
> With the latest releases this degraded into an infinite
> stream of the "Unknown interrupt or fault" messages.
> So today my patience ran out and I started to think how
> can I collect at least some info for the bug-report.
> Attached is the patch that allows to gather some valueable
> debug info on the problem by making an early console more
> useable. I can't properly test the patch, as the kernel
> still doesn't boot, so I'll explain it in details in a
> hope someone else can justify the intrusive changes.
> 

It's unusual that the failure has been only in -mm, and for so long.  That
would indicate that we have a problem in a for-mm-only patch.

And yet your patch applies OK to 2.6.16-rc4, so it's not obvious how this
got in there.

Did you never perform a bisection as per
http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt,
find out which patch in -mm was the offender?

> arch_hooks.h: added prototypes for setup_early_printk()
> and early_printk().
> 
> head.S: added "hlt" to the dummy fault handler. This is
> necessary because otherwise the fault retriggers infinitely,
> causing the infinite stream of an "Unknown interrupt or fault"
> messages, which scrolls away the usefull info. I don't know
> if this is a safe change.
> 
> setup.c: killed wrong setup_early_printk() prototype.
> Moved setup_early_printk() a bit earlier, as it was not
> "early enough" to cover the bug I was fighting with.
> 
> early_printk.c: made it to start printing from the bottom
> of the screen, otherwise the messages interfere with the
> ones of the boot-loader, so you can't read them.
> 
> main.c: moved smp_prepare_boot_cpu() call earlier. This
> was necessary because otherwise printk() can't print
> It checks cpu_online(), which returns false. This change
> is consistent with the UP case, where's the boot CPU is
> "online" from the very beginning, AFAICS. But again, I am
> not entirely sure whether this is safe.
> 

They all sound like good stuff - I'll take a look, thanks.

> OK, so with that patch I was hoping to collect some debug
> info. It turned out though, that the main.c change also
> fixes the problem itself. The lockup was happening in an
> __alloc_bootmem_core(): the "if (!size)" check was succeeding,
> and the BUG() was triggering. After my main.c change this no
> longer happens, but I don't know where the problem was.
> 
> I still can't boot the kernel because of this
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0602.2/1244.html
> but at least I know that with the attached patch, the boot
> process goes much further.
> 

Sorry, this was hot-fixed.  See
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/hot-fixes/.
 You'll want revert-register-sysfs-device-for-lp-devices.patch.  May as
well apply the others, too..
