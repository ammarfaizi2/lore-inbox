Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVFGDHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVFGDHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 23:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFGDHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 23:07:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:54000 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261565AbVFGDHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 23:07:37 -0400
Message-ID: <1118113637.42a50f65773eb@imap.linux.ibm.com>
Date: Mon,  6 Jun 2005 23:07:17 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: greg@kroah.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bodo Eggert <7eggert@gmx.de>, Dipankar Sarma <dipankar@in.ibm.com>,
       Grant Grundler <grundler@parisc-linux.org>, stern@rowland.harvard.edu,
       awilliam@fc.hp.com, bjorn.helgaas@hp.com
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.7
X-Originating-IP: 9.182.62.224
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Stern <stern@rowland.harvard.edu>:

> On Sat, 4 Jun 2005, Vivek Goyal wrote:
> 
> > Hi Alan, I know very little about consoles and their working.
> > I had a question. Even if console is being managed by platform firmware,
> in
> > initial states of booting, does it require interrupts to be enabled at 
> > VGA contorller (at least for the simple text mode). I was quickly
> browsing
> > through drivers/video/console/vgacon.c and did not look like that this
> > console driver needed interrupts to be enabled at the controller.
> 
> This isn't an issue for VGA, as far as I know.  It applies to
> architectures like PPC-64 and perhaps Alpha or PA-Risc.  And I don't know
> the details; ask Grant Grundler.
> 
> > Anyway, looks like serial consoles will always work. So at least this can
> be
> > done for kdump case (CONFIG_CRASH_DUMP) and not generic kernel. Or, as I
> > mentioned in previous mail, while pre-loading capture kernel, pass a
> command
> > line parameter containing pci dev id of console and capture kernel does not
> 
> > disable interrupts on this console.  
> 
> I suspect you're right that implementing this only in kdump kernels will 
> work okay.
> 
> For people interesting in reading some old threads on the subject, here 
> are some pointers:
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=111055702309788&w=2
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=98383052711171&w=2

I browsed through the discussion threads quickly. Previous proposal included
disabling the DMA as well from the devices. Currently, for kdump, we are not 
looking at disabling the DMA from the devices. So far have not run into 
any problems due to ongoing DMA (Need to look into IOMMU reprogramming aspect
though). Following is a snippet from one of the discussion threads.


|List:       linux-usb-devel
|Subject:    [linux-usb-devel] Re: PCI device initialization and USB
early-handoff
|From:       Grant Grundler <grundler () parisc-linux ! org>
|Date:       2005-03-11 18:12:57
|Message-ID: <20050311181257.GB15070 () colo ! lackof ! org>
|[Download message RAW]
.....

|> > Is it feasible to have the PCI device initialization sequence disable DMA
|> > and IRQs from the device?  This could solve the problems we've been seeing
|> > with non-quiescent devices sharing an IRQ line at startup.

|two potential issues here:
|o ISTR VGA devices may not like disabling Bus Master bit in the command reg.
| But I'm blissfully ignorant of all the issues around VGA and someone
| else will have to comment on that.
|
|o platform devices (e.g. bridges) that don't have PCI drivers to re-enable
|  them later. "transperent" Bridges are the only example I can come up with
|  now but expect more to come out of the woodwork as this gets widely
|  tested. Trolling through PCI quirks might flag some of the known ones.
|  I would expect a few more to show up with this change.

|hth,
|grant


o Bus Master bit is not being disabled, only interrupt generation will be 
  disabled and looks like at least VGA and serial consoles are not impacted 
  due to disabling of interrupt. Any other consoles which require interrupt
  to be enabled for their working????

o As per pci-to-pci bridge architecture specification revision 1.2, 
  interrupt disable bit in PCI-PCI bridge is optional and if implemented,
  it will disable interrupt generation from bridge but will have no effect
  on interrupts that the bridge forwards from the PCI devices on the 
  secondary bus.

  So even if interrupts are disabled on PCI-PCI bridge, interrupts generated
  by PCI devices on secondary bus are not blocked and I hope device should
  be working fine.


The whole idea is that currently this change is kdump specific. Ofcourse there
shall be issues which are not known yet and more devices might not
work for kdump kernels. But at the same time kdump kernels are not supposed to
do a great deal except capture and save the dump. So this change might not
be of a big concern even if some devices don't work as long as kdump kernel
can boot. 

Disabling interrupts at PCI level should increase the reliability of capturing
the dump on newer machines with hardware compliant with PCI 2.3 or higher. 
Booting a kdump kernel with reduced functionality should always be better than 
not booting at all. 

Thanks
Vivek

