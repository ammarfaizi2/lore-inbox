Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270163AbRHGJfK>; Tue, 7 Aug 2001 05:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270160AbRHGJfA>; Tue, 7 Aug 2001 05:35:00 -0400
Received: from Odin.AC.HMC.Edu ([134.173.32.75]:48099 "EHLO odin.ac.hmc.edu")
	by vger.kernel.org with ESMTP id <S270152AbRHGJeu>;
	Tue, 7 Aug 2001 05:34:50 -0400
Date: Tue, 7 Aug 2001 02:35:26 -0700 (PDT)
From: chahast+lkml@pangaea.dhs.org
To: linux-kernel@vger.kernel.org
Subject: lsmod reports serial module "used by" -1
Message-ID: <Pine.LNX.4.21.0108070145250.497-100000@pangaea.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This can't be a good thing.  Please copy all correspondence to
chahast+lkml@pangaea.dhs.org, as I am not subscribed to the list.

thanks,

--charles hastings
  chahast+lkml@pangaea.DHS.org
  http://pangaea.DHS.org/


[1.] One line summary of the problem:    

lsmod reports that the serial module is "used by" -1 things.


[2.] Full description of the problem/report:

Useful info: tip is a small and simple terminal program, src available at
<http://cvs.uclinux.org/cgi-bin/cvsweb/~checkout~/userland/tip/tip.c?rev=1.1.1.1&content-type=text/plain&sortby=file>

Here's the method to reproducing the bug.  I don't know exactly what parts
are relevant, so I'll include everything that I know.

After tip is used to access /dev/ttyS5 for the first time (relative to
the module loading) and then quit, nothing can access the port.  The first
time it runs flawlessly, properly sending data to the port.  On subsequent
tries, it exits with the error

chahast@pangaea:~$ tip -l /dev/ttyS5
ERROR: ioctl(TCSETS) failed, errno=5

strace tip -l /dev/ttyS5 shows

[...]
getpid()                                = 635
open("/dev/ttyS5", O_RDWR|O_NONBLOCK)   = 3
ioctl(3, TCSETSF, 0xbffff5dc)           = -1 EIO (Input/output error)
write(2, 0xbfffce70, 37ERROR: ioctl(TCSETS) failed, errno=5
)                = 37
_exit(1)                                = ?


Now, at this point I can succesfully unload and reload the serial module,
and it will again behave normally the first time tip is used.

However, if I do not unload the module, but instead try

stty < /dev/ttyS5

stty will freeze, forcing me to ^C back to a shell.  From there,
lsmod shows a negative "Used by" for the serial module.  Running stty <
/dev/ttyS5 more seems to decrease this negative number by two.

Strangely enough, none of this happens with seyon.  Could this be a
problem with tip?  It has performed flawlessly for me in the past.  I
guess this is two reports in one: a) tip choking after the first
execution, and b) "Used by" going negative.



[3.] Keywords (i.e., modules, networking, kernel):

serial, module, lsmod



[4.] Kernel version (from /proc/version):

Linux version 2.4.7 (root@pangaea) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #19 SMP Tue Aug 7 01:19:52 PDT 2001



[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

(n/a)



[6.] A small shell script or example program which triggers the
     problem (if possible)

<http://cvs.uclinux.org/cgi-bin/cvsweb/~checkout~/userland/tip/tip.c?rev=1.1.1.1&content-type=text/plain&sortby=file>

Download and compile tip.  Then:

tip -l /dev/ttySN    (where N is an appropriate serial terminal, probably 
^] to exit tip        has to be on a multiport card)
stty < /dev/ttySN
lsmod

lsmod should report a negative number in the "Used by" column.



[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux pangaea 2.4.7 #19 SMP Tue Aug 7 01:19:52 PDT 2001 i686 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.77
binutils               2.9.1.0.25
usage: fdformat [ -n ] device
mount                  2.9v
modutils               2.4.6
e2fsprogs              1.15
pcmcia-cs              3.1.25
PPP                    2.4.1
Linux C Library        2.1.3
ldd: version 1.9.9
Procps                 2.0.2
Net-tools              1.52
Kbd                    0.99
Sh-utils               1.16
Modules Loaded         serial ipt_MASQUERADE iptable_filter ds i82365
pcmcia_core audio soundcore uhci usbcore iptable_nat ip_tables ip_conntrack 
smbfs ncpfs tv audio tuner i2c-core ide-scsi sg sr_mod cdrom ppp_async
ppp_generic slhc rtc msdos fat



[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 400.915
[...]
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 1
cpu MHz         : 400.915
[...]


[7.3.] Module information (from /proc/modules):

serial                 43952  -8 (autoclean)
ipt_MASQUERADE          1680   1 (autoclean)
iptable_filter          2048   0 (autoclean) (unused)
ds                      6656   2
i82365                 21904   2
pcmcia_core            41824   0 [ds i82365]
audio                  39488   1
soundcore               4400   2 [audio]
uhci                   25824   0 (unused)
usbcore                55808   0 [audio uhci]
iptable_nat            16880   0 [ipt_MASQUERADE]
ip_tables              11552   5 [ipt_MASQUERADE iptable_filter
iptable_nat]
ip_conntrack           17376   1 [ipt_MASQUERADE iptable_nat]
smbfs                  35760   0 (unused)
ncpfs                  31248   0 (unused)
tvaudio                 8560   0 (unused)
tuner                   4288   0 (unused)
i2c-core               12944   0 [tvaudio tuner]
ide-scsi                7808   0
sg                     24144   0 (unused)
sr_mod                 12496   0 (unused)
cdrom                  28416   0 [sr_mod]
ppp_async               6864   0
ppp_generic            21136   0 [ppp_async]
slhc                    4896   0 [ppp_generic]
rtc                     6400   0 (autoclean)
msdos                   5264   0 (autoclean)
fat                    33504   0 (autoclean) [msdos]



[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02e8-02ef : serial(auto)
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03e0-03e1 : i82365
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corporation 82371AB PIIX4 USB
  e000-e01f : usb-uhci
e400-e407 : Siig Inc CyberSerial (2-port) 16550
  e400-e407 : serial(set)
e800-e807 : Siig Inc CyberSerial (2-port) 16550
  e800-e807 : serial(set)
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1


00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  00100000-001f7024 : Kernel code
  001f7025-00254bff : Kernel data
e0000000-e3ffffff : PCI Bus #01
  e1000000-e17fffff : Texas Instruments TVP4020 [Permedia 2]
  e1800000-e1ffffff : Texas Instruments TVP4020 [Permedia 2]
  e2000000-e201ffff : Texas Instruments TVP4020 [Permedia 2]
e4000000-e5ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge




[7.5.] PCI information ('lspci -vvv' as root)

The serial controller card's entry:

00:09.0 Serial controller: Siig Inc CyberSerial (2-port) 16550 (prog-if 02
[16550])
        Subsystem: Siig Inc PCI Serial Card
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at e400 [size=8]
        Region 1: I/O ports at e800 [size=8]
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)



[7.6.] SCSI information (from /proc/scsi/scsi)

(n/a)



[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

The following appears in dmesg after the "Used by" count goes negative.

Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
ttyS04 at port 0xe400 (irq = 17) is a 16550A
ttyS05 at port 0xe800 (irq = 17) is a 16550A
rs_close: bad serial port count; tty->count is 1, state->count is 2
rs_close: bad serial port count; tty->count is 1, state->count is 2
rs_close: bad serial port count; tty->count is 1, state->count is 2



[X.] Other notes, patches, fixes, workarounds:

I have tried this with 2.4.7-ac8.  Same problem.  Once again, no problems
when using seyon repeating the exact same process from [6.].  Hmm.




