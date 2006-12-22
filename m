Return-Path: <linux-kernel-owner+w=401wt.eu-S1754845AbWLVOBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbWLVOBG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbWLVOBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:01:06 -0500
Received: from smtp1.telegraaf.nl ([217.196.45.193]:56094 "EHLO
	smtp1.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbWLVOBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:01:04 -0500
Date: Fri, 22 Dec 2006 15:00:59 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061222140059.GD31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222103005.GC31882@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222103005.GC31882@telegraafnet.nl>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 11:30:05AM +0100, Ard -kwaak- van Breemen wrote:
> Anyway: on to the ide_setup tracking....
> (I've noticed that the notifier of this problem als has idebus=66
> or something similar, so that explains in his case the
> early call to ide_setup.)

Aaarrgh...
Somewhere between the call to ide_setup and ide_init_hwif_ports
the interrupts get enabled. But I haven't got to the point where
exactly...

include/linux/ide.h:
    266 /*
    267  * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
    268  * New ports shouldn't define IDE_ARCH_OBSOLETE_INIT in <asm/ide.h>.
    269  */
    270 #ifdef IDE_ARCH_OBSOLETE_INIT
    271 static inline void ide_init_hwif_ports(hw_regs_t *hw,
    272                                        unsigned long io_addr,
    273                                        unsigned long ctl_addr,
    274                                        int *irq)
    275 {
    276         if (!irqs_disabled()) printk(__FILE__ "%s(): blaat: interrupts were enabled early@%d\n",__FUNCTION__,__LINE__);
    277         if (!ctl_addr) {
    278                 ide_std_init_ports(hw, io_addr, ide_default_io_ctl(io_addr));

drivers/ide/ide.c:
    256 static void init_hwif_default(ide_hwif_t *hwif, unsigned int index)
    257 {
    258         hw_regs_t hw;
    259 
    260         if (!irqs_disabled()) printk(__FILE__ "%s(): blaat: interrupts were enabled early@%d\n",__FUNCTION__,__LINE__);
    261         memset(&hw, 0, sizeof(hw_regs_t));
    262         if (!irqs_disabled()) printk(__FILE__ "%s(): blaat: interrupts were enabled early@%d\n",__FUNCTION__,__LINE__);
    263 
    264         ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
    265         if (!irqs_disabled()) printk(__FILE__ " %s(): blaat: interrupts were enabled early@%d\n",__FUNCTION__,__LINE__);
    266 

dmesg:
BLAAT20Parsing ARGS: console=tty0 console=ttyS0,115200 hdb=noprobe hdc=noprobe hdd=noprobe root=/dev/md0 ro panic
=30 earlyprintk=serial,ttyS0,115200 
Unknown argument: calling ffffffff80643380
Unknown argument: calling ffffffff80643380
Unknown argument: calling ffffffff80643380
ide_setup: hdb=noprobeinclude/linux/ide.hide_init_hwif_ports(): blaat: interrupts were enabled early@276
include/linux/ide.hide_init_hwif_ports(): blaat: interrupts were enabled early@279
include/linux/ide.hide_init_hwif_ports(): blaat: interrupts were enabled early@284
include/linux/ide.hide_init_hwif_ports(): blaat: interrupts were enabled early@289
drivers/ide/ide.c init_hwif_default(): blaat: interrupts were enabled early@265
drivers/ide/ide.cinit_hwif_default(): blaat: interrupts were enabled early@269
drivers/ide/ide.cinit_ide_data(): blaat: interrupts were enabled early@317

So as I read it: init_hwif_default calls ide_init_hwif_ports with irq's
disabled, but upon entrance, the irq's are enabled.
That really makes no sense to me.
So I will continue digging this code (there must be something recursive going
on).
-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.
