Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271222AbTGWTHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271232AbTGWTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:05:34 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:1004 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S271231AbTGWTEc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:04:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: no_spam@ntlworld.com
Subject: Missing interrupts? - more...
Date: Wed, 23 Jul 2003 20:19:37 +0100
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307232019.37810.no_spam@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The missing interrupts gets murkier-

On all good machines interrupts are routed regardless of the PCI slot or IRQ 
allocated.

On the one bad machine interrupts are received iff the IRQ is 11.
I have tried all the available slots in the machine for my card and I have 
tried reconfiguring the IRQs allocated to these slots via the BIOS.  The 
upshot is that on interrupts 3 9 10 nothing is received by the card 
regardless of slot location.  If I select IRQ 11 for the card then it works 
perfectly. (I can only select 3 9 10 11 in the BIOS).

I have also witnessed a couple of "spurious interrupt" messages in the kernel 
on good and the bad machines - these are received when the driver registers 
the interrupt (always seem to be routed to IRQ7). Like so: (from dmesg)

....
PI: init_module: installing /proc
PI: installation complete
PI: enabling board
PI: open: registered interrupt 10 Ok
spurious 8259A interrupt: IRQ7.    <-------------- on good or bad machine
PI: reset performed


Since the original post I have changed the way I discover the IRQ and now 
query the pci_dev structure rather than the pci config space (although these 
have agreed so far) but it makes no difference.


On the bad machine:
cat /proc/interrupts
           CPU0
  0:     408059          XT-PIC  timer
  1:         24          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  usb-uhci
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci
 10:          0          XT-PIC  ehci-hcd
 11:      34980          XT-PIC  usb-uhci, e100
 12:        474          XT-PIC  PS/2 Mouse
 14:      11376          XT-PIC  ide0
 15:         22          XT-PIC  ide1
NMI:          0
ERR:          0
 - no interrupts are ever received on irqs 3 9 10 regardless of the settings 
in the BIOS.


Any suggestions (broken computer?) I am about to release the driver......

Thanks SA

On bad machine:
cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 1.80GHz
stepping        : 4
cpu MHz         : 1799.843
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3591.37


Also some sort of intel motherboard - no sure of exact type.

dmesg after boot  truncated....
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI: Found IRQ 9 for device 00:1f.1
PCI: Sharing IRQ 9 with 00:1d.2






------
Dear LK,

I am testing a new device driver and have found that one one machine it does
 not receive any interrupts. I am stumped by this problem and wonder if
 anyone had any advice before I start to take things apart blindly.

Machines test where everything worked: kernels 2.4.18-10 and  2.4.18-24.8.0
 on athlon based PCs

Machine where interrupts failed to appear: kernel 2.4.18-3 on a pentium 4.

I register the interrupt on open with
       
 err=request_irq(pi_stage.interrupt,pi_int_handler,SA_SHIRQ,PI_IRQ_ID,(void*)
&pi_stage);

My handler looks like

static void pi_int_handler(int irq, void *dev_id,struct pt_regs *regs){
u32 event;
        pi_stage.ints_all++;
        event=pi_read_control(PI_STAGE_INTEVENTSET);
        if(event & PI_STAGE_ALLINTS){
                pi_write_control(PI_STAGE_INTEVENTCLEAR,event 
 &PI_STAGE_ALLINTS); if(event & PI_STAGE_INTGPIO3)
                        pi_stage.ints_io++;
                if(event & PI_STAGE_GPINT){
                        pi_stage.ints_axis++;
                        tasklet_schedule(&pi_tasklet);
                        }
                pi_stage.ints_board++;
                }
        }

On the dodgy machine I see the driver and card working fine except for the
 missing interrupts. The variable pi_stage.ints_all is never incremented and
 /proc/interrupts never reports any interrupts. On all machines the
 conditions that generate the interrupts do occur.

It looks like on this one machine that interrupts are never received by the
 system.

Is it possible that differences between the BIOSs on the machines could cause
 this? (ie my card is init'd differently so on the bad machine the ints are
 never generated or received).

Any suggestions?

Thanks SA

