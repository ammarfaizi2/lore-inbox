Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSGFWj1>; Sat, 6 Jul 2002 18:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSGFWj0>; Sat, 6 Jul 2002 18:39:26 -0400
Received: from gw-fxb-in.genebee.msu.ru ([195.208.219.253]:31500 "EHLO
	libro.genebee.msu.su") by vger.kernel.org with ESMTP
	id <S312973AbSGFWjX> convert rfc822-to-8bit; Sat, 6 Jul 2002 18:39:23 -0400
Date: Sun, 7 Jul 2002 02:40:26 +0400 (MSD)
From: Tim Alexeevsky <realtim@mail.ru>
X-X-Sender: <tim@zhuchka>
Reply-To: <realtim@mail.ru>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: File accessing.
Message-ID: <Pine.LNX.4.33.0207070206140.213-100000@zhuchka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, linux-kernel!

  I fulfiled the form in the end of the mail, but first I want to describe
it all in other words.

  Please, answer to my address too (not only to the list) as long as I'm
not subscribed to it.

  Maybe this problem is in hardware -- I don't know...

  I have linux-2.4.17. Gzipped .config file is attached.
  My computer is AMD K6-200 running as AMD K6-210 :)
  I have 64Mb of SGI's SIMM. Motherboard is Acorp with 430tx chipset.
  HDD is Seagate 8.4Gb ST38421A.

  I use XFree86 v4.0.3, icewm (as a window manager), gkrellm (X' system
  monitor), etc

  Sometimes when I work kernel panic apears. It usually happens after I
  have worked for some time. After that some processes can run, other's
  cannot. Sometimes kernel panic calms down after a while and I can work
  again as I did before.

  I setuped syslogd to dump errors to /dev/tty8. All the times I
  remember off Kernel reported Oops there and it had
      Call Trace: [cached_lookup+14/80] [link_path_walk+1167/1736]
      [getname+94/156] [path_walk+26/28] [__user_walk+53/80]
      [sys_lstat64+25/112] [system_call+51/64]
  in it.

  This time
    a) gkrellm disappeared.
    b) I exited X.
    c) I started X and it finished shortly after starting icewm.
    d) I tracked down the problem to icewm's request to /proc/net/ using
    strace.
(!) e) ls /proc/net gives me Oops and Segmentation Fault.

   Note:
      strace ls /proc/net
    works OK and I even know now the contents of that directory :).

 I ksymoops-ed this problem and found that the problem is in d_lookup
 function (see below). Trying to find where it's sources are I got
 another kernel panic :). I did
   cd /reiser/linux/fs # path to linux sources.
   grep d_lookup * -r # and it gave me Oops and SIGSEGVed grep.

 Using strace I tracked this problem down to requesting
 open("jffs2/gc.c", O_READONLY|O_LARGEFILE)
 Now
   ls jffs2
  also gives me a kernel panic. It's on reiserfs.

 I also found a soft link on ext2 (or 3)  partition that has the same
 side-effect.

 Note: this bug is 'not directly reproduceble' -- as soon as I will
 reboot the system (I hope) this bug will be gone until some unknown
 moment in the future. But it appeared many times and I believe will
 come again not once... Sometimes it comes when daily cron's
   'whole disk'-work is being done.

Thanx.

==============T H E   F O R M========================================

[1.] One line summary of the problem:
	File accessing.
[2.] Full description of the problem/report:
    	Sometimes I get kernel panic.
	After it appeared first time until I reboot I have many Oops.
	I tracked down what they belong to -- to accessing the files.
	Three cases I found this time are:
		ls /proc/net # => Oops
		ls /reiser/linux/fs/jffs2 #=> Oops
		cat qprogdlg.h # => Oops
	I think there are more, but these are significant: first one is on
proc, second on reiserfs, third on ext2(3?).
	Function that causes Oops is d_lookup or cached_lookup...

[3.] Keywords:
	filesystem, file,

[4.] Kernel version (from /proc/version):
 	Linux version 2.4.17 (tim@zhuchka) (gcc version 2.95.4 20010604 (Debian prerelease)) #1 Чтв Мар 21 22:46:03 MSK 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

  Here are three Ksymoopsed Oops describing the mentioned cases. They
differ but not too much.

--:-- ls /proc/net --:--
ksymoops 2.4.4 on i586 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /reiser/linux/System.map (specified)

<1>Unable to handle kernel paging request at virtual address 00b18c94
c01392f8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01392f8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: c111aad8   ebx: 00b18c84   ecx: 0000000d   edx: 0023ee05
esi: 00000000   edi: c1755fa4   ebp: 00b18c94   esp: c1755f14
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 3932, stackpage=c1755000)
Stack: c1755f74 00000000 c1755fa4 c07bad80 c111aad8 c268600a 0023ee05 00000003
       c0131a12 c026cda0 c1755f74 c1755f74 c0132077 c026cda0 c1755f74 00000000
       c2686000 00000000 c1755fa4 00000008 c013182e 00000008 c268600d 00000000
Call Trace: [<c0131a12>] [<c0132077>] [<c013182e>] [<c01322ca>] [<c0132621>]
   [<c012fa4d>] [<c0106b23>]
Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75

>>EIP; c01392f8 <d_lookup+5c/f4>   <=====
Trace; c0131a12 <cached_lookup+e/50>
Trace; c0132077 <link_path_walk+48f/6c8>
Trace; c013182e <getname+5e/9c>
Trace; c01322ca <path_walk+1a/1c>
Trace; c0132621 <__user_walk+35/50>
Trace; c012fa4d <sys_lstat64+19/70>
Trace; c0106b23 <system_call+33/40>
Code;  c01392f8 <d_lookup+5c/f4>
00000000 <_EIP>:
Code;  c01392f8 <d_lookup+5c/f4>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c01392fb <d_lookup+5f/f4>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c01392ff <d_lookup+63/f4>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c0139302 <d_lookup+66/f4>
   a:   75 74                     jne    80 <_EIP+0x80> c0139378 <d_lookup+dc/f4>
Code;  c0139304 <d_lookup+68/f4>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c0139308 <d_lookup+6c/f4>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c013930b <d_lookup+6f/f4>
  13:   75 00                     jne    15 <_EIP+0x15> c013930d <d_lookup+71/f4>

--:-- ls jffs2/ --:--

ksymoops 2.4.4 on i586 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m ../System.map (specified)

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01392f8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01392f8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010217
eax: c111aad8   ebx: fffffff0   ecx: 0000000d   edx: 01936e7c
esi: 00000000   edi: c2299fa4   ebp: 00000000   esp: c2299f14
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 4442, stackpage=c2299000)
Stack: c2299f74 00000000 c2299fa4 c2706460 c111aad8 c23fb006 01936e7c 00000004
       c0131a12 c3833560 c2299f74 c2299f74 c0132077 c3833560 c2299f74 00000000
       c23fb000 00000000 c2299fa4 00000008 c013182e 00000008 c23fb00a 00000000
Call Trace: [<c0131a12>] [<c0132077>] [<c013182e>] [<c01322ca>] [<c0132621>]
   [<c012fa4d>] [<c0106b23>]
Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75

>>EIP; c01392f8 <d_lookup+5c/f4>   <=====
Trace; c0131a12 <cached_lookup+e/50>
Trace; c0132077 <link_path_walk+48f/6c8>
Trace; c013182e <getname+5e/9c>
Trace; c01322ca <path_walk+1a/1c>
Trace; c0132621 <__user_walk+35/50>
Trace; c012fa4d <sys_lstat64+19/70>
Trace; c0106b23 <system_call+33/40>
Code;  c01392f8 <d_lookup+5c/f4>
00000000 <_EIP>:
Code;  c01392f8 <d_lookup+5c/f4>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c01392fb <d_lookup+5f/f4>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c01392ff <d_lookup+63/f4>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c0139302 <d_lookup+66/f4>
   a:   75 74                     jne    80 <_EIP+0x80> c0139378 <d_lookup+dc/f4>
Code;  c0139304 <d_lookup+68/f4>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c0139308 <d_lookup+6c/f4>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c013930b <d_lookup+6f/f4>
  13:   75 00                     jne    15 <_EIP+0x15> c013930d <d_lookup+71/f4>

--:-- cat qprogdlg.h --:--
ksymoops 2.4.4 on i586 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /reiser/linux/System.map (specified)

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01392f8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01392f8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010217
eax: c111aad8   ebx: fffffff0   ecx: 0000000d   edx: b546e019
esi: 00000000   edi: c3bd7f8c   ebp: 00000000   esp: c3bd7e84
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 4518, stackpage=c3bd7000)
Stack: c3bd7ee4 00000000 c3bd7f8c c14025e0 c111aad8 c36ece90 b546e019 0000000a
       c0131a12 c375c6c0 c3bd7ee4 c3bd7ee4 c0132077 c375c6c0 c3bd7ee4 00000000
       c3bd7f8c c36ece80 00000000 c36ecd60 c11e2e40 00000001 c36ece9a 00000000
Call Trace: [<c0131a12>] [<c0132077>] [<c013438e>] [<c015ac96>] [<c01321aa>]
   [<c01322ca>] [<c0132753>] [<c01295aa>] [<c01298e7>] [<c0106b23>]
Code: 8b 6d 00 8b 54 24 18 39 53 44 75 74 8b 44 24 24 39 43 0c 75

>>EIP; c01392f8 <d_lookup+5c/f4>   <=====
Trace; c0131a12 <cached_lookup+e/50>
Trace; c0132077 <link_path_walk+48f/6c8>
Trace; c013438e <vfs_follow_link+b6/11c>
Trace; c015ac96 <ext2_follow_link+16/20>
Trace; c01321aa <link_path_walk+5c2/6c8>
Trace; c01322ca <path_walk+1a/1c>
Trace; c0132753 <open_namei+73/4e0>
Trace; c01295aa <filp_open+2e/4c>
Trace; c01298e7 <sys_open+33/94>
Trace; c0106b23 <system_call+33/40>
Code;  c01392f8 <d_lookup+5c/f4>
00000000 <_EIP>:
Code;  c01392f8 <d_lookup+5c/f4>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c01392fb <d_lookup+5f/f4>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c01392ff <d_lookup+63/f4>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c0139302 <d_lookup+66/f4>
   a:   75 74                     jne    80 <_EIP+0x80> c0139378 <d_lookup+dc/f4>
Code;  c0139304 <d_lookup+68/f4>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c0139308 <d_lookup+6c/f4>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c013930b <d_lookup+6f/f4>
  13:   75 00                     jne    15 <_EIP+0x15> c013930d <d_lookup+71/f4>


[6.] A small shell script or example program which triggers the
     problem (if possible)

	---

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.7
util-linux             2.11d
mount                  2.11d
modutils               2.4.6
e2fsprogs              1.21-WIP
reiserfsprogs          3.x.0j
cardmgr: not found
PPP                    2.4.1
isdnctrl: not found
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    [ключи...]
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         rtc nls_cp437

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 6
model name      : AMD-K6tm w/ multimedia extensions
stepping        : 2
cpu MHz         : 208.267
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 415.33

[7.3.] Module information (from /proc/modules):

rtc                     5376   0 (autoclean)
nls_cp437               4384   3 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

(cat /proc/ioports):
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
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0376-0376 : ide1
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
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5e00-5e3f : Intel Corp. 82371AB PIIX4 ACPI
5f00-5f1f : Intel Corp. 82371AB PIIX4 ACPI
6400-641f : Intel Corp. 82371AB PIIX4 USB
f000-f00f : Intel Corp. 82371AB PIIX4 IDE

(cat /proc/iomem):
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-0020dabf : Kernel code
  0020dac0-0025aa5f : Kernel data
e0000000-e0ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
e1000000-e1ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 6400 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0b.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riva128 (rev 10) (prog-if 00 [VGA])
	Subsystem: 3D Vision(???) 3DVision-SAGP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e1000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=4M]

[7.6.] SCSI information (from /proc/scsi/scsi)

	No SCSI

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

	No ideas

[X.] Other notes, patches, fixes, workarounds:

	See in the begining of the mail.

                                                         Tim

,-----------------------------------------------------------------------------.
|            Dumb luck beats sound planning every time. Trust me.             |
`-----------------------------------------------------------------------------'


