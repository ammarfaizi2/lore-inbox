Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWGEE3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWGEE3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 00:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWGEE3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 00:29:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:32452 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932451AbWGEE3m (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 00:29:42 -0400
Message-Id: <200607050429.k654TXUr012316@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Roman Zippel <zippel@linux-m68k.org>
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Mon, 03 Jul 2006 03:13:39 +0200."
             <Pine.LNX.4.64.0607030256581.17704@scrub.home>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271212150.17704@scrub.home> <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271903320.12900@scrub.home> <Pine.LNX.4.64.0606271919450.17704@scrub.home> <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu> <1151453231.24656.49.camel@cog.beaverton.ibm.com> <Pine.LNX.4.64.0606281218130.12900@scrub.home> <Pine.LNX.4.64.0606281335380.17704@scrub.home> <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu> <1151695569.5375.22.camel@localhost.localdomain> <200606302104.k5UL41vs004400@turing-police.cc.vt.edu>
            <Pine.LNX.4.64.0607030256581.17704@scrub.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152073772_10982P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Jul 2006 00:29:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152073772_10982P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 03 Jul 2006 03:13:39 +0200, Roman Zippel said:
> Hi,
>=20
> On Fri, 30 Jun 2006, Valdis.Kletnieks=40vt.edu wrote:
>=20
> > *AHA* I *found* the bugger, I think.
> >=20
> > In kernel/timer.c, we have:
> >=20
> > static void clocksource_adjust(struct clocksource *clock, s64 offset)=

> > (s64 used for offset in multiple places).
> >=20
> > However, in other places, offset is a 'cycle_t', which is:
> >=20
> > include/linux/clocksource.h:typedef u64 cycle_t;
> >=20
> > So it looks like a signed/unsigned screwage.
>=20
> It's a possibility, but the signed/unsigned usage is pretty much=20
> intentional. The assumptation is that time only goes forward so nothing=
=20
> there should become negative, only adjustments happen in both direction=
s.
> It's really weird why it's getting completely so out of control early=20
> during boot. It would be great if you could also test the patch below, =
it=20
> should trigger closer to when it goes wrong and help to analyze the=20
> problem (or at least rule out a number of possibilities).

Here you go.. For what it's worth, your debugging in clocksource_adjust s=
eems
to only pop before we start userspace, and get_realtime_clock_ts only onc=
e
userspace starts.

My speculation about the RTC module turns out to be a red herring - I tri=
ed
a kernel with it built in, and the problem still manifested and cleared i=
tself
early in rc.sysinit.  Checking the code there, what seems to matter is th=
at
rc.sysinit calls '/sbin/hwclock --hctosys --utc'.

Output of 'hwclock --debug':

hwclock from util-linux-2.13-pre6
Using /dev/rtc interface to clock.
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
...got clock tick
Time read from Hardware Clock: 2006/07/05 07:57:52
Hw clock time : 2006/07/05 07:57:52 =3D 1152086272 seconds since 1969
Calling settimeofday:
        tv.tv_sec =3D 1152086272, tv.tv_usec =3D 0
        tz.tz_minuteswest =3D 240

Absolutely nothing edifying there..

The dmesg, with all the suggested patches so far applied.  Looks like som=
ething
starts off uninitialized - we get the first 'big adj' squawk right after =
we
allocate the console - we don't allocate the tsc timesource for another 4=

seconds or so.

I'll bite - what *am* I using as a timesource for those first 4 seconds? =
:)

=5B    0.000000=5D Linux version 2.6.17-mm2-test (valdis=40turing-police.=
cc.vt.edu) (gcc version 4.1.1 20060629 (Red Hat 4.1.1-6)) =233 PREEMPT Tu=
e Jul 4 18:42:05 EDT 2006
=5B    0.000000=5D BIOS-provided physical RAM map:
=5B    0.000000=5D  BIOS-e820: 0000000000000000 - 000000000009fc00 (usabl=
e)
=5B    0.000000=5D  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reser=
ved)
=5B    0.000000=5D  BIOS-e820: 0000000000100000 - 000000002ffe2800 (usabl=
e)
=5B    0.000000=5D  BIOS-e820: 000000002ffe2800 - 0000000030000000 (reser=
ved)
=5B    0.000000=5D  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reser=
ved)
=5B    0.000000=5D  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reser=
ved)
=5B    0.000000=5D 767MB LOWMEM available.
=5B    0.000000=5D On node 0 totalpages: 196578
=5B    0.000000=5D   DMA zone: 4096 pages, LIFO batch:0
=5B    0.000000=5D   Normal zone: 192482 pages, LIFO batch:31
=5B    0.000000=5D DMI 2.3 present.
=5B    0.000000=5D ACPI: RSDP (v000 DELL                                 =
 ) =40 0x000fde50
=5B    0.000000=5D ACPI: RSDT (v001 DELL    CPi R   0x27d40107 ASL  0x000=
00061) =40 0x000fde64
=5B    0.000000=5D ACPI: FADT (v001 DELL    CPi R   0x27d40107 ASL  0x000=
00061) =40 0x000fde90
=5B    0.000000=5D ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x010=
0000e) =40 0x00000000
=5B    0.000000=5D ACPI: PM-Timer IO Port: 0x808
=5B    0.000000=5D Allocating PCI resources starting at 40000000 (gap: 30=
000000:ceda0000)
=5B    0.000000=5D Detected 1595.408 MHz processor.
=5B   24.231372=5D Built 1 zonelists.  Total pages: 196578
=5B   24.231376=5D Kernel command line: console=3Dtty0 vga=3D794 single
=5B   24.231839=5D Local APIC disabled by BIOS -- you can enable it with =
=22lapic=22
=5B   24.231854=5D mapped APIC to ffffd000 (01603000)
=5B   24.231860=5D Enabling fast FPU save and restore... done.
=5B   24.231864=5D Enabling unmasked SIMD FPU exception support... done.
=5B   24.231871=5D Initializing CPU=230
=5B   24.231977=5D CPU 0 irqstacks, hard=3Dc04e2000 soft=3Dc04e1000
=5B   24.231982=5D PID hash table entries: 4096 (order: 12, 16384 bytes)
=5B   24.232106=5D Console: colour dummy device 80x25
=5B   24.232202=5D big adj at -299999 (4294314460971008,128,128,0)
=5B   24.232214=5D clock jiffies: m:255960832,s:8,cl:4294667297,ci:1,xn:7=
6031960832,xi:255960832,e:4294967296
=5B   24.232983=5D big adj at -299998 (4294314460971008,64,64,0)
=5B   24.232996=5D clock jiffies: m:255960960,s:8,cl:4294667298,ci:1,xn:7=
6287921792,xi:255960960,e:4294967296
=5B   24.233231=5D Dentry cache hash table entries: 131072 (order: 7, 524=
288 bytes)
=5B   24.233991=5D big adj at -299997 (4294314460971008,64,64,0)
=5B   24.234010=5D clock jiffies: m:255961024,s:8,cl:4294667299,ci:1,xn:7=
6543882816,xi:255961024,e:4294967296
=5B   24.234390=5D Inode-cache hash table entries: 65536 (order: 6, 26214=
4 bytes)
=5B   24.234978=5D big adj at -299996 (4294314460971008,32,32,0)
=5B   24.234988=5D clock jiffies: m:255961088,s:8,cl:4294667300,ci:1,xn:7=
6799843904,xi:255961088,e:3221225472
=5B   24.235988=5D big adj at -299995 (4294314460971008,16,16,0)
=5B   24.236009=5D clock jiffies: m:255961120,s:8,cl:4294667301,ci:1,xn:7=
7055805024,xi:255961120,e:2147483648
=5B   24.238986=5D big adj at -299992 (4294314460971008,-32,-32,0)
=5B   24.239010=5D clock jiffies: m:255961141,s:8,cl:4294667304,ci:1,xn:7=
7823688441,xi:255961141,e:-771751936
=5B   24.239980=5D big adj at -299991 (4294314460971008,-16,-16,0)
=5B   24.240001=5D clock jiffies: m:255961109,s:8,cl:4294667305,ci:1,xn:7=
8079649550,xi:255961109,e:-587202560
=5B   24.261902=5D Memory: 773428k/786312k available (2279k kernel code, =
12284k reserved, 981k data, 192k init, 0k highmem)
=5B   24.261916=5D Checking if this processor honours the WP bit even in =
supervisor mode... Ok.
=5B   24.321842=5D Calibrating delay using timer specific routine.. 3192.=
23 BogoMIPS (lpj=3D1596118)
=5B   24.321890=5D Security Framework v1.0.0 initialized
=5B   24.321899=5D SELinux:  Initializing.
=5B   24.321916=5D SELinux:  Starting in permissive mode
=5B   24.321930=5D selinux_register_security:  Registering secondary modu=
le capability
=5B   24.321938=5D Capability LSM initialized as secondary
=5B   24.321957=5D Mount-cache hash table entries: 512
=5B   24.322102=5D CPU: After generic identify, caps: 3febf9ff 00000000 0=
0000000 00000000 00000000 00000000 00000000
=5B   24.322116=5D CPU: After vendor identify, caps: 3febf9ff 00000000 00=
000000 00000000 00000000 00000000 00000000
=5B   24.322130=5D CPU: Trace cache: 12K uops, L1 D cache: 8K
=5B   24.322137=5D CPU: L2 cache: 512K
=5B   24.322142=5D CPU: After all inits, caps: 3febf9ff 00000000 00000000=
 00000080 00000000 00000000 00000000
=5B   24.322152=5D Intel machine check architecture supported.
=5B   24.322162=5D Intel machine check reporting enabled on CPU=230.
=5B   24.322169=5D CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
=5B   24.322177=5D CPU0: Thermal monitoring enabled
=5B   24.322196=5D CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping=
 04
=5B   24.322210=5D Checking 'hlt' instruction... OK.
=5B   24.325941=5D SMP alternatives: switching to UP code
=5B   24.325948=5D Freeing SMP alternatives: 0k freed
=5B   24.325953=5D ACPI: Core revision 20060608
=5B   24.369235=5D ACPI: setting ELCR to 0200 (from 0800)
=5B   24.374594=5D checking if image is initramfs... it is
=5B   24.522694=5D Freeing initrd memory: 1031k freed
=5B   24.523169=5D NET: Registered protocol family 16
=5B   24.523769=5D ACPI: ACPI Dock Station Driver=20
=5B   24.523784=5D ACPI: bus type pci registered
=5B   24.537296=5D PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=
=3D2
=5B   24.537303=5D Setting up standard PCI resources
=5B   24.567815=5D ACPI: Interpreter enabled
=5B   24.567828=5D ACPI: Using PIC for interrupt routing
=5B   24.572140=5D ACPI: PCI Root Bridge =5BPCI0=5D (0000:00)
=5B   24.572153=5D PCI: Probing PCI hardware (bus 00)
=5B   24.572578=5D ACPI: Assume root bridge =5B=5C_SB_.PCI0=5D bus is 0
=5B   24.648477=5D PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/=
TCO
=5B   24.648490=5D PCI quirk: region 0880-08bf claimed by ICH4 GPIO
=5B   24.648591=5D PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
=5B   24.649169=5D Boot video device is 0000:01:00.0
=5B   24.649943=5D PCI: Transparent bridge - 0000:00:1e.0
=5B   24.650877=5D ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0._PRT=
=5D
=5B   24.801769=5D ACPI: PCI Interrupt Link =5BLNKA=5D (IRQs 9 10 *11)
=5B   24.803130=5D ACPI: PCI Interrupt Link =5BLNKB=5D (IRQs 5 7) *11
=5B   24.804452=5D ACPI: PCI Interrupt Link =5BLNKC=5D (IRQs 9 10 *11)
=5B   24.805785=5D ACPI: PCI Interrupt Link =5BLNKD=5D (IRQs 5 7 9 10 *11=
)
=5B   24.809149=5D ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0.AGP_=
._PRT=5D
=5B   24.810372=5D ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0.PCIE=
._PRT=5D
=5B   24.813313=5D ACPI: Power Resource =5BPADA=5D (on)
=5B   24.814796=5D Linux Plug and Play Support v0.97 (c) Adam Belay
=5B   24.814820=5D pnp: PnP ACPI init
=5B   25.042773=5D pnp: PnP ACPI: found 17 devices
=5B   25.042817=5D Intel 82802 RNG detected
=5B   25.043398=5D usbcore: registered new driver usbfs
=5B   25.043657=5D usbcore: registered new driver hub
=5B   25.044250=5D PCI: Using ACPI for IRQ routing
=5B   25.044259=5D PCI: If a device doesn't work, try =22pci=3Drouteirq=
=22.  If it helps, post a report
=5B   25.087170=5D pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved=

=5B   25.087181=5D pnp: 00:02: ioport range 0x800-0x805 could not be rese=
rved
=5B   25.087189=5D pnp: 00:02: ioport range 0x808-0x80f could not be rese=
rved
=5B   25.087202=5D pnp: 00:03: ioport range 0x806-0x807 has been reserved=

=5B   25.087209=5D pnp: 00:03: ioport range 0x810-0x85f could not be rese=
rved
=5B   25.087217=5D pnp: 00:03: ioport range 0x860-0x87f has been reserved=

=5B   25.087224=5D pnp: 00:03: ioport range 0x880-0x8bf has been reserved=

=5B   25.087231=5D pnp: 00:03: ioport range 0x8c0-0x8df has been reserved=

=5B   25.087237=5D pnp: 00:03: ioport range 0x8e0-0x8ff has been reserved=

=5B   25.087253=5D pnp: 00:04: ioport range 0xf000-0xf0fe has been reserv=
ed
=5B   25.087261=5D pnp: 00:04: ioport range 0xf100-0xf1fe has been reserv=
ed
=5B   25.087269=5D pnp: 00:04: ioport range 0xf200-0xf2fe has been reserv=
ed
=5B   25.087276=5D pnp: 00:04: ioport range 0xf400-0xf4fe has been reserv=
ed
=5B   25.087283=5D pnp: 00:04: ioport range 0xf500-0xf5fe has been reserv=
ed
=5B   25.087291=5D pnp: 00:04: ioport range 0xf600-0xf6fe has been reserv=
ed
=5B   25.087298=5D pnp: 00:04: ioport range 0xf800-0xf8fe has been reserv=
ed
=5B   25.087306=5D pnp: 00:04: ioport range 0xf900-0xf9fe has been reserv=
ed
=5B   25.087323=5D pnp: 00:09: ioport range 0x900-0x91f has been reserved=

=5B   25.087330=5D pnp: 00:09: ioport range 0x3f0-0x3f1 has been reserved=

=5B   25.087347=5D pnp: 00:0f: ioport range 0xbf40-0xbf5f has been reserv=
ed
=5B   25.089593=5D PCI: Bridge: 0000:00:01.0
=5B   25.089603=5D   IO window: c000-cfff
=5B   25.089614=5D   MEM window: fc000000-fdffffff
=5B   25.089624=5D   PREFETCH window: d8000000-e7ffffff
=5B   25.089680=5D PCI: Bus 3, cardbus bridge: 0000:02:01.0
=5B   25.089687=5D   IO window: 0000e000-0000e0ff
=5B   25.089697=5D   IO window: 0000e400-0000e4ff
=5B   25.089708=5D   PREFETCH window: 40000000-41ffffff
=5B   25.089719=5D   MEM window: f4000000-f5ffffff
=5B   25.089729=5D PCI: Bus 7, cardbus bridge: 0000:02:01.1
=5B   25.089735=5D   IO window: 0000e800-0000e8ff
=5B   25.089745=5D   IO window: 00001000-000010ff
=5B   25.089755=5D   PREFETCH window: 42000000-43ffffff
=5B   25.089765=5D   MEM window: f6000000-f7ffffff
=5B   25.089775=5D PCI: Bus 11, cardbus bridge: 0000:02:03.0
=5B   25.089781=5D   IO window: 00001400-000014ff
=5B   25.089791=5D   IO window: 00001800-000018ff
=5B   25.089801=5D   PREFETCH window: 44000000-45ffffff
=5B   25.089812=5D   MEM window: fa000000-fbffffff
=5B   25.089821=5D PCI: Bridge: 0000:00:1e.0
=5B   25.089829=5D   IO window: e000-ffff
=5B   25.089841=5D   MEM window: f4000000-fbffffff
=5B   25.089852=5D   PREFETCH window: 40000000-46ffffff
=5B   25.089888=5D PCI: Setting latency timer of device 0000:00:1e.0 to 6=
4
=5B   25.089916=5D PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
=5B   25.090851=5D ACPI: PCI Interrupt Link =5BLNKD=5D enabled at IRQ 11
=5B   25.090860=5D PCI: setting IRQ 11 as level-triggered
=5B   25.090865=5D ACPI: PCI Interrupt 0000:02:01.0=5BA=5D -> Link =5BLNK=
D=5D -> GSI 11 (level, low) -> IRQ 11
=5B   25.090903=5D PCI: Enabling device 0000:02:01.1 (0000 -> 0003)
=5B   25.090912=5D ACPI: PCI Interrupt 0000:02:01.1=5BA=5D -> Link =5BLNK=
D=5D -> GSI 11 (level, low) -> IRQ 11
=5B   25.090947=5D ACPI: PCI Interrupt 0000:02:03.0=5BA=5D -> Link =5BLNK=
D=5D -> GSI 11 (level, low) -> IRQ 11
=5B   25.090997=5D NET: Registered protocol family 2
=5B   25.100721=5D IP route cache hash table entries: 32768 (order: 5, 13=
1072 bytes)
=5B   25.101037=5D TCP established hash table entries: 131072 (order: 7, =
524288 bytes)
=5B   25.101582=5D TCP bind hash table entries: 65536 (order: 6, 262144 b=
ytes)
=5B   25.102109=5D TCP: Hash tables configured (established 131072 bind 6=
5536)
=5B   25.102118=5D TCP reno registered
=5B   25.103491=5D Machine check exception polling timer started.
=5B   25.103629=5D speedstep: frequency transition measured seems out of =
range (0 nSec), falling back to a safe one of 500000 nSec.
=5B   25.115284=5D audit: initializing netlink socket (disabled)
=5B   25.115311=5D audit(1152053784.178:1): initialized
=5B   25.115507=5D VFS: Disk quotas dquot_6.5.1
=5B   25.115537=5D Dquot-cache hash table entries: 1024 (order 0, 4096 by=
tes)
=5B   25.115658=5D SELinux:  Registering netfilter hooks
=5B   25.121372=5D Initializing Cryptographic API
=5B   25.121385=5D io scheduler noop registered
=5B   25.121400=5D io scheduler anticipatory registered (default)
=5B   25.121414=5D io scheduler deadline registered
=5B   25.121434=5D io scheduler cfq registered
=5B   25.122236=5D vesafb: framebuffer at 0xe0000000, mapped to 0xf088000=
0, using 5120k, total 32768k
=5B   25.122249=5D vesafb: mode is 1280x1024x16, linelength=3D2560, pages=
=3D1
=5B   25.122256=5D vesafb: protected mode interface info at c000:e140
=5B   25.122262=5D vesafb: scrolling: redraw
=5B   25.122269=5D vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
=5B   25.278897=5D Console: switching to colour frame buffer device 160x6=
4
=5B   25.279483=5D fb0: VESA VGA frame buffer device
=5B   25.281108=5D ACPI: Video Device =5BVID=5D (multi-head: yes  rom: no=
  post: no)
=5B   25.299034=5D Hangcheck: starting hangcheck timer 0.9.0 (tick is 180=
 seconds, margin is 60 seconds).
=5B   25.299873=5D Hangcheck: Using get_cycles().
=5B   25.300277=5D Serial: 8250/16550 driver =24Revision: 1.90 =24 4 port=
s, IRQ sharing enabled
=5B   25.301635=5D serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=

=5B   25.304229=5D 00:0d: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
=5B   25.306284=5D ACPI: PCI Interrupt Link =5BLNKB=5D enabled at IRQ 5
=5B   25.306809=5D PCI: setting IRQ 5 as level-triggered
=5B   25.306815=5D ACPI: PCI Interrupt 0000:00:1f.6=5BB=5D -> Link =5BLNK=
B=5D -> GSI 5 (level, low) -> IRQ 5
=5B   25.307648=5D ACPI: PCI interrupt for device 0000:00:1f.6 disabled
=5B   25.312431=5D RAMDISK driver initialized: 16 RAM disks of 10240K siz=
e 1024 blocksize
=5B   25.315146=5D loop: loaded (max 8 devices)
=5B   25.316718=5D ACPI: PCI Interrupt Link =5BLNKC=5D enabled at IRQ 11
=5B   25.317257=5D ACPI: PCI Interrupt 0000:02:00.0=5BA=5D -> Link =5BLNK=
C=5D -> GSI 11 (level, low) -> IRQ 11
=5B   25.318098=5D 3c59x: Donald Becker and others. www.scyld.com/network=
/vortex.html
=5B   25.318763=5D 0000:02:00.0: 3Com PCI 3c905C Tornado at f0804c00.
=5B   25.342167=5D Uniform Multi-Platform E-IDE driver Revision: 7.00alph=
a2
=5B   25.342758=5D ide: Assuming 33MHz system bus speed for PIO modes; ov=
erride with idebus=3Dxx
=5B   25.343543=5D ICH3M: IDE controller at PCI slot 0000:00:1f.1
=5B   25.344068=5D PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
=5B   25.345514=5D ACPI: PCI Interrupt Link =5BLNKA=5D enabled at IRQ 11
=5B   25.346049=5D ACPI: PCI Interrupt 0000:00:1f.1=5BA=5D -> Link =5BLNK=
A=5D -> GSI 11 (level, low) -> IRQ 11
=5B   25.346888=5D ICH3M: chipset revision 2
=5B   25.347232=5D ICH3M: not 100% native mode: will probe irqs later
=5B   25.347780=5D     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:=
DMA, hdb:DMA
=5B   25.348499=5D     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:=
pio, hdd:pio
=5B   25.349211=5D Probing IDE interface ide0...
=5B   25.612743=5D hda: FUJITSU MHV2060AH, ATA DISK drive
=5B   26.020116=5D hdb: TOSHIBA CD-RW/DVD-ROM SD-R2102, ATAPI CD/DVD-ROM =
drive
=5B   26.075258=5D ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
=5B   26.076319=5D Probing IDE interface ide1...
=5B   26.594608=5D hda: max request size: 128KiB
=5B   26.622741=5D hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=
=3D65535/16/63, UDMA(100)
=5B   26.628219=5D hda: cache flushes supported
=5B   26.628628=5D  hda: hda1 hda2
=5B   26.638796=5D hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UD=
MA(33)
=5B   26.666022=5D Uniform CD-ROM driver Revision: 3.20
=5B   26.698666=5D ohci_hcd: 2006 May 24 USB 1.1 'Open' Host Controller (=
OHCI) Driver (PCI)
=5B   26.698726=5D USB Universal Host Controller Interface driver v3.0
=5B   26.726063=5D ACPI: PCI Interrupt 0000:00:1d.0=5BA=5D -> Link =5BLNK=
A=5D -> GSI 11 (level, low) -> IRQ 11
=5B   26.753390=5D PCI: Setting latency timer of device 0000:00:1d.0 to 6=
4
=5B   26.753398=5D uhci_hcd 0000:00:1d.0: UHCI Host Controller
=5B   26.780846=5D uhci_hcd 0000:00:1d.0: new USB bus registered, assigne=
d bus number 1
=5B   26.808385=5D uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
=5B   26.835528=5D usb usb1: new device found, idVendor=3D0000, idProduct=
=3D0000
=5B   26.862572=5D usb usb1: new device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
=5B   26.889563=5D usb usb1: Product: UHCI Host Controller
=5B   26.916458=5D usb usb1: Manufacturer: Linux 2.6.17-mm2-test uhci_hcd=

=5B   26.943542=5D usb usb1: SerialNumber: 0000:00:1d.0
=5B   26.971026=5D usb usb1: configuration =231 chosen from 1 choice
=5B   26.998438=5D hub 1-0:1.0: USB hub found
=5B   27.025153=5D hub 1-0:1.0: 2 ports detected
=5B   27.152792=5D ACPI: PCI Interrupt 0000:00:1d.2=5BC=5D -> Link =5BLNK=
C=5D -> GSI 11 (level, low) -> IRQ 11
=5B   27.180293=5D PCI: Setting latency timer of device 0000:00:1d.2 to 6=
4
=5B   27.180301=5D uhci_hcd 0000:00:1d.2: UHCI Host Controller
=5B   27.207849=5D uhci_hcd 0000:00:1d.2: new USB bus registered, assigne=
d bus number 2
=5B   27.235744=5D uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
=5B   27.263385=5D usb usb2: new device found, idVendor=3D0000, idProduct=
=3D0000
=5B   27.290913=5D usb usb2: new device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
=5B   27.318344=5D usb usb2: Product: UHCI Host Controller
=5B   27.345662=5D usb usb2: Manufacturer: Linux 2.6.17-mm2-test uhci_hcd=

=5B   27.373143=5D usb usb2: SerialNumber: 0000:00:1d.2
=5B   27.401348=5D usb usb2: configuration =231 chosen from 1 choice
=5B   27.429047=5D hub 2-0:1.0: USB hub found
=5B   27.456193=5D hub 2-0:1.0: 2 ports detected
=5B   27.789215=5D usb 2-1: new low speed USB device using uhci_hcd and a=
ddress 2
=5B   27.984255=5D usb 2-1: new device found, idVendor=3D045e, idProduct=
=3D0023
=5B   28.010901=5D usb 2-1: new device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
=5B   28.037435=5D usb 2-1: Product: Microsoft Trackball Optical=AE
=5B   28.063757=5D usb 2-1: Manufacturer: Microsoft
=5B   28.090448=5D usb 2-1: configuration =231 chosen from 1 choice
=5B   28.134235=5D input: Microsoft Microsoft Trackball Optical=AE as /cl=
ass/input/input0
=5B   28.160854=5D input: USB HID v1.00 Mouse =5BMicrosoft Microsoft Trac=
kball Optical=AE=5D on usb-0000:00:1d.2-1
=5B   28.187866=5D usbcore: registered new driver usbhid
=5B   28.215125=5D drivers/usb/input/hid-core.c: v2.6:USB HID core driver=

=5B   28.242995=5D PNP: PS/2 Controller =5BPNP0303:KBC,PNP0f13:PS2M=5D at=
 0x60,0x64 irq 1,12
=5B   28.274277=5D serio: i8042 AUX port at 0x60,0x64 irq 12
=5B   28.301472=5D serio: i8042 KBD port at 0x60,0x64 irq 1
=5B   28.328600=5D mice: PS/2 mouse device common for all mice
=5B   28.355927=5D input: PC Speaker as /class/input/input1
=5B   28.386381=5D input: AT Translated Set 2 keyboard as /class/input/in=
put2
=5B   28.412351=5D i2c /dev entries driver
=5B   28.445100=5D device-mapper: 4.6.0-ioctl (2006-02-17) initialised: d=
m-devel=40redhat.com
=5B   28.471229=5D EDAC MC: Ver: 2.0.0 Jul  4 2006
=5B   28.497455=5D Advanced Linux Sound Architecture Driver Version 1.0.1=
2rc1 (Thu Jun 22 13:55:50 2006 UTC).
=5B   28.525942=5D ACPI: PCI Interrupt 0000:00:1f.5=5BB=5D -> Link =5BLNK=
B=5D -> GSI 5 (level, low) -> IRQ 5
=5B   28.552844=5D PCI: Setting latency timer of device 0000:00:1f.5 to 6=
4
=5B   29.081381=5D input: DualPoint Stick as /class/input/input3
=5B   29.126168=5D input: AlpsPS/2 ALPS DualPoint TouchPad as /class/inpu=
t/input4
=5B   29.163103=5D intel8x0_measure_ac97_clock: measured 50992 usecs
=5B   29.190075=5D intel8x0: measured clock 94563 rejected
=5B   29.216761=5D intel8x0: clocking to 48000
=5B   29.246297=5D ALSA device list:
=5B   29.272438=5D   =230: Intel 82801CA-ICH3 with CS4205 at 0xd800, irq =
5
=5B   29.299153=5D TCP bic registered
=5B   29.325327=5D Initializing IPsec netlink socket
=5B   29.351386=5D NET: Registered protocol family 1
=5B   29.377536=5D NET: Registered protocol family 10
=5B   29.403357=5D lo: Disabled Privacy Extensions
=5B   29.428765=5D IPv6 over IPv4 tunneling driver
=5B   29.454410=5D NET: Registered protocol family 17
=5B   29.479450=5D NET: Registered protocol family 15
=5B   29.504193=5D Using IPI Shortcut mode
=5B   29.528533=5D Time: tsc clocksource has been installed.
=5B   29.552855=5D clock changed at -296333 (4294314460971008)
=5B   29.577109=5D clock tsc: m:2628985,s:22,cl:47171945132,ci:1595166,xn=
:0,xi:4193667486510,e:0
=5B   29.601869=5D big adj at -296332 (4294314460971008,-16,-25522656,-11=
031712)
=5B   29.626688=5D clock tsc: m:2628985,s:22,cl:47288392250,ci:1595166,xn=
:148610636380190,xi:4193667486510,e:-76300711936
=5B   29.652263=5D big adj at -296331 (4294314460971008,512,816724992,737=
704960)
=5B   29.677968=5D clock tsc: m:2628969,s:22,cl:47368150550,ci:1595166,xn=
:358292745604602,xi:4193641963854,e:1193037240320
=5B   29.704510=5D big adj at -296330 (4294314460971008,-8192,-1306759987=
2,-2961899520)
=5B   29.731241=5D clock tsc: m:2629481,s:22,cl:47452694348,ci:1595166,xn=
:580598318408480,xi:4194458688846,e:-41883408859136
=5B   29.758931=5D big adj at -296329 (4294314460971008,262144,4181631959=
04,304081797120)
=5B   29.786568=5D clock tsc: m:2621289,s:22,cl:47538833312,ci:1595166,xn=
:806396399112596,xi:4181391088974,e:647244064829440
=5B   29.814707=5D big adj at -296328 (4294314460971008,-8388608,-1338122=
2268928,-7813787025408)
=5B   29.843116=5D clock tsc: m:2883433,s:22,cl:47628162608,ci:1595166,xn=
:1063667357268644,xi:4599554284878,e:-22744806385192960
=5B   29.872317=5D big adj at -296327 (4294314460971008,1,1595166,446268)=

=5B   29.901485=5D clock tsc: m:4289462121,s:22,cl:47720682236,ci:1595166=
,xn:562144401219152,xi:18446735292041567566,e:753587310949187584
=5B   29.931755=5D big adj at -296326 (4294314460971008,1,1595166,1284562=
)
=5B   29.962006=5D clock tsc: m:4289462122,s:22,cl:47814797030,ci:1595166=
,xn:44026083828728,xi:18446735292043162732,e:1537505019520821248
=5B   29.993322=5D big adj at -296325 (4294314460971008,1,1595166,734154)=

=5B   30.024732=5D clock tsc: m:4289462123,s:22,cl:47913697322,ci:1595166=
,xn:18207168308574885266,xi:18446735292044757898,e:2361282850206533632
=5B   30.057404=5D big adj at -296324 (4294314460971008,1,1595166,1013902=
)
=5B   30.090153=5D clock tsc: m:4289462124,s:22,cl:48015787946,ci:1595166=
,xn:17938170826129443784,xi:18446735292046353064,e:3211634054207305728
=5B   30.124811=5D Freeing unused kernel memory: 192k freed
=5B   30.158910=5D Write protecting the kernel read-only data: 402k
=5B   30.502924=5D unexpected nsec: -249310867,2962848525
=5B   30.534582=5D clock tsc: m:4289462438,s:22,cl:48778277294,ci:1595166=
,xn:15924728282382833372,xi:18446735292547235188,e:-8884147731732662272
=5B   30.567853=5D unexpected nsec: -1962978502,1374054342
=5B   30.601090=5D clock tsc: m:4289462436,s:22,cl:48885153416,ci:1595166=
,xn:15654512304741409624,xi:18446735292544044856,e:-7993970621383804928
=5B   78.648061=5D kjournald starting.  Commit interval 5 seconds
=5B   78.681141=5D EXT3-fs: mounted filesystem with ordered data mode.
=5B   79.511997=5D security:  6 users, 5 roles, 1965 types, 81 bools, 1 s=
ens, 256 cats
=5B   79.544616=5D security:  58 classes, 123884 rules
=5B   79.579276=5D SELinux:  Completing initialization.
=5B   79.611956=5D SELinux:  Setting up existing superblocks.
=5B   79.677464=5D SELinux: initialized (dev dm-0, type ext3), uses xattr=

=5B   79.829815=5D SELinux: initialized (dev tmpfs, type tmpfs), uses tra=
nsition SIDs
=5B   79.863240=5D SELinux: initialized (dev usbfs, type usbfs), uses gen=
fs_contexts
=5B   79.896423=5D SELinux: initialized (dev debugfs, type debugfs), uses=
 genfs_contexts
=5B   79.929696=5D SELinux: initialized (dev selinuxfs, type selinuxfs), =
uses genfs_contexts
=5B   79.963020=5D SELinux: initialized (dev mqueue, type mqueue), uses t=
ransition SIDs
=5B   79.996350=5D SELinux: initialized (dev devpts, type devpts), uses t=
ransition SIDs
=5B   80.028943=5D SELinux: initialized (dev eventpollfs, type eventpollf=
s), uses genfs_contexts
=5B   80.061259=5D SELinux: initialized (dev inotifyfs, type inotifyfs), =
uses genfs_contexts
=5B   80.093142=5D SELinux: initialized (dev tmpfs, type tmpfs), uses tra=
nsition SIDs
=5B   80.124561=5D SELinux: initialized (dev futexfs, type futexfs), uses=
 genfs_contexts
=5B   80.155563=5D SELinux: initialized (dev pipefs, type pipefs), uses t=
ask SIDs
=5B   80.186435=5D SELinux: initialized (dev sockfs, type sockfs), uses t=
ask SIDs
=5B   80.216576=5D SELinux: initialized (dev proc, type proc), uses genfs=
_contexts
=5B   80.245849=5D SELinux: initialized (dev bdev, type bdev), uses genfs=
_contexts
=5B   80.274340=5D SELinux: initialized (dev rootfs, type rootfs), uses g=
enfs_contexts
=5B   80.302334=5D SELinux: initialized (dev sysfs, type sysfs), uses gen=
fs_contexts
=5B   80.332660=5D audit(1152066829.655:2): policy loaded auid=3D42949672=
95
=5B   80.360059=5D audit(1152066829.642:3): avc:  granted  =7B load_polic=
y =7D for  pid=3D1 comm=3D=22init=22 scontext=3Dsystem_u:system_r:kernel_=
t:s0 tcontext=3Dsystem_u:object_r:security_t:s0 tclass=3Dsecurity
=5B   81.871761=5D unexpected nsec: -1188339803,701954360
=5B   81.897554=5D clock tsc: m:1965639796,s:22,cl:130830426002,ci:159516=
6,xn:17365880163142832508,xi:18446741971357700448,e:-6392280673125578752
=5B  129.407146=5D Real Time Clock Driver v1.12ac



--==_Exmh_1152073772_10982P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEq0AscC3lWbTT17ARAqYMAKC19ofAez+ujNeT/4A9xSCoAd8e/ACfVK1B
t0y1Y7H0OUsJU9vC/kkkzFc=
=sPtF
-----END PGP SIGNATURE-----

--==_Exmh_1152073772_10982P--
