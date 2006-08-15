Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWHOPgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWHOPgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWHOPgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:36:38 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36840 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030356AbWHOPgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:36:37 -0400
Message-ID: <44E1EA66.2060408@free.fr>
Date: Tue, 15 Aug 2006 17:38:14 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1: eth0: trigger_send() called with the transmitter
 busy
References: <20060813012454.f1d52189.akpm@osdl.org> <200608142325.59054.rjw@sisk.pl> <44E100B3.1060300@free.fr> <200608151210.31440.rjw@sisk.pl>
In-Reply-To: <200608151210.31440.rjw@sisk.pl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 15.08.2006 12:10, Rafael J. Wysocki a écrit :
> On Tuesday 15 August 2006 01:01, Laurent Riffard wrote:
>> Le 14.08.2006 23:25, Rafael J. Wysocki a écrit :
>>> On Monday 14 August 2006 22:06, Laurent Riffard wrote:
>>>> Le 14.08.2006 19:47, Laurent Riffard a écrit :
>>>>> Le 14.08.2006 18:50, Andrew Morton a écrit :
>>>>>> On Mon, 14 Aug 2006 16:38:47 +0200
>>>>>> Laurent Riffard <laurent.riffard@free.fr> wrote:
>>>>>>
>>>>>>> Le 13.08.2006 10:24, Andrew Morton a __crit :
>>>>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
>>>>>>> Hello,
>>>>>>>
>>>>>>> This morning, while trying to suspend to disk, my box started to loop 
>>>>>>> displaying the following message:
>>>>>>> eth0: trigger_send() called with the transmitter busy.
>>>>>>>
>>>>>>> Here is the scenario. I booted 2.6.18-rc4-mm1 with this command line:
>>>>>>> root=/dev/vglinux1/lvroot video=vesafb:ywrap,mtrr splash=silent resume=/dev/hdb7 netconsole=@192.163.0.3/,@192.168.0.1/00:0E:9B:91:ED:72 init 1
>>>>>>>
>>>>>>> Then I issued:
>>>>>>> # echo 6 > /proc/sys/kernel/printk
>>>>>>> # echo disk > /sys/power/state
>>>>>> ne2k isn't <ahem> the most actively-maintained driver.
>>>>>>
>>>>>> But most (I think all) net drivers have problems during suspend when
>>>>>> netconsole is active.  Does disabling netconsole help?
>>>>> Yes it does. 
>>>>>  
>>>>>> Did this operation work OK in earlier kernels, with netconsole enabled?
>>>>> It's the first time I see such a message. I can't speak for 2.6.18-rc3-mm2 
>>>>> because it could not suspend at all (did hang right after 
>>>>> "echo disk > /sys/power/state"), but it worked in earlier kernels.
>>>>>
>>>>> I'll try with plain 2.6.18-rc4.
>>>> Same problem with 2.6.18-rc4.
>>> I think something like this will help (untested):
>> Well, sort of: it sometimes works, which is better than not. I tried
>> about 10 times and it sometimes hangs after 'shrinking memory' or whilst 
>> writing to the swap device.
> 
> Hm, suspicious ...
> 
> The swap partition is not on an LVM, is it?
> 
>> The message "eth0: trigger_send() called with the transmitter busy" didn't
>> appear anymore. 
> 
> This is the one the patch was meant to get rid of.
> 
>> Note that I always have had a warning sowhere in acpi_pci_link_set during suspend:
>>  BUG: sleeping function called from invalid context at include/asm/semaphore.h:99
> Bad.  If that's 100% reproducible, could you please try to nail it down?

I wasn't clear: I always had this "BUG: sleeping function called ...." since one year
or more. It never prevents from suspending. Do you want me to track down what cause 
this message? Here is a more complete trace:

 Stopping tasks: ================|
 Shrinking memory...  ^H-^H\^Hdone (10908 pages freed)
 Suspending device sound
 Suspending device agpgart
 Suspending device rtc
 Suspending device 00308d0120e085ca
 Suspending device usbdev1.2
 Suspending device usbdev1.2_ep81
 Suspending device 1-2:1.0
 Suspending device usbdev1.2_ep00
 Suspending device 1-2
 Suspending device fw-host0
 Suspending device usbdev2.1
 Suspending device usbdev2.1_ep81
 Suspending device usbdev1.1
 Suspending device usbdev1.1_ep81
 Suspending device 2-0:1.0
 Suspending device usbdev2.1_ep00
 Suspending device usb2
 Suspending device 1-0:1.0
 Suspending device usbdev1.1_ep00
 Suspending device usb1
 Suspending device device-mapper
 Suspending device 1.1
 Suspending device 1.0
 Suspending device ide1
 Suspending device 0.1
 Suspending device 0.0
 Suspending device ide0
 Suspending device psaux
 Suspending device serio1
 Suspending device serio0
 Suspending device i8042
 Suspending device isa
 Suspending device vcsa
 Suspending device vcs
 Suspending device vc
 Suspending device vesafb.0
 Suspending device snapshot
 Suspending device misc
 Suspending device pcspkr
 Suspending device 0000:01:00.0
 Suspending device 0000:00:0d.0
 Suspending device 0000:00:0b.0
 ACPI: PCI interrupt for device 0000:00:0b.0 disabled
 Suspending device 0000:00:09.0
 Suspending device 0000:00:04.4
 Suspending device 0000:00:04.3
 ACPI: PCI interrupt for device 0000:00:04.3 disabled
 Suspending device 0000:00:04.2
 ACPI: PCI interrupt for device 0000:00:04.2 disabled
 Suspending device 0000:00:04.1
 Suspending device 0000:00:04.0
 Suspending device 0000:00:01.0
 Suspending device 0000:00:00.0
 pci_set_power_state(): 0000:00:00.0: state=3, current state=5
 Suspending device pci0000:00
 Suspending device acpi
 Suspending device vtcon0
 Suspending device vtconsole
 Suspending device virtual
 Suspending device platform
 swsusp: Need to copy 60817 pages
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 BUG: sleeping function called from invalid context at include/asm/semaphore.h:99
 in_atomic():0, irqs_disabled():1
  [<c0103894>] show_trace_log_lvl+0x12/0x25
  [<c0103975>] show_trace+0xd/0x10
  [<c01040aa>] dump_stack+0x19/0x1b
  [<c0112ef9>] __might_sleep+0x8d/0x95
  [<c01daf53>] acpi_os_wait_semaphore+0x93/0x158
  [<c01ffb9d>] acpi_ut_acquire_mutex+0x69/0xd4
  [<c01f3231>] acpi_ns_get_node+0x8e/0x112
  [<c01f259a>] acpi_ns_evaluate+0x62/0x258
  [<c01f8aa1>] acpi_rs_set_srs_method_data+0xf1/0x125
  [<c01f8341>] acpi_set_current_resources+0x8b/0xb0
  [<c0204ca5>] acpi_pci_link_set+0x10e/0x1e0
  [<c0204dc2>] irqrouter_resume+0x4b/0x62
  [<c021d04a>] __sysdev_resume+0x14/0x57
  [<c021d1c0>] sysdev_resume+0x19/0x4b
  [<c0221bf9>] device_power_up+0x8/0xf
  [<c0134271>] swsusp_suspend+0x51/0x78
  [<c013466a>] pm_suspend_disk+0x51/0xe2
  [<c01337d0>] enter_state+0x52/0x164
  [<c0133968>] state_store+0x86/0x9c
  [<c01831b8>] subsys_attr_store+0x20/0x25
  [<c01832c8>] sysfs_write_file+0xaa/0xcf
  [<c015472c>] vfs_write+0x8c/0x138
  [<c0154c44>] sys_write+0x3b/0x60
  [<c0102c2d>] sysenter_past_esp+0x56/0x8d
  =======================
 PCI: Setting latency timer of device 0000:00:01.0 to 64
 ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
 PCI: VIA IRQ fixup for 0000:00:04.2, from 12 to 5
 usb usb1: root hub lost power or was reset
 ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
 PCI: VIA IRQ fixup for 0000:00:04.3, from 12 to 5
 usb usb2: root hub lost power or was reset
 PM: Writing back config space on device 0000:00:09.0 at offset f (was 180c010c, writing 180c0105)
 PM: Writing back config space on device 0000:00:0b.0 at offset 1 (was 2000000, writing 2000003)
 ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
 PM: Writing back config space on device 0000:00:0d.0 at offset f (was 800c010c, writing 800c0105)
 PM: Writing back config space on device 0000:00:0d.0 at offset 1 (was 4100005, writing 34100000)
 Restarting tasks... done
 usb 1-2: USB disconnect, address 2


> Please revert the "suspend_console" patch before doing this, because it turns
> down all consoles altogether during the suspend.  You can also use the patch
> and instructions at
> 
> http://marc.theaimsgroup.com/?l=linux-acpi&m=115506915023030&q=raw
> 
> to debug device drivers' suspend/resume without really suspending.
> 
>> I'm under the impression your patch is a workaround for my network problem. 
>> Or must really netconsole be stopped during device_suspend ?
> 
> Yes, it must.  For now, the consoles are suspend-unfriendly, so to speak. ;-)
> 

I think I found something related to netconsole and your patch 
"suspend_console/resume_console". I was booting to runlevel 1 and I was using 
this script to suspend:

<=== script begin ===>
#!/bin/sh
# don't want to {fsck *and* reboot} if something goes wrong
mount -oremount,ro /
# enable write caching on HD
hdparm -W1 /dev/hd[ab]
echo 6 > /proc/sys/kernel/printk
sleep 2
echo disk > /sys/power/state
<=== script end ===>

The important point is the "sleep 2" line. If it is present, I can suspend the box.
Remove the "sleep command" and it will hang after displaying:
   Stopping tasks: =====================|
   Shrinking memory... done (0 pages freed)

If netconsole is disabled (ie not called from command line), I do not need this  
"sleep", suspend always works. 

-- 
laurent

