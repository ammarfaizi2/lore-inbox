Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268713AbUJEAFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268713AbUJEAFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUJEAFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:05:37 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:7824 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268713AbUJEAFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:05:05 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.9-rc3-mm2
Date: Tue, 5 Oct 2004 02:05:58 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200410041634.24937.annabellesgarden@yahoo.de> <20041004212633.GA13527@elte.hu> <20041004143738.5ca9c43f.akpm@osdl.org>
In-Reply-To: <20041004143738.5ca9c43f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410050205.58155.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag 04 Oktober 2004 23:37 schrieb Andrew Morton:
> Ingo Molnar <mingo@elte.hu> wrote:
> > Must not put side-effects into a macro that is NOP on
> > !SMP.
>
> This one, too:
>
> diff -puN
> include/linux/netfilter_ipv4/ip_conntrack.h~conntrack-preempt-safety-fix
> include/linux/netfilter_ipv4/ip_conntrack.h ---
> 25/include/linux/netfilter_ipv4/ip_conntrack.h~conntrack-preempt-safety-fix
>	Mon Oct  4 14:36:19 2004 +++
> 25-akpm/include/linux/netfilter_ipv4/ip_conntrack.h	Mon Oct  4 14:37:02
> 2004 @@ -311,10 +311,11 @@ struct ip_conntrack_stat
>  	unsigned int expect_delete;
>  };
>
> -#define CONNTRACK_STAT_INC(count)				\
> -	do {							\
> -		per_cpu(ip_conntrack_stat, get_cpu()).count++;	\
> -		put_cpu();					\
> +#define CONNTRACK_STAT_INC(count)					\
> +	do {								\
> +		preempt_disable();					\
> +		per_cpu(ip_conntrack_stat, smp_processor_id()).count++;	\
> +		preempt_disable();					\
>  	} while (0)
>
>  /* eg. PROVIDES_CONNTRACK(ftp); */
> _

Applied this and Ingos patch. The machine boots up now with one badness only:
>>>>
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
Badness in enable_irq 
at /home/ka/kernel/2.6/linux-2.6.9-rc3-mm2/kernel/irq/manage.c:106
 [<c013c561>] enable_irq+0x101/0x110
 [<c0237a13>] e100_up+0x163/0x220
 [<c0236df0>] e100_intr+0x0/0x150
 [<c0238c90>] e100_open+0x30/0x80
 [<c0289bab>] dev_open+0x8b/0xa0
 [<c028daa4>] dev_mc_upload+0x24/0x50
 [<c028b32a>] dev_change_flags+0x12a/0x150
 [<c02c9d87>] devinet_ioctl+0x277/0x710
 [<c01c1a8e>] copy_to_user+0x3e/0x50
 [<c02cc2c6>] inet_ioctl+0x66/0xb0
 [<c0281129>] sock_ioctl+0xc9/0x260
 [<c0170a5a>] sys_ioctl+0xea/0x250
 [<c0118450>] do_page_fault+0x0/0x618
 [<c010620d>] sysenter_past_esp+0x52/0x71
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
<<<<

uhci_hcd is not loaded yet. After "modprobe uhci_hcd" another badness:
>>>>
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 9 for device 0000:00:07.2
PCI: Sharing IRQ 9 with 0000:00:07.3
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:00:07.2: irq 9, io base 0xa400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 9 for device 0000:00:07.3
PCI: Sharing IRQ 9 with 0000:00:07.2
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
uhci_hcd 0000:00:07.3: irq 9, io base 0xa800
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Badness in remove_proc_entry 
at /home/ka/kernel/2.6/linux-2.6.9-rc3-mm2/fs/proc/generic.c:688
 [<c018eee9>] remove_proc_entry+0x109/0x150
 [<d08a3107>] uhci_hcd_init+0x107/0x122 [uhci_hcd]
 [<c0139617>] sys_init_module+0x227/0x250
 [<c010620d>] sysenter_past_esp+0x52/0x71
<<<<

(nothing else done, ) the following "rmmod uhci_hcd" results in a NULL pointer 
dereference:
>>>>
uhci_hcd 0000:00:07.2: remove, state 1
usb usb1: USB disconnect, address 1
uhci_hcd 0000:00:07.2: USB bus 1 deregistered
uhci_hcd 0000:00:07.3: remove, state 1
usb usb2: USB disconnect, address 1
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c018ee07
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: uhci_hcd apm via686a eeprom i2c_sensor i2c_isa i2c_viapro 
i2c_core parport_pc lp parport snd_via82xx snd_ac97_codec snd_pcm snd_timer 
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore nfsd 
exportfs lockd sunrpc nls_iso8859_1 nls_cp437 vfat fat nls_utf8 ntfs ext3 jbd 
sym53c8xx scsi_transport_spi sd_mod scsi_mod
CPU:    0
EIP:    0060:[<c018ee07>]    Not tainted VLI
EFLAGS: 00210246   (2.6.9-rc3-mm2)
EIP is at remove_proc_entry+0x27/0x150
eax: 00000000   ebx: cffdb800   ecx: ffffffff   edx: 00000000
esi: c13e1200   edi: 00000000   ebp: c52ba000   esp: c52bbe88
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 3243, threadinfo=c52ba000 task=cc2f6dd0)
Stack: c52ba000 00000003 cc88c620 c01bd93e 00000000 c56b1540 c13e1200 c03aeb60
       c013c763 00000000 cffdb800 c52ba000 00200212 00000009 c13e1200 c1293400
       c1293444 c52ba000 c026f877 00000009 c13e1200 c129349c 00000001 c1293400
Call Trace:
 [<c01bd93e>] kobject_put+0x1e/0x30
 [<c013c763>] free_irq+0x93/0x100
 [<c026f877>] usb_hcd_pci_remove+0xb7/0x190
 [<c01c9596>] pci_device_remove+0x76/0x80
 [<c021b2e6>] device_release_driver+0x66/0x70
 [<c021b31b>] driver_detach+0x2b/0x40
 [<c021b7bc>] bus_remove_driver+0x4c/0x90
 [<c021bd13>] driver_unregister+0x13/0x30
 [<c01c9816>] pci_unregister_driver+0x16/0x30
 [<d0a3ff9f>] uhci_hcd_cleanup+0xf/0x66 [uhci_hcd]
 [<c01372b5>] sys_delete_module+0x155/0x180
 [<c0150f87>] sys_munmap+0x47/0x70
 [<c010620d>] sysenter_past_esp+0x52/0x71
Code: 00 00 00 00 57 56 53 83 ec 14 8b 5c 24 28 8b 54 24 24 85 db 89 54 24 10 
0f 84 03 01 00 00 8b 54 24 10 31 c0 b9 ff ff ff ff 89 d7 <f2> ae f7 d1 49 8b 
43 34 89 ce 8d 7b 34 85 c0 74 30 90 8d b4 26
<<<<

2.6.9-rc3 is ok, though there is some floppy head seaking noise which I don't 
understand the reason for on "rmmod uhci_hcd".
Nothing is connected to the uhci ports.
.config and machine is the same as in the previous e-mail.

Thanks,
Karsten


