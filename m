Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbSJWGZY>; Wed, 23 Oct 2002 02:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbSJWGZY>; Wed, 23 Oct 2002 02:25:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42543 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262881AbSJWGZV>; Wed, 23 Oct 2002 02:25:21 -0400
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<1035241872.24994.21.camel@andyp> <m13cqzumx3.fsf@frodo.biederman.org>
	<1035328636.29319.55.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Oct 2002 00:29:33 -0600
In-Reply-To: <1035328636.29319.55.camel@andyp>
Message-ID: <m1ptu1sm5u.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Mon, 2002-10-21 at 21:20, Eric W. Biederman wrote:
> 
> > Have you tried booting that 2.4.18 kernel with kexec.  
> 
> > My other question is does running mkelfImage-1.17 on your kernel
> > before you boot it help? 
> > ftp://ftp.lnxi.com/pub/src/mkelfImage/mkelfImage-1.17.tar.gz

Ok thanks this was a good data points.  My tools are getting solid
enough that I can actually debug these problems.  Wow.

> Notes:
> 1) kexec_test 1.[23] "runs to completion" when not
>    massaged by mkelfImage.
> 
> 2) kexec_test 1.[23] "resets" the system (firmware
>    starts like cold boot) when massaged by mkelfImage.

Not a problem.  mkelfImage should really be called mkelfImage-linux.
It is not useful for anything else.  When it was feed kexec_test it
assumed it was being feed vmlinux and did the wrong thing, and
attempted to load it at 1MB.

> 3) all linux kernels tested on this system (same IBM
>    eServer as yesterday) "hang" when started with
>    kexec 1.[23] *unless* massaged by mkelfImage.
> 
> 4) linux-2.5.44 + mkelfImage panic in the SCSI driver
>    during reboot with kexec 1.[23].  <see below>
> 
> 5) linux-2.4.18 + CGL + mkelfImage + "root=805" came -->this<--
>    close to booting all the way, but it looks like the
>    ethernet driver can't probe the card in whatever state
>    it is left in... <see below> ...and there's that little
>    blurb about "Verify that the card is a bus-master capable slot."
>    Hmmm...  It's got a ServerWorks chipset...

It is a pci slot it better be bus-master capable...
 
> 6) no visible differences in success/failure between
>    kexec-tools-1.2 and kexec-tools-1.3.

The only substantive difference was in the addition of a debug mode,
that tells you it is make a little progress before the machine hangs.
> 
> Wild Speculation:
> Aside from driver issues, it would appear that whatever it is
> that mkelfImage does, it is better to use it for this specific
> system.  It would also appear that there may be several
> lingering device shutdown/reprobe problems.

Ok.  I came to suggest mkelfImage for some invalid reasons my weird
2.4.17 problem kernel has a weird development patch and the bzImage is
just plain unbootable.

What mkelfImage does it that it makes fewer BIOS calls, roughly the
same set of BIOS calls as are in kexec_test of 1.3.  While the kernels
setup.S makes more BIOS calls and it looks like one of those extra
BIOS calls is hanging your system.

Can you try kexec_test-1.4 in:
http://www.xmission.com/~ebiederm/files/kexec/kexec-utils-1.4.tar.gz

I have added a bunch more BIOS calls and unless I have missed the
important one we should be able to nail down which BIOS call is
crashing/hanging your system.

I need to nail this down but it appears with a little care I can
count on making BIOS calls to get the kernel parameters after a kexec.
That is the ideal case.  Now if I could only figure out what is needed
to make all of the BIOS calls actually work....

I will skimming the driver issues, but mostly I think they should have
an appropriate ->shutdown/reboot_notifier method implemented and the driver
should work.

> SCSI panic from a kexec'ed linux-2.5.44:
> <snip>
> ide: Assuming33MHz system bus speed for PIO modes; override with idebus=xx
> hda: probing with STATUS(0x50) instead of ALTSTATUS(0x80)
> hda: probing with STATUS(0x58) instead of ALTSTATUS(0x80)
> SCSI subsystem driver Revision: 1.00
> PCI: Enabling device 01:03.0 (0156 -> 0157)
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSIHBA DRIVER, Rev 6.2.4
>         <Adaptec aic7892 Ultra160 SCSI adapter>
>         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> 
> scsi0:0:0:0: Attempting to queue an ABORT message
> scsi0: Dumping Card State in Message-in phase, at SEQADDR 0x168
> ACCUM = 0x1, SINDEX = 0x61, DINDEX = 0x65, ARG_2 = 0xff
> HCNT = 0x0
> SCSISEQ = 0x12, SBLKCTL = 0xa
>  DFCNTRL = 0x0, DFSTATUS = 0x89
> LASTPHASE = 0xe0, SCSISIGI = 0xe6, SXFRCTL0 = 0x88
> SSTAT0 = 0x2, SSTAT1 = 0x1
> SCSIPHASE = 0x8
> STACK == 0x175, 0x0, 0x0, 0xe7
> SCB count = 4
> Kernel NEXTQSCB = 2
> Card NEXTQSCB = 2
> QINFIFO entries: 
> Waiting Queue entries: 
> Disconnected Queue entries: 
> QOUTFIFO entries: 
> Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
> Pending list: 3
> 
> Kernel Free SCB list: 1 0 
> Untagged Q(0): 3 
> DevQ(0:0:0): 0 waiting
> scsi0:0:0:0: Device is active, asserting ATN
> Recovery code sleeping
> Kernel panic: Attempted to kill the idle task!
> In idle task - not syncing
> 

There is nothing in the SCSI crash that I recognize at all :(
Given that there have been recent scsi problems I don't know.


> ethernet driver diagnostics from kexec'ed linux-2.4.18:
> <snip>
> eepro100.c:v1.09j-t 9/29/99 Donald Becker
> http://www.scyld.com/network/eepro100leepro100.c: $Revision: 1.36 $ 2000/11/17
> Modified by Andrey V. Savochkin <saw@ssPCI: Enabling device 00:09.0 (0000 ->
> 0003)
> 
> PCI: Setting latency timer of device 00:09.0 to 64
> eth0: Invalid EEPROM checksum 0x7f00, check settings before activating this
^^^^^ Here we go
> dev!eth0: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 16.
> 
>   Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
>   Primary interface chip unknown-15 PHY #31.
>     Secondary interface chip i82555.
> Self test failed, status ffffffff:
^^^^^ Or possibly here.

Either the nic eeprom was left in a bad state or something weird happened
with the eeprom.

>  Failure to initialize the i82557.
>  Verify that the card is a bus-master capable slot.
> <snip>
> Setting up network interfaces:
>     lo                                                               done
>     eth0      eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!

^^^^ If you had only gotten these I would assume your eepro100 had just chosen
     today this reboot to freak out.
> eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> (DHCP) eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> . . . eepro100: wait_for_cmd_done timeout!
> eepro100: wait_for_cmd_done timeout!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0116014>]    Not tainted
> EFLAGS: 00010213
> eax: 00000000   ebx: e75c6000   ecx: e8806000   edx: ffffffff
> esi: e666c7e0   edi: c1a6b800   ebp: e75c7e14   esp: e75c7df8
> ds: 0018   es: 0018   ss: 0018
> Process dhcpcd (pid: 359, stackpage=e75c7000)
> Stack: e75c6000 e666c7e0 c1a6b800 c1a6b800 00000100 e8806002 00000282 e75c7e20 
>        c0116406 e75c6000 e75c7e38 c02708b9 e75c6000 c1a6b800 00000000 e763ca00 
>        e75c7e58 c02689fd c1a6b800 e763ca00 c1a6b800 0000024e e75c7e80 c02a5403 
> Call Trace: [<c0116406>] [<c02708b9>] [<c02689fd>] [<c02a5403>] [<c02a5439>] 
>    [<c02620fd>] [<c0263054>] [<c013a817>] [<c013a839>] [<c015112a>] [<c0151450>
> [<c0151490>] [<c01518f4>] [<c026386f>] [<c01070db>]
> 
> 
> Code: 0f 0b b8 00 e0 ff ff 21 e0 ff 40 04 89 45 fc 69 40 20 a0 09 
>  
> Entering kdb (current=0xe75c6000, pid 359) on processor 0 Oops: invalid operand
> due to oops @ 0xc0116014
> eax = 0x00000000 ebx = 0xe75c6000 ecx = 0xe8806000 edx = 0xffffffff 
> esi = 0xe666c7e0 edi = 0xc1a6b800 esp = 0xe75c7df8 eip = 0xc0116014 
> ebp = 0xe75c7e14 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010213 
> xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xe75c7dc4
> [0]kdb> reboot
> 
> lspci output for the system:
> 00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> 00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> 00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
> 00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> 00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
> 00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
> 00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
> 01:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)


I would love to have the drivers to have reasonable shutdown routines
so this code could just be used.  But as that does not currently exist
in 2.5.44 I have some possibly productive suggestions.

1) Down all network interfaces before kexec
2) Build everything as modules and remove the modules before kexec
3) Look at the remove methods and see if you can adapt into shutdown methods.

And please tell me what kexec_test-1.4 reports. I would love to find out which
BIOS calls are hanging your system. 

In kexec_test/kexec_test16.S The calls to all BIOS tests are listed as below.
And if one of those keeps kexec from completing could you please comment
out print calls until kexec_test runs to completion.  This will give a list
of the bad BIOS calls on your system.

	/* Here we test various BIOS calls to determine how much of the system is working */
	call	get_meme820
	call	print_meme820
	call	print_meme801
	call	print_mem88
	call	disable_apm
	call	print_dasd_type
	call	print_equipment_list
	call	print_sysdesc
	call	print_edd
	call	print_video
	call	print_cursor
	call	print_video_mode
	call	set_auto_repeat_rate

The next step is to see if I can integrate a safer set of BIOS into the kernel.
Or at the very least integrate in the mkelfImage functionality into kexec...

Eric
