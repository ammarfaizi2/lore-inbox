Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVEJIoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVEJIoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 04:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVEJIoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 04:44:22 -0400
Received: from colino.net ([213.41.131.56]:44532 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261585AbVEJIoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 04:44:10 -0400
Date: Tue, 10 May 2005 10:43:49 +0200
From: Colin Leroy <colin@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [2.6.12-rc4] network wlan connection goes
 down
Message-ID: <20050510104349.7aca4227@colin.toulouse>
In-Reply-To: <200505090812.49090.david-b@pacbell.net>
References: <20050509162454.1c1c09a9@colin.toulouse>
	<200505090812.49090.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 1.9.9 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005 08:12:48 -0700
David Brownell <david-b@pacbell.net> wrote:

> On Monday 09 May 2005 7:24 am, Colin Leroy wrote:
> > Hi,
> > 
> > I upgraded to 2.6.12-rc4, and noticed something strange after that.
> > After a few hours, the network connection goes down. The network
> > connectivity is done via a USB wifi stick driven by zd1201.
> > 
> > After that, nothing gets through, not even a ping. ...
> > 
> > Would anyone have any hint about what could have changed in the usb
> > subsystem (ohci driver) or in the network subsystem, that might
> > cause that?
> 
> The OHCI code shouldn't have changed either, unless you're
> maybe using an old Compaq-brand chipset. 

Nope, it's the ohci controller in the iBook g4 (Nec, I believe).

> However, if you enable CONFIG_USB_DEBUG and send the "async" and
> "registers" files from the relevant /sys/class/usb_host/usbN
> directory, it should be easy to tell whether there's an issue at that
> particular level.

ok, I reproduced it. I've put in place a crontab that checks if my
router is pingable, and if not, dumps async and registers, resets the
zd1201 (the iwconfig command is the one that puts it back into a
functioning state), and dumps async and registers.

Here's the result:
before resetting (when nothing gets through):
async:
ed/e1f8b040 fs dev3 ep1in max 64 00401083 DATA0
	td e6f44040 in 3000 cc=0 urb ddf17120 (00140000)

registers:
bus pci, device 0001:10:1b.0
NEC Corporation USB
ohci_hcd version 2004 Nov 08
OHCI 1.0, NO legacy support registers
control 0x0a3 HCFS=operational BLE CBSR=3
cmdstatus 0x00000 SOC=0
intrstatus 0x00000064 RHSC FNO SF
intrenable 0x8000001a MIE UE RD WDH
ed_controlhead 21f8b000
ed_bulkhead 21f8b040
ed_bulkcurrent 21f8b040
hcca frame 0x5468
fmintvl 0xa7782edf FIT FSMPS=0xa778 FI=0x2edf
fmremaining 0x8000227a FRT FR=0x227a
periodicstart 0x2a2f
lsthresh 0x0628
roothub.a 0a000203 POTPGT=10 NPS NDP=3
roothub.b 00000000 PPCM=0000 DR=0000
roothub.status 00008000 DRWE
roothub.portstatus [0] 0x00000103 PPS PES CCS
roothub.portstatus [1] 0x00000100 PPS
roothub.portstatus [2] 0x00000100 PPS


#iwconfig essid ...
#ping works now

async:
ed/e1f8b040 fs dev3 ep1in max 64 00401083 DATA0
	td e6f44040 in 3000 cc=0 urb ddf17120 (00140000)

registers:
bus pci, device 0001:10:1b.0
NEC Corporation USB
ohci_hcd version 2004 Nov 08
OHCI 1.0, NO legacy support registers
control 0x0a3 HCFS=operational BLE CBSR=3
cmdstatus 0x00004 SOC=0 BLF
intrstatus 0x00000064 RHSC FNO SF
intrenable 0x8000001a MIE UE RD WDH
ed_controlhead 21f8b000
ed_bulkhead 21f8b040
ed_bulkcurrent 21f8b040
hcca frame 0x667b
fmintvl 0xa7782edf FIT FSMPS=0xa778 FI=0x2edf
fmremaining 0x8000258e FRT FR=0x258e
periodicstart 0x2a2f
lsthresh 0x0628
roothub.a 0a000203 POTPGT=10 NPS NDP=3
roothub.b 00000000 PPCM=0000 DR=0000
roothub.status 00008000 DRWE
roothub.portstatus [0] 0x00000103 PPS PES CCS
roothub.portstatus [1] 0x00000100 PPS
roothub.portstatus [2] 0x00000100 PPS


The registers file changes while everything works, too. For example
"BLF" isn't always present on the cmdstatus line.

Also, I saw these lines in dmesg. Sadly enough they don't appear in
syslog so I can't tell whether it happened at the same time the network
went down.
ohci_hcd 0001:10:1b.0: fminterval a7782edf
ohci_hcd 0001:10:1b.0: fminterval a7782edf
ohci_hcd 0001:10:1b.0: fminterval a7782edf
ohci_hcd 0001:10:1b.0: fminterval a7782edf

Hope this helps,
-- 
Colin
