Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbVLRTyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbVLRTyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbVLRTyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:54:20 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:7618 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S965256AbVLRTyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:54:19 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: gcoady@gmail.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.15-rc5-mm3
Date: Mon, 19 Dec 2005 06:54:02 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <9hebq1p0t3ldrsedvn1pvdkt7ofsven6gb@4ax.com>
References: <20051214234016.0112a86e.akpm@osdl.org> <276aq1pc2us3np77rd8p6gvifbdj4nf2vd@4ax.com> <200512181231.55981.rjw@sisk.pl>
In-Reply-To: <200512181231.55981.rjw@sisk.pl>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Dec 2005 12:31:55 +0100, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

>Hi,
>
>On Sunday, 18 December 2005 09:16, Grant Coady wrote:
>> On Wed, 14 Dec 2005 23:40:16 -0800, Andrew Morton <akpm@osdl.org> wrote:
>> 
>> >  Probably-unfixed bugs from -mm1 and -mm2 include:
>> [...]
>> >  - Grant Coady <grant_lkml@dodo.com.au>: "Locked up on boot just after
>> >    USB 2.0 initialised, EHCI 1.00 ..."
>> 
>> With ehci compiled in I get a kernel panic during boot, ehci as module 
>> and the things boots.  Then 'modprobe ehci_hcd' provokes a similar panic :(
>> 
>> Nothing useful in logs.
>
>Could you please use the appended patch and see if that makes things better
>(or worse)?
>
>Greetings,
>Rafael
>
>
> drivers/usb/host/ehci-hcd.c |    2 +-
> 1 files changed, 1 insertion(+), 1 deletion(-)
>
>Index: linux-2.6.15-rc5-mm2/drivers/usb/host/ehci-hcd.c
>===================================================================
>--- linux-2.6.15-rc5-mm2.orig/drivers/usb/host/ehci-hcd.c	2005-12-11 13:57:27.000000000 +0100
>+++ linux-2.6.15-rc5-mm2/drivers/usb/host/ehci-hcd.c	2005-12-13 22:10:53.000000000 +0100
>@@ -617,7 +617,7 @@
> 	}
> 
> 	/* remote wakeup [4.3.1] */
>-	if ((status & STS_PCD) && device_may_wakeup(&hcd->self.root_hub->dev)) {
>+	if (status & STS_PCD) {
> 		unsigned	i = HCS_N_PORTS (ehci->hcs_params);
> 
> 		/* resume root hub? */

Looks good to me! :)

Box info: http://bugsplatter.mine.nu/test/boxen/sempro/ for dmesg, etc.

SktA Sempron on VIA chipset, 2 x SATA HDD.

linux-2.6.15-rc5-mm3a - ehci_hcd compiled in, insert CF memory:

Dec 19 07:34:55 sempro kernel: usb 1-6: new high speed USB device using ehci_hcd and address 3
Dec 19 07:34:55 sempro kernel: usb 1-6: configuration #1 chosen from 1 choice
Dec 19 07:34:55 sempro kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Dec 19 07:35:02 sempro kernel:   Vendor: OTi       Model: CF CARD Reader    Rev: 2.00
Dec 19 07:35:02 sempro kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Dec 19 07:35:02 sempro kernel: SCSI device sdc: 1000944 512-byte hdwr sectors (512 MB)
Dec 19 07:35:02 sempro kernel: sdc: Write Protect is off
Dec 19 07:35:02 sempro kernel: SCSI device sdc: 1000944 512-byte hdwr sectors (512 MB)
Dec 19 07:35:02 sempro kernel: sdc: Write Protect is off
Dec 19 07:35:02 sempro kernel:  sdc: sdc1
Dec 19 07:35:02 sempro kernel: sd 2:0:0:0: Attached scsi removable disk sdc

linux-2.6.15-rc5-mm3b - ehci_hcd module, insert CF memory, remove CF, 
  modprobe ehci-hcd, insert CF again:

Dec 19 07:39:24 sempro kernel: usb 2-2: new full speed USB device using uhci_hcd and address 2
Dec 19 07:39:25 sempro kernel: usb 2-2: configuration #1 chosen from 1 choice
Dec 19 07:39:25 sempro kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Dec 19 07:39:32 sempro kernel:   Vendor: OTi       Model: CF CARD Reader    Rev: 2.00
Dec 19 07:39:32 sempro kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Dec 19 07:39:32 sempro kernel: SCSI device sdc: 1000944 512-byte hdwr sectors (512 MB)
Dec 19 07:39:32 sempro kernel: sdc: Write Protect is off
Dec 19 07:39:32 sempro kernel: SCSI device sdc: 1000944 512-byte hdwr sectors (512 MB)
Dec 19 07:39:32 sempro kernel: sdc: Write Protect is off
Dec 19 07:39:32 sempro kernel:  sdc: sdc1
Dec 19 07:39:32 sempro kernel: sd 2:0:0:0: Attached scsi removable disk sdc
Dec 19 07:39:51 sempro kernel: usb 2-2: USB disconnect, address 2
Dec 19 07:40:02 sempro sshd[563]: Accepted publickey for root from 192.168.1.31 port 3009 ssh2
Dec 19 07:40:14 sempro kernel: ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 17
Dec 19 07:40:14 sempro kernel: PCI: Via IRQ fixup for 0000:00:10.4, from 10 to 1
Dec 19 07:40:14 sempro kernel: ehci_hcd 0000:00:10.4: EHCI Host Controller
Dec 19 07:40:14 sempro kernel: ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 3
Dec 19 07:40:14 sempro kernel: ehci_hcd 0000:00:10.4: irq 17, io mem 0xee201000
Dec 19 07:40:14 sempro kernel: ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Dec 19 07:40:14 sempro kernel: usb usb3: configuration #1 chosen from 1 choice
Dec 19 07:40:14 sempro kernel: hub 3-0:1.0: USB hub found
Dec 19 07:40:14 sempro kernel: hub 3-0:1.0: 6 ports detected
Dec 19 07:40:14 sempro kernel: usb 1-1: USB disconnect, address 2
Dec 19 07:40:15 sempro kernel: usb 1-1: new low speed USB device using uhci_hcd and address 3
Dec 19 07:40:15 sempro kernel: usb 1-1: configuration #1 chosen from 1 choice
Dec 19 07:40:15 sempro kernel: input: Microsoft Microsoft 5-Button Mouse with IntelliEye(TM) as /class/input/input3
Dec 19 07:40:15 sempro kernel: input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with IntelliEye(TM)] on usb-0000:00:10.0-1
Dec 19 07:40:30 sempro kernel: usb 3-6: new high speed USB device using ehci_hcd and address 3
Dec 19 07:40:30 sempro kernel: usb 3-6: configuration #1 chosen from 1 choice
Dec 19 07:40:30 sempro kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Dec 19 07:40:37 sempro kernel:   Vendor: OTi       Model: CF CARD Reader    Rev: 2.00
Dec 19 07:40:37 sempro kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Dec 19 07:40:37 sempro kernel: SCSI device sdc: 1000944 512-byte hdwr sectors (512 MB)
Dec 19 07:40:37 sempro kernel: sdc: Write Protect is off
Dec 19 07:40:37 sempro kernel: SCSI device sdc: 1000944 512-byte hdwr sectors (512 MB)
Dec 19 07:40:37 sempro kernel: sdc: Write Protect is off
Dec 19 07:40:37 sempro kernel:  sdc: sdc1
Dec 19 07:40:37 sempro kernel: sd 3:0:0:0: Attached scsi removable disk sdc

Thanks,
Grant.
