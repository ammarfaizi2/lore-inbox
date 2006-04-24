Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWDXB6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWDXB6z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 21:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWDXB6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 21:58:55 -0400
Received: from fmr20.intel.com ([134.134.136.19]:2711 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751485AbWDXB6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 21:58:54 -0400
Subject: Re: 2.6.17-rc1: kernel only boots one CPU on HT system
From: Shaohua Li <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Kevin Baradon <kevin.baradon@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060423141519.314ae567.akpm@osdl.org>
References: <200604231434.59966.Kevin.Baradon@gmail.com>
	 <20060423141519.314ae567.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 09:57:39 +0800
Message-Id: <1145843859.19994.63.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, 2006-04-23 at 14:15 -0700, Andrew Morton wrote:
> Kevin Baradon <kevin.baradon@gmail.com> wrote:
> >
> > Hello,
> > 
> > Starting with kernel 2.6.17-rc1 (also happens with 2.6.17-rc2), second 
> > logical-CPU of my Hyperthreading system no longer boots.
> > 
> > I tracked up changes in APIC code, and it appears reverting commit 
> > 7c5c1e427b5e83807fd05419d1cf6991b9d87247 fixes this bug.
> 
> That helps heaps, thanks.
The commit doesn't look like the root cause to me. BIOS already assigns
unique id to ioapic, and the cpu family is 15, so with/without the patch
the code path hasn't any difference. Kevin, can you please make a clean
build and check if the patch is the real cause?

If it still doesn't work, you might apply a small change below to
include/asm-i386/apic.h, and attach the dmesg, so we could analyze it.

-#define Dprintk(x...)
+#define Dprintk(format, arg...) printk(format, ##arg)
> > See both dmesgs, and kernel configuration attached.
> > 
> > Feel free to ask me if you need other informations.
> > Please CC me as I'm not subscribed to LKML.
> > 
> > 
> > Hardware : 
> > ------------------------------
> > MB: Gigabyte GA-8SINXP1394
> > CPU: Intel Pentium 4 3.06Ghz HT
> > RAM: Corsair 512Mo
> > 
> > cat /proc/cpuinfo: (patched kernel)
> > ------------------------------
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 15
> > model           : 2
> > model name      : Intel(R) Pentium(R) 4 CPU 3.06GHz
> > stepping        : 7
> > cpu MHz         : 3081.400
> > cache size      : 512 KB
> > physical id     : 0
> > siblings        : 2
> > core id         : 0
> > cpu cores       : 1
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> > cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> > bogomips        : 6165.74
> > 
> > processor       : 1
> > vendor_id       : GenuineIntel
> > cpu family      : 15
> > model           : 2
> > model name      : Intel(R) Pentium(R) 4 CPU 3.06GHz
> > stepping        : 7
> > cpu MHz         : 3081.400
> > cache size      : 512 KB
> > physical id     : 0
> > siblings        : 2
> > core id         : 0
> > cpu cores       : 1
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> > cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> > bogomips        : 6162.10
> > 
> > cat /proc/interrupts :  (patched kernel)
> > -----------------------------
> >            CPU0       CPU1
> >   0:    2143303       6647    IO-APIC-edge  timer
> >   1:         15          9    IO-APIC-edge  i8042
> >   4:          7          1    IO-APIC-edge  serial
> >   8:      19518          1    IO-APIC-edge  rtc
> >   9:          0          0   IO-APIC-level  acpi
> >  15:      37053         23    IO-APIC-edge  ide1
> >  16:     240872          1   IO-APIC-level  cx88[0], eth-lan
> >  17:      11128         19   IO-APIC-level  ide2, ide3
> >  18:      63432          4   IO-APIC-level  libata, ohci1394, CS46XX
> >  19:          0          3   IO-APIC-level  ehci_hcd:usb1
> >  20:     457635        195   IO-APIC-level  ohci_hcd:usb2
> >  21:          0          0   IO-APIC-level  ohci_hcd:usb3
> >  22:          0          0   IO-APIC-level  ohci_hcd:usb4
> > NMI:    2149889    2149786
> > LOC:    2150122    2150121
> > ERR:          0
> > MIS:          0
> > 
> 
> Shaohua, I'll queue up a reversion patch so this doesn't get forgotten
> about but I won't send it to Linus at this stage.
Thanks, Andrew.

Thanks,
Shaohua


