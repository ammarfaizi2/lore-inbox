Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUCIJX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 04:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbUCIJX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 04:23:28 -0500
Received: from ext-nj2gw-5.online-age.net ([64.14.56.41]:20935 "EHLO
	ext-nj2gw-5.online-age.net") by vger.kernel.org with ESMTP
	id S261827AbUCIJVM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 04:21:12 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6521.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: PROBLEM::  irreversible Memory growth of process in mmap()-munmap() calls 
Date: Tue, 9 Mar 2004 14:50:35 +0530
Message-ID: <62DD37292ED5464CBB142913FC65F8AB0A59FC88@BANMLVEM01.e2k.ad.ge.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Need Help from CTT : irreversible Memory growth of process in mmap()-munmap() calls 
Thread-Index: AcQFBgKI2NL2e2utTP2L3fK5b59VywAsA7bw
From: "Kumar, Rajneesh \(MED\)" <rajneesh.kumar@med.ge.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Mar 2004 09:21:00.0747 (UTC) FILETIME=[D66761B0:01C405B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:   irreversible Memory growth of process in mmap()-munmap() calls 
[2.] Full description of the problem/report: 

  Problem : 

    I created 4 files of different sizes.Then wrote a program , as below:

     while ( for arbitrary time)
     {
           fopen (  first file )
           mmap (  first file )
           Note the memory-size of process

          munmap ( the file)
          Note the memory-size of process again
          fclose ( first file)
    
         //Repeat the above Sequence for 2nd File
         //Repeat the above Sequence for 3rd File
         //Repeat the above Sequence for 4th File
    }
  Observations : 
    When this program was run on 
1) Linux ( Compiled with gcc 3.2.2) :  The memory size of process grows when files are mapped during first iteration of while loop. But there in no change in size after unmapping the file. However My expectations was drop in size of memory after munmap( ). On more point of interest  is  there is no growth in memory after subsequent iterations of while loop.

2)  SUN (5.7) : Memory grows every time when file is mapped . Memory size drops down each time file is unmapped.

3) IRIX (6.5) :  Memory grows every time when file is mapped . Memory size drops down each time file is unmapped.

Expectations:

   The irreversible Memory growth in Linux is a problem for us. What we expect is the variance in size i.e., increase in size when files are mapped and decrease in size when files are unmapped. 
    Is that an issue with system call map( ) and unmap( )? or is it an issue with command "top"


[3.] Keywords (i.e., modules, networking, kernel): 
 [4.] Kernel version (from /proc/version):: Linux version 2.4.20-28.9.XFS1.3.1smp (root@chef) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP Mon Jan 5 13:20:15 CST 2004
 [5.] Output of Oops.. message (if applicable) with symbolic information resolved (see Documentation/oops-tracing.txt): No Message
 [6.] A small shell script or example program which triggers the problem (if possible) :
  Create 4 files a.txt, b.txt, c.txt, d.txt of verying sizes ( mine was 1MB , 10 MB, 15 MB,10 KB respectively). 
 Compile and Run following snippet

#include <sys/mman.h>
#include <iostream.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

#define MEM_MULTIPLIER 1

int main()
{
    char *mapAddress = NULL;
    int length = 10000526;
    int status =0 ;
    sleep(10 );     // start top on other terminal with this pid to watch size growth
    int fd = 0;
    for( int i = 0 ; i<6 ; i++) //arbitrary number of iterations
    {
      {

              fd = open("./a.txt", O_RDONLY);
              if (fd == -1)
              {
                  cout<<" Could Not open a.txt"<<endl;
                  return 1;
             }
             mapAddress = (char*) mmap(0, length, PROT_READ, MAP_SHARED, fd, 0);
             if (mapAddress == (char*)-1)
             {
                  cout<<" Map Failed for a.txt "<<endl ;
                  mapAddress = NULL;
                  return 1;
             }
             madvise(mapAddress,length,MADV_SEQUENTIAL);
             cout<<"Watch out the size now after mapping a.txt"<<endl;
             sleep(4);
             close(fd);    
             st = munmap(mapAddress, length);
             if (status != 0)
             {
                 cout<<"Failed Unmap: "<<endl ;
                 return 1 ;
            }

            cout<<"Watch out the size now after unmapping a.txt"<<endl;
            sleep(4);
            mapAddress = NULL;
      }
      {
           int fd = open("./b.txt", O_RDONLY);
           if (fd == -1)
           {
               cout<<" Could Not open b.txt"<<endl;
               return 1;
           }
           mapAddress = (char*)mmap(0, length, PROT_READ, MAP_SHARED, fd, 0);
           if (mapAddress == (char*)-1)
           {
               cout<<"Failed Mmap: "<<endl ;
               return 1;
           }
          cout<<"Watch out the size now after mapping b.txt"<<endl;
          sleep(4);
          close(fd);
          status = munmap(mapAddress, length);
         if (status != 0)
         {
         
            cout<<" Unmapped faild "<<endl;
            return 1;
        }
        cout<<"Watch out the size now after unmapping b.txt"<<endl;
       sleep(4);
       mapAddress = NULL;
    }
   {
       length = length* MEM_MULTIPLIER ;
       int fd = open("./c.txt", O_RDONLY);
      if (fd == -1)
      {
        cout<<" Could Not open c.txt"<<endl;
        return 1;
       }
      mapAddress = (char*)mmap(0, length, PROT_READ, MAP_SHARED, fd, 0);
      if (mapAddress == (char*)-1)
       {
           cout<<" Map Failed for a.txt "<<endl ;
            return 1;
        }
         
       cout<<"Watch out the size now after mapping c.txt"<<endl;
       sleep(4);
       close(fd);
        status = munmap(mapAddress, length);
       if (status != 0 )
       {
          cout<<" Unmapped faild "<<endl;
          return 1;
        }
       cout<<"Watch out the size now after unmapping c.txt"<<endl;
       sleep(4);
       mapAddress = NULL;
   }
   {
       length = length* MEM_MULTIPLIER ;
       cout<<"Watch out the size now before mapping d.txt for size "<<length <<endl;
       sleep(4);

      int fd = open("./d.txt", O_RDONLY);
      if (fd == -1)
      {
        cout<<" Could Not open d.txt"<<endl;
        return 1;
       }
      mapAddress = (char*)mmap(0, length, PROT_READ, MAP_SHARED, fd, 0);
      if (mapAddress == (char*)-1)
       {
           cout<<" Map Failed for d.txt "<<endl ;
            return 1;
        }
       cout<<"Watch out the size now after mapping d.txt"<<endl;
       sleep(4);
       close(fd);
        st = munmap(mapAddress, length);
       if (st != 0)
       {
          cout<<" Unmapped faild "<<endl;
          return 1;
        }
       cout<<"Watch out the size now after unmapping d.txt"<<endl;
       sleep(4);
       mapAddress = NULL;
    }
 }
 sleep(10);
}

I checked with following options to see any effect on LINUX:

1) called  API :  madvise(mapAddress,length,MADV_SEQUENTIAL);
Observed no change in Behaviour

2) changed the third parameter of mmap() from  MAP_SHARED to MAP_PRIVATE
Observed no change in Behaviour

[7.] Environment [7.1.] Software (add the output of the ver_linux script here) 
[7.2.] Processor information (from /proc/cpuinfo):
processor   : 0
vendor_id   : GenuineIntel
cpu family  : 6
model       : 8
model name  : Pentium III (Coppermine)
stepping    : 6
cpu MHz     : 864.004
cache size  : 256 KB
physical id : 0
siblings    : 1
fdiv_bug    : no
hlt_bug     : no
f00f_bug    : no
coma_bug    : no
fpu     : yes
fpu_exception   : yes
cpuid level : 2
wp      : yes
flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips    : 1723.59

processor   : 1
vendor_id   : GenuineIntel
cpu family  : 6
model       : 8
model name  : Pentium III (Coppermine)
stepping    : 6
cpu MHz     : 864.004
cache size  : 256 KB
physical id : 0
siblings    : 1
fdiv_bug    : no
hlt_bug     : no
f00f_bug    : no
coma_bug    : no
fpu     : yes
fpu_exception   : yes
cpuid level : 2
wp      : yes
flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips    : 1723.59

 [7.3.] Module information (from /proc/modules): 
soundcore               7044   0 (autoclean)
parport_pc             19236   1 (autoclean)
lp                      9188   0 (autoclean)
parport                39040   1 (autoclean) [parport_pc lp]
mvfs                  346624  44
autofs                 13780   4 (autoclean)
nfs                    84600  14 (autoclean)
lockd                  59248   1 (autoclean) [nfs]
sunrpc                 87324   1 (autoclean) [mvfs nfs lockd]
iptable_filter          2444   0 (autoclean) (unused)
ip_tables              15992   1 [iptable_filter]
e100                   56356   1
sg                     37548   0 (autoclean)
sr_mod                 18168   0 (autoclean)
cdrom                  34144   0 (autoclean) [sr_mod]
keybdev                 2976   0 (unused)
mousedev                5688   1
hid                    22436   0 (unused)
input                   6208   0 [keybdev mousedev hid]
usb-ohci               22152   0 (unused)
usbcore                83008   1 [hid usb-ohci]
xfs                   644064   2
aacraid                32740   3
aic7xxx               142516   0
sd_mod                 13452   6
scsi_mod              110712   5 [sg sr_mod aacraid aic7xxx sd_mod]
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
 /proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #0a
  acc0-acdf : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#5)
    acc0-acdf : e100
  ace0-acff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#4)
    ace0-acff : e100
b000-bfff : PCI Bus #09
  bcc0-bcdf : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
    bcc0-bcdf : e100
  bce0-bcff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
    bce0-bcff : e100
c000-cfff : PCI Bus #07
  c400-c4ff : Adaptec AIC-7880U
  c800-c8ff : Adaptec RAID subsystem HBA (#2)
  cc00-ccff : Adaptec RAID subsystem HBA
f800-f8ff : ATI Technologies Inc 3D Rage IIC
fcc0-fcff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fcc0-fcff : e100
/proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc1ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffdfff : System RAM
  00100000-0029a802 : Kernel code
  0029a803-003c935f : Kernel data
3fffe000-3fffffff : reserved
ef700000-ef7fffff : PCI Bus #0a
  ef7fe000-ef7fefff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#5)
    ef7fe000-ef7fefff : e100
  ef7ff000-ef7fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#4)
    ef7ff000-ef7fffff : e100
ef800000-ef8fffff : PCI Bus #09
  ef8fe000-ef8fefff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
    ef8fe000-ef8fefff : e100
  ef8ff000-ef8fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
    ef8ff000-ef8fffff : e100
efa00000-efcfffff : PCI Bus #0a
  efa00000-efafffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#5)
    efa00000-efafffff : e100
  efb00000-efbfffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#4)
    efb00000-efbfffff : e100
efd00000-efffffff : PCI Bus #09
  efd00000-efdfffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
    efd00000-efdfffff : e100
  efe00000-efefffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
    efe00000-efefffff : e100
f0000000-f7ffffff : Dell Computer Corporation PowerEdge Expandable RAID Controller 3
fbd00000-fbefffff : PCI Bus #07
  fbdfd000-fbdfdfff : Adaptec AIC-7880U
    fbdfd000-fbdfdfff : aic7xxx
  fbdfe000-fbdfefff : Adaptec RAID subsystem HBA (#2)
  fbdff000-fbdfffff : Adaptec RAID subsystem HBA
fd000000-fdffffff : ATI Technologies Inc 3D Rage IIC
fe900000-fe9fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fe900000-fe9fffff : e100
feb00000-feb00fff : ServerWorks OSB4/CSB5 OHCI USB Controller
  feb00000-feb00fff : usb-ohci
feb01000-feb01fff : ATI Technologies Inc 3D Rage IIC
feb02000-feb02fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  feb02000-feb02fff : e100
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved                                                                                                                                                                                                                          
                                                                                                                                                                       
                                                                                              

[7.5.] PCI information ('lspci -vvv' as root) [7.6.] SCSI information (from /proc/scsi/scsi) 
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 48, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 48, cache line size 08

00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Dell Computer Corporation PowerEdge 2550
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at feb02000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at fcc0 [size=64]
        Region 2: Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at fea00000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:06.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC (rev 7a) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 009a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at f800 [size=256]
        Region 2: Memory at feb01000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
        Subsystem: ServerWorks OSB4 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=4K]

00:11.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 48, cache line size 08

00:11.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 48, cache line size 08

06:04.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Bus: primary=06, secondary=07, subordinate=07, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fbd00000-fbefffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

06:04.1 RAID bus controller: Dell Computer Corporation PowerEdge Expandable RAID Controller 3 (rev 02)
        Subsystem: Dell Computer Corporation PowerEdge Expandable RAID Controller 3/Di
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 31
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at fbc00000 [disabled] [size=64K]

07:04.0 SCSI storage controller: Adaptec RAID subsystem HBA (rev 01)
        Subsystem: Dell Computer Corporation PowerEdge 2550
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 31
        BIST result: 00
        Region 0: I/O ports at cc00 [size=256]
        Region 1: Memory at fbdff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at fbe00000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
07:04.1 SCSI storage controller: Adaptec RAID subsystem HBA (rev 01)
        Subsystem: Dell Computer Corporation PowerEdge 2550
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin B routed to IRQ 24
        BIST result: 00
        Region 0: I/O ports at c800 [size=256]
        Region 1: Memory at fbdfe000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at fbe00000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

07:06.0 SCSI storage controller: Adaptec AIC-7880U (rev 02)
        Subsystem: Adaptec AIC-7880P Ultra/Ultra Wide SCSI Chipset
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 25
        Region 0: I/O ports at c400 [disabled] [size=256]
        Region 1: Memory at fbdfd000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fbe00000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

08:04.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=08, secondary=09, subordinate=09, sec-latency=32
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: efd00000-efffffff
        Prefetchable memory behind bridge: 00000000ef800000-00000000ef800000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

08:06.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Bus: primary=08, secondary=0a, subordinate=0a, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: efa00000-efcfffff
        Prefetchable memory behind bridge: 00000000ef700000-00000000ef700000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
09:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Dual Port Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at ef8ff000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at bce0 [size=32]
        Region 2: Memory at efe00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at eff00000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

09:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Dual Port Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at ef8fe000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at bcc0 [size=32]
        Region 2: Memory at efd00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at eff00000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0a:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Dual Port Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at ef7ff000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at ace0 [size=32]
        Region 2: Memory at efb00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at efc00000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
              Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0a:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Dual Port Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at ef7fe000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at acc0 [size=32]
        Region 2: Memory at efa00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at efc00000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi) 
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: HITACHI  Model: DVD-RAM GF-2050  Rev: E271
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: DELL     Model: PERCRAID RAID5   Rev: V1.0
  Type:   Direct-Access                    ANSI SCSI revision: 02




> Regards
> Rajneesh Kumar
> 
> GSP, GEMS-GTO
> GE Medical Systems
> John F Welch Technology Center
> #152, EPIP. Phase 2
> Whitefield, Bangalore.560 066
> 
> Ph :          91-80 - 2503 3412
> mail:       rajneesh.kumar@med.ge.com
> 
> 
> 
