Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbUC2E76 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUC2E76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:59:58 -0500
Received: from fmr11.intel.com ([192.55.52.31]:52954 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262635AbUC2E7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:59:52 -0500
Subject: Re: 2.6.5-rc2-mm4 (and 3) IRQ problem
From: Len Brown <len.brown@intel.com>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F68B9@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F68B9@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080536373.16220.196.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Mar 2004 23:59:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need full dmesg (eg. dmesg -s40000) to see if it is related to recent
ACPI changes. like this:

http://bugzilla.kernel.org/show_bug.cgi?id=2366

thanks,
-Len

On Sat, 2004-03-27 at 13:13, Fabio Coatti wrote:
> I'm seeing a problem with ethernet driver (e1000) on 2.6.5-rc2-mm4,
> here the 
> syslog excerpt:
> 
> ========================
> Mar 27 18:39:23 kefk kernel: e1000: eth0 NIC Link is Up 100 Mbps Full
> Duplex
> Mar 27 18:39:23 kefk kernel: irq 18: nobody cared!
> Mar 27 18:39:23 kefk kernel: Call Trace:
> Mar 27 18:39:23 kefk kernel:  [<c010882b>] __report_bad_irq+0x2a/0x8b
> Mar 27 18:39:23 kefk kernel:  [<c0108937>] note_interrupt+0x91/0xaf
> Mar 27 18:39:23 kefk kernel:  [<c0108c4a>] do_IRQ+0x151/0x19a
> Mar 27 18:39:23 kefk kernel:  [<c034b4c8>] common_interrupt+0x18/0x20
> Mar 27 18:39:23 kefk kernel:  [<c0104c2e>] default_idle+0x0/0x2c
> Mar 27 18:39:23 kefk kernel:  [<c0104c57>] default_idle+0x29/0x2c
> Mar 27 18:39:23 kefk kernel:  [<c0104cbb>] cpu_idle+0x2e/0x3c
> Mar 27 18:39:23 kefk kernel:  [<c0430a02>] start_kernel+0x196/0x1c5
> Mar 27 18:39:23 kefk kernel:  [<c0430436>]
> unknown_bootoption+0x0/0x126
> Mar 27 18:39:23 kefk kernel:
> Mar 27 18:39:23 kefk kernel: handlers:
> Mar 27 18:39:23 kefk kernel: [<c02a7b0b>] (ata_interrupt+0x0/0x173)
> Mar 27 18:39:23 kefk kernel: [<c02d2f9c>] (usb_hcd_irq+0x0/0x67)
> Mar 27 18:39:23 kefk kernel: Disabling IRQ #18
> ===========================
> 
> I've seen the same problem on -mm3, but that version has other
> problems that 
> prevents me to do more tests.
> 
> A similar issue was present in earlier kernel when I've tried to use
> SATA 
> driver compiled as modules, same behaviour, solved by compiling SATA
> driver 
> as built-in, not as module. (I've both normal ATA and SATA controllers
> active 
> on my mb)
> 
> under 2.6.5-rc2-mm1, this is the output of cat /proc/interrupts; as
> you can 
> see there is also a nvidia module, but the problem arises event
> without that 
> module. irq 18 is shared between eth0,libata and uhci_hcd.
> 
> [root@kefk root]# cat /proc/interrupts
>            CPU0       CPU1
>   0:    1002506          0    IO-APIC-edge  timer
>   1:       4722          0    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   9:          0          0   IO-APIC-level  acpi
>  12:       8826          0    IO-APIC-edge  i8042
>  14:      11920          0    IO-APIC-edge  ide0
>  15:         23          0    IO-APIC-edge  ide1
>  16:     278123          0   IO-APIC-level  uhci_hcd, uhci_hcd, nvidia
>  17:       2337          0   IO-APIC-level  Intel ICH5
>  18:      56240          0   IO-APIC-level  libata, uhci_hcd, eth0
>  19:         55          0   IO-APIC-level  uhci_hcd
>  22:        279          0   IO-APIC-level  aic7xxx
>  23:          0          0   IO-APIC-level  ehci_hcd
> NMI:          0          0
> LOC:    1002427    1002439
> ERR:          0
> MIS:          0
> 
> The MB is a ABIT IC7-G (i875p) ICH5, the kernel is compiled with
> SMP/SMT 
> support active.
> 
> Please let me know if more details are needed.
> 
> A small question, not related to the above issue:
> reverting 4k-stacks-always-on.patch can lead to problems or it's safe?
> I've to 
> run nvidia binary driver so I've to use 8k instead of 4k; it would be
> better 
> (for my standpoint) to have the possibility to disable 4k from config,
> but to 
> do so I've to revert this patch. Apart from losing time to do a patch
> -R :), 
> using 8k can be a problem?
> 
> Many thanks for any answer.
> 
> -- 
> Fabio Coatti       http://www.ferrara.linux.it/members/cova     
> Ferrara Linux Users Group           http://ferrara.linux.it
> GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
> Old SysOps never die... they simply forget their password.
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

