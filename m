Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263126AbTCWRT6>; Sun, 23 Mar 2003 12:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263129AbTCWRT6>; Sun, 23 Mar 2003 12:19:58 -0500
Received: from ethlife-b.ethz.ch ([129.132.202.8]:47488 "HELO
	ethlife-b.ethz.ch") by vger.kernel.org with SMTP id <S263126AbTCWRTz> convert rfc822-to-8bit;
	Sun, 23 Mar 2003 12:19:55 -0500
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: Sun, 23 Mar 2003 18:30 +0100
Subject: Need help for pci driver on powerpc
To: linux-kernel@vger.kernel.org
From: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Content-Transfer-Encoding: 7BIT
Message-Id: <20030323171955Z263126-25575+35740@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Somehow I can't access a PCI card on a PowerMac.  I once wrote a
driver for this card on MacOS8, but that does not seem to help me so
far.

It's a digital I/O card Computer Boards PCI-DIO96H showing this info
in lspci -vvn:

00:0e.0 Class ffff: 1307:0017 (rev 02) (prog-if ff)
        Subsystem: 1307:0017
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 24
        Region 1: I/O ports at 0800 [disabled] [size=128]
        Region 2: I/O ports at 0880 [disabled] [size=16]

This is what I am doing (irrelevant parts stripped):
    error= pci_enable_device(mydevicep);
    mybase1_phys= pci_resource_start(dev, 2);
    mybase1length= pci_resource_len(dev,2);
    // gives: address 0x00000880, len 16
    error = pci_request_regions (dev, NAME);
    pci_set_master (dev);
    mybase1= (unsigned long)ioremap(mybase1_phys,mybase1length);
    // gives: 0, while the following is printed to the kernel log:
    // __ioremap(): phys addr 0 is RAM lr c0010c34

I have also tried the following:

- pass mybase1_phys to phys_to_virt() (this gave 0xc0000880) 
  and pass that for ioremap. The latter then returned 
  address 0xc7898880. But I then got this:
Mar 23 17:09:34 Sensor kernel: Machine check in kernel mode.
Mar 23 17:09:34 Sensor kernel: Caused by (from SRR1=49030): Transfer error ack signal
Mar 23 17:09:34 Sensor kernel: Oops: machine check, sig: 7
(...)

- pass mybase1_phys to phys_to_bus(), but insmod then gives
  "unresolved symbol phys_to_bus".

- ~same thing for pci_resource_start(dev, 1) instead of 2.

(- and many further combinations)


Questions:

- What does pci_resource_start return, a phys/virt/bus address?
- What does ioremap expect?
- I'm seeing a special case in the source of the C ioremap() version,
  which assumes ISA for an address as low as 0x00000880. Thus it seems
  like I have to convert that address? On the other hand, the 8139too
  driver which I've glimpsed at does not do any conversion.
- do I need pci_set_master? Which other PCI calls are important?
- where do I find up to date information about handling PCI on linux?
  The Documentation/pci.txt and Documentation/IO-mapping.txt files 
  do not mention many important details.


You can see my code at:
http://pflanze.mine.nu/~chris/linux/sensor/sensor.c

Thanks for your help
Christian.

