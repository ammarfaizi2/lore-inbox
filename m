Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTHKQcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272788AbTHKQc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:32:28 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:51139 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264448AbTHKQ3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:29:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16183.50273.723650.136532@gargle.gargle.HOWL>
Date: Mon, 11 Aug 2003 18:29:21 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: davej@redhat.com
Cc: torvalds@transmeta.com, fxkuehl@gmx.de, linux-kernel@vger.kernel.org,
       willy@w.ods.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] Disable APIC on reboot.
In-Reply-To: <E19mCuO-0003dI-00@tetrachloride>
References: <E19mCuO-0003dI-00@tetrachloride>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@redhat.com writes:
 > diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/reboot.c linux-2.5/arch/i386/kernel/reboot.c
 > --- bk-linus/arch/i386/kernel/reboot.c	2003-05-13 11:51:12.000000000 +0100
 > +++ linux-2.5/arch/i386/kernel/reboot.c	2003-07-16 02:54:29.000000000 +0100
 > @@ -8,6 +8,7 @@
 >  #include <linux/interrupt.h>
 >  #include <linux/mc146818rtc.h>
 >  #include <asm/uaccess.h>
 > +#include <asm/apic.h>
 >  #include "mach_reboot.h"
 >  
 >  /*
 > @@ -250,6 +251,19 @@ void machine_restart(char * __unused)
 >  	 */
 >  	smp_send_stop();
 >  	disable_IO_APIC();
 > +#else
 > +#ifdef CONFIG_X86_LOCAL_APIC
 > +	{
 > +	unsigned int l, h;
 > +
 > +	local_irq_disable();
 > +	disable_local_APIC();
 > +	rdmsr(MSR_IA32_APICBASE, l, h);
 > +	l &= ~MSR_IA32_APICBASE_ENABLE;
 > +	wrmsr(MSR_IA32_APICBASE, l, h);
 > +	local_irq_enable();
 > +}
 > +#endif

I agree we should probably disable the local APIC at reboot if we
enabled it previously, but this patch is broken. CONFIG_X86_LOCAL_APIC
doesn't imply that the CPU actually has one, and even if it does, the
access method may be different (e.g. P5 vs P6/K7/P4, and who knows how
the future C3 with local APIC will do it).

Only apic.c knows how the local APIC was initialised (if at all), so the
"disable it dammit" procedure needs to be in apic.c too.

Was the original bug report posted to LKML? I don't remember seeing it.

/Mikael
