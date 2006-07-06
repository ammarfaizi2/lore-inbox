Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWGFL6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWGFL6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 07:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbWGFL6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 07:58:11 -0400
Received: from canuck.infradead.org ([205.233.218.70]:5304 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S965132AbWGFL6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 07:58:10 -0400
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 12:58:03 +0100
Message-Id: <1152187083.2987.117.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 10:52 +0200, Haavard Skinnemoen wrote:
> Hi everyone,
> 
> I've put up an updated set of patches for AVR32 support at
> http://avr32linux.org/twiki/bin/view/Main/LinuxPatches
> 
> The most interesting patch probably is
> http://avr32linux.org/twiki/pub/Main/LinuxPatches/avr32-arch-2.patch

Please add include/asm-avr32/Kbuild which lists those files which need
to be present in /usr/include/asm, over and above those listed in
asm-generic/Kbuild.asm. Then run 'make headers_install' and review the
exported headers to make sure they're suitable for building glibc, etc.

Should probably drop the #ifdef __KERNEL__ from asm/atomic.h. There's no
excuse for anything non-kernel to be using atomic.h, so by the time you
merge that'll probably have been taken out of asm-generic/Kbuild.asm.
Likewise bitops.h and anything else which isn't, or shouldn't be,
exported (including dma-mapping.h, probably also io.h, etc.)

You define PAGE_SIZE in asm/page.h where userspace can see it. No need
for that -- portable userspace must use sysconf(_SC_PAGE_SIZE) anyway --
you can move it inside the #ifdef __KERNEL__ you already have there.

Your posix_types.h wraps __FD_SET et al in 
#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
I suspect that's not at all needed, so it can be fixed to just
__KERNEL__ as we did on s390 recently iirc.

Kill syscall[012456] from your unistd.h -- they aren't used anywhere. In
fact, you might as well kill syscall3() too, since you only use it in
one place for execve. Just do execve 'manually' with the appropriate
inline asm.

Do you really need the EARLY_PRINTK crap? Can't you just register your
proper console nice and early? There's no need to wait for
console_init() and use console_initcall(). You can do it right at the
beginning of setup_arch(), as long as you parse the command line early
enough for console= options. 

You're including <linux/config.h> in a few places -- kill them all.

"DMA controller framework".... isn't that what drivers/dma was recently
invented for? If appropriate, you should probably use that. If not, you
should explain why, and perhaps we should get it fixed.

You're a bit behind on syscall support -- I note you have
TIF_RESTORE_SIGMASK (which means you're ahead of x86_64) but you haven't
wired up ppoll() and pselect(), amongst others.

You say 'MB' in a few places where you actually mean 'MiB', probably
copied from sloppy code elsewhere.

-- 
dwmw2

