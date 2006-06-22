Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWFVAcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWFVAcr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWFVAcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:32:46 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:30404 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932154AbWFVAcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:32:45 -0400
Date: Wed, 21 Jun 2006 17:32:14 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Jeff Gold <jgold@mazunetworks.com>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Serial Console and Slow SCSI Disk Access?
In-Reply-To: <44979F99.1090807@aitel.hist.no>
Message-ID: <Pine.LNX.4.63.0606211729360.6305@qynat.qvtvafvgr.pbz>
References: <448DDC7F.4030308@mazunetworks.com> <448DDF1D.5020108@rtr.ca> 
 <448DE4F1.9000407@mazunetworks.com> <4496492A.1030907@aitel.hist.no> 
 <4496BF65.30108@mazunetworks.com> <44979F99.1090807@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Helge Hafting wrote:

> Jeff Gold wrote:
>> Helge Hafting wrote:
>>> With nothing attached, any write to the serial device might go
>>> through a lengthy timeout because of flow control.  [...] But I can't
>>> see why it'd make scsi disks slower. The scsi host adapter initialization 
>>> writes some messages of course, but there should be no
>>> more console accesses during a hdparm test run.
>> 
>> This makes sense to me.  When I attach a serial cable and use that to login 
>> (I've got agetty running), hdparm produces no console messages that I can 
>> see using minicom.  Still, the disk throughput is around 1.5 MB/sec for 
>> some reason.  When I disable the serial console in grub.conf and reboot I 
>> get over 70 MB/sec again.
>> 
>> A combination of out-of-tree patches (mainly network related but also one 
>> to disable PM_TIMERS) seem to eliminate the issue even with the serial 
>> console enabled, at least for the moment.  That means I no longer have a 
>> problem, but the whole thing is mysterious to me.
> I can see one possibility, that I didn't think of yesterday.
> Do the scsi host adapter share its interrupt with the serial line?
> (Boot a kernel that has the problem, and when scsi is slow, do a
> cat /proc/interrupts
> If the scsi and the serial driver share an interrupt, then that is the source
> of the problem.
>
> Linux can share interrupts without big performance problems - IF both of
> the hardware drivers are written with interrupt sharing in mind.  Many
> linux drivers are, but some are not.  So check if interrupt sharing is 
> happening,
> and if so, contact the maintainers of your scsi driver and your serial
> port driver.  Ask them if such sharing is ok or not.  If you don't
> understand the /proc/interrupt listing, just send it to the
> maintainers so they can have a look.
>
> Shared interrupts are to some extent set up by the bios, and to some
> extent by linux.  So different kernel versions (or booting with a different
> set of drivers loaded, or a different distribution) may make a difference.
>
> You can often get a pci device to use a different interrupt by moving it
> to another slot.  That tends to solve interrupt sharing problems. I assume
> your scsi adapter is pci.
>

I ran into a similar problem (extremely slow scsi performance), but hadn't 
reported it as I made a lot of changes at the same time (moved from 2.6.7 to 
2.6.12.3 as well as enabling the serial console). but with this report I wanted 
to chime in with a weak 'me-too'. I haven't rebooted without the serial console 
yet to confirm this, but I will do so shortly, and try 2.6.17 to see if it has a 
similar problem or not.

David Lang

# cat /proc/interrupts
            CPU0       CPU1
   0:  458865186      29148    IO-APIC-edge  timer
   1:        216          7    IO-APIC-edge  i8042
   3:         78          1    IO-APIC-edge  serial
   4:         76          1    IO-APIC-edge  serial
   8:          8          1    IO-APIC-edge  rtc
   9:          0          0   IO-APIC-level  acpi
  12:         84         10    IO-APIC-edge  i8042
  14:        332         10    IO-APIC-edge  ide0
  24:    4426414          1   IO-APIC-level  eth2
  26:  426930991          1   IO-APIC-level  eth0
  27:      17795  365692411   IO-APIC-level  eth1
  29:     553120         87   IO-APIC-level  ioc0
NMI:          0          0
LOC:  458903065  458904855
ERR:          0
MIS:          0

# lspci
0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 
12)
0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 
12)
0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:01:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:02:02.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 02)
0000:02:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X 
Gigabit Ethernet (rev 02)
0000:02:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X 
Gigabit Ethernet (rev 02)
0000:03:04.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet 
Controller (rev 01)
0000:03:04.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet 
Controller (rev 01)
0000:03:06.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet 
Controller (rev 01)
0000:03:06.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet 
Controller (rev 01)
0000:04:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
Fusion-MPT Dual Ultra320 SCSI (rev 07)



