Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOCSI>; Tue, 14 Nov 2000 21:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKOCR7>; Tue, 14 Nov 2000 21:17:59 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:2308 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S129045AbQKOCRp>;
	Tue, 14 Nov 2000 21:17:45 -0500
Date: Tue, 14 Nov 2000 19:46:40 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: Christoph Hellwig <hch@caldera.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: opl3.o initialization problems in 2.4
In-Reply-To: <200011141842.TAA03384@ns.caldera.de>
Message-ID: <Pine.LNX.4.21.0011141851090.684-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, Christoph Hellwig wrote:

> In article <Pine.LNX.4.21.0011140825020.1788-100000@wr5z.localdomain> you wrote:
> > I continue to see apparent interaction problems between sb.o and opl3.o
> > during system initialization.  Several people have reported problems
> > with the opl3.o module not loading or not working properly.  A
> > workaround was developed which results in a functional system; if sb.o
> > is compiled as built-in and opl3.o is compiled modular things work.  
> 
> > My working theory is that the soundcard must be initialized and the
> > driver functioning before the opl3 module can initialize its function on
> > the card.  Currently, the opl3 code is executed before the soundcard
> > code and is unable to initialize the fm synthesizer.  
> 
> > I hate to reignite the link order war, but I would appreciate a
> > clarification of the situation.
> 
> This is strange. CONFIG_SOUND_YM3812 (the opl3 config options)
> is actually _after_ CONFIG_SB in the Makefile.
> 
> Does it work if both drivers are modular?


Sorry this took so long.

The short answer is no, it only works if the soundcard is built in and
opl3 is modular.  This seems to apply mainly to soundblaster.

The long answer is that I've been trying to debug this myself, but I
don't understand what I'm seeing, particularly with respect to module
loadng and initialization.  I wanted to present what I've found in hopes
that either someone will tell me what I'm doing wrong or else this will
help someone debug a problem.


I have a PAS16 soundcard.  It includes a Soundblaster compatible chip
with it and has an OPL3 synthesizer.  I have the following in
/etc/lilo.conf:
append="pas2=0x388,10,3,-1,0x220,5,1,-1 sb=0x220,5,1,-1 opl3=0x388"
If pas2, sb, and opl3 are all built in, the kernel attempts to
initialize the opl3 first.  In this case io is -1 when the init_opl3
function is executed, and the fm synthesizer is not detected.


I have the following in modules.conf:
options opl3 io=0x388
options pas2 io=0x388 irq=10 dma=3
options sb io=0x220 irq=5 dma=1
If I build everything modular and attempt to modprobe opl3 before
initializing the soundcard, io is 0x388 as it should be, but the
signature it reads from the card is 0xff instead of 0x0 as it should
be.  If I modprobe pas2 and modprobe sb, weird things happen.  I get the
following on the screen:

[root@wr5z /root]# modprobe sb
/lib/modules/2.4.0-test11-pre4-tm7/kernel/drivers/sound/sb.o: init_module: No
such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.0-test11-pre4-tm7/kernel/drivers/sound/sb.o: insmod
/lib/modules/2.4.0-test11-pre4-tm7/kernel/drivers/sound/sb.o failed
/lib/modules/2.4.0-test11-pre4-tm7/kernel/drivers/sound/sb.o: insmod sb
failed

and I get in dmesg:
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: dsp reset failed.

If I now try modprobe opl3 it reads the correct signature from the card
and I get the following in dmesg:

YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft
1993-1996
<Yamaha OPL3> at 0x388

but I get the following on the screen:

[root@wr5z /root]# modprobe opl3
<Yamaha OPL3> at 0x388
/lib/modules/2.4.0-test11-pre4-tm7/kernel/drivers/sound/opl3.o: init_module: Device
or resource busy
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.0-test11-pre4-tm7/kernel/drivers/sound/opl3.o: insmod
/lib/modules/2.4.0-test11-pre4-tm7/kernel/drivers/sound/opl3.o failed
insmod opl3 failed
[root@wr5z /root]# Nov 14 18:40:14 wr5z kernel: <Yamaha OPL3> at 0x388

lsmod at this point shows:
[root@wr5z sound]# lsmod
Module                  Size  Used by
pas2                   13392   0  (unused)
sb_lib                 34720   0
uart401                 6512   0  [sb_lib]

If I try to execute playmidi, using the synthesizer I get the following
oops:

ksymoops 2.3.4 on i586 2.4.0-test11-pre4-tm7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11-pre4-tm7/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address c503a580
c01d6676
*pde = 011c2063
Oops: 0000
CPU:    0
EIP:    0010:[<c01d6676>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c503a580
esi: c0295fe0   edi: c029618c   ebp: 00000002   esp: c2eefec0
ds: 0018   es: 0018   ss: 0018
Process playmidi (pid: 622, stackpage=c2eef000)
Stack: c0295d60 00000001 00000001 00000001 00000001 c01d846a 00000001 c303de00
       c0295d60 00000000 c2f9b740 00000000 00000000 c2eeff30 00000000 c01cf531
       c2f083c0 c303de00 00000000 c303de00 c2f083c0 c11ae260 c02963a0 c2f083c0
Call Trace: [<c01d846a>] [<c01cf531>] [<c013555d>] [<c013470f>] [<c0134647>] [<c013493c>] [<c010b2c3>]
Code: 8b 02 85 c0 74 0d ff 40 10 8b 06 8b 00 80 48 14 18 8b 16 55

>>EIP; c01d6676 <sequencer_open+1e2/37c>   <=====
Trace; c01d846a <sound_open+aa/f0>
Trace; c01cf531 <soundcore_open+109/180>
Trace; c013555d <chrdev_open+41/4c>
Trace; c013470f <dentry_open+bf/14c>
Trace; c0134647 <filp_open+47/50>
Trace; c013493c <sys_open+38/b4>
Trace; c010b2c3 <system_call+33/40>
Code;  c01d6676 <sequencer_open+1e2/37c>
00000000 <_EIP>:
Code;  c01d6676 <sequencer_open+1e2/37c>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c01d6678 <sequencer_open+1e4/37c>
   2:   85 c0                     test   %eax,%eax
Code;  c01d667a <sequencer_open+1e6/37c>
   4:   74 0d                     je     13 <_EIP+0x13> c01d6689 <sequencer_open+1f5/37c>
Code;  c01d667c <sequencer_open+1e8/37c>
   6:   ff 40 10                  incl   0x10(%eax)
Code;  c01d667f <sequencer_open+1eb/37c>
   9:   8b 06                     mov    (%esi),%eax
Code;  c01d6681 <sequencer_open+1ed/37c>
   b:   8b 00                     mov    (%eax),%eax
Code;  c01d6683 <sequencer_open+1ef/37c>
   d:   80 48 14 18               orb    $0x18,0x14(%eax)
Code;  c01d6687 <sequencer_open+1f3/37c>
  11:   8b 16                     mov    (%esi),%edx
Code;  c01d6689 <sequencer_open+1f5/37c>
  13:   55                        push   %ebp


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
