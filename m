Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945939AbWBONkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945939AbWBONkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945940AbWBONkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:40:42 -0500
Received: from ezoffice.mandriva.com ([84.14.106.134]:23055 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1945939AbWBONkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:40:41 -0500
From: Thierry Vignaud <tvignaud@mandriva.com>
To: Andrew Morton <akpm@osdl.org>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc3
Organization: Mandrakesoft
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	<20060212190520.244fcaec.akpm@osdl.org> <s5hk6bz4gca.wl%tiwai@suse.de>
	<m2zmkuqcs5.fsf@vador.mandriva.com>
	<20060214225154.2e82dfd2.akpm@osdl.org>
X-URL: <http://www.linux-mandrake.com/
Date: Wed, 15 Feb 2006 14:40:32 +0100
In-Reply-To: <20060214225154.2e82dfd2.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 14 Feb 2006 22:51:54 -0800")
Message-ID: <m2lkwckaen.fsf@vador.mandriva.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Andrew Morton <akpm@osdl.org> writes:

> >  > It's not a "regression".  PM didn't work with ens1370 at all in
> >  > the eralier version.
> > 
> >  btw, PM support in snd-intel8x0 is broken (at least regarding
> >  suspending) in 2.6.16-rc2-mm1 on a nforce2 chipset
> 
> Can you identify when this breakage occurred?

i'll try to compile a few older kernels (and/or just older
alsa-kernel) if you want but i'm not sure it's a regression (i'll
check if it has ever worked before).

i've tried unloading/reloading sound modules after resuming (maybe
would it work if unloaded before suspending but of course full PM
support would be nicer).

not sure if it can help but while resuming, the snd-intel8x0 printed
quite a lot of warnings (due to preempting[1] i guess?) such as:
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  

dmesg after resuming (only look at the beginning, the end is only ehci
garbage b/c ehci is bugging for monthes (rejecting mass media after
writing a few Mo)):

--=-=-=
Content-Disposition: attachment; filename=bug.suspend.broken_dmesg1

e+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
 <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
PCI: Setting latency timer of device 0000:00:08.0 to 64
ohci_hcd 0000:01:07.0: PCI D0, from previous PCI D3
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c011d16a> msleep+0x17/0x1c
 <c01b5d83> pci_set_power_state+0x127/0x16a   <c01b5dd3> pci_enable_device_bars+0xd/0x38
 <c01b5e0c> pci_enable_device+0xe/0x2c   <cf848a1b> usb_hcd_pci_resume+0x11b/0x1b7 [usbcore]
 <c01b6dee> pci_device_resume+0x16/0x43   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [LNK4] -> GSI 12 (level, low) -> IRQ 12
ohci_hcd 0000:01:07.1: PCI D0, from previous PCI D3
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c011d16a> msleep+0x17/0x1c
 <c01b5d83> pci_set_power_state+0x127/0x16a   <c01b5dd3> pci_enable_device_bars+0xd/0x38
 <c01b5e0c> pci_enable_device+0xe/0x2c   <cf848a1b> usb_hcd_pci_resume+0x11b/0x1b7 [usbcore]
 <c01b6dee> pci_device_resume+0x16/0x43   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
ACPI: PCI Interrupt 0000:01:07.1[B] -> Link [LNK1] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:01:07.2: PCI D0, from previous PCI D3
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c011d16a> msleep+0x17/0x1c
 <c01b5d83> pci_set_power_state+0x127/0x16a   <c01b5dd3> pci_enable_device_bars+0xd/0x38
 <c01b5e0c> pci_enable_device+0xe/0x2c   <cf848a1b> usb_hcd_pci_resume+0x11b/0x1b7 [usbcore]
 <c01b6dee> pci_device_resume+0x16/0x43   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
ACPI: PCI Interrupt 0000:01:07.2[C] -> Link [LNK2] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:01:07.2: lost power, restarting
usb usb5: root hub lost power or was reset
ehci_hcd 0000:01:07.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:01:07.2: MWI active
ehci_hcd 0000:01:07.2: ...powerdown ports...
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c011d16a> msleep+0x17/0x1c
 <cf861ed1> ehci_pci_reinit+0xf6/0xfe [ehci_hcd]   <cf86584f> ehci_pci_resume+0xbd/0x10a [ehci_hcd]
 <cf848a7a> usb_hcd_pci_resume+0x17a/0x1b7 [usbcore]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
ehci_hcd 0000:01:07.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:01:07.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:01:07.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
ehci_hcd 0000:01:07.2: ...powerup ports...
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <cf86309c> ehci_run+0x165/0x16f [ehci_hcd]
 <c028c6bf> schedule_timeout+0x7a/0x95   <c011c755> process_timeout+0x0/0x5
 <c011d16a> msleep+0x17/0x1c   <cf865895> ehci_pci_resume+0x103/0x10a [ehci_hcd]
 <cf848a7a> usb_hcd_pci_resume+0x17a/0x1b7 [usbcore]   <c01b6dee> pci_device_resume+0x16/0x43
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
nvidiafb: your nForce DIMMs are not arranged in optimal banks!
i2c_adapter i2c-0: PM: resume from 0, parent 0000:02:00.0 still 1
i2c_adapter i2c-1: PM: resume from 0, parent 0000:02:00.0 still 1
i2c_adapter i2c-2: PM: resume from 0, parent 0000:02:00.0 still 1
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c01af304> vsnprintf+0x45a/0x497
 <c028c6bf> schedule_timeout+0x7a/0x95   <c011c755> process_timeout+0x0/0x5
 <c01fe3cb> ps2_sendbyte+0xa1/0xdd   <c0124c68> autoremove_wake_function+0x0/0x2d
 <c01fe5bb> ps2_command+0xdd/0x2ce   <c02271bc> atkbd_probe+0x4c/0xe0
 <c022842f> atkbd_reconnect+0x97/0xfc   <c01fc876> serio_reconnect_driver+0x21/0x34
 <c01fc8ba> serio_resume+0xb/0x1a   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6c6> schedule_timeout+0x81/0x95
 <c028c6bf> schedule_timeout+0x7a/0x95   <c011c755> process_timeout+0x0/0x5
 <c01fe64f> ps2_command+0x171/0x2ce   <c0124c68> autoremove_wake_function+0x0/0x2d
 <c02271bc> atkbd_probe+0x4c/0xe0   <c022842f> atkbd_reconnect+0x97/0xfc
 <c01fc876> serio_reconnect_driver+0x21/0x34   <c01fc8ba> serio_resume+0xb/0x1a
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c01fe731> ps2_command+0x253/0x2ce
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c02271bc> atkbd_probe+0x4c/0xe0
 <c022842f> atkbd_reconnect+0x97/0xfc   <c01fc876> serio_reconnect_driver+0x21/0x34
 <c01fc8ba> serio_resume+0xb/0x1a   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c01fe3cb> ps2_sendbyte+0xa1/0xdd
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c01fe5bb> ps2_command+0xdd/0x2ce
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c022736e> atkbd_activate+0x1a/0x69
 <c0228455> atkbd_reconnect+0xbd/0xfc   <c01fc876> serio_reconnect_driver+0x21/0x34
 <c01fc8ba> serio_resume+0xb/0x1a   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c01fe3cb> ps2_sendbyte+0xa1/0xdd
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c01fe5d8> ps2_command+0xfa/0x2ce
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c022736e> atkbd_activate+0x1a/0x69
 <c0228455> atkbd_reconnect+0xbd/0xfc   <c01fc876> serio_reconnect_driver+0x21/0x34
 <c01fc8ba> serio_resume+0xb/0x1a   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c01fe3cb> ps2_sendbyte+0xa1/0xdd
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c01fe5bb> ps2_command+0xdd/0x2ce
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c0227385> atkbd_activate+0x31/0x69
 <c0228455> atkbd_reconnect+0xbd/0xfc   <c01fc876> serio_reconnect_driver+0x21/0x34
 <c01fc8ba> serio_resume+0xb/0x1a   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c01fe3cb> ps2_sendbyte+0xa1/0xdd
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c01fe5d8> ps2_command+0xfa/0x2ce
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c0227385> atkbd_activate+0x31/0x69
 <c0228455> atkbd_reconnect+0xbd/0xfc   <c01fc876> serio_reconnect_driver+0x21/0x34
 <c01fc8ba> serio_resume+0xb/0x1a   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c01fe3cb> ps2_sendbyte+0xa1/0xdd
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c01fe5bb> ps2_command+0xdd/0x2ce
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c0227397> atkbd_activate+0x43/0x69
 <c0228455> atkbd_reconnect+0xbd/0xfc   <c01fc876> serio_reconnect_driver+0x21/0x34
 <c01fc8ba> serio_resume+0xb/0x1a   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c01fe3cb> ps2_sendbyte+0xa1/0xdd
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c01fe5bb> ps2_command+0xdd/0x2ce
 <c0228465> atkbd_reconnect+0xcd/0xfc   <c01fc876> serio_reconnect_driver+0x21/0x34
 <c01fc8ba> serio_resume+0xb/0x1a   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c01fe3cb> ps2_sendbyte+0xa1/0xdd
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c01fe5d8> ps2_command+0xfa/0x2ce
 <c0228465> atkbd_reconnect+0xcd/0xfc   <c01fc876> serio_reconnect_driver+0x21/0x34
 <c01fc8ba> serio_resume+0xb/0x1a   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c0213851> ide_do_request+0x515/0x730
 <c010339a> common_interrupt+0x1a/0x20   <c028c59f> wait_for_completion+0x70/0xc2
 <c0112f98> default_wake_function+0x0/0xc   <c0213b37> ide_do_drive_cmd+0xcb/0xf0
 <c0211301> generic_ide_resume+0x7d/0x88   <c01a84c8> blk_end_sync_rq+0x0/0x1d
 <c02177f3> task_no_data_intr+0x0/0x63   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c59f> wait_for_completion+0x70/0xc2
 <c0112f98> default_wake_function+0x0/0xc   <c0213b37> ide_do_drive_cmd+0xcb/0xf0
 <c0211301> generic_ide_resume+0x7d/0x88   <c01a84c8> blk_end_sync_rq+0x0/0x1d
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
BUG: warning at drivers/ide/ide-iops.c:1235/ide_wait_not_busy()
 <c0214b0a> ide_wait_not_busy+0x48/0x92   <c02136d9> ide_do_request+0x39d/0x730
 <c01a83bc> freed_request+0x1d/0x37   <c0213cf8> ide_intr+0x19c/0x1d4
 <c0219548> ide_dma_intr+0x0/0x8f   <c01302f8> handle_IRQ_event+0x21/0x4a
 <c0130397> __do_IRQ+0x76/0xcf   <c0104abe> do_IRQ+0x5e/0x79
 =======================
 <c010339a> common_interrupt+0x1a/0x20   <c01019bc> default_idle+0x2b/0x53
 <c0101a24> cpu_idle+0x40/0x5e   <c0322602> start_kernel+0x299/0x29b
usb usb1: finish resume
ohci_hcd 0000:00:02.0: lost power
usb usb1: root hub lost power or was reset
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x600
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c011d0d9> __mod_timer+0x9f/0xa9
 <c028c6bf> schedule_timeout+0x7a/0x95   <c011c755> process_timeout+0x0/0x5
 <c011d16a> msleep+0x17/0x1c   <cf828643> ohci_run+0x19e/0x46d [ohci_hcd]
 <cf8291ba> ohci_bus_resume+0x35e/0x5e4 [ohci_hcd]   <cf840c5e> hcd_bus_resume+0x2d/0x7a [usbcore]
 <cf83d974> hub_resume+0x38/0x17f [usbcore]   <cf83c4f7> usb_generic_resume+0x0/0xcf [usbcore]
 <cf83c56a> usb_generic_resume+0x73/0xcf [usbcore]   <cf83d610> finish_device_resume+0x119/0x16a [usbcore]
 <cf83e46a> usb_resume_device+0x46/0xa1 [usbcore]   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: hcca frame #0003
ohci_hcd 0000:00:02.0: roothub.a 01000203 POTPGT=1 NPS NDP=3(3)
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.0: restart complete
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c011d16a> msleep+0x17/0x1c
 <cf83d9b0> hub_resume+0x74/0x17f [usbcore]   <cf83c4f7> usb_generic_resume+0x0/0xcf [usbcore]
 <cf83c56a> usb_generic_resume+0x73/0xcf [usbcore]   <cf83d610> finish_device_resume+0x119/0x16a [usbcore]
 <cf83e46a> usb_resume_device+0x46/0xa1 [usbcore]   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [0] = 0x00010100 CSC PPS
usb usb2: finish resume
ohci_hcd 0000:00:03.0: lost power
usb usb2: root hub lost power or was reset
ohci_hcd 0000:00:03.0: resetting from state 'reset', control = 0x600
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <cf842dc0> usb_start_wait_urb+0x141/0x14b [usbcore]
 <c028c6bf> schedule_timeout+0x7a/0x95   <c011c755> process_timeout+0x0/0x5
 <c011d16a> msleep+0x17/0x1c   <cf828643> ohci_run+0x19e/0x46d [ohci_hcd]
 <cf8291ba> ohci_bus_resume+0x35e/0x5e4 [ohci_hcd]   <cf840c5e> hcd_bus_resume+0x2d/0x7a [usbcore]
 <cf83d974> hub_resume+0x38/0x17f [usbcore]   <cf83c4f7> usb_generic_resume+0x0/0xcf [usbcore]
 <cf83c56a> usb_generic_resume+0x73/0xcf [usbcore]   <cf83d610> finish_device_resume+0x119/0x16a [usbcore]
 <cf83e46a> usb_resume_device+0x46/0xa1 [usbcore]   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
ohci_hcd 0000:00:03.0: OHCI controller state
ohci_hcd 0000:00:03.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:03.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:03.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:03.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:03.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:03.0: hcca frame #0003
ohci_hcd 0000:00:03.0: roothub.a 01000203 POTPGT=1 NPS NDP=3(3)
ohci_hcd 0000:00:03.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:03.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:03.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:03.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:03.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:03.0: restart complete
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c011d16a> msleep+0x17/0x1c
 <cf83d9b0> hub_resume+0x74/0x17f [usbcore]   <cf83c4f7> usb_generic_resume+0x0/0xcf [usbcore]
 <cf83c56a> usb_generic_resume+0x73/0xcf [usbcore]   <cf83d610> finish_device_resume+0x119/0x16a [usbcore]
 <cf83e46a> usb_resume_device+0x46/0xa1 [usbcore]   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
ohci_hcd 0000:00:03.0: GetStatus roothub.portstatus [0] = 0x00010100 CSC PPS
usb usb3: finish resume
ohci_hcd 0000:01:07.0: lost power
usb usb3: root hub lost power or was reset
ohci_hcd 0000:01:07.0: resetting from state 'reset', control = 0x0
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <cf842dc0> usb_start_wait_urb+0x141/0x14b [usbcore]
 <c028c6bf> schedule_timeout+0x7a/0x95   <c011c755> process_timeout+0x0/0x5
 <c011d16a> msleep+0x17/0x1c   <cf828643> ohci_run+0x19e/0x46d [ohci_hcd]
 <cf8291ba> ohci_bus_resume+0x35e/0x5e4 [ohci_hcd]   <cf840c5e> hcd_bus_resume+0x2d/0x7a [usbcore]
 <cf83d974> hub_resume+0x38/0x17f [usbcore]   <cf83c4f7> usb_generic_resume+0x0/0xcf [usbcore]
 <cf83c56a> usb_generic_resume+0x73/0xcf [usbcore]   <cf83d610> finish_device_resume+0x119/0x16a [usbcore]
 <cf83e46a> usb_resume_device+0x46/0xa1 [usbcore]   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
ohci_hcd 0000:01:07.0: OHCI controller state
ohci_hcd 0000:01:07.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:01:07.0: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:01:07.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:01:07.0: intrstatus 0x00000004 SF
ohci_hcd 0000:01:07.0: intrenable 0x8000001a MIE UE RD WDH
ohci_hcd 0000:01:07.0: hcca frame #01fe
ohci_hcd 0000:01:07.0: roothub.a ff000203 POTPGT=255 NPS NDP=3(3)
ohci_hcd 0000:01:07.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:01:07.0: roothub.status 00008000 DRWE
ohci_hcd 0000:01:07.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:01:07.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:01:07.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:01:07.0: restart complete
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c011d0d9> __mod_timer+0x9f/0xa9
 <c028c6bf> schedule_timeout+0x7a/0x95   <c011c755> process_timeout+0x0/0x5
 <c011d16a> msleep+0x17/0x1c   <cf83d9b0> hub_resume+0x74/0x17f [usbcore]
 <cf83c4f7> usb_generic_resume+0x0/0xcf [usbcore]   <cf83c56a> usb_generic_resume+0x73/0xcf [usbcore]
 <cf83d610> finish_device_resume+0x119/0x16a [usbcore]   <cf83e46a> usb_resume_device+0x46/0xa1 [usbcore]
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
ohci_hcd 0000:01:07.0: GetStatus roothub.portstatus [0] = 0x00010100 CSC PPS
usb 3-2: finish resume
usb 3-2: gone after usb resume? status -19
hub 3-0:1.0: resume port 2 --> -19
hub 3-0:1.0: logical disconnect on port 2
usb usb4: finish resume
ohci_hcd 0000:01:07.1: lost power
usb usb4: root hub lost power or was reset
ohci_hcd 0000:01:07.1: resetting from state 'reset', control = 0x0
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <cf842dc0> usb_start_wait_urb+0x141/0x14b [usbcore]
 <c028c6bf> schedule_timeout+0x7a/0x95   <c011c755> process_timeout+0x0/0x5
 <c011d16a> msleep+0x17/0x1c   <cf828643> ohci_run+0x19e/0x46d [ohci_hcd]
 <cf8291ba> ohci_bus_resume+0x35e/0x5e4 [ohci_hcd]   <cf840c5e> hcd_bus_resume+0x2d/0x7a [usbcore]
 <cf83d974> hub_resume+0x38/0x17f [usbcore]   <cf83c4f7> usb_generic_resume+0x0/0xcf [usbcore]
 <cf83c56a> usb_generic_resume+0x73/0xcf [usbcore]   <cf83d610> finish_device_resume+0x119/0x16a [usbcore]
 <cf83e46a> usb_resume_device+0x46/0xa1 [usbcore]   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
ohci_hcd 0000:01:07.1: OHCI controller state
ohci_hcd 0000:01:07.1: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:01:07.1: control 0x083 HCFS=operational CBSR=3
ohci_hcd 0000:01:07.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:01:07.1: intrstatus 0x00000004 SF
ohci_hcd 0000:01:07.1: intrenable 0x8000001a MIE UE RD WDH
ohci_hcd 0000:01:07.1: hcca frame #01fe
ohci_hcd 0000:01:07.1: roothub.a ff000202 POTPGT=255 NPS NDP=2(2)
ohci_hcd 0000:01:07.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:01:07.1: roothub.status 00008000 DRWE
ohci_hcd 0000:01:07.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:01:07.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:01:07.1: restart complete
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c011d0d9> __mod_timer+0x9f/0xa9
 <c028c6bf> schedule_timeout+0x7a/0x95   <c011c755> process_timeout+0x0/0x5
 <c011d16a> msleep+0x17/0x1c   <cf83d9b0> hub_resume+0x74/0x17f [usbcore]
 <cf83c4f7> usb_generic_resume+0x0/0xcf [usbcore]   <cf83c56a> usb_generic_resume+0x73/0xcf [usbcore]
 <cf83d610> finish_device_resume+0x119/0x16a [usbcore]   <cf83e46a> usb_resume_device+0x46/0xa1 [usbcore]
 <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
 <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
 <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
 <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
 <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
 <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
 <c0102973> sysenter_past_esp+0x54/0x75  
ohci_hcd 0000:01:07.1: GetStatus roothub.portstatus [0] = 0x00010100 CSC PPS
usb usb5: finish resume
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
 <c011c755> process_timeout+0x0/0x5   <c011d16a> msleep+0x17/0x1c
 <cf83d9b0> hub_resume+0x74/0x17f [usbcore]   <cf83c4f7> usb_generic_resume+0x0/0xcf [usbcore]
 <cf83c56a> usb_generic_resume+0x73/0xcf [usbcore]   <cf83d610> finish_device_resume+0x119/0x16a [usbcore]
 <cf83e46a> usb_resume_device+0x46/0xa1 [usbcore]   <c02025d9> resume_device+0x7d/0x96
 <c02026a7> dpm_resume+0x58/0x80   <c02026dc> device_resume+0xd/0x16
 <c012db1f> pm_suspend_disk+0xbf/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001002 POWER sig=se0 CSC
ehci_hcd 0000:01:07.2: GetStatus port 3 status 001403 POWER sig=k CSC CONNECT
Restarting tasks...<3>BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c0112f8f> try_to_wake_up+0xe1/0xea
 <c012cea3> thaw_processes+0x97/0xc4   <c012d90e> unprepare_processes+0x25/0x2a
 <c012db24> pm_suspend_disk+0xc4/0xc8   <c012cb95> enter_state+0x50/0x16f
 <c012cd37> state_store+0x83/0x8f   <c012ccb4> state_store+0x0/0x8f
 <c0173492> subsys_attr_store+0x1e/0x22   <c0173a1b> sysfs_write_file+0x92/0xb9
 <c0173989> sysfs_write_file+0x0/0xb9   <c01491ca> vfs_write+0x83/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102973> sysenter_past_esp+0x54/0x75
hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0002
ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [0] = 0x00010100 CSC PPS
hub 1-0:1.0: port 1, status 0100, change 0001, 12 Mb/s
 done
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c014922a> vfs_write+0xe3/0x122
 <c01499df> sys_write+0x3c/0x63   <c0102a3a> work_resched+0x5/0x16
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c028be58> io_schedule+0xe/0x16
 <c014a963> sync_buffer+0x2b/0x2e   <c028c733> __wait_on_bit+0x31/0x56
 <c014a938> sync_buffer+0x0/0x2e   <c014a938> sync_buffer+0x0/0x2e
 <c028c7b9> out_of_line_wait_on_bit+0x61/0x69   <c0124d17> wake_bit_function+0x0/0x3c
 <c014a1b3> __wait_on_buffer+0x1c/0x1f   <c017b03e> ext3_bread+0x47/0x61
 <c017c4a2> dx_probe+0x3a/0x2af   <c017d4e4> ext3_find_entry+0xc2/0x4ed
 <c01af373> snprintf+0x1b/0x1f   <c017dfaa> ext3_lookup+0x1f/0x75
 <c0153848> __lookup_hash+0xaa/0xc3   <c0155916> open_namei+0xc9/0x4e5
 <c0148839> do_filp_open+0x1c/0x31   <c01af373> snprintf+0x1b/0x1f
 <c014885d> filp_open+0xf/0x11   <c0151295> do_coredump+0x4e9/0x59e
 <c011e84a> __dequeue_signal+0x149/0x154   <c011f777> get_signal_to_deliver+0x3eb/0x418
 <c0111230> do_page_fault+0x0/0x4c3   <c0102372> do_notify_resume+0x6f/0x5a1
 <c0103463> error_code+0x4f/0x54   <c028dd4a> iret_exc+0x136/0x779
 <c01116a3> do_page_fault+0x473/0x4c3   <c0111230> do_page_fault+0x0/0x4c3
 <c0102a5e> work_notifysig+0x13/0x19  
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c01a7957> generic_make_request+0x191/0x1c2
 <c028be58> io_schedule+0xe/0x16   <c014a963> sync_buffer+0x2b/0x2e
 <c028c733> __wait_on_bit+0x31/0x56   <c014a938> sync_buffer+0x0/0x2e
 <c014a938> sync_buffer+0x0/0x2e   <c028c7b9> out_of_line_wait_on_bit+0x61/0x69
 <c0124d17> wake_bit_function+0x0/0x3c   <c014a1b3> __wait_on_buffer+0x1c/0x1f
 <c017b03e> ext3_bread+0x47/0x61   <c017d571> ext3_find_entry+0x14f/0x4ed
 <c017dfaa> ext3_lookup+0x1f/0x75   <c0153848> __lookup_hash+0xaa/0xc3
 <c0155916> open_namei+0xc9/0x4e5   <c0148839> do_filp_open+0x1c/0x31
 <c01af373> snprintf+0x1b/0x1f   <c014885d> filp_open+0xf/0x11
 <c0151295> do_coredump+0x4e9/0x59e   <c011e84a> __dequeue_signal+0x149/0x154
 <c011f777> get_signal_to_deliver+0x3eb/0x418   <c0111230> do_page_fault+0x0/0x4c3
 <c0102372> do_notify_resume+0x6f/0x5a1   <c0103463> error_code+0x4f/0x54
 <c028dd4a> iret_exc+0x136/0x779   <c01116a3> do_page_fault+0x473/0x4c3
 <c0111230> do_page_fault+0x0/0x4c3   <c0102a5e> work_notifysig+0x13/0x19
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0002
ohci_hcd 0000:00:03.0: GetStatus roothub.portstatus [0] = 0x00010100 CSC PPS
hub 2-0:1.0: port 1, status 0100, change 0001, 12 Mb/s
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c01354ed> get_page_from_freelist+0x7d/0x2fb
 <c01a7957> generic_make_request+0x191/0x1c2   <c028be58> io_schedule+0xe/0x16
 <c014a963> sync_buffer+0x2b/0x2e   <c028c733> __wait_on_bit+0x31/0x56
 <c014a938> sync_buffer+0x0/0x2e   <c014a938> sync_buffer+0x0/0x2e
 <c028c7b9> out_of_line_wait_on_bit+0x61/0x69   <c0124d17> wake_bit_function+0x0/0x3c
 <c014a1b3> __wait_on_buffer+0x1c/0x1f   <c014c575> __bread+0x59/0x6c
 <c01771b4> read_inode_bitmap+0x28/0x4c   <c01779ed> ext3_new_inode+0x3f9/0x824
 <c017d188> ext3_create+0x5d/0xc2   <c017d12b> ext3_create+0x0/0xc2
 <c0155811> vfs_create+0x5e/0x9a   <c0155982> open_namei+0x135/0x4e5
 <c0148839> do_filp_open+0x1c/0x31   <c01af373> snprintf+0x1b/0x1f
 <c014885d> filp_open+0xf/0x11   <c0151295> do_coredump+0x4e9/0x59e
 <c011e84a> __dequeue_signal+0x149/0x154   <c011f777> get_signal_to_deliver+0x3eb/0x418
 <c0111230> do_page_fault+0x0/0x4c3   <c0102372> do_notify_resume+0x6f/0x5a1
 <c0103463> error_code+0x4f/0x54   <c028dd4a> iret_exc+0x136/0x779
 <c01116a3> do_page_fault+0x473/0x4c3   <c0111230> do_page_fault+0x0/0x4c3
 <c0102a5e> work_notifysig+0x13/0x19  
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
hub 3-0:1.0: state 7 ports 3 chg 0004 evt 0006
ohci_hcd 0000:01:07.0: GetStatus roothub.portstatus [0] = 0x00010100 CSC PPS
hub 3-0:1.0: port 1, status 0100, change 0001, 12 Mb/s
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c01354ed> get_page_from_freelist+0x7d/0x2fb
 <c01a7957> generic_make_request+0x191/0x1c2   <c028be58> io_schedule+0xe/0x16
 <c014a963> sync_buffer+0x2b/0x2e   <c028c733> __wait_on_bit+0x31/0x56
 <c014a938> sync_buffer+0x0/0x2e   <c014a938> sync_buffer+0x0/0x2e
 <c028c7b9> out_of_line_wait_on_bit+0x61/0x69   <c0124d17> wake_bit_function+0x0/0x3c
 <c014a1b3> __wait_on_buffer+0x1c/0x1f   <c0178352> __ext3_get_inode_loc+0x27b/0x2c2
 <c017841e> ext3_reserve_inode_write+0x1a/0x7a   <c017889b> ext3_mark_inode_dirty+0x11/0x27
 <c01858ca> journal_dirty_metadata+0x12e/0x15c   <c0177d87> ext3_new_inode+0x793/0x824
 <c017d188> ext3_create+0x5d/0xc2   <c017d12b> ext3_create+0x0/0xc2
 <c0155811> vfs_create+0x5e/0x9a   <c0155982> open_namei+0x135/0x4e5
 <c0148839> do_filp_open+0x1c/0x31   <c01af373> snprintf+0x1b/0x1f
 <c014885d> filp_open+0xf/0x11   <c0151295> do_coredump+0x4e9/0x59e
 <c011e84a> __dequeue_signal+0x149/0x154   <c011f777> get_signal_to_deliver+0x3eb/0x418
 <c0111230> do_page_fault+0x0/0x4c3   <c0102372> do_notify_resume+0x6f/0x5a1
 <c0103463> error_code+0x4f/0x54   <c028dd4a> iret_exc+0x136/0x779
 <c01116a3> do_page_fault+0x473/0x4c3   <c0111230> do_page_fault+0x0/0x4c3
 <c0102a5e> work_notifysig+0x13/0x19  
hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
ohci_hcd 0000:01:07.0: GetStatus roothub.portstatus [1] = 0x00010100 CSC PPS
hub 3-0:1.0: port 2, status 0100, change 0001, 12 Mb/s
usb 3-2: USB disconnect, address 3
usb 3-2: usb_disable_device nuking all URBs
usb 3-2: unregistering interface 3-2:1.0
usb 3-2:1.0: uevent
usb 3-2: unregistering device
usb 3-2: uevent
hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0002
ohci_hcd 0000:01:07.1: GetStatus roothub.portstatus [0] = 0x00010100 CSC PPS
hub 4-0:1.0: port 1, status 0100, change 0001, 12 Mb/s
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c01a7957> generic_make_request+0x191/0x1c2
 <c028be58> io_schedule+0xe/0x16   <c014a963> sync_buffer+0x2b/0x2e
 <c028c733> __wait_on_bit+0x31/0x56   <c014a938> sync_buffer+0x0/0x2e
 <c014a938> sync_buffer+0x0/0x2e   <c028c7b9> out_of_line_wait_on_bit+0x61/0x69
 <c0124d17> wake_bit_function+0x0/0x3c   <c014a1b3> __wait_on_buffer+0x1c/0x1f
 <c0178352> __ext3_get_inode_loc+0x27b/0x2c2   <c017841e> ext3_reserve_inode_write+0x1a/0x7a
 <c017889b> ext3_mark_inode_dirty+0x11/0x27   <c017be7c> add_dirent_to_buf+0x1fa/0x279
 <c017c836> ext3_add_entry+0x11f/0x871   <c0177e08> ext3_new_inode+0x814/0x824
 <c017cf97> ext3_add_nondir+0xf/0x3a   <c017d1b9> ext3_create+0x8e/0xc2
 <c017d12b> ext3_create+0x0/0xc2   <c0155811> vfs_create+0x5e/0x9a
 <c0155982> open_namei+0x135/0x4e5   <c0148839> do_filp_open+0x1c/0x31
 <c01af373> snprintf+0x1b/0x1f   <c014885d> filp_open+0xf/0x11
 <c0151295> do_coredump+0x4e9/0x59e   <c011e84a> __dequeue_signal+0x149/0x154
 <c011f777> get_signal_to_deliver+0x3eb/0x418   <c0111230> do_page_fault+0x0/0x4c3
 <c0102372> do_notify_resume+0x6f/0x5a1   <c0103463> error_code+0x4f/0x54
 <c028dd4a> iret_exc+0x136/0x779   <c01116a3> do_page_fault+0x473/0x4c3
 <c0111230> do_page_fault+0x0/0x4c3   <c0102a5e> work_notifysig+0x13/0x19
hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
hub 5-0:1.0: state 7 ports 5 chg 0004 evt 000c
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001803 POWER sig=j CSC CONNECT
hub 5-0:1.0: port 2, status 0501, change 0001, 480 Mb/s
usb 5-2: USB disconnect, address 3
usb 5-2: usb_disable_device nuking all URBs
usb 5-2: unregistering interface 5-2:1.0
usb 5-2:1.0: uevent
usb 5-2: unregistering device
usb 5-2: uevent
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x501
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c011652c> vprintk+0x23f/0x286
 <c01a7957> generic_make_request+0x191/0x1c2   <c028be58> io_schedule+0xe/0x16
 <c014a963> sync_buffer+0x2b/0x2e   <c028c733> __wait_on_bit+0x31/0x56
 <c014a938> sync_buffer+0x0/0x2e   <c014a938> sync_buffer+0x0/0x2e
 <c028c7b9> out_of_line_wait_on_bit+0x61/0x69   <c0124d17> wake_bit_function+0x0/0x3c
 <c014a1b3> __wait_on_buffer+0x1c/0x1f   <c014c575> __bread+0x59/0x6c
 <c017550e> read_block_bitmap+0x27/0x4a   <c0176336> ext3_new_blocks+0x191/0x55d
 <c01281c3> debug_mutex_add_waiter+0x14/0x25   <c0179dad> ext3_get_blocks_handle+0x12b/0x89d
 <c0179dad> ext3_get_blocks_handle+0x12b/0x89d   <c0179fd5> ext3_get_blocks_handle+0x353/0x89d
 <c0102a5e> work_notifysig+0x13/0x19   <c011652c> vprintk+0x23f/0x286
 <c011652c> vprintk+0x23f/0x286   <c010dc72> smp_apic_timer_interrupt+0x2a/0x2f
 <c01033bc> apic_timer_interrupt+0x1c/0x24   <c017a5ad> ext3_direct_io_get_blocks+0x8e/0xa8
 <c017a5d6> ext3_get_block+0xf/0x12   <c014b904> __block_prepare_write+0x114/0x379
 <c014bb7f> block_prepare_write+0x16/0x22   <c017a5c7> ext3_get_block+0x0/0x12
 <c01795fc> ext3_prepare_write+0x7f/0x115   <c017a5c7> ext3_get_block+0x0/0x12
 <c013216e> generic_file_buffered_write+0x21e/0x52b   <c0183f09> journal_stop+0x1c7/0x1d1
 <c017ef4f> __ext3_journal_stop+0x19/0x34   <c013353e> __generic_file_aio_write_nolock+0x3a1/0x3de
 <c013377e> generic_file_aio_write+0x3d/0xa4   <c0133792> generic_file_aio_write+0x51/0xa4
 <c017701d> ext3_file_write+0x19/0x83   <c0148df6> do_sync_write+0xb8/0xf3
 <c0124c68> autoremove_wake_function+0x0/0x2d   <c017ba41> ext3_orphan_del+0x52/0x1b6
 <c015d87a> inode_setattr+0x146/0x150   <c01affab> _mmx_memcpy+0x3c/0x136
 <c0169540> dump_write+0x10/0x1c   <c016b515> elf_core_dump+0x6ad/0xb32
 <c015dba3> notify_change+0x20d/0x21d   <c01512f1> do_coredump+0x545/0x59e
 <c011e84a> __dequeue_signal+0x149/0x154   <c011f777> get_signal_to_deliver+0x3eb/0x418
 <c0111230> do_page_fault+0x0/0x4c3   <c0102372> do_notify_resume+0x6f/0x5a1
 <c0103463> error_code+0x4f/0x54   <c028dd4a> iret_exc+0x136/0x779
 <c01116a3> do_page_fault+0x473/0x4c3   <c0111230> do_page_fault+0x0/0x4c3
 <c0102a5e> work_notifysig+0x13/0x19  
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 4
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c01a7957> generic_make_request+0x191/0x1c2
 <c028be58> io_schedule+0xe/0x16   <c014a963> sync_buffer+0x2b/0x2e
 <c028c733> __wait_on_bit+0x31/0x56   <c014a938> sync_buffer+0x0/0x2e
 <c014a938> sync_buffer+0x0/0x2e   <c028c7b9> out_of_line_wait_on_bit+0x61/0x69
 <c0124d17> wake_bit_function+0x0/0x3c   <c014a1b3> __wait_on_buffer+0x1c/0x1f
 <c014c575> __bread+0x59/0x6c   <c0179c0d> ext3_get_branch+0x6b/0xe0
 <c0179d37> ext3_get_blocks_handle+0xb5/0x89d   <c0135653> get_page_from_freelist+0x1e3/0x2fb
 <c01858ef> journal_dirty_metadata+0x153/0x15c   <c0178830> ext3_mark_iloc_dirty+0x2d7/0x331
 <c017a5ad> ext3_direct_io_get_blocks+0x8e/0xa8   <c017a5d6> ext3_get_block+0xf/0x12
 <c0164d2d> do_mpage_readpage+0xe3/0x318   <c0132461> generic_file_buffered_write+0x511/0x52b
 <c0165787> mpage_readpages+0x8e/0xef   <c017a5c7> ext3_get_block+0x0/0x12
 <c01357b8> __alloc_pages+0x4d/0x25d   <c0177e7e> ext3_readpages+0x0/0x15
 <c0136aaf> __do_page_cache_readahead+0x140/0x201   <c017a5c7> ext3_get_block+0x0/0x12
 <c013377e> generic_file_aio_write+0x3d/0xa4   <c013379b> generic_file_aio_write+0x5a/0xa4
 <c0132a98> filemap_nopage+0x148/0x2e2   <c013bab5> __handle_mm_fault+0x201/0x6a2
 <c013c102> get_user_pages+0x1ac/0x25b   <c016b7eb> elf_core_dump+0x983/0xb32
 <c01512f1> do_coredump+0x545/0x59e   <c011e84a> __dequeue_signal+0x149/0x154
 <c011f777> get_signal_to_deliver+0x3eb/0x418   <c0111230> do_page_fault+0x0/0x4c3
 <c0102372> do_notify_resume+0x6f/0x5a1   <c0103463> error_code+0x4f/0x54
 <c028dd4a> iret_exc+0x136/0x779   <c01116a3> do_page_fault+0x473/0x4c3
 <c0111230> do_page_fault+0x0/0x4c3   <c0102a5e> work_notifysig+0x13/0x19
BUG: scheduling while atomic: zsh/0x00000001/2196
 <c028b93f> schedule+0x43/0x54e   <c0177e7e> ext3_readpages+0x0/0x15
 <c0136aaf> __do_page_cache_readahead+0x140/0x201   <c017a5c7> ext3_get_block+0x0/0x12
 <c028be58> io_schedule+0xe/0x16   <c0131043> sync_page+0x0/0x36
 <c0131076> sync_page+0x33/0x36   <c028c7ed> __wait_on_bit_lock+0x2c/0x51
 <c0131169> __lock_page+0x50/0x56   <c0124d17> wake_bit_function+0x0/0x3c
 <c0132b5c> filemap_nopage+0x20c/0x2e2   <c013bab5> __handle_mm_fault+0x201/0x6a2
 <c013c102> get_user_pages+0x1ac/0x25b   <c016b7eb> elf_core_dump+0x983/0xb32
 <c01512f1> do_coredump+0x545/0x59e   <c011e84a> __dequeue_signal+0x149/0x154
 <c011f777> get_signal_to_deliver+0x3eb/0x418   <c0111230> do_page_fault+0x0/0x4c3
 <c0102372> do_notify_resume+0x6f/0x5a1   <c0103463> error_code+0x4f/0x54
 <c028dd4a> iret_exc+0x136/0x779   <c01116a3> do_page_fault+0x473/0x4c3
 <c0111230> do_page_fault+0x0/0x4c3   <c0102a5e> work_notifysig+0x13/0x19
note: zsh[2196] exited with preempt_count 1
 0:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sda1): ext3_find_entry: reading directory #2 offset 0
ehci_hcd 0000:01:07.2: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.
usb 5-2: khubd timed out on ep0in len=8/64
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
usb 5-2: khubd timed out on ep0out len=0/0
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
usb 5-2: khubd timed out on ep0out len=0/0
 0:0:0:0: rejecting I/O to dead device
usb 5-2: device not accepting address 4, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 5
 0:0:0:0: rejecting I/O to dead device
usb 5-2: khubd timed out on ep0in len=18/64
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
usb 5-2: khubd timed out on ep0out len=0/0
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 5, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 6
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
usb 5-2: khubd timed out on ep0out len=0/0
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 6, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 7
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
usb 5-2: khubd timed out on ep0out len=0/0
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 7, error -110
ehci_hcd 0000:01:07.2: GetStatus port 3 status 001403 POWER sig=k CSC CONNECT
hub 5-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
hub 5-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
ehci_hcd 0000:01:07.2: port 3 low speed --> companion
ehci_hcd 0000:01:07.2: GetStatus port 3 status 003402 POWER OWNER sig=k CSC
hub 5-0:1.0: state 7 ports 5 chg 0000 evt 0000
hub 3-0:1.0: state 7 ports 3 chg 0000 evt 0004
ohci_hcd 0000:01:07.0: GetStatus roothub.portstatus [1] = 0x00010301 CSC LSDA PPS CCS
hub 3-0:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
 0:0:0:0: rejecting I/O to dead device
hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
ohci_hcd 0000:01:07.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
usb 3-2: new low speed USB device using ohci_hcd and address 4
ohci_hcd 0000:01:07.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
usb 3-2: skipped 1 descriptor after interface
usb 3-2: default language 0x0409
usb 3-2: new device found, idVendor=045e, idProduct=0040
usb 3-2: new device strings: Mfr=1, Product=3, SerialNumber=0
usb 3-2: Product: Microsoft 3-Button Mouse with IntelliEye(TM)
usb 3-2: Manufacturer: Microsoft
usb 3-2: uevent
usb 3-2: device is bus-powered
usb 3-2: configuration #1 chosen from 1 choice
usb 3-2: adding 3-2:1.0 (config #1, interface 0)
usb 3-2:1.0: uevent
usbhid 3-2:1.0: usb_probe_interface
usbhid 3-2:1.0: usb_probe_interface - got id
input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as /class/input/input3
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on usb-0000:01:07.0-2
drivers/usb/core/inode.c: creating file '004'
hub 3-0:1.0: state 7 ports 3 chg 0000 evt 0004
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
 0:0:0:0: rejecting I/O to dead device
hub 5-0:1.0: state 7 ports 5 chg 0000 evt 0004
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001002 POWER sig=se0 CSC
hub 5-0:1.0: port 2, status 0100, change 0001, 12 Mb/s
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 5-0:1.0: state 7 ports 5 chg 0000 evt 0004
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001803 POWER sig=j CSC CONNECT
hub 5-0:1.0: port 2, status 0501, change 0001, 480 Mb/s
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x501
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 9
usb 5-2: khubd timed out on ep0in len=18/64
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 9, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 10
usb 5-2: khubd timed out on ep0in len=18/64
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 10, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 11
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 11, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 12
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 12, error -110
hub 5-0:1.0: state 7 ports 5 chg 0000 evt 0004
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001002 POWER sig=se0 CSC
hub 5-0:1.0: port 2, status 0100, change 0001, 12 Mb/s
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 5-0:1.0: state 7 ports 5 chg 0000 evt 0004
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001803 POWER sig=j CSC CONNECT
hub 5-0:1.0: port 2, status 0501, change 0001, 480 Mb/s
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x501
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 13
usb 5-2: khubd timed out on ep0in len=8/64
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 13, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 14
usb 5-2: khubd timed out on ep0in len=18/64
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 14, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 15
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 15, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 16
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 16, error -110
hub 5-0:1.0: state 7 ports 5 chg 0000 evt 0004
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001002 POWER sig=se0 CSC
hub 5-0:1.0: port 2, status 0100, change 0001, 12 Mb/s
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 5-0:1.0: state 7 ports 5 chg 0000 evt 0004
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001803 POWER sig=j CSC CONNECT
hub 5-0:1.0: port 2, status 0501, change 0001, 480 Mb/s
hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x501
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 17
usb 5-2: khubd timed out on ep0in len=8/64
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 17, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 18
usb 5-2: khubd timed out on ep0in len=18/64
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 18, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 19
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 19, error -110
ehci_hcd 0000:01:07.2: port 2 high speed
ehci_hcd 0000:01:07.2: GetStatus port 2 status 001005 POWER sig=se0 PE CONNECT
usb 5-2: new high speed USB device using ehci_hcd and address 20
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: khubd timed out on ep0out len=0/0
usb 5-2: device not accepting address 20, error -110

--=-=-=


while testing suspending with that kernel, the root shell that echoed
in /sys/power/state got killed with "note: zsh[2196] exited with preempt_count 1"

--=-=-=--

