Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbRFFO0g>; Wed, 6 Jun 2001 10:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263289AbRFFO01>; Wed, 6 Jun 2001 10:26:27 -0400
Received: from sunmail.canal-plus.fr ([194.2.208.66]:25784 "EHLO
	sunmail.canal-plus.fr") by vger.kernel.org with ESMTP
	id <S263218AbRFFO0X>; Wed, 6 Jun 2001 10:26:23 -0400
Message-ID: <3B1E3D86.C7A7874@canal-plus.fr>
Date: Wed, 06 Jun 2001 16:26:14 +0200
From: thierry.lelegard@canal-plus.fr
Organization: CANAL+ Technologies
X-Mailer: Mozilla 4.75 [fr]C-CCK-MCD C+  (WinNT; U)
X-Accept-Language: en,fr,zh-CN,zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: I/O system call never returns if file desc is closed in the 
 meantime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] I/O system call never returns if file desc is closed in the meantime

[2.] Full description of the problem/report:

This report describes a problem in the usage of file descriptors across
multiple threads. When one thread closes a file descriptor, another
thread which waits for an I/O on that file descriptor is not notified
and blocks forever.

I don't know exactly what should be considered as "correct behavior"
but all other operating systems we use (Sun Solaris, HP-UX, OpenVMS
and Windows NT) have the exact same behavior. Linux is the only one
to hang.

Context: We use multi-threaded applications. Some threads perform I/O on
file descriptors (usually sockets, but not only sockets). Each thread
manages one file descriptor (a "communication"). A manager thread detects
application-defined conditions and may decide to interrupt a communication.
To interrupt the communication, this manager thread closes the file descriptor.
If the close operation occurs while the "communication" thread is waiting
for data on this file descriptor (using poll(2) for instance), this thread
never returns from the I/O system call and hangs forever.

On all other operating systems we use, the I/O system call in the
"communication" thread returns and reports an error.

See example program below.

[3.] Keywords

file-descriptor thread async-close

[4.] Kernel version (from /proc/version):

Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 20:41:30
EDT 2001

[5.] Output of Oops.. message:

None.

[6.] A small shell script or example program which triggers the problem

Here is an example program in C.

>From the main thread, the program creates an UDP socket and polls it
using poll(2). Since no packet is received on this UDP port. poll blocks.
>From a second thread, after 2 seconds, the socket's file descriptor is
closed (while the main thread is suspended on poll).

On Solaris and HP-UX (as well as equivalent programs on OpenVMS and
Windows NT), the poll returns in the main thread and reports an error
on the file descriptor. On Linux, the poll never returns and the main
thread is blocked forever.

This example uses a socket but it works exactly the same way using
a pipe or any device which may block long enough.

--> Output on Solaris 5.8 and HP-UX B.11.00

main: starting poll
close_thread: starting thread
close_thread: closing socket
close_thread: close status = 0
main: poll status = 1
main: events   = 00000001
main: revents  = 00000020

... and the program exits.

--> Output on Linux RedHat 7.1 (kernel 2.4.2-2)

main: starting poll
close_thread: starting thread
close_thread: closing socket
close_thread: close status = 0

... and the program remains blocked.

--> Source code

/*
 *  Test the asynchronous close of an UDP socket.
 *
 *  Linux   : gcc -o asclose_udp_c asclose_udp_c.c -lpthread
 *  Solaris : cc -o asclose_udp_c asclose_udp_c.c -lpthread -lsocket -lnsl
 *  HP-UX   : cc -o asclose_udp_c asclose_udp_c.c -lpthread
 */

#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <poll.h>
#include <pthread.h>

#define UDP_PORT 6666
#define CLOSE_DELAY 2 /* seconds */

/* UDP socket descriptor */

static int sock_fd = -1;

/* This procedure is a thread which closes the socket after a delay */

static void* close_thread (void *arg)
{
    int status;
    struct timeval now;
    struct timezone tz;
    struct timespec timeout;
    pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

    printf ("close_thread: starting thread\n");

    /* Wait for the specified delay */

    pthread_mutex_lock (&mutex);
    gettimeofday (&now, &tz);
    timeout.tv_sec = now.tv_sec + CLOSE_DELAY;
    timeout.tv_nsec = now.tv_usec * 1000;
    pthread_cond_timedwait (&cond, &mutex, &timeout);
    pthread_mutex_unlock (&mutex);
   
    /* Close the socket while the main task is blocked in a poll(2) */

    printf ("close_thread: closing socket\n");
    status = close (sock_fd);
    printf ("close_thread: close status = %d\n", status);
    
    return NULL;
}

/* Main program */

int main (int argc, char *argv[])
{
    int status;
    pthread_t th;
    struct pollfd fdset;
    struct sockaddr_in saddr;

    /* Create a UDP socket */

    if ((sock_fd = socket (AF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0) {
        perror ("socket");
        exit (EXIT_FAILURE);
    }

    saddr.sin_family = AF_INET;
    saddr.sin_port = htons (UDP_PORT);
    saddr.sin_addr.s_addr = 0;

    if (bind (sock_fd, (struct sockaddr*) &saddr, sizeof (saddr)) < 0) {
        perror ("bind");
        exit (EXIT_FAILURE);
    }

    /* Create a new thread to asynchronously close the socket */

    if ((status = pthread_create (&th, NULL, close_thread, NULL)) != 0) {
        fprintf (stderr, "pthread_create: %s\n", strerror (status));
        exit (EXIT_FAILURE);
    }

    /* Wait for input data using poll(2) and an infinite timeout */

    fdset.fd = sock_fd;
    fdset.events = POLLIN;
    fdset.revents = 0;

    printf ("main: starting poll\n");
    status = poll (&fdset, 1, -1);
    printf ("main: poll status = %d\n", status);
    printf ("main: events   = %08X\n", fdset.events);
    printf ("main: revents  = %08X\n", fdset.revents);
}

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux penguin.canal-plus.fr 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11b
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ide-cd cdrom i810 agpgart autofs nfs lockd sunrpc e100 3c59x ipchains usb-uhci usbcore

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 797.433
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1592.52

[7.3.] Module information (from /proc/modules):

ide-cd                 26848   0 (autoclean)
cdrom                  27232   0 (autoclean) [ide-cd]
i810                   80256   1
agpgart                23392   7 (autoclean)
autofs                 11264   1 (autoclean)
nfs                    79008   1 (autoclean)
lockd                  52464   1 (autoclean) [nfs]
sunrpc                 61328   1 (autoclean) [nfs lockd]
e100                   44240   1 (autoclean)
3c59x                  25344   1 (autoclean)
ipchains               38976   0 (unused)
usb-uhci               20720   0 (unused)
usbcore                49664   1 [usb-uhci]

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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-1fff : PCI Bus #02
  1000-103f : Intel Corporation 82820 820 (Camino 2) Chipset Ethernet
    1000-101f : e100
  1040-107f : 3Com Corporation 3c900 Combo [Boomerang]
    1040-107f : eth0
2000-20ff : PCI device 8086:2445 (Intel Corporation)
2400-243f : PCI device 8086:2445 (Intel Corporation)
2440-245f : Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub B)
  2440-245f : usb-uhci
2460-246f : Intel Corporation 82820 820 (Camino 2) Chipset IDE U100
  2460-2467 : ide0
  2468-246f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ecffff : System RAM
  00100000-002557df : Kernel code
  002557e0-0026c80b : Kernel data
07ed0000-07eeffff : ACPI Non-volatile Storage
07ef0000-07efffff : System RAM
40000000-402fffff : PCI Bus #02
  40000000-40000fff : Intel Corporation 82820 820 (Camino 2) Chipset Ethernet
40300000-4037ffff : PCI device 8086:1132 (Intel Corporation)
44000000-47ffffff : PCI device 8086:1132 (Intel Corporation)
feea0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset Graphics Controller]  (rev 02) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 0019
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 44000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at 40300000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 40000000-402fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82820 820 (Camino 2) Chipset IDE U100 (rev 01) (prog-if 80 [Master])
        Subsystem: Intel Corporation: Unknown device 2411
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at 2460 [size=16]

00:1f.4 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub B) (rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 2411
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 2440 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device 000b
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 2000 [size=256]
        Region 1: I/O ports at 2400 [size=64]

02:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2) Chipset Ethernet (rev 01)
        Subsystem: Compaq Computer Corporation: Unknown device 0012
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 1000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:0b.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 1040 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=64K]

[7.6.] SCSI information (from /proc/scsi/scsi)

No SCSI adapter.

[7.7.] Other information that might be relevant to the problem

None.

[X.] Other notes, patches, fixes, workarounds:

None.
