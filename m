Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVDFHiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVDFHiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVDFHiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:38:19 -0400
Received: from upco.es ([130.206.70.227]:29082 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262131AbVDFHiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:38:09 -0400
Date: Wed, 6 Apr 2005 09:38:00 +0200
From: Romano Giannetti <romanol@upco.es>
To: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: ACPI + preempt + swsusp (S4) still no go in 2.6.12-rc2
Message-ID: <20050406073800.GA27156@pern.dea.icai.upco.es>
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
	acpi-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

   I had a bit of time and tested yesterday 2.6.12-rc2. swsusp works (modulo
   the alps resume patch, which are not in yet) provided that preempt is
   disabled. A working[Note 1] config/patch/dmesg is here: 
   http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc2-nopreempt-boot/laptop-config.html
   
   [Note 1] working modulo the still present 8-key delay related in
   http://bugme.osdl.org/show_bug.cgi?id=4124#c2   

   Now, compiling the _same_kernel_ with preempt on fail on resume. The same
   data (config/patch/dmesg etc) is here:
   http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc2-preempt-boot/laptop-config.html   
   The resuming script is doing: 

            [...]   
            echo 4 > /proc/acpi/sleep
            hwclock --hctosys
            sleep 1
            modprobe battery   #never arrives here
            modprobe ac
            modprobe fan
            modprobe button
            service usb start

    but it fails. The system start spew "scheduling while atomic" (I do not
    know why the script fails: there are no Oops or similar thing in the
    logs). There are a bunch of them, it seems one for every device resumed. 
    Full log is http://www.dea.icai.upco.es/romano/linux/br/bug-2.6.12-rc2-fulllog.txt    
    but I report here the first of such "scheduling while atomic": 

 [nosave pfn 0x4a0]<7>[nosave pfn 0x4a1]<7>[4295571.192000] PM: Image restored successfully.
 scheduling while atomic: really_suspend/0x00000001/5478
  [schedule+1384/1568] schedule+0x568/0x620
  [<c03a6af8>] schedule+0x568/0x620
  [__mod_timer+453/496] __mod_timer+0x1c5/0x1f0
  [<c0122245>] __mod_timer+0x1c5/0x1f0
  [schedule_timeout+93/176] schedule_timeout+0x5d/0xb0
  [<c03a75bd>] schedule_timeout+0x5d/0xb0
  [process_timeout+0/16] process_timeout+0x0/0x10
  [<c0122ce0>] process_timeout+0x0/0x10
  [msleep+47/64] msleep+0x2f/0x40
  [<c01230cf>] msleep+0x2f/0x40
  [pci_set_power_state+400/464] pci_set_power_state+0x190/0x1d0
  [<c0252be0>] pci_set_power_state+0x190/0x1d0
  [pci_enable_device_bars+24/64] pci_enable_device_bars+0x18/0x40
  [<c0252d28>] pci_enable_device_bars+0x18/0x40
  [pci_enable_device+31/64] pci_enable_device+0x1f/0x40
  [<c0252d6f>] pci_enable_device+0x1f/0x40
  [pg0+276592203/1068393472] snd_via82xx_resume+0x1b/0x140 [snd_via82xx]
  [<d0cdf64b>] snd_via82xx_resume+0x1b/0x140 [snd_via82xx]
  [pg0+276450129/1068393472] snd_card_pci_resume+0x41/0x6e [snd]
  [<d0cbcb51>] snd_card_pci_resume+0x41/0x6e [snd]
  [pci_device_resume+44/64] pci_device_resume+0x2c/0x40
  [<c025500c>] pci_device_resume+0x2c/0x40
  [dpm_resume+168/176] dpm_resume+0xa8/0xb0
  [<c02d6678>] dpm_resume+0xa8/0xb0
  [device_resume+17/32] device_resume+0x11/0x20
  [<c02d6691>] device_resume+0x11/0x20
  [<c02d6691>] device_resume+0x11/0x20
  [finish+8/64] finish+0x8/0x40
  [<c0139f18>] finish+0x8/0x40
  [pm_suspend_disk+148/192] pm_suspend_disk+0x94/0xc0
  [<c013a0b4>] pm_suspend_disk+0x94/0xc0
  [enter_state+134/144] enter_state+0x86/0x90
  [<c0137a76>] enter_state+0x86/0x90
  [software_suspend+15/32] software_suspend+0xf/0x20
  [<c0137a8f>] software_suspend+0xf/0x20
  [acpi_system_write_sleep+106/132] acpi_system_write_sleep+0x6a/0x84
  [<c02927ea>] acpi_system_write_sleep+0x6a/0x84
  [vfs_write+332/352] vfs_write+0x14c/0x160
  [<c015c56c>] vfs_write+0x14c/0x160
  [sys_write+81/128] sys_write+0x51/0x80
  [<c015c651>] sys_write+0x51/0x80
  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
  [<c010335b>] sysenter_past_esp+0x54/0x75
    
  After that, if I repeat a couple of time rmmod battery; modprobe battery;
  the battery monitor works in the end; and restarting the other ACPI
  modules and USB by hand the systems feels ok. 

  Hope this helps to nail down the problem. I tried to start with
  init=/bin/bash (with -rc1 kernel), same kind of problems. 

                  Romano   
        

   
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
