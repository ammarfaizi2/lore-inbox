Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266359AbUHBJDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266359AbUHBJDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 05:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUHBJDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 05:03:22 -0400
Received: from ls413.htnet.hr ([195.29.150.117]:10405 "EHLO ls413.htnet.hr")
	by vger.kernel.org with ESMTP id S266359AbUHBJDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 05:03:19 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Bug in ethernet module b44.c (2.6.7)
X-face: GK)@rjKTDPkyI]TBX{!7&/#rT:#yE\QNK}s(-/!'{dG0r^_>?tIjT[x0aj'Q0u>a
              yv62CGsq'Tb_=>f5p|$~BlO2~A&%<+ry%+o;k'<(2tdowfysFc:?@($aTGX
              4fq`u}~4,0;}y/F*5,9;3.5[dv~C,hl4s*`Hk|1dUaTO[pd[x1OrGu_:1%-lJ]W@
Organization: ENAMETOOLONG
X-Operating-System: GNU/Linux 2.6.7
Mail-Copies-To: never
From: Miroslav Zubcic <mvz@nimium.com>
Date: Mon, 02 Aug 2004 11:02:52 +0200
Message-ID: <lzd629zzcz.fsf@devana.nimium.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: ls413.htnet.hr 1091437397 993 194.152.194.163 (Mon, 02 Aug 2004 11:03:17 +0200)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone!

I have Laptop Compaq nx5000 with Linux installed, and this network
card:

-------------------------------------------------------------------
01:0e.0 Ethernet controller: Broadcom Corporation BCM5705M 10/100/1000Base T (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 08bc
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at 90080000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
-------------------------------------------------------------------

Motherboard and chipset:

-------------------------------------------------------------------
00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 08bc
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at <unassigned> (32-bit, prefetchable)
        Capabilities: [40] #09 [a105]

00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O Control Registers (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 08bc
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH Configuration Process Registers (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 08bc
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

-------------------------------------------------------------------

I had problems with b44 module on 2.6.6 kernel, but this was resolved
with patch from Pekka Pietikainen on this list, and later merged in
2.6.7 kernel. Thanks Pekka and Jeff.

Meanwhile, I have discovered new bug in this module. When opening raw
socket, network card will stop sending and receiveing packets.

For example, if I start `nmap -v -sS 192.168.1.70'. nmap(1) freezes
and waits forever. While nmap(1) is active (and trying to do it's
job), I cannot do anything on the net. Existing ssh connections are
freezed and unresponsive. If I interrupt nmap, everything comes back
to normal after 1-2 seconds.

Only working mode for nmap(1) is: "nmap -v -sT -P0". This mode will
not freeze broadcom ethernet card.

However, I have found one workaround. If I start tcpdump(8) in one
xterm on eth interface to wait for traffic, and "nmap -v -sS" in other
window, nmap (and all other active or new connections, like ssh, http)
are working without problem. So, if PROMISC is set on interface
(tcpdump will set this flag when started, and remove on interrupt),
everything works as expected. Of course, if I stop tcpdump(8), and
start nmap(1) again, it will not work, and network will be unusable
until I kill nmap(1). In normal mode without nmap(1), that is -
tcp,udp ssh/http/imap/smtp ... there is no visible problems.  dmesg(8)
does not report anything unusual, neither logfiles do.

I hope this is enough info.


-- 
Many men would sooner die then think. In fact they do.
		-- Bertrand Russell

