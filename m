Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUI0XWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUI0XWC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 19:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUI0XWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 19:22:02 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:28389 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267450AbUI0XVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 19:21:48 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64 (update)
Date: Tue, 28 Sep 2004 01:23:54 +0200
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <200409251214.28743.rjw@sisk.pl> <200409261337.53298.rjw@sisk.pl> <20040926132036.GG826@openzaurus.ucw.cz>
In-Reply-To: <20040926132036.GG826@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KEKWBzt50Xr3OVu"
Message-Id: <200409280123.54857.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_KEKWBzt50Xr3OVu
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 26 of September 2004 15:20, Pavel Machek wrote:
> Hi!
> 
> > > > Not explicitly, but it's used by SuSE initscripts to set IDE DMA, 
AFAICS.  
> > > > However, the problem did not occur on 2.6.9-rc2-mm1 with the same 
> > > > initscripts.
> > > 
> > > Okay, so try what happens without the initscripts
> > 
> > I turned the stuff off but of course it didn't change anything. :-)
> > 
> > > and try to locate change that breaks it...
> > 
> > Well, I'm a bit confused:
> 
> That's very simple bugfix. Some code outside swsusp is doing this.

You are right, but I don't think it's a module.  Read on. ;-)

> Is it still slow with init=/bin/bash? If no, locate module that
> causes slowdown. We've seen pcmcia support behaving strange.

I did some tests on 2.6.9-rc2-mm4, just to make sure that the problem hasn't 
been fixed "magically".  Apparently, it hasn't.

First, I rebooted the machine, unloaded all modules except for ipv6 (it seems 
to be always used) and tried to suspend it.  It successfully suspended and 
resumed.

Then, I loaded ohci_hcd and ehci_hcd (usbhid and evdev got loaded 
automatically) and tried to suspend it again.  It successfully suspended and 
resumed.

Next, I loaded sk98lin and restarted networking (/etc/init.d/network restart), 
so af_packet got loaded automatically.  I tried to suspend the box and, 
again, everything went OK.

Next, after the box had woken up, I loaded parport and parport_pc and 
successfully suspended the box and resumed.

Next, I loaded lp and usbserial, and the box successfully suspended with these 
modules, but I got a familiar double fault on resume (trace attached).  So, I 
tried to recreate the conditions: I rebooted the box, unloaded all modules, 
loaded only the modules that had been present previosly (ie usbserial lp 
ohci_hcd parport_pc parport af_packet sk98lin ehci_hcd evdev usbhid ipv6) and 
tried to suspend the box.  It seemed to go just fine:

Stopping tasks: ============================|
Freeing memory... done (19488 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 0x586].....................................swsusp: Need to 
copy 10721 pages
suspend: (pages needed: 10721 + 512 free: 120158)
..<7>[nosave pfn 0x586]......................................swsusp: critical 
section/: done (10849 pages copied)
PM: writing image.
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:02.1 to 64
PCI: Setting latency timer of device 0000:00:02.2 to 64
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
 swsusp: Version: 132617
 swsusp: Num Pages: 130880
 swsusp: UTS Sys: Linux
 swsusp: UTS Node: albercik
 swsusp: UTS Release: 2.6.9-rc2-mm4
 swsusp: UTS Version: #14 Mon Sep 27 19:59:28 CEST 2004
 swsusp: UTS Machine: x86_64
 swsusp: UTS Domain:
 swsusp: CPUs: 1
 swsusp: Image: 10849 Pages
 swsusp: Pagedir: 0 Pages
Writing data to swap (10849 pages)...  84%

but the system slowed down here, after writing 84% pages to the swap, so I 
pressed Alt+sysrq+p:

<6>SysRq : Show Regs

Modules linked in: usbserial lp af_packet sk98lin evdev parport_pc parport 
usbhid ehci_hcd ohci_hcd ipv6
Pid: 1035, comm: kjournald Tainted: G   M  2.6.9-rc2-mm4
RIP: 0010:[<ffffffff80117b1b>] <ffffffff80117b1b>{sched_clock+11}
RSP: 0018:000001001d7a3d90  EFLAGS: 00000206
RAX: 00000085835f7fdd RBX: 000001001bd854d8 RCX: 00000000fffee984
RDX: 0000008500000000 RSI: 0000000000000000 RDI: 000001001fda8130
RBP: 000001001bd854d8 R08: 000001001d7a2000 R09: 000001001c9ca9e0
R10: 0000000000000000 R11: 0000000000000000 R12: 000001001bd854d8
R13: 000001001bd854d8 R14: 000001001bd854d8 R15: 000001001bd854d8
FS:  0000002a9588d700(0000) GS:ffffffff805582c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000415cbf CR3: 0000000000101000 CR4: 00000000000006e0

Call Trace:<ffffffff803a695c>{schedule+204} 
<ffffffff801634f7>{refrigerator+743}
       <ffffffff80236d12>{kjournald+1042} 
<ffffffff8015be70>{autoremove_wake_function+0}
       <ffffffff8015be70>{autoremove_wake_function+0} 
<ffffffff802370d0>{commit_timeout+0}
       <ffffffff80111843>{child_rip+8} <ffffffff80236900>{kjournald+0}
       <ffffffff8011183b>{child_rip+0}

Now, can you tell me, please, what the chances of hitting schedule() this way 
should be?  Not great, I think.  Still, I pressed Alt+sysrq+p for several 
times after I'd got the above trace and it always hit schedule() (all the 
traces were very similar to this one).

I've investigated this a bit more and it turns out that when I press 
Alt+sysrq+p after such a slowdown, I almost always hit schedule().  Slowdowns 
usually happen sooner or later after swsusp has been started, and the more 
modules are in memory at that time, the sooner the system slows down.  When 
all modules are present, it slows down right after printing "PM: writing 
image.".

My theory is that something really bad is going on in the scheduler after 
swsusp has been started and the "slowdowns" occur because the processor 
spends _a_ _lot_ of time in schedule().

I have verified that the problem was introduced between 2.6.9-rc2-mm1 and 
2.6.9-rc2-mm2, but I haven't identified the change that might have caused it, 
yet.  I've verified that it's not caused by any of the following patches:

cleanup-move-call-to-update_process_times.patch
cleanup-timeh-timesh-timexh-and-jiffiesh.patch

I can also say with a great deal of certainty that it's not caused by any 
changes to PCI and/or ACPI.  Moreover, I replaced the scheduler in 
2.6.9-rc2-mm2 with the Con's staircase scheduler and it made the symptoms 
even worse.  That is, with the staircase scheduler, the system always "slows 
down" before it writes all pages to the swap and if all modules are present 
when the system is suspended, the "slowdown" is much more "visible".  Of 
course, I can do some more tests/measurements if necessary.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_KEKWBzt50Xr3OVu
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="swsusp-double_fault.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="swsusp-double_fault.log"

Relocating pagedir not necessary
Reading image data (9659 pages): 100% 9659 done.
Stopping tasks: ===|
Freeing memory... done (0 pages freed)
PM: Restoring saved image.
<0>double fault: 0000 [1]
CPU 0
Modules linked in: usbserial lp ohci_hcd parport_pc parport af_packet sk98lin ehci_hcd evdev usbhid ipv6
Pid: 17009, comm: hibernate.sh Tainted: G   M  2.6.9-rc2-mm4
RIP: 0010:[<ffffffff8012518d>] <ffffffff8012518d>{do_page_fault+1485}
RSP: 0000:000001001fe00008  EFLAGS: 00010002
RAX: 000000001fce8740 RBX: 0000000000000001 RCX: 000ffffffffff000
RDX: 000000001fce8000 RSI: 0000010000000000 RDI: 000001001fe000e8
RBP: 000001001fce8740 R08: 0000000000000000 R09: 000001001fe27e54
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 000001001fe000e8 R15: 000001001b09e200
FS:  0000000000000000(0000) GS:ffffffff805582c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 0000000080050033
CR2: 000001001fdffff8 CR3: 0000000000101000 CR4: 00000000000006e0
Process hibernate.sh (pid: 17009, threadinfo 000001001c6d8000, task 000001001ad16530)
Stack: 000001001fe01000 0000000000000060 000001001ad16530 0000ffff0000001a
       fffefffefffefffe fffefffe00030001 fffefffefffefffe fffefffefffefffe
       fffefffefffefffe fffefffefffefffe
Call Trace:<ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} <ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} <ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff80282d47>{acpi_os_allocate+12}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff8011168d>{error_exit+0} <ffffffff8012518d>{do_page_fault+1485}
       <ffffffff80282d47>{acpi_os_allocate+12} <ffffffff8011168d>{error_exit+0}
       <ffffffff8012518d>{do_page_fault+1485} <ffffffff80282d47>{acpi_os_allocate+12}


Code: f6 04 06 81 0f 84 52 fc ff ff 48 8b 05 e2 f9 3a 00 48 89 c2
RIP <ffffffff8012518d>{do_page_fault+1485} RSP <000001001fe00008>


--Boundary-00=_KEKWBzt50Xr3OVu--
