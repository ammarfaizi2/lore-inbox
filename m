Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265581AbSKKGZn>; Mon, 11 Nov 2002 01:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265588AbSKKGZn>; Mon, 11 Nov 2002 01:25:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:38676 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265581AbSKKGZg>;
	Mon, 11 Nov 2002 01:25:36 -0500
Message-ID: <3DCF4F08.DF153FD0@gmx.net>
Date: Mon, 11 Nov 2002 07:32:40 +0100
From: Matjaz Omerzel <21442@gmx.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] TCP connection hangs when sending /dev/hda
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am experiencing undeterministic network behaviour on a rather old 486.
Some TCP connections occasionally block within a few seconds from
connecting. There is no obvious rule: sometimes it works fine for a day,
then after a reboot (or even without one), most of the connections tend
to hang after a few seconds. Generally, if a connection doesn't block
for a minute, it works OK for the rest of the day.

Restarting network with /etc/init.d/network or rebooting sometimes helps
and brings the system from state in which nearly all of the
connection work to state in which most of the connections hang, or vice
versa - but not always. Very rarely, the connection which had been hung
for a few minutes would wake, transfer a few more bytes and hang again,
but 95% of the time it won't even wake.

To reconstruct:

Machine C(ontrol): Windows 95, IP 10.8.100.250, 3Com 3C905C, thoroughly
tested and working for years
Machine S(ubject): RedHat Linux 8, kernel 2.4.18-14, 100 MHz i486 with
32 Mb RAM, IP 10.8.32.1, Via Rhine DFE-530TX, working for years on win98

I wire the machines directly using a crossover cable. On machine C, I
just start two sink programs listening on ports 7999 and 8999, each
counting incoming bytes.

>From here on, everything written applies to machine S. First, I start:

dd if=/dev/zero bs=512 | nc 10.8.100.250 7999 &

and it runs as one would expect. Moreover, I have never seen this
connection to hang or fail in any way. But if I do

dd if=/dev/hda  bs=512 | nc 10.8.100.250 8999 &

this would almost always stop just after transferring just a few
megabytes, leaving both sides waiting (process nc sleeping in I/O).

The funny thing is however, that even with the second connection
blocked, the first is still running smoothly.

Ping also works all the time and does not lose any packets. Therefore, I
assume that network drivers are functioning properly, but there might be
some subtle issues with the disk activity. But then again, wouldn't disk
activity affect both connections?

Blocking also occurs when sending a file instead of raw disk.


----- On S, netstat -to shows that the send queue is full (last line):

Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address           Foreign Address        
State       Timer
tcp        0      0 10.8.32.1:ssh           10.8.100.250:1045      
ESTABLISHED keepalive (6949.75/0/0)
tcp        0      0 10.8.32.1:ssh           10.8.100.250:2141      
ESTABLISHED keepalive (7101.85/0/0)
tcp        0      0 10.8.32.1:ssh           10.8.100.250:2142      
ESTABLISHED keepalive (7169.31/0/0)
tcp        0  12536 10.8.32.1:1029          10.8.100.250:8999      
ESTABLISHED on (18.80/7/0)

----- And tcpdump looks as though as no acknowledgment from C had been
received. See last lines, this is the example in which blocking happened
almost immediately:

22:13:59.466888 10.8.32.1.1025 > 10.8.100.250.8999: S
1695174963:1695174963(0) win 5840 <mss 1460,sackOK,timestamp 42050
0,nop,wscale 0> (DF)
22:13:59.467142 10.8.100.250.8999 > 10.8.32.1.1025: S 9397777:9397777(0)
ack 1695174964 win 8760 <mss 1460,nop,wscale 0,nop,nop,timestamp 0
0,nop,nop,sackOK> (DF)
22:13:59.467629 10.8.32.1.1025 > 10.8.100.250.8999: . ack 1 win 5840
<nop,nop,timestamp 42050 0> (DF)
22:13:59.507591 10.8.32.1.1025 > 10.8.100.250.8999: . 1:1449(1448) ack 1
win 5840 <nop,nop,timestamp 42054 0> (DF)
22:13:59.508240 10.8.32.1.1025 > 10.8.100.250.8999: . 1449:2897(1448)
ack 1 win 5840 <nop,nop,timestamp 42055 0> (DF)
22:13:59.508644 10.8.100.250.8999 > 10.8.32.1.1025: . ack 2897 win 8760
<nop,nop,timestamp 87780 42054> (DF)
22:13:59.509079 10.8.32.1.1025 > 10.8.100.250.8999: P 2897:4097(1200)
ack 1 win 5840 <nop,nop,timestamp 42055 87780> (DF)
22:13:59.567121 10.8.32.1.1025 > 10.8.100.250.8999: . 4097:5545(1448)
ack 1 win 5840 <nop,nop,timestamp 42060 87780> (DF)
22:13:59.567673 10.8.32.1.1025 > 10.8.100.250.8999: . 5545:6993(1448)
ack 1 win 5840 <nop,nop,timestamp 42060 87780> (DF)
22:13:59.567597 10.8.100.250.8999 > 10.8.32.1.1025: . ack 5545 win 8760
<nop,nop,timestamp 87781 42055> (DF)
22:13:59.568833 10.8.32.1.1025 > 10.8.100.250.8999: . 6993:8441(1448)
ack 1 win 5840 <nop,nop,timestamp 42061 87781> (DF)
22:13:59.569104 10.8.32.1.1025 > 10.8.100.250.8999: P 8441:9889(1448)
ack 1 win 5840 <nop,nop,timestamp 42061 87781> (DF)
22:13:59.569509 10.8.32.1.1025 > 10.8.100.250.8999: . 9889:11337(1448)
ack 1 win 5840 <nop,nop,timestamp 42061 87781> (DF)
22:13:59.569243 10.8.100.250.8999 > 10.8.32.1.1025: . ack 5545 win 8760
<nop,nop,timestamp 87781 42055,nop,nop,sack sack 1 {6993:8441} > (DF)
22:13:59.570144 10.8.32.1.1025 > 10.8.100.250.8999: P 11337:12289(952)
ack 1 win 5840 <nop,nop,timestamp 42061 87781> (DF)
22:13:59.570443 10.8.100.250.8999 > 10.8.32.1.1025: . ack 5545 win 8760
<nop,nop,timestamp 87781 42055,nop,nop,sack sack 2
{11337:12289}{6993:8441} > (DF)
22:13:59.570911 10.8.32.1.1025 > 10.8.100.250.8999: . 5545:6993(1448)
ack 1 win 5840 <nop,nop,timestamp 42061 87781> (DF)
22:13:59.778121 10.8.32.1.1025 > 10.8.100.250.8999: . 5545:6993(1448)
ack 1 win 5840 <nop,nop,timestamp 42082 87781> (DF)
22:14:00.198058 10.8.32.1.1025 > 10.8.100.250.8999: . 5545:6993(1448)
ack 1 win 5840 <nop,nop,timestamp 42124 87781> (DF)
22:14:01.038056 10.8.32.1.1025 > 10.8.100.250.8999: . 5545:6993(1448)
ack 1 win 5840 <nop,nop,timestamp 42208 87781> (DF)
22:14:02.718115 10.8.32.1.1025 > 10.8.100.250.8999: . 5545:6993(1448)
ack 1 win 5840 <nop,nop,timestamp 42376 87781> (DF)
22:14:06.078083 10.8.32.1.1025 > 10.8.100.250.8999: . 5545:6993(1448)
ack 1 win 5840 <nop,nop,timestamp 42712 87781> (DF)
22:14:12.798119 10.8.32.1.1025 > 10.8.100.250.8999: . 5545:6993(1448)
ack 1 win 5840 <nop,nop,timestamp 43384 87781> (DF)
22:14:15.648644 10.8.100.250.8999 > 10.8.32.1.1025: R 9397778:9397778(0)
win 0 (DF)

If I close the connection end on C, S eventhough hung senses it
immediately and closes too.


I've tried the following, of which nothing had helped:
- upgrading kernel from 2.4.7-10 to 2.4.18-14
- changing PCI parameters (IRQ, latency timers)
- moving card to a different PCI slot
- removing other cards
- tweaking via-rhine.o parameters max_interrupt_work, rx_copybreak
- changing hdparam parameters
- enabling/disabling CONFIG_VIA_RHINE_MMIO in kernel
- experimenting with some sysctl parameters
- forcing the link to 10/100 and half/full duplex using mii-tool

The problem was the same when I used 3Com 3C905C NIC (Boomerang, 10/100
Mbit PCI NIC, driver 3c59x) instead of via-rhine. Obviously, the problem
cannot be related to either NIC hardware or the driver.

Using 3Com 3C509B NIC (which is a 10 Mbit ISA card) however, I was
unable to reproduce this bizarre behaviour, and all connections were
working all of the time, no matter how hard I tried. (Interesting
enough, I also observed that the transfer ratio was much smoother with
3C509B, whereas with via-rhine everything was happening in short
"bursts", suggesting that there might be interrupts in question.)

Does anyone have a clue on what might be happening? Are the problems
hardware-related, driver-related, CPU-speed related,
queue-overflow-related or a combination of PCI-IDE and drivers? Or
perhaps something else?

Any ideas would be greatly appreciated.

Attached below are some details about my system S. Sorry for the long
post.

Matjaz Omerzel



----------------------------------------------------------
# netstat -s

Ip:
    40060 total packets received
    0 forwarded
    0 incoming packets discarded
    40045 incoming packets delivered
    79869 requests sent out
Icmp:
    114 ICMP messages received
    0 input ICMP message failed.
    ICMP input histogram:
        destination unreachable: 10
        echo requests: 104
    114 ICMP messages sent
    0 ICMP messages failed
    ICMP output histogram:
        destination unreachable: 10
        echo replies: 104
Tcp:
    2 active connections openings
    1 passive connection openings
    0 failed connection attempts
    0 connection resets received
    3 connections established
    39935 segments received
    79745 segments send out
    24 segments retransmited
    0 bad segments received.
    0 resets sent
Udp:
    0 packets received
    10 packets to unknown port received.
    0 packet receive errors
    10 packets sent
TcpExt:
    ArpFilter: 0
    77 delayed acks sent
    1 packets directly queued to recvmsg prequeue.
    1 packets directly received from prequeue
    10 packets header predicted
    TCPPureAcks: 48
    TCPHPAcks: 39674
    TCPRenoRecovery: 0
    TCPSackRecovery: 4
    TCPSACKReneging: 0
    TCPFACKReorder: 0
    TCPSACKReorder: 0
    TCPRenoReorder: 0
    TCPTSReorder: 0
    TCPFullUndo: 0
    TCPPartialUndo: 0
    TCPDSACKUndo: 0
    TCPLossUndo: 0
    TCPLoss: 2
    TCPLostRetransmit: 0
    TCPRenoFailures: 0
    TCPSackFailures: 0
    TCPLossFailures: 0
    TCPFastRetrans: 5
    TCPForwardRetrans: 0
    TCPSlowStartRetrans: 0
    TCPTimeouts: 0
    TCPRenoRecoveryFail: 0
    TCPSackRecoveryFail: 4
    TCPSchedulerFailed: 0
    TCPRcvCollapsed: 0
    TCPDSACKOldSent: 0
    TCPDSACKOfoSent: 0
    TCPDSACKRecv: 0
    TCPDSACKOfoRecv: 0
    TCPAbortOnSyn: 0
    TCPAbortOnData: 0
    TCPAbortOnClose: 0
    TCPAbortOnMemory: 0
    TCPAbortOnTimeout: 0
    TCPAbortOnLinger: 0
    TCPAbortFailed: 0
    TCPMemoryPressures: 0

# mii-diag -sv

mii-diag.c:v2.06 8/7/2002 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Using the default interface 'eth0'.
  Using the new SIOCGMIIPHY value on PHY 24 (BMCR 0x3000).
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD
10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx
10baseT-FD 10baseT, w/ 802.3X flow control.
   End of basic transceiver information.

 MII PHY #24 transceiver registers:
   3000 782d 0040 6176 05e1 45e1 0003 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   1000 0300 0000 0000 0000 01ce 0200 0000
   003f 8d3e 0f00 ff40 002f 0000 80a0 000b.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 Basic mode status register 0x782d ... 782d.
   Link status: established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Vendor ID is 00:10:18:--:--:--, model 23 rev. 6.
   No specific information is known about this transceiver type.
 I'm advertising 05e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD
10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 45e1: Flow-control 100baseTx-FD 100baseTx
10baseT-FD 10baseT.
   Negotiation  completed.

# lspci -vvv

00:10.0 Host bridge: United Microelectronics [UMC] UM8881F (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0

00:12.0 ISA bridge: United Microelectronics [UMC] UM8886F (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:16.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine]
(rev 06)
	Subsystem: D-Link System Inc DFE-530TX rev A
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 200 (29500ns min, 38000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 4000 [size=128]
	Region 1: Memory at 90000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at fe000000 [disabled] [size=64K]

00:17.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
	Subsystem: OPTi Inc. 82C861
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]

00:18.0 VGA compatible controller: S3 Inc. 86c868 [Vision 868 VRAM] vers
0 (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 14000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:19.0 IDE interface: Quantum Designs (H.K.) Ltd QD-8580 (rev 01)
(prog-if 00 [])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374
	Expansion ROM at 000c8000 [disabled] [size=16K]

# cat /proc/interrupts

           CPU0
  0:      12049          XT-PIC  timer
  1:          3          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 11:        434          XT-PIC  eth0
 13:          0          XT-PIC  fpu
 14:       2884          XT-PIC  ide0
NMI:          0
ERR:          0

# via-diag

via-diag.c:v2.06 5/22/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a VIA VT3043 Rhine adapter at 0x4000.
 Station address 00:50:ba:e0:29:ea.
 Tx enabled, Rx enabled, full-duplex (0x0c1a).
  Receive  mode is 0x6c: Normal unicast and hashed multicast.
  Transmit mode is 0x20: Normal transmit, 256 byte threshold.
VIA VT3043 Rhine chip registers at 0x4000
 0x000: e0ba5000 206cea29 00000c1a 4eff0000 80000000 00000000 011340a0
01134170
 0x020: 80000400 00000600 01c31010 011340b0 80000000 00000600 01719810
011340c0
 0x040: 00000000 00e0803c 01edaa00 01134180 00000000 00e0803c 01edaa00
01134180
 0x060: 01719080 01eda43c 00000000 00061008 782d0100 00000080 00070020
00000000
 No interrupt sources are pending (0000).

# cat /proc/ioports

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-01ffffff : System RAM
  00100000-001e4d33 : Kernel code
  001e4d34-0021a73f : Kernel data
10000000-10000fff : OPTi Inc. 82C861
14000000-17ffffff : S3 Inc. 86c868 [Vision 868 VRAM] vers 0
90000000-9000007f : VIA Technologies, Inc. VT3043 [Rhine]
  90000000-9000007f : via-rhine
ffff78c6-ffffffff : reserved

# Excerpt from /var/log/messages with "options via-rhine debug=7" in
/etc/modules.conf

Nov  4 21:40:37 gate kernel: via-rhine.c:v1.10-LK1.1.14  May-3-2002 
Written by Donald Becker
Nov  4 21:40:37 gate kernel:  
http://www.scyld.com/network/via-rhine.html
Nov  4 21:40:37 gate kernel: via-rhine: reset finished after 5
microseconds.
Nov  4 21:40:37 gate kernel: eth0: VIA VT86C100A Rhine at 0x90000000,
00:50:ba:e0:29:ea, IRQ 11.
Nov  4 21:40:37 gate kernel: eth0: MII PHY found at address 8, status
0x782d advertising 05e1 Link 45e1.
Nov  4 21:40:37 gate kernel: eth0: reset finished after 5 microseconds.
Nov  4 21:40:37 gate kernel: eth0: Setting full-duplex based on MII #8
link partner capability of 45e1.
Nov  4 21:40:41 gate login(pam_unix)[392]: session opened for user root
by LOGIN(uid=0)
Nov  4 21:40:41 gate  -- root[392]: ROOT LOGIN ON tty1
Nov  4 21:41:04 gate kernel: status 0001.
Nov  4 21:41:04 gate kernel: <upt, status 0001.
Nov  4 21:41:06 gate kernel: ne_rx() status is 00468f00.
Nov  4 21:41:06 gate kernel: <7status 00468f00.
Nov  4 21:41:07 gate kernel: ne_rx() status is 00468f00.
Nov  4 21:41:08 gate kernel: g interrupt, status=0x0000.
Nov  4 21:41:09 gate kernel: ne_rx() status is 00468f00.
Nov  4 21:41:12 gate kernel: rx() status is 00468f00.
Nov  4 21:41:13 gate kernel: g interrupt, status=0x0000.
Nov  4 21:41:23 gate kernel:
Nov  4 21:41:25 gate kernel: ng interrupt, status=0x0000.
Nov  4 21:41:31 gate kernel:
Nov  4 21:41:33 gate kernel:
Nov  4 21:41:52 gate kernel: >eth0: Interrupt, status 0002.
Nov  4 21:42:20 gate kernel: <7
Nov  4 21:42:30 gate dhcpd: receive_packet failed on eth0: Network is
down
Nov  4 21:42:31 gate network: Shutting down interface eth0:  succeeded
Nov  4 21:42:33 gate network: Shutting down loopback interface: 
succeeded
Nov  4 21:42:34 gate sysctl: net.ipv4.ip_forward = 0
Nov  4 21:42:35 gate sysctl: net.ipv4.conf.default.rp_filter = 1
Nov  4 21:42:35 gate sysctl: kernel.core_uses_pid = 1
Nov  4 21:42:35 gate network: Setting network parameters:  succeeded
Nov  4 21:42:38 gate network: Bringing up loopback interface:  succeeded
Nov  4 21:42:40 gate kernel: eth0: reset finished after 5 microseconds.
