Return-Path: <linux-kernel-owner+w=401wt.eu-S1030313AbWLOWsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWLOWsq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 17:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWLOWsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 17:48:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:13692 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030310AbWLOWso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 17:48:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=KOcaUZhxmw8Cxd723r4za5AaNAAtvw2R53tLN2EU6xd3AL8ZFntOkjJIpGK8EcaW+q8TnGCnLllpFEGOKas+BtBIbulIjZ87PRpGgMNI/OFr1SVN/Ay6xqMl0+aeodfCs+Uq1LCLBwNypmme1fC0N9nkAUDWDIL1BI1L5wGAOQU=
Message-ID: <4583263C.3070403@gmail.com>
Date: Fri, 15 Dec 2006 23:48:05 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: OOPS: deref 0x14 at pdc_port_start+0x82 [Was: 2.6.20-rc1-mm1]
References: <20061214225913.3338f677.akpm@osdl.org>	<4582B53A.8010809@gmail.com> <20061215112412.d92dfceb.akpm@osdl.org>
In-Reply-To: <20061215112412.d92dfceb.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 15 Dec 2006 15:45:55 +0059
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Andrew Morton wrote:
>>> Temporarily at
>>>
>>> 	http://userweb.kernel.org/~akpm/2.6.20-rc1-mm1/
>>>
>>> Will appear later at
>>>
>>> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc1/2.6.20-rc1-mm1/
>> The kernel panics at boot in pdc_port_start+0x82 with deref of 0x14:
>> http://www.fi.muni.cz/~xslaby/sklad/pdc_oops.png
>>
>> ATA port is not connected, only 2 SATA disks on my
>> # lspci -vvxs 02:01.0
>> 02:01.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300
>> TX2plus) (rev 02)
>>         Subsystem: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus)
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B-
>>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 72 (1000ns min, 4500ns max), Cache Line Size: 4 bytes
>>         Interrupt: pin A routed to IRQ 19
>>         Region 0: I/O ports at 8000 [size=128]
>>         Region 2: I/O ports at 8400 [size=256]
>>         Region 3: Memory at fb025000 (32-bit, non-prefetchable) [size=4K]
>>         Region 4: Memory at fb000000 (32-bit, non-prefetchable) [size=128K]
>>         [virtual] Expansion ROM at 50000000 [disabled] [size=32K]
>>         Capabilities: [60] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>> 00: 5a 10 73 3d 07 00 30 02 02 00 80 01 01 48 00 00
>> 10: 01 80 00 00 00 00 00 00 01 84 00 00 00 50 02 fb
>> 20: 00 00 00 fb 00 00 00 00 00 00 00 00 5a 10 73 3d
>> 30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 04 12
>>
> 
> Presumably
> 
>                 void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;
> 
> gave us a null pointer.
> 
> Something like this:
> 
> diff -puN drivers/ata/sata_promise.c~a drivers/ata/sata_promise.c
> --- a/drivers/ata/sata_promise.c~a
> +++ a/drivers/ata/sata_promise.c
> @@ -294,6 +294,10 @@ static int pdc_port_start(struct ata_por
>  		void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;
>  		unsigned int tmp;
>  
> +		if (!mmio) {
> +			rc = -EDOM;
> +			goto out_kfree;
> +		}
>  		tmp = readl(mmio + 0x014);
>  		tmp = (tmp & ~3) | 1;	/* set bits 1:0 = 0:1 */
>  		writel(tmp, mmio + 0x014);
> _
> 
> should perhaps let you wobble to a state where you can get us the full
> dmesg output, please.
> 
> Actually, that should already be possible simply using netconsole.

I set it up and here it comes:
[    6.779351] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 21 (level, low) -> IRQ 19
[    6.779483] sata_promise PATA port found
[    6.779584] ata3: SATA max UDMA/133 cmd 0xF8816200 ctl 0xF8816238 bmdma 0x0
irq 19
[    6.779708] ata4: SATA max UDMA/133 cmd 0xF8816280 ctl 0xF88162B8 bmdma 0x0
irq 19
[    6.779831] BUG: unable to handle kernel NULL pointer dereference at virtual
address 00000014
[    6.779958]  printing eip:
[    6.780020] c02753b9
[    6.780080] *pde = 00000000
[    6.780142] Oops: 0000 [#1]
[    6.780202] SMP
[    6.780328] last sysfs file:
[    6.780389] Modules linked in:
[    6.780488] CPU:    1
[    6.780488] EIP:    0060:[<c02753b9>]    Not tainted VLI
[    6.780490] EFLAGS: 00010202   (2.6.20-rc1-mm1 #203)
[    6.780680] EIP is at pdc_port_start+0x82/0xb0
[    6.780742] eax: 00000001   ebx: f7e3d9a0   ecx: 00000000   edx: 00000000
[    6.780808] esi: f7dcc2e8   edi: 00000000   ebp: c193fe3c   esp: c193fe24
[    6.780873] ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
[    6.780938] Process swapper (pid: 1, ti=c193e000 task=c1923a90 task.ti=c193e000)
[    6.781004] Stack: 000000d0 c1a59a80 c1adcc48 f7ea4000 f88162b8 f7dcc2e8
c193fe90 c026c724
[    6.781398]        00000078 00000004 00000053 c043d998 f8816280 f88162b8
00000000 00000013
[    6.781789]        f7ea4000 f7d91b00 f8816280 c1adcc48 00000013 c1adcc00
00000002 c01de64f
[    6.782180] Call Trace:
[    6.782298]  [<c0103f1b>] show_trace_log_lvl+0x1a/0x30
[    6.782396]  [<c0103fd6>] show_stack_log_lvl+0xa5/0xca
[    6.782494]  [<c01041ce>] show_registers+0x1d3/0x2b8
[    6.782591]  [<c01043d4>] die+0x121/0x243
[    6.782690]  [<c01193b0>] do_page_fault+0x2b8/0x5e8
[    6.782788]  [<c0389e74>] error_code+0x7c/0x84
[    6.782885]  [<c026c724>] ata_device_add+0x1b1/0x516
[    6.782983]  [<c027568e>] pdc_ata_init_one+0x2a7/0x3e9
[    6.783081]  [<c01e057e>] pci_device_probe+0x44/0x5f
[    6.783180]  [<c02432a2>] driver_probe_device+0x75/0x12c
[    6.783279]  [<c0243470>] __driver_attach+0x8c/0x8e
[    6.783376]  [<c02428b3>] bus_for_each_dev+0x44/0x62
[    6.783476]  [<c0243161>] driver_attach+0x19/0x1b
[    6.783574]  [<c0242ba7>] bus_add_driver+0x6a/0x188
[    6.783671]  [<c02436c9>] driver_register+0x54/0x84
[    6.783768]  [<c01e06e0>] __pci_register_driver+0x45/0x73
[    6.783865]  [<c0520f34>] pdc_ata_init+0xf/0x1b
[    6.783967]  [<c01004b6>] init+0x10d/0x310
[    6.784063]  [<c0103bbf>] kernel_thread_helper+0x7/0x18
[    6.784160]  =======================
[    6.784224] Code: 00 8b 45 f0 e8 ca 25 e9 ff 89 03 85 c0 74 32 89 9e 54 20 00
00 8b 45 ec f6 00 01 74 b6 89 f0 e8 99 1b ff ff 85 c0 74 ab 8b 56 64 <8b> 42 14
83 e0 fc 83 c8 01 89 42 14 89 f8 83 c4 0c 5b 5e 5f 5d
[    6.786508] EIP: [<c02753b9>] pdc_port_start+0x82/0xb0 SS:ESP 0068:c193fe24
[    6.786641]  <0>Kernel panic - not syncing: Attempted to kill init!
[    6.787970]

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
