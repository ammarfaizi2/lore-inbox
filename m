Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754126AbWKHEHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbWKHEHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 23:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbWKHEHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 23:07:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754126AbWKHEHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 23:07:24 -0500
Date: Tue, 7 Nov 2006 20:07:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: ak@suse.de, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, ashok.raj@intel.com
Subject: Re: [patch 0/4] i386, x86_64: fix the irqbalance quirk for
 E7520/E7320/E7525
Message-Id: <20061107200702.8abac851.akpm@osdl.org>
In-Reply-To: <20061107173306.C3262@unix-os.sc.intel.com>
References: <20061107173306.C3262@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 17:33:06 -0800
"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:

> Mechanism of selecting physical mode in genapic when cpu hotplug is enabled
> on x86_64, broke the quirk(quirk_intel_irqbalance()) introduced for working
> around the transposing interrupt message errata in E7520/E7320/E7525
> (revision ID 0x9 and below. errata #23 in 
> http://download.intel.com/design/chipsets/specupdt/30304203.pdf).
> 
> This errata requires the mode to be in logical flat, so that interrupts
> can be directed to more than one cpu(and thus use hardware IRQ balancing
> enabled by BIOS on these platforms).
> 
> Following four patches fixes this by moving the quirk to early quirk
> and forcing the x86_64 genapic selection to logical flat on these platforms.
> 
> Thanks to Shaohua for pointing out the breakage.

It blew up with the first config I tried
(http://userweb.kernel.org/~akpm/config-vmm.txt):

arch/i386/kernel/built-in.o: In function `verify_quirk_intel_irqbalance':
arch/i386/kernel/quirks.c:19: undefined reference to `genapic'
arch/i386/kernel/quirks.c:19: undefined reference to `apic_default'
arch/i386/kernel/built-in.o: In function `__cpu_up':
arch/i386/kernel/smpboot.c:1487: undefined reference to `genapic'
arch/i386/kernel/smpboot.c:1487: undefined reference to `apic_default'

The dependencies in the code which you're touching here are really really
complex and fragile.  One needs to review the change very carefully and
test it exhaustively.

