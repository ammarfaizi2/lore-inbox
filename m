Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265308AbRFVBwg>; Thu, 21 Jun 2001 21:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbRFVBwd>; Thu, 21 Jun 2001 21:52:33 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:55304 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S265308AbRFVBwS>; Thu, 21 Jun 2001 21:52:18 -0400
From: raf@raf.org
Date: Fri, 22 Jun 2001 11:52:12 +1000
To: linux-kernel@vger.kernel.org
Subject: bugreport: poll() timeout always takes 10ms too long
Message-ID: <20010622115212.A8681@eccles.raf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

poll() timeout always takes 10ms too long

[2.] Full description of the problem/report:

Select() timeouts work fine. A timeout between 10n-9 and 10n ms times
out after 10n ms on average. Poll() timeouts between 10n-9 and 10n ms,
on the other hand, time out after 10(n+1) ms on average. It's always a
jiffy too long. This means it's impossible to set a 10ms timeout using
poll() even though it's possible using select(). The programs and their
output below [6] demonstrate this. The same behavious occurs with
linux-2.2 and linux-2.4.

[3.] Keywords (i.e., modules, networking, kernel):

poll, select, timer, timeout

[4.] Kernel version (from /proc/version):

$ cat /proc/version
Linux version 2.4.0 (root@eccles.raf.org) (gcc version 2.95.2 19991024 (release)) #16 Sat Jan 20 07:45:58 EST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

--- select.c ------------------------------------------------------------------
#include <stdlib.h>
#include <float.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>

void timeval_diff(struct timeval *start, struct timeval *end, struct timeval *diff)
{
	diff->tv_sec = end->tv_sec - start->tv_sec;

	if (end->tv_usec < start->tv_usec)
		diff->tv_usec = 1000000 + end->tv_usec - start->tv_usec, --diff->tv_sec;
	else
		diff->tv_usec = end->tv_usec - start->tv_usec;
}

double time_select(int msec)
{
	struct timeval timeout[1], start[1], end[1], elapsed[1];

	timeout->tv_sec = 0;
	timeout->tv_usec = msec * 1000;
	gettimeofday(start, NULL);
	select(1, NULL, NULL, NULL, timeout);
	gettimeofday(end, NULL);
	timeval_diff(start, end, elapsed);
	return ((double)elapsed->tv_sec * 1000000.0 + (double)elapsed->tv_usec) / 1000;
}

void test_select(int msec)
{
	double min = DBL_MAX;
	double max = DBL_MIN;
	double sum = 0.0;
	int i;

	for (i = 0; i < 1000; ++i)
	{
		double elapsed = time_select(msec);

		if (elapsed < min)
			min = elapsed;
		if (elapsed > max)
			max = elapsed;
		sum += elapsed;
	}
	
	printf("select(%d ms) min %g ms, max %g ms, avg %g ms\n", msec, min, max, sum / 1000);
}

int main(int ac, char **av)
{
	int msec = av[1] ? atoi(av[1]) : 1;
	test_select(msec);
	return EXIT_SUCCESS;
}
-------------------------------------------------------------------------------

--- poll.c --------------------------------------------------------------------
#include <stdlib.h>
#include <float.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/poll.h>

void timeval_diff(struct timeval *start, struct timeval *end, struct timeval *diff)
{
	diff->tv_sec = end->tv_sec - start->tv_sec;

	if (end->tv_usec < start->tv_usec)
		diff->tv_usec = 1000000 + end->tv_usec - start->tv_usec, --diff->tv_sec;
	else
		diff->tv_usec = end->tv_usec - start->tv_usec;
}

double time_poll(int msec)
{
	struct timeval start[1], end[1], elapsed[1];

	gettimeofday(start, NULL);
	poll(NULL, 0, msec);
	gettimeofday(end, NULL);
	timeval_diff(start, end, elapsed);
	return ((double)elapsed->tv_sec * 1000000.0 + (double)elapsed->tv_usec) / 1000;
}

void test_poll(int msec)
{
	double min = DBL_MAX;
	double max = DBL_MIN;
	double sum = 0.0;
	int i;

	for (i = 0; i < 1000; ++i)
	{
		double elapsed = time_poll(msec);

		if (elapsed < min)
			min = elapsed;
		if (elapsed > max)
			max = elapsed;
		sum += elapsed;
	}
	
	printf("poll(%d ms) min %g ms, max %g ms, avg %g ms\n", msec, min, max, sum / 1000);
}

int main(int ac, char **av)
{
	int msec = (av[1]) ? atoi(av[1]) : 1;
	test_poll(msec);
	return EXIT_SUCCESS;
}
-------------------------------------------------------------------------------

--- select-output -------------------------------------------------------------
$ for i in 1 5 9 10 11 15 19 20 21 25 29 30 31 35 39 40 41 45 49 50 51 1000         
do
        ./select $i
done
select(1 ms) min 5.624 ms, max 10.299 ms, avg 9.99298 ms
select(5 ms) min 5.668 ms, max 10.357 ms, avg 9.99301 ms
select(9 ms) min 5.635 ms, max 10.034 ms, avg 9.993 ms
select(10 ms) min 5.683 ms, max 10.347 ms, avg 9.99306 ms
select(11 ms) min 15.663 ms, max 20.627 ms, avg 19.993 ms
select(15 ms) min 15.664 ms, max 20.331 ms, avg 19.993 ms
select(19 ms) min 15.632 ms, max 20.04 ms, avg 19.993 ms
select(20 ms) min 15.652 ms, max 20.029 ms, avg 19.993 ms
select(21 ms) min 25.661 ms, max 30.299 ms, avg 29.993 ms
select(25 ms) min 25.663 ms, max 30.085 ms, avg 29.993 ms
select(29 ms) min 25.669 ms, max 30.084 ms, avg 29.993 ms
select(30 ms) min 25.642 ms, max 30.084 ms, avg 29.993 ms
select(31 ms) min 35.623 ms, max 40.313 ms, avg 39.993 ms
select(35 ms) min 35.626 ms, max 40.156 ms, avg 39.993 ms
select(39 ms) min 35.645 ms, max 40.568 ms, avg 39.993 ms
select(40 ms) min 35.65 ms, max 40.328 ms, avg 39.993 ms
select(41 ms) min 45.645 ms, max 50.085 ms, avg 49.993 ms
select(45 ms) min 45.627 ms, max 50.085 ms, avg 49.993 ms
select(49 ms) min 45.646 ms, max 50.085 ms, avg 49.993 ms
select(50 ms) min 45.652 ms, max 50.082 ms, avg 49.993 ms
select(51 ms) min 55.652 ms, max 60.307 ms, avg 59.993 ms
select(1000 ms) min 995.641 ms, max 1000.01 ms, avg 999.992 ms
-------------------------------------------------------------------------------

--- poll-output ---------------------------------------------------------------
$ for i in 1 5 9 10 11 15 19 20 21 25 29 30 31 35 39 40 41 45 49 50 51 1000
do
        ./poll $i  
done
poll(1 ms) min 15.629 ms, max 20.82 ms, avg 19.9933 ms
poll(5 ms) min 15.646 ms, max 20.3 ms, avg 19.9934 ms
poll(9 ms) min 15.651 ms, max 20.331 ms, avg 19.9934 ms
poll(10 ms) min 15.63 ms, max 20.299 ms, avg 19.9934 ms
poll(11 ms) min 25.628 ms, max 30.312 ms, avg 29.9933 ms
poll(15 ms) min 25.647 ms, max 30.373 ms, avg 29.9933 ms
poll(19 ms) min 25.606 ms, max 30.373 ms, avg 29.9932 ms
poll(20 ms) min 25.65 ms, max 30.33 ms, avg 29.9933 ms
poll(21 ms) min 35.626 ms, max 40.331 ms, avg 39.9933 ms
poll(25 ms) min 35.632 ms, max 40.087 ms, avg 39.9933 ms
poll(29 ms) min 35.651 ms, max 40.33 ms, avg 39.9933 ms
poll(30 ms) min 35.637 ms, max 40.331 ms, avg 39.9933 ms
poll(31 ms) min 45.638 ms, max 50.328 ms, avg 49.9933 ms
poll(35 ms) min 45.601 ms, max 50.574 ms, avg 49.9932 ms
poll(39 ms) min 45.66 ms, max 50.312 ms, avg 49.9933 ms
poll(40 ms) min 45.643 ms, max 50.311 ms, avg 49.9933 ms
poll(41 ms) min 55.612 ms, max 60.329 ms, avg 59.9932 ms
poll(45 ms) min 55.631 ms, max 60.343 ms, avg 59.9932 ms
poll(49 ms) min 55.645 ms, max 60.332 ms, avg 59.9933 ms
poll(50 ms) min 55.639 ms, max 60.375 ms, avg 59.9932 ms
poll(51 ms) min 65.663 ms, max 70.039 ms, avg 69.9933 ms
poll(1000 ms) min 1005.64 ms, max 1010.29 ms, avg 1009.99 ms
-------------------------------------------------------------------------------

[7.] Environment

MACHTYPE=i686
HOSTTYPE=i686
OSTYPE=linux-gnu

[7.1.] Software (add the output of the ver_linux script here)

$ scripts/ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux eccles.raf.org 2.4.0 #16 Sat Jan 20 07:45:58 EST 2001 i686 unknown
Kernel modules         2.3.23
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.1.0.23
Linux C Library        2.2.1
Dynamic linker         ldd (GNU libc) 2.2.1
Procps                 2.0.2
Mount                  2.9o
Net-tools              1.52
Console-tools          1999.03.02
Sh-utils               1.16
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 0
cpu MHz         : 451.028
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 897.84

[7.3.] Module information (from /proc/modules):

$ cat /proc/modules
serial                 42448   1 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

$ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5f00-5f1f : Intel Corporation 82371AB PIIX4 ACPI
6100-613f : Intel Corporation 82371AB PIIX4 ACPI
6400-641f : Intel Corporation 82371AB PIIX4 USB
6800-68ff : Adaptec AIC-7881U
6c00-6c3f : 3Com Corporation 3c905 100BaseTX [Boomerang]
  6c00-6c3f : eth0
e000-efff : PCI Bus #01
f000-f00f : Intel Corporation 82371AB PIIX4 IDE

$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-001d6685 : Kernel code
  001d6686-00221e27 : Kernel data
e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
e4000000-e7ffffff : S3 Inc. 86c325 [ViRGE]
eb000000-eb000fff : Adaptec AIC-7881U
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

$ lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64 set
	Region 0: Memory at e0000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=21
		Command: RQ=31 SBA+ AGP- 64bit- FW- Rate=21

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at f000

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 6400

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 SCSI storage controller: Adaptec AIC-7881U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 6800
	Region 1: Memory at eb000000 (32-bit, non-prefetchable)

00:0b.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 3 min, 8 max, 64 set
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 6c00

00:0c.0 VGA compatible controller: S3 Inc. 86C325 [ViRGE] (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 4 min, 255 max, 64 set
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e4000000 (32-bit, non-prefetchable)

[7.6.] SCSI information (from /proc/scsi/scsi)

$ cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

N/A

[X.] Other notes, patches, fixes, workarounds:

N/A

