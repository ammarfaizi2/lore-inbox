Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVC2ISs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVC2ISs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVC2IQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:16:50 -0500
Received: from upco.es ([130.206.70.227]:33664 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262192AbVC2INZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:13:25 -0500
Date: Tue, 29 Mar 2005 10:13:21 +0200
From: Romano Giannetti <romanol@upco.es>
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Cc: shaohua.li@intel.com
Subject: Re: [BKPATCH] ACPI for 2.6.12-rc1
Message-ID: <20050329081321.GA4133@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	Andrew Morton <akpm@osdl.org>, len.brown@intel.com,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
	shaohua.li@intel.com
References: <1111127024.9332.157.camel@d845pe> <20050318150129.GB22887@pern.dea.icai.upco.es> <20050318152122.7994965b.akpm@osdl.org> <20050319215239.GA5105@rukbat.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20050319215239.GA5105@rukbat.dea.icai.upco.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to resume an old thread, but...

On Sat, Mar 19, 2005 at 10:52:39PM +0100, Romano Giannetti wrote:
> 
> http://bugme.osdl.org/show_bug.cgi?id=4124
> 

During Easter I had time to test a bit more the patch and I found a very bad
issue between acpi keys, preempt and suspend. It's a lot of data; I have
filed the same data on the above bug. 

Hi!

This is to report an issue with 2.6.11 and ACPI battery/ac. The resume is:
acpi battery with preemptive kernel do not work, while the same kernel with
no preempt works ok. I have tried to collect all the possible info; tell me
if you need something more. 

The details: 

The working kernel is 2.6.11 with the patch from the acpi-devel list to fix
acpi keys (not working otherwise). See for a description 
http://bugme.osdl.org/show_bug.cgi?id=4124

The data on the non-preemptive kernel (boot messages, config, etc) is here:
http://www.dea.icai.upco.es/romano/linux/br/config-nop/laptop-config.html
This works, apart for the little glitch that doing two "acpi -V" at the same
time, one of them give "0" for battery charge, while the other works ok. 
Suspend/resume works perfectly with this script:
http://www.dea.icai.upco.es/romano/linux/br/config-nop/rg_suspend_script_nowait

The complete configuration for the preemptive kernel is here: 
http://www.dea.icai.upco.es/romano/linux/br/config-p2/laptop-config.html

The problem with the preemptive kernel is that after a while the ac/battery
ACPI reading stop working. The errors do occur at seemely random times.
First time it happened at boot, but I do not have a log of it. Second time
it happened at resume time, and I have captured "oops" (really, scheduling
while atomic) from this (in the following lines). After that, battery/ac
status does not work anymore. If you look at the following dmesg, battery
module will load but it will not detect any battery in the slots.

The same information as above, after resume, is here: 
http://www.dea.icai.upco.es/romano/linux/br/after-res2/laptop-config.html

After that, I activated full ACPI debug (echo 0xFFFFFFFF >
/proc/acpi/debug_level) and tried to load again the battery module.  This
time the loading suceeded. The full syslog output (it's enormous) is 
here:
http://www.dea.icai.upco.es/romano/linux/br/after-res2/syslog.txt.gz


Notice that a very similar thing happens with vanilla 2.6.11 with preemptive
kernel (without the patch above). Notice, though, that the acpi key delay
bug is resolved by simpl activate preempt, like Mr. Shaohua said in 
http://bugme.osdl.org/show_bug.cgi?id=4124#c8

Here is the "oops" log at resume (log starts at suspend time)

usbcore: deregistering driver usbhid
uhci_hcd 0000:00:07.2: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-2: USB disconnect, address 2
uhci_hcd 0000:00:07.2: USB bus 1 deregistered
uhci_hcd 0000:00:07.3: remove, state 1
usb usb2: USB disconnect, address 1
uhci_hcd 0000:00:07.3: USB bus 2 deregistered
usbcore: deregistering driver usbmouse
Stopping tasks: ================================= [...]
Freeing memory...  -\|/-\|/-\ [...]
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section: 
[nosave pfn 0x484]<7>[nosave pfn 0x485]swsusp: Need to copy 8934 pages
suspend: (pages needed: 8934 + 512 free: 56600)
[nosave pfn 0x484]<7>[nosave pfn 0x485]<7>PM: Image restored successfully.
scheduling while atomic: really_suspend/0x00000001/4624
 [<c0396007>] schedule+0x467/0x520
 [<c0121035>] __mod_timer+0x1c5/0x1f0
 [<c0396acd>] schedule_timeout+0x5d/0xb0
 [<c0121ac0>] process_timeout+0x0/0x10
 [<c0121eaf>] msleep+0x2f/0x40
 [<c024b080>] pci_set_power_state+0x190/0x1d0
 [<c024b1c8>] pci_enable_device_bars+0x18/0x40
 [<c024b20f>] pci_enable_device+0x1f/0x40
 [<d0ccf64c>] snd_via82xx_resume+0x1c/0x170 [snd_via82xx]
 [<c024b199>] pci_restore_state+0x39/0x50
 [<d0cacc79>] snd_card_pci_resume+0x49/0x76 [snd]
 [<c024d36c>] pci_device_resume+0x2c/0x40
 [<c02c79a8>] dpm_resume+0xa8/0xb0
 [<c02c79c1>] device_resume+0x11/0x20
 [<c0135268>] finish+0x8/0x40
 [<c01353c5>] pm_suspend_disk+0x75/0xc0
 [<c0133786>] enter_state+0x86/0x90
 [<c013379f>] software_suspend+0xf/0x20
 [<c0289d9a>] acpi_system_write_sleep+0x6a/0x84
 [<c015835c>] vfs_write+0x14c/0x160
 [<c0158441>] sys_write+0x51/0x80
 [<c01032b9>] sysenter_past_esp+0x52/0x75
ACPI: PCI interrupt 0000:00:07.5[C] -> GSI 5 (level, low) -> IRQ 5
scheduling while atomic: really_suspend/0x00000001/4624
 [<c0396007>] schedule+0x467/0x520
 [<c0120fb2>] __mod_timer+0x142/0x1f0
 [<c0396acd>] schedule_timeout+0x5d/0xb0
 [<c0121ac0>] process_timeout+0x0/0x10
 [<c0121eaf>] msleep+0x2f/0x40
 [<d0c338b6>] socket_shutdown+0x26/0x40 [pcmcia_core]
 [<d0c33dbf>] socket_resume+0xbf/0x130 [pcmcia_core]
 [<d0c6ec0e>] yenta_dev_resume+0xae/0xb0 [yenta_socket]
 [<d0c3310c>] pcmcia_socket_dev_resume+0x7c/0x90 [pcmcia_core]
 [<c024d36c>] pci_device_resume+0x2c/0x40
 [<c02c79a8>] dpm_resume+0xa8/0xb0
 [<c02c79c1>] device_resume+0x11/0x20
 [<c0135268>] finish+0x8/0x40
 [<c01353c5>] pm_suspend_disk+0x75/0xc0
 [<c0133786>] enter_state+0x86/0x90
 [<c013379f>] software_suspend+0xf/0x20
 [<c0289d9a>] acpi_system_write_sleep+0x6a/0x84
 [<c015835c>] vfs_write+0x14c/0x160
 [<c0158441>] sys_write+0x51/0x80
 [<c01032b9>] sysenter_past_esp+0x52/0x75
scheduling while atomic: really_suspend/0x00000001/4624
 [<c0396007>] schedule+0x467/0x520
 [<c0120fb2>] __mod_timer+0x142/0x1f0
 [<c0396acd>] schedule_timeout+0x5d/0xb0
 [<c0249088>] pci_bus_write_config_word+0x68/0xa0
 [<c0121ac0>] process_timeout+0x0/0x10
 [<c0121eaf>] msleep+0x2f/0x40
 [<d0c339ed>] socket_setup+0x3d/0x160 [pcmcia_core]
 [<d0c33d5f>] socket_resume+0x5f/0x130 [pcmcia_core]
 [<d0c6ec0e>] yenta_dev_resume+0xae/0xb0 [yenta_socket]
 [<d0c3310c>] pcmcia_socket_dev_resume+0x7c/0x90 [pcmcia_core]
 [<c024d36c>] pci_device_resume+0x2c/0x40
 [<c02c79a8>] dpm_resume+0xa8/0xb0
 [<c02c79c1>] device_resume+0x11/0x20
 [<c0135268>] finish+0x8/0x40
 [<c01353c5>] pm_suspend_disk+0x75/0xc0
 [<c0133786>] enter_state+0x86/0x90
 [<c013379f>] software_suspend+0xf/0x20
 [<c0289d9a>] acpi_system_write_sleep+0x6a/0x84
 [<c015835c>] vfs_write+0x14c/0x160
 [<c0158441>] sys_write+0x51/0x80
 [<c01032b9>] sysenter_past_esp+0x52/0x75
scheduling while atomic: really_suspend/0x00000001/4624
 [<c0396007>] schedule+0x467/0x520
 [<c0323b2e>] pci_write+0x3e/0x50
 [<c0120fb2>] __mod_timer+0x142/0x1f0
 [<c0396acd>] schedule_timeout+0x5d/0xb0
 [<c0121ac0>] process_timeout+0x0/0x10
 [<c0121eaf>] msleep+0x2f/0x40
 [<d0c33a83>] socket_setup+0xd3/0x160 [pcmcia_core]
 [<d0c33d5f>] socket_resume+0x5f/0x130 [pcmcia_core]
 [<d0c6ec0e>] yenta_dev_resume+0xae/0xb0 [yenta_socket]
 [<d0c3310c>] pcmcia_socket_dev_resume+0x7c/0x90 [pcmcia_core]
 [<c024d36c>] pci_device_resume+0x2c/0x40
 [<c02c79a8>] dpm_resume+0xa8/0xb0
 [<c02c79c1>] device_resume+0x11/0x20
 [<c0135268>] finish+0x8/0x40
 [<c01353c5>] pm_suspend_disk+0x75/0xc0
 [<c0133786>] enter_state+0x86/0x90
 [<c013379f>] software_suspend+0xf/0x20
 [<c0289d9a>] acpi_system_write_sleep+0x6a/0x84
 [<c015835c>] vfs_write+0x14c/0x160
 [<c0158441>] sys_write+0x51/0x80
 [<c01032b9>] sysenter_past_esp+0x52/0x75
scheduling while atomic: really_suspend/0x00000001/4624
 [<c0396007>] schedule+0x467/0x520
 [<c0323b2e>] pci_write+0x3e/0x50
 [<c0120fb2>] __mod_timer+0x142/0x1f0
 [<c0396acd>] schedule_timeout+0x5d/0xb0
 [<c0121ac0>] process_timeout+0x0/0x10
 [<c0121eaf>] msleep+0x2f/0x40
 [<d0c33929>] socket_reset+0x59/0xe0 [pcmcia_core]
 [<d0c33aa2>] socket_setup+0xf2/0x160 [pcmcia_core]
 [<d0c33d5f>] socket_resume+0x5f/0x130 [pcmcia_core]
 [<d0c6ec0e>] yenta_dev_resume+0xae/0xb0 [yenta_socket]
 [<d0c3310c>] pcmcia_socket_dev_resume+0x7c/0x90 [pcmcia_core]
 [<c024d36c>] pci_device_resume+0x2c/0x40
 [<c02c79a8>] dpm_resume+0xa8/0xb0
 [<c02c79c1>] device_resume+0x11/0x20
 [<c0135268>] finish+0x8/0x40
 [<c01353c5>] pm_suspend_disk+0x75/0xc0
 [<c0133786>] enter_state+0x86/0x90
 [<c013379f>] software_suspend+0xf/0x20
 [<c0289d9a>] acpi_system_write_sleep+0x6a/0x84
 [<c015835c>] vfs_write+0x14c/0x160
 [<c0158441>] sys_write+0x51/0x80
 [<c01032b9>] sysenter_past_esp+0x52/0x75
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 9 (level, low) -> IRQ 9
scheduling while atomic: really_suspend/0x00000001/4624
 [<c0396007>] schedule+0x467/0x520
 [<c02f86a4>] do_rw_taskfile+0x254/0x2b0
 [<c02f8890>] task_no_data_intr+0x0/0xb0
 [<c0396206>] wait_for_completion+0x86/0xf0
 [<c0114460>] default_wake_function+0x0/0x20
 [<c0114460>] default_wake_function+0x0/0x20
 [<c02c8339>] __elv_add_request+0x99/0xe0
 [<c02f38cf>] ide_do_drive_cmd+0x11f/0x170
 [<c02f0623>] generic_ide_resume+0x93/0xc0
 [<c02f8890>] task_no_data_intr+0x0/0xb0
 [<c023cbc7>] kobject_get+0x17/0x20
 [<c02c79a8>] dpm_resume+0xa8/0xb0
 [<c02c79c1>] device_resume+0x11/0x20
 [<c0135268>] finish+0x8/0x40
 [<c01353c5>] pm_suspend_disk+0x75/0xc0
 [<c0133786>] enter_state+0x86/0x90
 [<c013379f>] software_suspend+0xf/0x20
 [<c0289d9a>] acpi_system_write_sleep+0x6a/0x84
 [<c015835c>] vfs_write+0x14c/0x160
 [<c0158441>] sys_write+0x51/0x80
 [<c01032b9>] sysenter_past_esp+0x52/0x75
Restarting tasks...<3>scheduling while atomic: really_suspend/0x00000001/4624
 [<c0396007>] schedule+0x467/0x520
 [<c011399e>] wake_up_process+0x1e/0x20
 [<c0133c78>] thaw_processes+0xe8/0x100
 [<c0135276>] finish+0x16/0x40
 [<c01353c5>] pm_suspend_disk+0x75/0xc0
 [<c0133786>] enter_state+0x86/0x90
 [<c013379f>] software_suspend+0xf/0x20
 [<c0289d9a>] acpi_system_write_sleep+0x6a/0x84
 [<c015835c>] vfs_write+0x14c/0x160
 [<c0158441>] sys_write+0x51/0x80
 [<c01032b9>] sysenter_past_esp+0x52/0x75
 done
scheduling while atomic: really_suspend/0x00000001/4624
 [<c0396007>] schedule+0x467/0x520
 [<c0158441>] sys_write+0x51/0x80
 [<c0103336>] work_resched+0x5/0x16
scheduling while atomic: really_suspend/0x00000001/4624
 [<c0396007>] schedule+0x467/0x520
 [<c011506a>] sys_sched_yield+0x5a/0x80
 [<c0164f02>] coredump_wait+0x32/0xa0
 [<c016505c>] do_coredump+0xec/0x22a
 [<c0113854>] activate_task+0x64/0x80
 [<c0113524>] task_rq_lock+0x14/0x20
 [<c0121fac>] free_uid+0x1c/0x80
 [<c01228d5>] __dequeue_signal+0x105/0x180
 [<c0122985>] dequeue_signal+0x35/0xd0
 [<c012491f>] get_signal_to_deliver+0x2df/0x350
 [<c01030dd>] do_signal+0x9d/0x170
 [<c012a4e8>] __kernel_text_address+0x28/0x40
 [<c0103755>] show_trace+0x35/0x90
 [<c0103755>] show_trace+0x35/0x90
 [<c0103336>] work_resched+0x5/0x16
 [<c0113c90>] finish_task_switch+0x30/0x90
 [<c0395e64>] schedule+0x2c4/0x520
 [<c01123f0>] do_page_fault+0x0/0x5de
 [<c01031e7>] do_notify_resume+0x37/0x3c
 [<c010335a>] work_notifysig+0x13/0x15
note: really_suspend[4624] exited with preempt_count 1
ALPS Touchpad (Glidepoint) detected
  Disabling hardware tapping
input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: AC Adapter [ACAD] (off-line)
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:07.2: irq 9, io base 0x1c00
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:07.3[D] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:07.3: irq 9, io base 0x1c20
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Mouse [USB Mouse] on usb-0000:00:07.2-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usbcore: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver




-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
