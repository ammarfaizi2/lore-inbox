Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUCSUpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUCSUpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:45:43 -0500
Received: from LLMAIL.LL.MIT.EDU ([129.55.12.40]:27015 "EHLO ll.mit.edu")
	by vger.kernel.org with ESMTP id S261959AbUCSUpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:45:18 -0500
Subject: PROBLEM: Multicast reception fail when setsockopt() used to set
	SO_RCVBUF to small.
From: "Richard A. Hogaboom" <hogaboom@ll.mit.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-YoK++ovrc/qTa55X70st"
Organization: MIT Lincoln Laboratory
Message-Id: <1079728843.30591.19.camel@capella>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 19 Mar 2004 15:40:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YoK++ovrc/qTa55X70st
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

See attached bug.report file and example code files.

-- 
Richard A. Hogaboom
MIT Lincoln Laboratory
244 Wood St.
Lexington, MA 02420-9108
B-389
781-981-0276
hogaboom@ll.mit.edu

--=-YoK++ovrc/qTa55X70st
Content-Disposition: attachment; filename=serv.c
Content-Type: text/x-c; name=serv.c; charset=UTF-8
Content-Transfer-Encoding: 7bit


#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

#define _POSIX_C_SOURCE 1

int
main(int argc, char *argv[])
{
    int s;
    struct sockaddr_in addr;
    int addrlen;
    unsigned char buf[16] = "012345678901234";



    /*
     * INIT MULTICAST COMM
     */

    if ((s = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP)) == -1)
    {
        fprintf(stderr, "serv: Multicast socket() open fail. %s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(25000);
    addr.sin_addr.s_addr = htonl(INADDR_ANY);
    addrlen = sizeof(addr);

    if (bind(s, (struct sockaddr *) &addr, sizeof(addr)) == -1)
    {
        fprintf(stderr, "serv: Multicast bind() port fail. %s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    /* set up addr for multicast on mcast_group */
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(25000);
    addr.sin_addr.s_addr = inet_addr("224.0.0.250");
    addrlen = sizeof(addr);

    fprintf(stderr, "Start Loop\n");

    for (;;)
    {
        sleep(1);
        fprintf(stderr, "Loop: %s\n", buf);

        if ((sendto(s, (const void *)&buf[0], sizeof(buf), 0, (struct sockaddr *) &addr, addrlen)) == -1)
        {
            fprintf(stderr, "serv: sendto() fail. %s", strerror(errno));
            exit(EXIT_FAILURE);
        }
    }
}


--=-YoK++ovrc/qTa55X70st
Content-Disposition: attachment; filename=client.c
Content-Type: text/x-c; name=client.c; charset=UTF-8
Content-Transfer-Encoding: 7bit


#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

   int
main(int argc, char *argv[])
{
    int				cnt;
    int				s_mc;
    int				rcvbuf_len;
    struct sockaddr_in		addr;
    int				addrlen;
    struct ip_mreq		mreq;

    unsigned char		buf[16];



    /*
     * INIT MULTICAST COMM
     */

    if ((s_mc = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP)) == -1)
    {
        fprintf(stderr, "client: Multicast socket() open fail. %s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(25000);
    addr.sin_addr.s_addr = inet_addr("224.0.0.250");
    addrlen = sizeof(addr);

    if (bind(s_mc, (struct sockaddr *) &addr, sizeof(addr)) == -1)
    {
        fprintf(stderr, "client: Multicast bind() port fail. %s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    mreq.imr_multiaddr.s_addr = inet_addr("224.0.0.250");
    mreq.imr_interface.s_addr = INADDR_ANY;

    if (setsockopt(s_mc, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mreq, sizeof(mreq)) == -1)
    {
        fprintf(stderr, "client: Multicast setsockopt(IP_ADD_MEMBERSHIP) fail. %s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    /* 2048 works */
    /* rcvbuf_len = 2048; */

    /* 1024 does not work */
    rcvbuf_len = 1024;
    if (setsockopt(s_mc, SOL_SOCKET, SO_RCVBUF, (const void *)&rcvbuf_len, sizeof(rcvbuf_len)) == -1)
    {
        fprintf(stderr, ": Multicast setsockopt(SO_RCVBUF) fail. %s\n", strerror(errno));
        exit(EXIT_FAILURE);
    }

    fprintf(stderr, "MC: START LOOP\n");

    for (;;)
    {
        if ((cnt = recvfrom(s_mc, (void *)&buf, sizeof(buf), 0, (struct sockaddr *) &addr, (socklen_t *)&addrlen)) == -1)
        {
            if (errno != EWOULDBLOCK)
            {
                fprintf(stderr, "client: Multicast recvfrom() fail. %s\n", strerror(errno));
                exit(EXIT_FAILURE);
            }
        }

        if (cnt != -1)
        {
            fprintf(stderr, "MC: %d %s\n", sizeof(buf), buf);
        }
    }
}


--=-YoK++ovrc/qTa55X70st
Content-Disposition: attachment; filename=mk.client
Content-Type: text/x-ksh; name=mk.client; charset=UTF-8
Content-Transfer-Encoding: 7bit

#!/bin/ksh

set -v

CDEBUG="-g -ansi -pedantic -Wall -Wpointer-arith -Winline -Wmissing-prototypes \
    -Wstrict-prototypes"

# Linux
gcc -I. -g -ansi $CDEBUG -o client client.c -lnsl -lm


--=-YoK++ovrc/qTa55X70st
Content-Disposition: attachment; filename=mk.serv
Content-Type: text/x-ksh; name=mk.serv; charset=UTF-8
Content-Transfer-Encoding: 7bit

#!/bin/ksh

set -v

CDEBUG="-g -ansi -pedantic -Wall -Wpointer-arith -Winline -Wmissing-prototypes \
    -Wstrict-prototypes"

# Solaris
gcc -I. -g -ansi $CDEBUG -o serv serv.c -lsocket -lnsl -lm


--=-YoK++ovrc/qTa55X70st
Content-Disposition: attachment; filename=bug.report
Content-Type: text/plain; name=bug.report; charset=UTF-8
Content-Transfer-Encoding: 7bit


[1.] One line summary of the problem:
     On multicast reception if the setsockopt() SO_RCVBUF option is set too small then multicast reception is disabled.




[2.] Full description of the problem/report:
     I used setsockopt() to set the receive buffer size for multicast reception.  If I set the buffer size to
     1024 bytes no multicast reception occurs.  If I increase the buffer size to 2048 bytes then multicast
     reception is reestablished.  setsockopt() returns no error in either case.  It seems to me that if there
     is a minimum size that works, then setsockopt() should return an error if you go below that limit.  I was sending
     multicast messages of exactly 16 bytes(data, not including protocol bytes).  I have included both the server and
     client code to reproduce this problem(the server code runs on my Solaris machine, but that does not matter, it's
     the receive end on the Linux box that is having the problem.  I checked the wire with tcpdump() to make sure the
     multicast messages were on the wire.).

     P.S. Last year I used setsockopt() on a TCP connection to set the receive buffer size to 1 byte(somehow thinking
          that this might speed delivery of TCP messages) and discovered that sometimes TCP messages sent from the
          server would disappear completely.  This did not stop reception completely like the multicast case, but
          only resulted in the dropping of some TCP messages sent from the server.  Maybe these are related?
          Something about setsockopt() using SO_RCVBUF that's smaller then is really needed.




[3.] Keywords (i.e., modules, networking, kernel):
     Multicast, setsockopt().




[4.] Kernel version (from /proc/version):
     Linux version 2.4.22-1.2174.nptlsmp (bhcompile@tweety.devel.redhat.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-6)) #1 SMP Wed Feb 18 16:21:50 EST 2004




[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
     No Oops.. messages.




[6.] A small shell script or example program which triggers the
     problem (if possible)
     See attached files.




[7.] Environment
     Not used.




[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
  
Linux capella 2.4.22-1.2174.nptlsmp #1 SMP Wed Feb 18 16:21:50 EST 2004 i686 i686 i386 GNU/Linux
  
Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.25
e2fsprogs              1.34
jfsutils               1.1.3
reiserfsprogs          3.6.8
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         nls_iso8859-1 nls_cp437 vfat fat agpgart nvidia i810_audio ac97_codec soundcore nfs nfsd lockd sunrpc parport_pc lp parport autofs e1000 floppy sg sr_mod microcode ide-scsi ide-cd cdrom ohci1394 ieee1394 keybdev mousedev hid input ehci-hcd usb-uhci usbcore ext3 jbd mptscsih mptbase sd_mod scsi_mod




[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.06GHz
stepping        : 7
cpu MHz         : 3056.894
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
runqueue        : 0
 
bogomips        : 6094.84
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.06GHz
stepping        : 7
cpu MHz         : 3056.894
cache size      : 512 KB
physical id     : 3
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
runqueue        : 1
 
bogomips        : 6107.95




[7.3.] Module information (from /proc/modules):

nls_iso8859-1           3516   0 (autoclean)
nls_cp437               5148   0 (autoclean)
vfat                   12716   0 (autoclean)
fat                    39352   0 (autoclean) [vfat]
agpgart                56708   3 (autoclean)
nvidia               2124416   6 (autoclean)
i810_audio             28872   0 (autoclean)
ac97_codec             16972   0 (autoclean) [i810_audio]
soundcore               7044   2 (autoclean) [i810_audio]
nfs                    88280   0 (autoclean)
nfsd                   80528   8 (autoclean)
lockd                  58160   1 (autoclean) [nfs nfsd]
sunrpc                 90460   1 (autoclean) [nfs nfsd lockd]
parport_pc             18884   1 (autoclean)
lp                      8772   0 (autoclean)
parport                39072   1 (autoclean) [parport_pc lp]
autofs                 12500   3 (autoclean)
e1000                  71680   1
floppy                 58268   0 (autoclean)
sg                     36396   0 (autoclean)
sr_mod                 17400   0 (autoclean)
microcode               4736   0 (autoclean)
ide-scsi               12208   0
ide-cd                 34560   0
cdrom                  35040   0 [sr_mod ide-cd]
ohci1394               29544   0 (unused)
ieee1394              208164   0 [ohci1394]
keybdev                 2656   0 (unused)
mousedev                5432   1
hid                    23972   0 (unused)
input                   6208   0 [keybdev mousedev hid]
ehci-hcd               20488   0 (unused)
usb-uhci               27180   0 (unused)
usbcore                82560   1 [hid ehci-hcd usb-uhci]
ext3                   74564   6
jbd                    55784   6 [ext3]
mptscsih               40592   7
mptbase                43840   3 [mptscsih]
sd_mod                 13388  14
scsi_mod              113640   5 [sg sr_mod ide-scsi mptscsih sd_mod]




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
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c800-c8ff : Intel Corp. 82801DB AC'97 Audio Controller
  c800-c8ff : Intel ICH4
cc40-cc7f : Intel Corp. 82801DB AC'97 Audio Controller
  cc40-cc7f : Intel ICH4
cc80-cc9f : Intel Corp. 82801DB/DBM SMBus Controller
d000-efff : PCI Bus #02
  d000-dfff : PCI Bus #04
    dc00-dcff : LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI
  e000-efff : PCI Bus #03
    ecc0-ecff : Intel Corp. 82545EM Gigabit Ethernet Controller (Copper)
      ecc0-ecff : e1000
ff40-ff5f : Intel Corp. 82801DB USB (Hub #3)
  ff40-ff5f : usb-uhci
ff60-ff7f : Intel Corp. 82801DB USB (Hub #2)
  ff60-ff7f : usb-uhci
ff80-ff9f : Intel Corp. 82801DB USB (Hub #1)
  ff80-ff9f : usb-uhci
ffa0-ffaf : Intel Corp. 82801DB Ultra ATA Storage Controller
  ffa8-ffaf : ide1


00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ce800-000d27ff : Extension ROM
000d2800-000d3fff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ff74fff : System RAM
  00100000-00293e7d : Kernel code
  00293e7e-003bec67 : Kernel data
3ff75000-3ff76fff : ACPI Non-volatile Storage
3ff77000-3ff97fff : ACPI Tables
3ff98000-3fffffff : reserved
40000000-400003ff : Intel Corp. 82801DB Ultra ATA Storage Controller
e0000000-e7ffffff : Intel Corp. E7000 Series Processor to AGP Controller
e8000000-efffffff : Intel Corp. E7505 Memory Controller Hub
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : nVidia Corporation NV30GL [Quadro FX 1000]
fc000000-fdffffff : PCI Bus #01
  fc000000-fcffffff : nVidia Corporation NV30GL [Quadro FX 1000]
fe1f8000-fe1fbfff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
fe1ff800-fe1fffff : Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
  fe1ff800-fe1fffff : ohci1394
fe300000-fe8fffff : PCI Bus #02
  fe3fe000-fe3fefff : Intel Corp. 82870P2 P64H2 I/OxAPIC (#2)
  fe3ff000-fe3fffff : Intel Corp. 82870P2 P64H2 I/OxAPIC
  fe500000-fe6fffff : PCI Bus #04
    fe5e0000-fe5effff : LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI
    fe5f0000-fe5fffff : LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI
  fe700000-fe8fffff : PCI Bus #03
    fe7e0000-fe7fffff : Intel Corp. 82545EM Gigabit Ethernet Controller (Copper)
      fe7e0000-fe7fffff : e1000
fe900000-fe9000ff : Intel Corp. 82801DB AC'97 Audio Controller
  fe900000-fe9000ff : ich_audio MBBAR
fe900400-fe9005ff : Intel Corp. 82801DB AC'97 Audio Controller
  fe900400-fe9005ff : ich_audio MMBAR
fe900800-fe900bff : Intel Corp. 82801DB USB2
  fe900800-fe900bff : ehci_hcd
fec00000-fec8ffff : reserved
fee00000-fee0ffff : reserved
ffb00000-ffffffff : reserved




[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. E7505 Memory Controller Hub (rev 03)
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: <available only to root>
 
00:01.0 PCI bridge: Intel Corp. E7000 Series Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>
 
00:02.0 PCI bridge: Intel Corp. E7000 Series Hub Interface B PCI-to-PCI Bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
        I/O behind bridge: 0000d000-0000efff
        Memory behind bridge: fe300000-fe8fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
 
00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at ff80 [size=32]
 
00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at ff60 [size=32]
 
00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at ff40 [size=32]
 
00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at fe900800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>
 
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Bridge (rev 81) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fe100000-fe2fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
 
00:1f.0 ISA bridge: Intel Corp. 82801DB (ICH4) LPC Bridge (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:1f.1 IDE interface: Intel Corp. 82801DB (ICH4) Ultra ATA 100 Storage Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at ffa0 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]
 
00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at cc80 [size=32]
 
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at c800 [size=256]
        Region 1: I/O ports at cc40 [size=64]
        Region 2: Memory at fe900400 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at fe900000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>
 
01:00.0 VGA compatible controller: nVidia Corporation NV30GL [Quadro FX 1000] (rev a2) (prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 0182
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at c1000000 [disabled] [size=128K]
        Capabilities: <available only to root>
 
02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fe3ff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>
 
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe700000-fe8fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>
 
02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fe3fe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>
 
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe500000-fe6fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>
 
03:0e.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 10
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at fe7e0000 (64-bit, non-prefetchable) [size=128K]
        Region 4: I/O ports at ecc0 [size=64]
        Capabilities: <available only to root>
 
04:0e.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 4500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 50
        Region 0: I/O ports at dc00 [size=256]
        Region 1: Memory at fe5f0000 (64-bit, non-prefetchable) [size=64K]
        Region 3: Memory at fe5e0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe600000 [disabled] [size=1M]
        Capabilities: <available only to root>
 
05:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Dell Computer Corporation: Unknown device 012c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at fe1ff800 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at fe1f8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: <available only to root>
 




[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST336607LW       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: _NEC     Model: DVD+RW ND-1100A  Rev: 10FD
  Type:   CD-ROM                           ANSI SCSI revision: 02




[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
       Can't thing of any, but you can ask me for more info if needed.




[X.] Other notes, patches, fixes, workarounds:
     Workaround: Just accept the default receive buffer size or use setsockopt() to set a very large size.


--=-YoK++ovrc/qTa55X70st--

