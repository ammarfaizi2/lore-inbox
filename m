Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290625AbSA3Vc6>; Wed, 30 Jan 2002 16:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290624AbSA3Vcp>; Wed, 30 Jan 2002 16:32:45 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27024 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290623AbSA3VcU>;
	Wed, 30 Jan 2002 16:32:20 -0500
Importance: Normal
MIME-Version: 1.0
Sensitivity: 
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
From: "Mike Spreitzer" <mspreitz@us.ibm.com>
Message-ID: <OFFCC680AF.8BC01507-ON85256B51.00746A5C@pok.ibm.com>
Date: Wed, 30 Jan 2002 16:32:08 -0500
Subject: Reported CPU utilization of network server doing constant work - varies
 periodically
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/30/2002 04:32:11 PM
Content-Type: multipart/mixed; boundary="=_mixed 0076465185256B51_="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=_mixed 0076465185256B51_=
Content-Type: text/plain; charset="us-ascii"

I am not a kernel hacker, but I think I have a kernel bug to report.
I have a hard time believing something so basic can be broken, but I
have ruled out every other explanation I can think of.

[1.] One line summary of the problem:

The CPU utilization reported through /proc/stat and the times()
syscall varies significantly (e.g., factors over 2) even when I think
the actual CPU consumption is essentially constant (e.g., varying by
less than 10%).

[2.] Full description of the problem/report:

I have this problem with network services but not programs with
narrower footprints (e.g., a simple loop).  I noticed this problem
when working with a more complex network service, but I have produced
a very simple network service that illustrates the problem (sources
are attached to this message).  The simple server is a non-threaded C
program.  It listens on a TCP socket, accepts one connection at a
time, and for that connection copies the input to the output, as long
as there is input, through fixed buffers (no explicit malloc nor free
in the loop).  The multithreaded client connects to the server and
then one thread goes into a simple loop that alternately sleeps and
writes a fixed buffer, while another thread reads and verifies the
echoes.  I have some instrumentation built into the server program,
and also use `procmeter3`, `ps`, and `top` to observe CPU and network
throughput from both client and server machines.  I see essentially
constant throughput, in bytes/second averaged over each reporting
period, as observed by `procmeter3` on both client and server, and
also as reported by the instrumentation in my server program.  I also
wrote an instrumented user-level idle loop, and when I run it,
`nice`d, in parallel with my simple server, it also reports counting
at essentially (+- 1%) a constant rate, as averaged over each
reporting period.  But the reported CPU utilization of the simple
network server varies over the same reporting periods.  And when I run
the `nice`d user-level idle loop in parallel, its reported CPU
utilization also varies (so that the sum of the two is essentially
100%).  The CPU utilization numbers get from the kernel to my eyes in
the following ways.  For one, I run procmeter3 (which get its CPU
utilization information from /proc/stat) on the server machine, and
ask it to show me "Stat-CPU" / "CPU" in graphical form (a snapshot is
attached to this message).  For another, my simple server reads the
CPU line of /proc/stat every reporting period, and reports
whole-machine CPU utilization based on that.  Finally, my simple
server also calls times() each loop iteration, and reports its
per-process CPU utilization based on that, aggregated over each
reporting period.

The CPU utilization can vary quite a lot.  In one case, it varied from
under 0.1% to about 50%, with a one-minute reporting period.  That is,
aggregated over one particular minute, less than one thousandth of the
machine's CPU goes to my simple server, while it's half the CPU over
the course of a different minute.

The variation usually has a fairly clearly-defined periodic shape.  I
have seen periods as low as 63 seconds and as high as 114 minutes;
colleagues report seeing periods up to about 150 minutes.  I have not
been able to determine what the period correlates with.  It holds
fairly constant for a given <client machine, client program &
parameters, server machine, server program & parameters> tuple.  I can
vary some of the parameters without significantly changing the period.
For fixed programs and parameters, the period can vary greatly for
different choices of <client machine, server machine>.

I have looked for this problem on uniprocessor Pentium machines
assembled by IBM, and seen it on every such machine at which I looked.
They have been Intellistation M-Pro and PC 300 machines.  When the
simple server was run on an Intellistation M-Pro, the CPU variation's
period was in the 1 to 3 minute range, and a one minute reporting
period was too short to make the pattern clear.  I saw the pattern
with a reporting period of 10 seconds, and saw it more clearly with a
reporting period of 5 seconds.  When the simple server was run on a PC
300 machine, the CPU variation's period was 5 minutes or more, and a
one minute reporting period was adequate to show the problem.  This
message reports some specifics from runs with the server on a PC
300PL.

I have looked for this problem on a uniprocessor RS/6000 machine
running AIX 4.3.3.  There I did not see a clearly defined CPU
variation of significant magnitude.

I have run my simple test client and server at various points within
the LAN in my office building.  The most common configuration involves
a box my support people describe as "an ethernet switch with IP
routing capability" --- but my client and server are on the same IP
subnet.  Between each of my machines and the abovementioned "box" is a
"smart ethernet hub" or "switch" concentrating 3 or 4 of my machines
onto a single connection to that "box".  All links are 100 Mb/s
ethernet.

I have attached a JPEG of the part of a procmeter3 display covering
about three cycles of one run.  You see horizontal lines for 0%, 20%,
40%, and 60% CPU utilization.  I have procmeter3's reporting period
set to 60 seconds, and the CPU variation's period is about 20 minutes.

Here are two excerpts from a run of both the simple server and the
`nice`d user-level idle loop, showing very different alleged CPU
utilizations by the simple test server and the user-level idle loop
--- and their own observations of constant progress:

At Tue Jan 29 16:06:14 2002 + 551771us, dIter=116904, dt=60005989 us
db=[  12.0,  704.90 +-  261.41,   937.0, 82405232.0],
I=[   3.0,  472.41 +- 2730.20, 23828.0, 55226872.0] us,
M=[  19.0,   24.19 +-  109.83, 30051.0,  2827827.0] us,
O=[   2.0,   14.02 +-   61.04, 20065.0,  1639097.0] us,
chg-user-t=[0.0, 0.000316 +- 0.017788, 1.0,   37.0] cs,  0.6%
chg-syst-t=[0.0, 0.000274 +- 0.016543, 1.0,   32.0] cs,  0.5%
chg-both-t=[0.0, 0.000590 +- 0.024288, 1.0,   69.0] cs,  1.1%
cum-user-t=70 cs, cum-syst-t=65 cs, cum-both-t=135 cs.

mach    user cs nice cs syst cs    idle cs        total cs
cum      130270   56924   88832    8857843         9133869
diff         37    5913      50          0            6000
%age        0.6    98.6     0.8        0.0

At Tue Jan 29 16:06:58 2002 + 682939us, count=1917,
d-count=475, d-t=60050540 us, rate=7.91/s


At Tue Jan 29 16:07:14 2002 + 551797us, dIter=117257, dt=60000026 us
db=[  15.0,  704.85 +-  261.43,   937.0, 82648121.0],
I=[   3.0,  471.11 +- 2721.76, 23852.0, 55240914.0] us,
M=[  19.0,   23.90 +-   65.85, 20050.0,  2802985.0] us,
O=[   2.0,   14.08 +-   60.88, 20031.0,  1651205.0] us,
chg-user-t=[0.0, 0.000205 +- 0.014305, 1.0,   24.0] cs,  0.4%
chg-syst-t=[0.0, 0.000247 +- 0.015725, 1.0,   29.0] cs,  0.5%
chg-both-t=[0.0, 0.000452 +- 0.021256, 1.0,   53.0] cs,  0.9%
cum-user-t=94 cs, cum-syst-t=94 cs, cum-both-t=188 cs.

mach    user cs nice cs syst cs    idle cs        total cs
cum      130294   62858   88873    8857843         9139868
diff         24    5934      41          0            5999
%age        0.4    98.9     0.7        0.0

<snip/>

At Tue Jan 29 16:19:14 2002 + 635582us, dIter=114611, dt=60008078 us
db=[   3.0,  716.20 +-  257.87,   937.0, 82083840.0],
I=[   3.0,  452.13 +- 2663.22, 30133.0, 51819438.0] us,
M=[  19.0,   42.91 +-  649.27, 30165.0,  4918375.0] us,
O=[   2.0,   24.90 +-  484.11, 30148.0,  2853877.0] us,
chg-user-t=[0.0, 0.008097 +- 0.089618, 1.0,  928.0] cs, 15.5%
chg-syst-t=[0.0, 0.012111 +- 0.109380, 1.0, 1388.0] cs, 23.1%
chg-both-t=[0.0, 0.020207 +- 0.140710, 1.0, 2316.0] cs, 38.6%
cum-user-t=2567 cs, cum-syst-t=3473 cs, cum-both-t=6040 cs.

mach    user cs nice cs syst cs    idle cs        total cs
cum      132768  127512   93745    8857843         9211868
diff        928    3165    1907          0            6000
%age       15.5    52.8    31.8        0.0

At Tue Jan 29 16:19:59 2002 + 677315us, count=8102,
d-count=477, d-t=60116853 us, rate=7.93/s


At Tue Jan 29 16:20:14 2002 + 635615us, dIter=114403, dt=60000033 us
db=[   5.0,  718.34 +-  261.50,   937.0, 82180226.0],
I=[   3.0,  451.92 +- 2665.81, 30080.0, 51700975.0] us,
M=[  19.0,   42.83 +-  657.08, 30132.0,  4900343.0] us,
O=[   2.0,   25.24 +-  457.30, 30087.0,  2887847.0] us,
chg-user-t=[0.0, 0.009772 +- 0.098372, 1.0, 1118.0] cs, 18.6%
chg-syst-t=[0.0, 0.010262 +- 0.100781, 1.0, 1174.0] cs, 19.6%
chg-both-t=[0.0, 0.020034 +- 0.140119, 1.0, 2292.0] cs, 38.2%
cum-user-t=3685 cs, cum-syst-t=4647 cs, cum-both-t=8332 cs.

mach    user cs nice cs syst cs    idle cs        total cs
cum      133886  130615   95523    8857843         9217867
diff       1118    3103    1778          0            5999
%age       18.6    51.7    29.6        0.0


Here is a brief guide to the output.  The first two blocks of text you
see are from the simple test server, at the end of a reporting period;
the third is from the instrumented user-level idle loop at the end of
one of its reporting periods.  This pattern repeats regularly in the
full typescript.  The excerpts above focus on two idle loop reports
and their surrounding test server reports (because the reporting
periods are not aligned).  The simple test server begins by reporting
the time at the end of the reporting period, with the number of
iterations and microseconds since the last report.  Then there is a
statistical summary of the numbers of bytes input by the read() calls
over the last period.  The summary's contents are: min, avg +-
std.dev., max, sum.  Then come statistical summaries of the elapsed
times (in microseconds) taken in the three phases of the server's loop
body (over the last reporting period): Input, copy & Munge, and
Output.  Then come statistical summaries of the CPU utilizations
reported for the server process by differencing times() for each
iteration in the last reporting period; "both" is the sum of the user
and system times.  The second text block from the simple test server
reports the breakdown from the CPU line of /proc/stat: first the raw
cumulative numbers, then the differences from the last report, and
finally each difference as a percentage of the sum of the differences.
The block from the instrumented user-level idle loop reports current
and differenced time and outer loop iterations, and then the ratio of
the two differences.

In all reports excerpted above, the simple test server says it has
echoed about 82 MB over the past approx. 60 seconds, and the
user-level idle loop does 476 +- 1 outer loop iterations over the past
approx. 60 seconds.  But the CPU utilization alleged for the test
server varies from about 38% to about 1%, while the idle loop's CPU
varies from about 52% to about 99%.  I don't have space to include
it here, but the procmeter3 display
also shows essentially constant network input and output throughput.

When I run the simple test server alone (without the idle loop in
parallel), I see no `nice`-level CPU usage, so I know all the `nice`
exhibited above is due to my `nice`d user-level idle loop.


[3.] Keywords (i.e., modules, networking, kernel):

networking, kernel, CPU utilization

[4.] Kernel version (from /proc/version):

I have seen this on Linux 2.2.something (RedHat 6.2), 2.4.something
(stock RedHat 7.1), 2.4.9-12, and 2.4.9-21 (the latest patch level of
RedHat 7.1).  For the last, here is /proc/version:

Linux version 2.4.9-21 (bhcompile@stripples.devel.redhat.com) (gcc
version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Thu Jan 17
14:09:42 EST 2002

[6.] A small shell script or example program which triggers the
     problem (if possible)

I have attached the sources for the client and server for my simple
test service, along with my instrumented user-level idle loop (strip
the .txt off the file names before you use them; they are ordinary C
and Java sources).  On the server machine, here is a compilation and
an example usage:

$ cc -o sserver -g sserver.c -lm
$ cc -o idle    -g idle.c
$ ./sserver 60 0 & nice ./idle 60

That invocation asks for a reporting period of 60 seconds in both the
simple server and the user-level idle loop.  The second parameter of
the server program gives the number of iterations of an inner loop
that can be used to bulk up the CPU consumption; it's not needed to
show the effect, and a value of 0 cuts it out.  The server program
reports the ephemeral port number on which it is listening for
connections; you'll need to pass that to the client program.

The client test program is written in Java.  It should compile and run
with any non-antique Java; I use IBM's JDK 1.3.0.  Put the client
source in test/client.java; here's an example of compilation and
usage:

$ javac test/client.java
$ java test.client eutil2 32800 1 10 20 25000

There "eutil2" is the name of the machine running the server, and
"32800" is the port on which it is listening (your number will vary).
"1" restricts the client to one connection at a time (necessary for
this very simple test server).  On each iteration, the client picks
(uniform random choice) a sleep time from a given interval, 10--20
milliseconds in this case.  The length of the buffer written is
specified above to be 25000 bytes.

You probably want to run the client and server on different machines;
the one time I tried them both on the same machine the period was
about 4 days.

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

[root@eutil2 linux-2.4.9-21]# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux eutil2.watson.ibm.com 2.4.9-21 #1 Thu Jan 17 14:09:42 EST 2002 i686 
unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11f
mount                  2.11b
modutils               2.4.10
e2fsprogs              1.23
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         autofs 3c59x ipchains usb-uhci usbcore

[7.2.] Processor information (from /proc/cpuinfo):

[tstusr@eutil2 tstusr]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 662.226
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1320.55

[7.3.] Module information (from /proc/modules):

[tstusr@eutil2 tstusr]$ cat /proc/modules
autofs                 11300   2 (autoclean)
3c59x                  25224   1 (autoclean)
ipchains               36424   0
usb-uhci               20708   0 (unused)
usbcore                49920   1 [usb-uhci]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

[tstusr@eutil2 tstusr]$ cat /proc/ioports
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
7480-74ff : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  7480-74ff : 00:0f.0
7800-78ff : ESS Technology ES1988 Allegro-1
fce0-fcff : VIA Technologies, Inc. UHCI USB
  fce0-fcff : usb-uhci
fff0-ffff : VIA Technologies, Inc. Bus Master IDE
  fff0-fff7 : ide0
  fff8-ffff : ide1

[tstusr@eutil2 tstusr]$ cat  /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffe2ebf : System RAM
  00100000-002b2cab : Kernel code
  002b2cac-002c986b : Kernel data
0ffe2ec0-0ffe6ebf : ACPI Tables
0ffe6ec0-0ffeeeff : ACPI Non-volatile Storage
0ffeef00-0fffffff : reserved
ec000000-efffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
f0000000-fe9fffff : PCI Bus #01
  f0000000-f7ffffff : S3 Inc. Savage 4
feafff80-feafffff : 3Com Corporation 3c905B 100BaseTX [Cyclone]
feb00000-febfffff : PCI Bus #01
  feb80000-febfffff : S3 Inc. Savage 4
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

[root@eutil2 /root]# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 8
        Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: feb00000-febfffff
        Prefetchable memory behind bridge: f0000000-fe9fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] 
(rev 12)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at fff0 [size=16]

00:02.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 08) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 22
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at fce0 [size=32]

00:02.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 
20)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 7480 [size=128]
        Region 1: Memory at feafff80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at ff000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:12.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 
10)
        Subsystem: IBM: Unknown device 017b
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 7800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04) (prog-if 00 
[VGA])
        Subsystem: Diamond Multimedia Systems: Unknown device 4906
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1000ns min, 63750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at feb80000 (32-bit, non-prefetchable) 
[size=512K]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

There is no /proc/scsi.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

For information on procmeter3, see
<http://www.gedanken.demon.co.uk/procmeter3/>.

I don't think the problem depends on the client's JDK, but just for
completeness:

[tstusr@eutil2 tstusr]$ java -version
java version "1.3.0"
Java(TM) 2 Runtime Environment, Standard Edition (build 1.3.0)
Classic VM (build 1.3.0, J2RE 1.3.0 IBM build cx130-20010925 (JIT enabled: 
jitc))



Thank you, and I hope you find this useful,
Mike

--=_mixed 0076465185256B51_=
Content-Type: text/plain; name="sserver.c.txt"
Content-Disposition: attachment; filename="sserver.c.txt"
Content-Transfer-Encoding: quoted-printable

#include <stdlib.h>	/* for atoi, malloc */
#include <stdio.h>
#include <math.h>	/* for sqrt() */
#include <unistd.h>	/* for read, write, getpid */
#include <errno.h>	/* for errno */
#include <time.h>	/* for ctime() */
#include <sys/time.h>	/* for gettimeofday() */
#include <sys/times.h>	/* for times() */
#include <sys/types.h>	/* for socket(), getpid, etc */
#include <sys/socket.h>	/* for socket(), etc */
#include <netinet/in.h>	/* for sockaddr=5Fin, in=5Faddr */

#define MYBUFLEN 937

typedef struct {
  struct sockaddr=5Fin remaddr;
  int sock;
  char *cbuf;
  char *wbuf;
} ConnData;

typedef struct {
  double ss=5Fmin, ss=5Fmax, ss=5Fsum1, ss=5Fsum2;
} StatSum;

typedef struct {
  long unsigned psc=5Fuser, psc=5Fnice, psc=5Fsyst, psc=5Fidle, psc=5Ftotal;
} ProcStatCpu;

typedef struct {
  int ps=5Futime;
  int ps=5Fstime;
  int ps=5Fttime;
} ProcsStat;

#define ZSS {10*1000*1000, 0, 0, 0.0}
static StatSum zss =3D ZSS;

void updateSSd(StatSum *ss, double x) {
  ss->ss=5Fsum1 +=3D x;
  ss->ss=5Fsum2 +=3D x*x;
  if (x < ss->ss=5Fmin)
    ss->ss=5Fmin =3D x;
  if (x > ss->ss=5Fmax)
    ss->ss=5Fmax =3D x;
  return;
}

void updateSS(StatSum *ss, long x) {updateSSd(ss, (double)x);}

char *sfmtSS(char *buf, StatSum ss, long nIter, int fmti) {
  double n =3D nIter;
  double avg =3D ((double)ss.ss=5Fsum1) / n;
  double devsq =3D 0;
  if (nIter > 1)
    devsq =3D ((ss.ss=5Fsum2 + n*avg*avg - 2*avg*ss.ss=5Fsum1)
	     / (n-1));
  if (devsq >=3D 0)
    sprintf(buf, (fmti
		  ?"[%3.1f, %8.6f +=3D %8.6f, %3.1f, %6.1f]"
		  :"[%6.1f, %7.2f +=3D %7.2f, %7.1f, %10.1f]"),
	    ss.ss=5Fmin, avg, (double) sqrt(devsq), ss.ss=5Fmax, ss.ss=5Fsum1);
  else
    sprintf(buf, (fmti
		  ?"[%3.1f, %8.6f +=3D sqrt(%8.6f), %3.1f, %6.1f]"
		  :"[%6.1f, %7.2f +=3D sqrt(%7.2f), %7.1f, %10.1f]"),
	    ss.ss=5Fmin, avg, devsq, ss.ss=5Fmax, ss.ss=5Fsum1);
  return buf;
}

char *sfmtTime(char *buf, struct timeval tv) {
  char *tstr;
  tstr =3D ctime(&tv.tv=5Fsec);
  if (tstr !=3D NULL) {
    int tslen;
    tslen =3D strlen(tstr);
    if (tstr[tslen-1] =3D=3D '\n')
      tstr[tslen-1] =3D 0;
    sprintf(buf, "%s + %06ldus", tstr, (long) tv.tv=5Fusec);
  } else sprintf(buf, "%ld + %06ldus (ctime failed)",
		 (long) tv.tv=5Fsec, (long) tv.tv=5Fusec);
  return buf;
}

char *sfmtNow(char *buf) {
  struct timeval now;
  int res;
  res =3D gettimeofday(&now, NULL);
  if (res)
    sprintf(buf, "(getttimeofday() failed!)");
  else
    sfmtTime(buf, now);
  return buf;
}

long dtv(struct timeval tva, struct timeval tvb) {
  long ds  =3D tva.tv=5Fsec  - tvb.tv=5Fsec ;
  long dus =3D tva.tv=5Fusec - tvb.tv=5Fusec;
  return (dus + (1000000*ds));
}

long ReportPeriod=5FS =3D 60;
int fusum;
struct timeval lastRept =3D {0};
StatSum dBytes =3D ZSS, dusIn =3D ZSS, dusMid =3D ZSS, dusOut =3D ZSS;
StatSum dut =3D ZSS, dst =3D ZSS, dbt =3D ZSS;

ProcStatCpu curPsc;
ProcsStat curPs;
FILE *procStat =3D NULL, *procsStat =3D NULL;

int pid;

ProcStatCpu readProcStat() {
  int ns;
  ProcStatCpu ans;
  rewind(procStat);
  ns =3D fscanf(procStat, "cpu %lu %lu %lu %lu\n", &ans.psc=5Fuser,
	      &ans.psc=5Fnice, &ans.psc=5Fsyst, &ans.psc=5Fidle);
  if (ns !=3D 4) {
    fprintf(stderr, "Read of /proc/stat failed!\n");
    exit(1);
  }
  ans.psc=5Ftotal =3D (ans.psc=5Fuser + ans.psc=5Fnice +
		   ans.psc=5Fsyst + ans.psc=5Fidle);
  return ans;
}

ProcsStat readProcsStat() {
  int ns;
  ProcsStat ans;
  rewind(procsStat);
  ns =3D fscanf(procsStat,
	      "%*d (%*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %d %d ",
	      &ans.ps=5Futime, &ans.ps=5Fstime);
  if (ns < 2) {
    fprintf(stderr, "proc's stat scanf failed!\n");
    exit(1);
  }
  ans.ps=5Fttime =3D ans.ps=5Futime + ans.ps=5Fstime;
  return ans;
}

ProcStatCpu psc=5Fdiff(ProcStatCpu *pa, ProcStatCpu *pb) {
  ProcStatCpu ans;
  ans.psc=5Fuser =3D pa->psc=5Fuser - pb->psc=5Fuser;
  ans.psc=5Fnice =3D pa->psc=5Fnice - pb->psc=5Fnice;
  ans.psc=5Fsyst =3D pa->psc=5Fsyst - pb->psc=5Fsyst;
  ans.psc=5Fidle =3D pa->psc=5Fidle - pb->psc=5Fidle;
  ans.psc=5Ftotal =3D pa->psc=5Ftotal - pb->psc=5Ftotal;
  return ans;
}

void psc=5FprintStep(char *what, ProcStatCpu *pCur, ProcStatCpu *pNxt) {
  ProcStatCpu dltPsc;
  float tot, pct=5Fuser, pct=5Fnice, pct=5Fsyst, pct=5Fidle;
  dltPsc =3D psc=5Fdiff(pNxt, pCur);
  tot =3D dltPsc.psc=5Ftotal;
  pct=5Fuser =3D 100 * dltPsc.psc=5Fuser / tot;
  pct=5Fnice =3D 100 * dltPsc.psc=5Fnice / tot;
  pct=5Fsyst =3D 100 * dltPsc.psc=5Fsyst / tot;
  pct=5Fidle =3D 100 * dltPsc.psc=5Fidle / tot;
  printf("%s\tuser cs\tnice cs\tsyst cs\t   idle cs\t  total cs\n"
	 "cum\t%7lu\t%7lu\t%7lu\t%10lu\t%10lu\n"
	 "diff\t%7lu\t%7lu\t%7lu\t%10lu\t%10lu\n"
	 "%%age\t%7.1f\t%7.1f\t%7.1f\t%10.1f\n\n", what
	 , pNxt->psc=5Fuser, pNxt->psc=5Fnice
	 , pNxt->psc=5Fsyst, pNxt->psc=5Fidle
	 , pNxt->psc=5Ftotal
	 , dltPsc.psc=5Fuser, dltPsc.psc=5Fnice
	 , dltPsc.psc=5Fsyst, dltPsc.psc=5Fidle
	 , dltPsc.psc=5Ftotal
	 , pct=5Fuser, pct=5Fnice, pct=5Fsyst, pct=5Fidle
	 );
}

void ps=5FprintStep(int pid, ProcsStat *pCur, ProcsStat *pNxt, float dt) {
  int dutime =3D pNxt->ps=5Futime - pCur->ps=5Futime;
  int dstime =3D pNxt->ps=5Fstime - pCur->ps=5Fstime;
  int dttime =3D pNxt->ps=5Fttime - pCur->ps=5Fttime;
  float pct=5Fu =3D 1.0 * dutime / dt;
  float pct=5Fs =3D 1.0 * dstime / dt;
  float pct=5Ft =3D 1.0 * dttime / dt;
  printf("p%d\tuser\tkern\tboth\n"
	 "new\t%d\t%d\t%d\n"
	 "diff\t%d\t%d\t%d\n"
	 "%%age\t%04.1f\t%04.1f\t%04.1f\n", pid
	 , pNxt->ps=5Futime, pNxt->ps=5Fstime, pNxt->ps=5Fttime
	 , dutime, dstime, dttime
	 , pct=5Fu, pct=5Fs, pct=5Ft
	 );
}

void *runConn(void *arg, int nsub) {
  ConnData *cdp =3D (ConnData*) arg;
  char *wbuf;
  size=5Ft i;
  int j, res;
  long sinceRept, dIter =3D 0, ReportPeriod=5FUS =3D ReportPeriod=5FS*1000*=
1000;
  struct timeval tvb, tva;
  struct tms tmsa, tmsb;
  int first;
  char bufb[100], bufi[100], bufm [100], bufo[100];
  char bufu[100], bufs[100], bufus[100], buft[100];
  if (times(&tmsa) =3D=3D (clock=5Ft) -1) {
    fprintf(stderr, "times() A failed.\n");
    exit(13);
  }
  if (procStat)
    curPsc =3D readProcStat();
  if (procsStat)
    curPs =3D readProcsStat();
  res =3D gettimeofday(&tva, NULL);
  if (res !=3D 0)
    exit(22);
  lastRept =3D tva;
  for (;1;) {
    ssize=5Ft nb, nbw;
    res =3D gettimeofday(&tvb, NULL);
    if (res !=3D 0)
      exit(21);
    nb =3D read(cdp->sock, cdp->cbuf, MYBUFLEN);
    if (nb < 0) {
      int theErr =3D errno;
      fprintf(stderr, "At %s, aborting conn at read, errno=3D%d.\n",
	      sfmtNow(buft), theErr);
      return;
    }
    if (nb =3D=3D 0) {
      fprintf(stderr, "got EOF.\n");
      exit(0);	/* so gprof writes its stats */
    }
    res =3D gettimeofday(&tva, NULL);
    if (res !=3D 0)
      exit(22);
    updateSS(&dusIn, dtv(tva, tvb));
    updateSS(&dBytes, (long) nb);
    cdp->cbuf[MYBUFLEN] =3D 0;
    for (i =3D 0; i <=3D MYBUFLEN; i++) {
      cdp->wbuf[i] =3D cdp->cbuf[i];
    }
    for (j =3D 0; j < nsub; j++) {
      for (i=3D0; i < MYBUFLEN; i++) {
	int dm, n, q;
	dm =3D cdp->wbuf[MYBUFLEN-i];
	n =3D cdp->cbuf[(i+400*j)%MYBUFLEN];
	q =3D n / (dm + 1);
	fusum +=3D q;
      }
    }
    if (fusum =3D=3D 123456789)
      fprintf(stdout, "Bingo!\n");
    res =3D gettimeofday(&tvb, NULL);
    if (res !=3D 0)
      exit(23);
    updateSS(&dusMid, dtv(tvb, tva));
    for (wbuf =3D cdp->wbuf; nb > 0; ) {
      nbw =3D write(cdp->sock, wbuf, nb);
      if (nbw < 0) {
	int theErr =3D errno;
	fprintf(stderr, "At %s, aborting conn at write, errno=3D%d.\n",
		sfmtNow(buft), theErr);
	return;
      }
      nb -=3D nbw;
      wbuf +=3D nbw;
    }
    res =3D gettimeofday(&tva, NULL);
    if (res !=3D 0)
      exit(24);
    if (times(&tmsb) =3D=3D (clock=5Ft) -1) {
      fprintf(stderr, "times() B failed.\n");
      exit(25);
    }
    updateSS (&dusOut, dtv(tva, tvb));
    /*
    updateSSd(&dut,
	      ((double) (tmsb.tms=5Futime - tmsa.tms=5Futime))/CLOCKS=5FPER=5FSEC);
    updateSSd(&dst,
	      ((double) (tmsb.tms=5Fstime - tmsa.tms=5Fstime))/CLOCKS=5FPER=5FSEC);
    */
    updateSS(&dut,  (tmsb.tms=5Futime - tmsa.tms=5Futime) );
    updateSS(&dst,  (tmsb.tms=5Fstime - tmsa.tms=5Fstime) );
    updateSS(&dbt, ((tmsb.tms=5Futime - tmsa.tms=5Futime) +
		    (tmsb.tms=5Fstime - tmsa.tms=5Fstime)));
    tmsa =3D tmsb;
    sinceRept =3D dtv(tva, lastRept);
    dIter++;
    if (sinceRept >=3D ReportPeriod=5FUS) {
      ProcStatCpu nxtPsc, dltPsc;
      ProcsStat nxtPs;
      float pct=5Fu =3D dut.ss=5Fsum1*1.0e6/sinceRept;
      float pct=5Fs =3D dst.ss=5Fsum1*1.0e6/sinceRept;
      float pct=5Fb =3D dbt.ss=5Fsum1*1.0e6/sinceRept;
      if (procStat) {
	nxtPsc =3D readProcStat();
      }
      if (procsStat) {
	nxtPs  =3D readProcsStat();
      }
      printf("\n\nAt %s, dIter=3D%ld, dt=3D%ld us\n"
	     "db=3D%s,\n"
	     "I=3D%s us,\nM=3D%s us,\nO=3D%s us,\n"
	     "chg-user-t=3D%s cs, %4.1f%%\n"
	     "chg-syst-t=3D%s cs, %4.1f%%\n"
	     "chg-both-t=3D%s cs, %4.1f%%\n"
	     "cum-user-t=3D%ld cs, cum-syst-t=3D%ld cs, cum-both-t=3D%ld cs.\n"
	     "\n",
	     sfmtTime(buft, tva), dIter, sinceRept,
	     sfmtSS(bufb, dBytes, dIter, 0),
	     sfmtSS(bufi, dusIn , dIter, 0),
	     sfmtSS(bufm, dusMid, dIter, 0),
	     sfmtSS(bufo, dusOut, dIter, 0),
	     sfmtSS(bufu , dut  , dIter, 1), pct=5Fu,
	     sfmtSS(bufs , dst  , dIter, 1), pct=5Fs,
	     sfmtSS(bufus, dbt  , dIter, 1), pct=5Fb,
	     (long) tmsb.tms=5Futime,
	     (long) tmsb.tms=5Fstime,
	     (long) tmsb.tms=5Futime + tmsb.tms=5Fstime
	     );
      dBytes =3D dusIn =3D dusMid =3D dusOut =3D dut =3D dst =3D dbt =3D zs=
s;
      dIter =3D 0;
      lastRept =3D tva;
      if (procStat) {
	psc=5FprintStep("mach", &curPsc, &nxtPsc);
	curPsc =3D nxtPsc;
      }
      if (procsStat) {
	ps=5FprintStep(pid, &curPs, &nxtPs, sinceRept/1.0e6);
	curPs  =3D nxtPs ;
      }
    }
  }
}

int main(int argc, char **argv) {
  int ss;
  int port;
  union {
    struct sockaddr mysa;
    struct sockaddr=5Fin mysain;
  } mysau;
  int salen =3D sizeof(mysau.mysa);
  int res;
  int nsub =3D 1;
  pid=5Ft tpid;
  if (argc !=3D 3) {
    fprintf(stderr, "Usage: %s report-period n-sub\n", argv[0]);
    return 1;
  }
  ReportPeriod=5FS =3D atoi(argv[1]);
  nsub =3D atoi(argv[2]);
  fprintf(stdout, "Report Period =3D %ld seconds\n", ReportPeriod=5FS);
  fprintf(stdout, "Sub loop count =3D %d\n", nsub);
  fprintf(stdout, "CLOCKS=5FPER=5FSEC =3D %g\n", (double) CLOCKS=5FPER=5FSE=
C);
  fusum =3D 0;
  tpid =3D getpid();
  pid =3D tpid;
  ss =3D socket(AF=5FINET, SOCK=5FSTREAM, 0);
  if (ss < 0) {
    int theErr =3D errno;
    fprintf(stderr, "socket() failed, errno=3D%d.\n", theErr);
    exit(2);
  }
  res =3D listen(ss, 100);
  if (res < 0) {
    int theErr =3D errno;
    fprintf(stderr, "listen() failed, errno=3D%d.\n", theErr);
    exit(4);
  }
  res =3D getsockname(ss, &mysau.mysa, &salen);
  if (res < 0) {
    int theErr =3D errno;
    fprintf(stderr, "getsockname() failed, errno=3D%d.\n", theErr);
    exit(6);
  }
  if (salen !=3D sizeof(mysau.mysain)) {
    fprintf(stderr, "getsockname() returned len=3D%d rather than %d.\n",
	    salen, sizeof(mysau.mysain));
    exit(8);
  }
  port =3D ntohs(mysau.mysain.sin=5Fport);
  fprintf(stdout, "listening on port %d.\n", port);
  procStat =3D fopen("/proc/stat", "r");
  if (!procStat){
    fprintf(stderr, "Failed to open /proc/stat!\n");
  } else {
    setvbuf(procStat , NULL, =5FIONBF, 0);
  }
  if (0) {
    char psname[100];
    sprintf(psname, "/proc/%d/stat", pid);
    procsStat =3D fopen(psname, "r");
    if (!procsStat) {
      fprintf(stderr, "Failed to open proc %d's stat!\n", pid);
    } else {
      setvbuf(procsStat, NULL, =5FIONBF, 0);
    }
  }
  for (;;) {
    int newsock;
    ConnData *cdp;
    salen =3D sizeof(mysau.mysa);
    newsock =3D accept(ss, &mysau.mysa, &salen);
    if (newsock < 0) {
      int theErr =3D errno;
      fprintf(stderr, "accept() failed, errno=3D%d.\n", theErr);
      exit(10);
    }
    if (salen !=3D sizeof(mysau.mysain)) {
      fprintf(stderr, "accept claimed remote address of length %d, rather t=
han %d.\n",
	      salen, sizeof(mysau.mysain));
      exit(12);
    }
    cdp =3D (ConnData*) malloc(sizeof(ConnData));
    if (cdp !=3D NULL) {
      cdp->cbuf =3D malloc(MYBUFLEN+1);
      cdp->wbuf =3D malloc(MYBUFLEN+1);
    }
    if (cdp =3D=3D NULL || cdp->cbuf=3D=3DNULL || cdp->wbuf=3D=3DNULL) {
      fprintf(stderr, "malloc failed!\n");
      exit(14);
    }
    cdp->remaddr =3D mysau.mysain;
    cdp->sock =3D newsock;
    runConn(cdp, nsub);
  }
}
--=_mixed 0076465185256B51_=
Content-Type: text/plain; name="idle.c.txt"
Content-Disposition: attachment; filename="idle.c.txt"
Content-Transfer-Encoding: quoted-printable

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

long unsigned countInner;

char *sfmtTime(char *buf, struct timeval tv) {
  char *tstr;
  tstr =3D ctime(&tv.tv=5Fsec);
  if (tstr !=3D NULL) {
    int tslen;
    tslen =3D strlen(tstr);
    if (tstr[tslen-1] =3D=3D '\n')
      tstr[tslen-1] =3D 0;
    sprintf(buf, "%s + %06ldus", tstr, (long) tv.tv=5Fusec);
  } else sprintf(buf, "%ld + %06ldus (ctime failed)",
		 (long) tv.tv=5Fsec, (long) tv.tv=5Fusec);
  return buf;
}

long dtv(struct timeval tva, struct timeval tvb) {
  long ds  =3D tva.tv=5Fsec  - tvb.tv=5Fsec ;
  long dus =3D tva.tv=5Fusec - tvb.tv=5Fusec;
  return (dus + (1000000*ds));
}

void inner() {
  int i;
  for (i =3D 0; i < 10000000; i++)
    countInner ++;
  return;
}

int main(int argc, char **argv) {
  long unsigned countOuter, lastCount =3D 0;
  struct timeval tva, tvb;
  int res, ReportPeriod=5FS, ReportPeriod=5FUS;
  long since;
  char buft[100];
  if (argc !=3D 2) {
    fprintf(stderr, "Usage: %s report-period\n", argv[0]);
    return 1;
  }
  ReportPeriod=5FS =3D atoi(argv[1]);
  ReportPeriod=5FUS =3D ReportPeriod=5FS * 1000 * 1000;
  fprintf(stdout, "Report Period =3D %g seconds\n",
	  ReportPeriod=5FUS/(double)1.0e6);
  res =3D gettimeofday(&tva, NULL);
  if (res !=3D 0)
    exit(22);
  for (countOuter =3D 0; ; countOuter++) {
    inner();
    res =3D gettimeofday(&tvb, NULL);
    if (res !=3D 0)
      exit(22);
    since =3D dtv(tvb, tva);
    if (since > ReportPeriod=5FUS) {
      long unsigned dCount =3D countOuter - lastCount;
      float rate =3D dCount * 1.0e6 / since;
      printf("At %s, count=3D%lu,\n"
	     "d-count=3D%lu, d-t=3D%ld us, rate=3D%4.2f/s\n",
	     sfmtTime(buft, tvb),
	     countOuter,
	     dCount,
	     since,
	     rate);
      lastCount =3D countOuter;
      tva =3D tvb;
    }
  }
}
--=_mixed 0076465185256B51_=
Content-Type: image/jpeg; name="pm3shot-trim2.jpg"
Content-Disposition: attachment; filename="pm3shot-trim2.jpg"
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkz
ODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2Nj
Y2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAmAD4DASEA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDqN93/
AM8If+/x/wDiaN93/wA8If8Av8f/AImtry7CDfd/88If+/x/+Jo33f8Azwh/7/H/AOJovLsAb7v/
AJ4Q/wDf4/8AxNG+7/54Q/8Af4//ABNF5dgDfd/88If+/wAf/iaN93/zwh/7/H/4mi8uwB9rj/uT
/wDfh/8ACmi/gMhjHmlwoYr5L5AOcHGOnB/KjnQDvtcf9yf/AL8P/hVbUb7ytNung81JVhdkZoWA
U4OCcjHXHWnzaAVdA1pr/TVe5jYTRny2aMGQOQoy3yjAyc8Vp/a4/wC5P/34f/4mkpK2oGX4i1mS
w04SWa4maVVBmUooHU/eAzkDGM55z2q3p18JdNtZJzK0rQoXdYWILY55Ax+XFJSuwNCuE8EX1xee
Ibl5nJL2oD8k7iuxQx9TjPPqT603uB3dYnjP/kV7z/gH/oa0PYCl8PP+QFP/ANfLf+gpXUUR2A5b
4hf8gKDn/l5X/wBBatDwe7v4YsmdmYgMuSSeAxAH4Dil9oCxqtvBb6VeTQ28CyRwO6nylOCFODz7
1xvgV2u9YmjumM6C3JCyHcAdy84NJpXA7z7FaD/l1g/79isLxn9nsPD8hihWKWR1jR40ClTnJyR7
KabSsBS8ByJe2l3DcxLM8Tqwkk+c4YdOew2k/jXVfYbT/n1g/wC/YojFNAcF44uhDrC21o/lLFGN
6xrs+c88kdeNv+c10vhKCK48OWk00SSStv3O6gsfnbvUxS5gLd7opv7V7a61K8khfG5cRDODnsnt
VOw8IWum3IuLO9vopQCuQ6HIPYgrg1dgLU+hvO259Y1RTnd+7mVOcAfwqPQfr6moL7wtBqMcEd5f
30qwArHlkyAcZyQmT0HWhoB2m+GYdK8z7Df3kXm438xtnGcdUPqavfYLn/oLXn/fMP8A8boS0Ayb
rwXY3lw89zeX0kshyzGROf8Ax2r9lopsLVLa11K8jhTO1cRHGTk8lPU0Jagf/9k=
--=_mixed 0076465185256B51_=
Content-Type: text/plain; name="client.java.txt"
Content-Disposition: attachment; filename="client.java.txt"
Content-Transfer-Encoding: quoted-printable

package test;

import java.io.*;
import java.net.*;
import java.util.Date;
import java.text.DateFormat;
import java.util.Random;

public class client {

    Socket s;
    int pauseMillisMin, pauseMillisMax;
    int msgLen;
    String msg;

    Random rand =3D new Random();

    public client(InetAddress host, int sport, int pauseMillisMin, int paus=
eMillisMax, int msgLen)
	throws IOException
    {
	s =3D new Socket(host, sport);
	this.pauseMillisMin =3D pauseMillisMin;
	this.pauseMillisMax =3D pauseMillisMax;
	this.msgLen =3D msgLen;
	StringBuffer sb =3D new StringBuffer(msgLen+1);
	for (int i =3D 0; i < msgLen; i++)
	    sb.append((char) (33 + Math.random()*93));
	sb.append("\n");
	msg =3D sb.toString();
	(new Thread(new MyWriter(s.getOutputStream()))).start();
	(new Thread(new MyReader(s.getInputStream()))).start();
    }

    class MyWriter implements Runnable {
	OutputStream so;
	int pauseMillisSpread =3D 1 + pauseMillisMax - pauseMillisMin;
	MyWriter(OutputStream so) {this.so =3D so;}
	public void run() {
	    OutputStreamWriter osr =3D new OutputStreamWriter(so);
	    try {
		while (true) {
		    osr.write(msg);
		    int pauseMillis =3D pauseMillisMin;
		    if (pauseMillisSpread > 1)
			pauseMillis +=3D rand.nextInt(pauseMillisSpread);
		    try {
			Thread.sleep(pauseMillis);
		    } catch (Exception ex) {}
		}
	    } catch (IOException ex) {
		int locport =3D s.getLocalPort();
		System.err.println("At " + nowString()
				   + ", aborting writing from " + locport
				   + " because of exn " + ex.getClass().getName()
				   + " msg=3D" + ex.getMessage());
	    }
	}
    }
   =20
    class MyReader implements Runnable {
	InputStream si;
	MyReader(InputStream si) {this.si =3D si;}
	public void run() {
	    InputStreamReader isr =3D new InputStreamReader(si);
	    BufferedReader br =3D new BufferedReader(isr);
	    try {
		while (true) {
		    String mr =3D br.readLine();
		    if (!msg.regionMatches(0, mr, 0, msgLen)) {
			System.err.println("Message mismatch!  Sent ["
					   + msg + "] received ["
					   + mr + "].");
			return;
		    }
		}
	    } catch (IOException ex) {
		int locport =3D s.getLocalPort();
		System.err.println("At " + nowString()
				   + ", aborting reading through " + locport
				   + " because of exn " + ex.getClass().getName()
				   + " msg=3D" + ex.getMessage());
	    }
	}
    }
   =20
    public static void main(String[] args) throws IOException {
	if (args.length !=3D 6) {
	    System.err.println("Usage: client host port nThreads pauseMillisMin pa=
useMillisMax msgLen");
	    System.exit(1);
	}
	String hostStr =3D args[0];
	int sport =3D Integer.parseInt(args[1]);
	int nThreads =3D Integer.parseInt(args[2]);
	int pauseMillisMin =3D Integer.parseInt(args[3]);
	int pauseMillisMax =3D Integer.parseInt(args[4]);
	int msgLen =3D Integer.parseInt(args[5]);
	InetAddress host =3D InetAddress.getByName(hostStr);
	System.out.println("Testing host " + host
			   + ", port " + sport
			   + ", n-thds=3D" + nThreads
			   + ", pause-ms=3D[" + pauseMillisMin
			   + ", " + pauseMillisMax + "]"
			   + ", msglen=3D" + msgLen);
	for (int i =3D 0; i < nThreads; i++) {
	    new client(host, sport, pauseMillisMin, pauseMillisMax, msgLen);
	}
	System.out.println("Started at " + nowString());
    }

    private static final DateFormat df =3D DateFormat.getDateTimeInstance(D=
ateFormat.FULL,
									DateFormat.FULL);

    private static String nowString() {
        Date dNow =3D new Date();
        return df.format(dNow);
    }
   =20
}
--=_mixed 0076465185256B51_=--
