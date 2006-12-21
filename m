Return-Path: <linux-kernel-owner+w=401wt.eu-S1423094AbWLUVFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423094AbWLUVFn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423110AbWLUVFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:05:43 -0500
Received: from smtp1.telegraaf.nl ([217.196.45.193]:59973 "EHLO
	smtp1.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423094AbWLUVFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:05:42 -0500
Date: Thu, 21 Dec 2006 22:05:38 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061221210538.GU31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2E7C5@pdsmsx404.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117E3EB5059E4E48ADFF2822933287A401F2E7C5@pdsmsx404.ccr.corp.intel.com>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 04:04:04PM +0800, Zhang, Yanmin wrote:
> I couldn't reproduce it on my EM64T machine. I instrumented function start_kernel and
> didn't find irq was enabled before calling init_IRQ. It'll be better if the reporter could
> instrument function start_kernel to capture which function enables irq.

Editing init/main.c:
        preempt_disable();
        if (!irqs_disabled())
                printk("start_kernel(): bug: interrupts were enabled early\n");
                printk("BLAAT17");
        build_all_zonelists();
        if (!irqs_disabled())
                printk("start_kernel(): bug: interrupts were enabled early\n");
                printk("BLAAT18");
        page_alloc_init();
        if (!irqs_disabled())
                printk("start_kernel(): bug: interrupts were enabled early\n");
                printk("BLAAT19");
        printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
        parse_early_param();
        if (!irqs_disabled())
                printk("start_kernel(): bug: interrupts were enabled early\n");
                printk("BLAAT20");
        parse_args("Booting kernel", command_line, __start___param,
                   __stop___param - __start___param,
                   &unknown_bootoption);
                printk("BLAAT21");
        if (!irqs_disabled())
                printk("start_kernel(): bug: interrupts were enabled early\n");
        sort_main_extable();
        if (!irqs_disabled())
                printk("start_kernel(): bug: interrupts were enabled early\n");
                printk("BLAAT22");
        trap_init();
        if (!irqs_disabled())
                printk("start_kernel(): bug: interrupts were enabled early\n");
                printk("BLAAT23");

Results in:
^MAllocating PCI resources starting at 88000000 (gap: 80000000:60000000)
^MBLAAT12BLAAT13<6>PERCPU: Allocating 32960 bytes of per cpu data
^MBLAAT14BLAAT15BLAAT16BLAAT17Built 2 zonelists.  Total pages: 1032635
^MBLAAT18BLAAT19<5>Kernel command line: console=tty0 console=ttyS0,115200 hdb=noprobe hdc=noprobe hdd=noprobe root=/dev/md0 ro panic=30 earlyprintk=serial,ttyS0,115200 
^MBLAAT20<6>ide_setup: hdb=noprobe
^Mide_setup: hdc=noprobe
^Mide_setup: hdd=noprobe
^MBLAAT21start_kernel(): bug: interrupts were enabled early
^Mstart_kernel(): bug: interrupts were enabled early
^MBLAAT22Initializing CPU#0

Hmmm, that actually doesn't make sense to me (unless parse_args is able to enable irq's).
-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.
