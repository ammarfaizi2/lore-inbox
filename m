Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965521AbWJBXWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965521AbWJBXWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965538AbWJBXWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:22:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965533AbWJBXWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:22:32 -0400
Date: Mon, 2 Oct 2006 16:22:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>, suka@us.ibm.com
Subject: Re: 2.6.18-mm2 networking problem + IRQ panic
Message-Id: <20061002162227.1096ac17.akpm@osdl.org>
In-Reply-To: <1159830432.5039.16.camel@dyn9047017100.beaverton.ibm.com>
References: <1159830432.5039.16.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2006 16:07:12 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> Hi,
> 
> I am having problem bringing up networking on 2.6.18-mm2.
> I don't see any interrupts for eth0. I also see "cannot 
> handle IRQ" panic on shutdown - wondering if they are related..
> 
>            CPU0       CPU1       CPU2       CPU3
>   0:     112736     117883     117738     123737    IO-APIC-edge  timer
>   1:          0          0          1         10    IO-APIC-edge  i8042
>   4:          0          1          0        477    IO-APIC-edge  serial
>   6:          0          0          0          5    IO-APIC-edge  floppy
>   8:          0          0          0          0    IO-APIC-edge  rtc
>   9:          0          0          0          0   IO-APIC-level  acpi
>  12:          0         42          6         65    IO-APIC-edge  i8042
>  14:       4869       1911       3449       6079    IO-APIC-edge  ide0
>  15:          0      11051       4806        847    IO-APIC-edge  ide1
>  17:      55636          0          5          0   IO-APIC-level  eth0
> NMI:        216         40         38         41
> LOC:     471992     471992     472046     471481
> ERR:          0
> MIS:          0
> 
> 
> Everything works fine on 2.6.18.
> 
> (I saw similar report by Sukadev on 2.6.18-mm1).
> dmesg shows (similar messages about unable to allocate messages):
> 
> PCI: Cannot allocate resource region 0 of device 0000:08:01.1
> PCI: Cannot allocate resource region 0 of device 0000:08:02.1
> PCI: Cannot allocate resource region 0 of device 0000:08:03.1
> PCI: Cannot allocate resource region 0 of device 0000:08:04.1
> 

yes, this is probably the insert-ioapics-and-local-apic-into-resource-map
patch.  Does mainline crash too?  It should.  Or at least, it should have
the same resource allocation errors.

I've backed that out and applied an updated version.  My current rollup
(which actually seems to mostly compile now) is at

http://userweb.kernel.org/~akpm/badari.bz2

That's against 2.6.18.  Can you see if that fixes things?

> 
> INIT:do_IRQ: cannot handle IRQ -1
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at arch/x86_64/kernel/irq.c:118
> invalid opcode: 0000 [1] SMP
> last sysfs file: /devices/pci0000:00/0000:00:06.0/irq
> CPU 1
> Modules linked in: acpi_cpufreq ipv6 thermal processor fan button
> battery ac dm_mod floppy parport_pc lp parport
> Pid: 1, comm: init Not tainted 2.6.18-mm2 #1
> RIP: 0010:[<ffffffff8020ced0>]
> 

Once upon a time we'd have got a backtrace from that.
