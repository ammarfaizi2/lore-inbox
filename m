Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVAGTxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVAGTxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVAGTwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:52:46 -0500
Received: from zaphod.axian.com ([64.122.196.146]:4295 "EHLO zaphod.axian.com")
	by vger.kernel.org with ESMTP id S261575AbVAGTve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:51:34 -0500
Subject: Re: oops in snmp6_unregister_dev()
From: Terry Griffin <terryg@axian.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1105124721.30138.77.camel@tux.hq.axian.com>
References: <1105124721.30138.77.camel@tux.hq.axian.com>
Content-Type: text/plain
Message-Id: <1105127489.30138.80.camel@tux.hq.axian.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 11:51:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I may have been wrong about that user-space workaround.
It's not 100% reliable.

I previously wrote:
> Hi all,
> 
> I'm getting an oops in snmp6_unregister_dev(). I've replicated the
> problem with these kernels:
> 
>   Pre-built 2.6.9-1.6_FC2 (Fedora Core 2)
>   Pre-built 2.6.9-1.11_FC2 (Fedora Core 2)
>   Custom-built 2.6.10 (kernel.org)
> 
> The oops message below is from 2.6.9-1.11_FC2.
> 
> The trigger is these commands in rapid succession:
> 
>   service dhcpd stop
>   ifdown eth2
>   ifconfig eth2 0.0.0.0
> 
> The ifconfig command is not required to trigger the oops but it
> dramatically increases the odds of it happening to better than
> 90%. Without the ifconfig command the odds of getting the oops
> are much lower, less than 10%.
> 
> The service and ifdown scripts, and the ifconfig utility
> are those included with FC2.
> 
> Interface eth2 is associated with the r8169 device driver. The
> DHCP server is configured to dish out leases on this interface.
> 
> The user-space workaround is to insert delays between the commands
> as follows:
> 
>   service dhcpd stop
>   sleep 1
>   ifdown eth2
>   sleep 1
>   ifconfig eth2 0.0.0.0
> 
> The oops message text below was hand typed so their could be some
> errors.
> 
> Thanks,
> Terry
> 
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000a
>  printing eip:
> c019f200
> *pde = 1faf3067
> Oops: 0000 [#1]
> Modules linked in: r8169 microcode dm_mod uhci_hcd ehci_hdc e100 mii
> appletalk ipx md5 ipv6 ext3 jbd
> CPU:    0
> EIP:    0060:[<c019f200>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.9-1.11_FC2)
> EIP is at remove_proc_entry+0x2f/0xe3
> eax: 00000000   ebx: 0000000a   ecx: ffffffff   edx: de100200
> esi: ddce6000   edi: 0000000a   ebp: c03d9fd0   esp: c03d9f80
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c03d9000 task=c034cb80)
> Stack: de100200 0000000a dfd24800 ddce6000 00000000 c03d9fd0 e09691d7
> dfd24800
>        e094b025 dd9e6e80 dddf2680 c02a63e1 dddf2680 c0421ce0 c03529e0
> c02a606f
>        00000000 c02a5fc4 c0128666 c03d9fd0 c03d9fd0 c03d9fd0 00000000
> 00000001
> Call Trace:
>  [<e09691d7>] snmp6_unregister_dev+0x2f/0x3e [ipv6]
>  [<e094b025>] in6_dev_finish_destroy+0x70/0x7f [ipv6]
>  [<c02a63e1>] dst_destroy+0x60/0xa7
>  [<c02a606f>] dst_run_gc+0xab/0x18a
>  [<c02a5fc4>] dst_run_gc+0x0/0x18a
>  [<c0128666>] run_timer_softirq+0x1e3/0x2e1
>  [<c0124b41>] __do_softirq+0x35/0x79
>  [<c01093e7>] do_softirq+0x3a/0x41
>  =======================
>  [<c0108993>] do_IRQ+0x239/0x242
>  [<c0106468>] common_interrupt+0x18/0x20
>  [<c0116418>] apm_bios_call_simple+0x5e/0x95
>  [<c02f0000>] __xfrm_state_delete+0xe8/0x160
>  [<c0116523>] apm_do_idle+0x12/0x5c
>  [<c0116637>] apm_cpu_idle+0xab/0x121
>  [<c010408c>] cpu_idle+0x1f/0x34
>  [<c03af6bc>] start_kernel+0x20f/0x211
> Code: 56 53 55 55 89 14 24 89 44 24 04 75 13 8d 4c 24 04 89 e2 e8 42 f4
> ff ff 85 c0 0f 85 b7 00 00 00 8b 5c 24 04 31 c0 83 c9 ff 89 df <f2> ae
> f7 d1 49 8b 04 24 89 cd 8d 70 34 83 78 34 00 0f 84 95 00
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

