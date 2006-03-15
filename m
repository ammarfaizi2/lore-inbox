Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWCOWeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWCOWeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWCOWeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:34:04 -0500
Received: from mail.dvmed.net ([216.237.124.58]:1419 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932221AbWCOWeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:34:02 -0500
Message-ID: <44189654.2080607@garzik.org>
Date: Wed, 15 Mar 2006 17:33:56 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
 ticks on PM timer]
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu>
In-Reply-To: <20060315221119.GA21775@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> the patch below is a blind shot into the dark: it turns on MMIO for the 
> sata_nv driver. But be careful with it - this turns on a probably 
> totally untested mode in the driver and thus may damage your data. (It 
> might not even work at all because the driver might not be ready for it 
> - Jeff?).  I'd suggest to first boot into single-user mode with all 
> filesystems readonly mounted.
> 
> on the low chance of this patch actually working, the interesting thing 
> would be to check whether the latencies occur in MMIO mode too? (if they 
> do then please send us the new latency traces too.)
> 
> 	Ingo
> 
> ---------
> 
> WARNING: this may damage your data. Be careful ...
> 
>  drivers/scsi/sata_nv.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> Index: linux/drivers/scsi/sata_nv.c
> ===================================================================
> --- linux.orig/drivers/scsi/sata_nv.c
> +++ linux/drivers/scsi/sata_nv.c
> @@ -280,6 +280,7 @@ static struct ata_port_info nv_port_info
>  	.host_flags	= ATA_FLAG_SATA |
>  			  /* ATA_FLAG_SATA_RESET | */
>  			  ATA_FLAG_SRST |
> +			  ATA_FLAG_MMIO |
>  			  ATA_FLAG_NO_LEGACY,

It won't work at all...

You have to stop talking to PCI IDE registers completely (consumes 5 PCI 
BARs), and talk exclusively to the MMIO 6th PCI BAR, at non-standard 
offsets and a using a proprietary DMA descriptor format [all public now 
in that link I just sent].

My main workstation has one:
> 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
>         Subsystem: Hewlett-Packard Company: Unknown device 1500
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 0 (750ns min, 250ns max)
>         Interrupt: pin A routed to IRQ 201
>         Region 0: I/O ports at 28e0 [size=8]
>         Region 1: I/O ports at 2c00 [size=4]
>         Region 2: I/O ports at 28e8 [size=8]
>         Region 3: I/O ports at 2c04 [size=4]
>         Region 4: I/O ports at 28c0 [size=16]
>         Region 5: Memory at f2103000 (32-bit, non-prefetchable) [size=4K]

Regards,

	Jeff


