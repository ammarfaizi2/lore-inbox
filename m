Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbULLVtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbULLVtF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbULLVtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:49:05 -0500
Received: from colo.lackof.org ([198.49.126.79]:29601 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262134AbULLVsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:48:55 -0500
Date: Sun, 12 Dec 2004 14:48:03 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: linux-kernel@vger.kernel.org, frahm@irsamc.ups-tlse.fr
Cc: Grant Grundler <grundler@parisc-linux.org>,
       John Linville <linville@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Fwd: 2.6.10-rc3: tulip-driver: tulip_stop_rxtx() failed]
Message-ID: <20041212214803.GB22514@colo.lackof.org>
References: <41BAAC04.6090706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BAAC04.6090706@pobox.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Klaus Frahm wrote:
> I would like give my feedback on a recent modification of the tulip
> driver in 2.6.10-rc3 by:
> 
> John W. Linville:
>   o tulip: make tulip_stop_rxtx() wait for DMA to fully stop

Klaus,
thanks for the feedback. I'm one of the original authors of the patch.

That patch was added prevent the tulip driver from deallocating DMA buffers
while tulip was still doing DMA to consistent memory or RX buffers.
This showed up as an MCA (crash) on faster ia64 (1.6Ghz) HP ZX1 platforms.


> I have a sitecom network card which happens to work with the tulip
> driver. I have observed in the kernel version 2.6.10-rc3 when I
> deconfigure the device with "ifconfig eth1 down" (or also with 
> "dhcpcd -k eth1"), I get the following message in dmesg and
> /var/log/messages:
> 0000:00:0e.0: tulip_stop_rxtx() failed
> The message did not appear until 2.6.10-rc2 and I assume it is due to
> the modification of "John W. Linville" mentioned above. 

Correct - it is.

> This message does not seem to create any problem for me and I do not
> require any assistance. I can configure and deconfigure the device as
> usual and the network card appears to work properly. However, I thought
> this information might be useful for debugging purposes for the
> developer.

I need just one or two more bits of info.
Apologies for not including that in the original patch. (see below)


> Since this is related to DMA this might also be a hardward bug since I
> use a 5 year old motherboard and since 2.4.21 I can no longer use DMA
> for my old cdrom. DMA for the harddisk works properly.

The message does not indicate a new problem on your platform.
And it's unlikely you will run into the same problem the patch
was intended to fix.


>  Furthermore I
> have two network cards, the first one (eth0) is:
> 
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xa800. Vers LK1.1.19
> 
> and the second one is the sitecom card which appears in dmesg as:
> 
> Linux Tulip driver version 1.1.13 (May 11, 2002)
> PCI: Found IRQ 10 for device 0000:00:0e.0
> PCI: Sharing IRQ 10 with 0000:00:0a.0
> tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
> eth1: ADMtek Comet rev 17 at 0001a400, 00:0C:F6:03:DA:D3, IRQ 10.
> 
> When I deactivate my internet connection (I am using a modem which
> provides a dhcp-serveur) by "dhcpcd -k eth1" I obtain in
> /var/log/messages:
> Dec 11 01:14:44 albireo dhcpcd[1867]: terminating on signal 1 
> Dec 11 01:14:44 albireo kernel: 0000:00:0e.0: tulip_stop_rxtx() failed

I'm kicking myself now since I didn't include the CSR5 or CSR6 value from
the last time it was read. Can you manually apply this small change
and try it for me?

-			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed\n",
-					tp->pdev->slot_name);
+			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed"
+					" (CSR5 0x%x CSR6 0x%x)\n",
+					tp->pdev->slot_name,
+					ioread32(ioaddr + CSR5),
+					ioread32(ioaddr + CSR6));

Basically, I need the CSR5/CSR6 contents after the loop is exited.

I expect one of three things to fix this:
o The comet card needs more time than we've allocated.
  Could you also try larger values for "i" in the loop?
  e.g. 2000/10 or 4000/10

o The loop is too "tight" and poking the card every 10us is interfering
  with DMA.  The solution is to change the udelay(10) to 50 or 100
  (and the corresponding "i" value initialization).

o Chip defect. When DMA is stopped, CSR5 Transmit State and Receive
  State machines are expected to be zero. It's possible this chip
  just never sets those states. I suppose we could check CSR6 bits
  to confirm the ST and SR bits are clear before printing the message.
  The CSR6 value above will tell me if that's feasible.


> Dec 11 01:14:44 albireo dhcpcd.exe: interface eth1 has been brought down
> 
> when I reactivate the connection afterwards with "dhcp eth1" I get:
> Dec 11 01:16:09 albireo dhcpcd.exe: interface eth1 has been configured with new IP=xx.xx.xx.xx
> Dec 11 01:16:12 albireo kernel: 0000:00:0e.0: tulip_stop_rxtx() failed
> Dec 11 01:16:12 albireo kernel: eth1: Setting full-duplex based on MII#1 link partner capability of 4061.
> 
> Afterwards the connection works properly. 
> 
> For information the values of /proc/interrupts:
>             CPU0       
>   0:    5010413          XT-PIC  timer
>   1:      10212          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:          0          XT-PIC  uhci_hcd, eth0
>  10:       5357          XT-PIC  eth1, aic7xxx
>  12:     140379          XT-PIC  i8042
>  14:       7021          XT-PIC  ide0
>  15:       1650          XT-PIC  ide1
> NMI:          0 
> ERR:          0
> 
> and of lspci:
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
> 00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
> 00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> 00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
> 00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
> 00:0a.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
> 00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
> 00:0e.0 Ethernet controller: Bridgecom, Inc: Unknown device 0985 (rev 11)
> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c)
> 
> I have no idea if my observation is really important or indicates a bug.

Yes - either a HW bug or it indicates we need to adjust the loop.

> I thought it might be useful to give my feedback before 2.6.10 comes out
> in case there is a bug.

yes - thanks.

> I can provide further information on my configuration if necessary.
> Please make in this case a cc to frahm_at_irsamc_dot_ups-tlse_dot_fr
> since I am not subscribed to the mailing list. 

The above output would be great. thanks!

grant

> 
> 
> Greetings, Klaus Frahm.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

