Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130250AbRBMA15>; Mon, 12 Feb 2001 19:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130235AbRBMA1r>; Mon, 12 Feb 2001 19:27:47 -0500
Received: from [64.160.188.242] ([64.160.188.242]:53770 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S130214AbRBMA1h>; Mon, 12 Feb 2001 19:27:37 -0500
Date: Mon, 12 Feb 2001 16:27:32 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: APIC problems
Message-ID: <Pine.LNX.4.30.0102121531400.22147-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I asked for some information and seems at least 1 person took the "tone"
of my email to mean I had an attitude while asking.

On the premise that perhaps I did ask with an attitude, even if I don't
see it, I'd like to ask for some information.

Here is a synopsis of what I'm running up against and what I've done
to try to fix it.

I have the Abit VP6 mainboard loaded with 1GB of RAm and dual PIII-733s.
On heavy I/O I get "APIC error on CPU# ##(##)" (replace #'s with CPUID#
and APIC error code)

In this case I'm getting 08(02) 04(08) 04(02) 02(04) 02(08) as the
returned codes. Now the person that responded told me that it meant I had
crap hardware. The Abit VP6 is an extremely popular board in the linux
crowd from what I've been able to glean through IRC channels and other
conversations. If the board was truly that bad, I have a hard time
believing it would be as popular as it is. (OK, so this comment is
subjective. :) )

Tracing back through the kernel code I found the list of error codes in
apic.c. I'm specifically looking at function...

asmlinkage smp_error_interrupt(void)

>From what I understand of C, the error code returned is generated
by a call to apic_read(APIC_ESR) which stores the value in 'v', sets the
ESR register to 0 via the call to apic_write(APIC_ESR, 0);, regets the
value via apic_read(APIC_ESR); yet again and stores that value in 'v1',
acknowledges the IRQ service call, the APIC controller made, and finally
increments the irq error count.


It appears that it's using the modulus value as the actual error code.
OK, so now that I know what the error code is but I still don't see how it
can return a value of 08 which is not listed as an error code.

I can see that the error codes are actually the values of ESR both before
and after the apic_write() call. I see that the codes are the modulus'd
value before and after the apic_write call. What I'm not understanding is
how to translate that into a valid ID for determining what the exact error
is. In this instance 08 doesn't appear to be a valid return. Or am I
missing something here??


Here are the APIC errors

APIC error on CPU0: 00(08)
APIC error on CPU1: 00(08)
APIC error on CPU1: 08(08)
APIC error on CPU1: 08(08)
APIC error on CPU1: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU1: 08(08)
APIC error on CPU1: 08(08)
APIC error on CPU0: 08(08)
APIC error on CPU1: 08(02)
APIC error on CPU1: 02(02)
APIC error on CPU1: 02(08)
APIC error on CPU0: 08(02)
APIC error on CPU1: 08(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(02)
APIC error on CPU1: 02(08)
APIC error on CPU1: 08(02)
APIC error on CPU1: 02(02)



When I review my dmesg I see the following error as well.


mapped IOAPIC to ffffd000 (fec00000)
CALLIN, before setup_local_APIC().
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.......    : physical APIC id: 02
.......     : IO APIC version: 0011
WARNING: unexpected IO-APIC, please mail
calibrating APIC timer ...
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I13,P0) -> 18
PCI->APIC IRQ transform: (B0,I14,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16



After about 50% completion of creating a 1.0GB file, the system will lock
up with no errors or warnings. I can flip VTs, but if I try to log in it
will not respond, nor will any commands like a simple ls -al $HOME/


The controller my drives sit on is the HPT370 ATA100/RAID controller
Info is below

HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT370: ATA-66/100 forced bit set (WARNING)!!
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:DMA, hdf:DMA
HPT370: ATA-66/100 forced bit set (WARNING)!!
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:DMA, hdh:pio
hde: WDC WD300BB-00AUA1, ATA DISK drive
hdf: WDC WD300BB-00AUA1, ATA DISK drive
hdg: WDC WD300BB-00AUA1, ATA DISK drive
ide2 at 0xb800-0xb807,0xbc02 on irq 18
ide3 at 0xc000-0xc007,0xc402 on irq 18
hde: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)
hdf: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)
hdg: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)


I am not using the RAID ability, simply the ATA100. hdparm -t -T shows
that my buffered disk reads sit at around 32MB/s. I get excellent speed on
files smaller than 512MB. No lock ups, no problems. Go over the 512MB or
thereabouts (sometimes it locks around 612-640MB), and bam the box is
dead.

Since the HPT370 controller uses an APIC IRQ (namely IRQ18), this is
creating quite an issue for this box. I can burn CDs (which is hung off my
Advansys ABS3940UW controller) with the image sitting on any of the
HPT370 with no problems. If I copy OFF the CD and ONTO the drive, bam,
lockup after the aforementioned limits. If I copy small (less than 512MB)
files to/from any of the other drives I'm fine. It's that magic 512 to
640MB that things lock up.

I am about to move the drives to a Promise 20267 ATA100 controller which,
from all the mailing lists, google.com/linux searches, and others that I
know personally, works.

If I remove APIC support will SMP still work or do I have to have APIC
support for SMP?


Yes, I realize that I lack alot of information on what/how all of this
works. That's why I'm coming to you guys who DO know this stuff.

Once again, this is not being asked with an attitude, it's simply me on a
fact finding adventure. I'm not expecting information to be handed to me
on a silver platter as one replying individual stated. I'm not trying to
steal anyone's hard earned knowledge. I simply wish to find whatever
information I can to fix this problem or at least work around it while
maintaining SMP support (kind of a waste to have an SMP box if you can't
use it for SMP) and the ability to use my drives at the maximum amount of
speed possible.

Thank you in advance for any and all assistance.


David Downey


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
