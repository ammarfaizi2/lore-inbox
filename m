Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWELJor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWELJor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 05:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWELJor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 05:44:47 -0400
Received: from mallorn.ii.uj.edu.pl ([149.156.65.90]:14761 "EHLO
	mallorn.ii.uj.edu.pl") by vger.kernel.org with ESMTP
	id S1750914AbWELJoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 05:44:46 -0400
Message-ID: <44645908.3000109@mallorn.ii.uj.edu.pl>
Date: Fri, 12 May 2006 11:44:40 +0200
From: =?ISO-8859-2?Q?Pawe=B3_Jaworski?= <paweusz@mallorn.ii.uj.edu.pl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: i am totally stumped <linux-kernel@vger.kernel.org>
Cc: paweusz@mallorn.ii.uj.edu.pl
Subject: Kernel network layer breakes recv_from() as the server (i think)
 (kernel-bug)
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ brief-problem
Kernel network layer breakes recv_from() as the server (i think)

$ full-problem
I am student of Jagiellonian University of Cracow. Recently I've been trying to 
write some network programs as a learning of network protocols. Everything went 
fine except for UDP. I was trying to send a structure through the UDP protocol 
to the server. Every time I was sending a packet, recv_from() returned "Invalid 
argument". As it was my homework, i brought the program to my teacher, but... it 
worked well on systems in my school.

1. It worked on Linux Mandrake (i think) 10
2. It worked on Debian Sarge with kernel-image-2.4.27-2-686-smp
3. It worked on Debian Sarge with kernel-image-2.6.8-2
4. It worked on IRIX (i know it's not Linux, but... it worked)

It didn't work on Debian Sarge kernels 2.6.14 (my friend tested), 2.6.15(me) and 
2.6.16 (also me)

As I am currently working on 2.6.15 (and 2.6.16 was installed only for testing 
of UDP) - i send info about 2.6.15, and WORKED on kernel 2.6.x

Btw. I use some packages from backports.org (this is not exactly sarge), but I 
tested compiled program from other systems (mandrake, pure debian sarge) and it 
didn't work.

$ keywords
networking, kernel

$ cat /proc/version
Linux version 2.6.15-1-k7 (Debian 2.6.15-7bpo1) (nobse@debian.org) (gcc version 
3.3.5 (Debian 1:3.3.5-13)) #2 Tue Mar 7 02:52:03 CET 2006

$ cat str.h
#ifndef _STR_H_
#define _STR_H_

#define MAX_PACKET 1024

typedef struct __packet_ {
   unsigned int nr;
   unsigned short len;
   char buf[ MAX_PACKET ];
} packet;


#endif /* _STR_H_ */

$ cat server.c
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h> /* clock() */

#include <netdb.h>

#include "str.h"

#define boolean unsigned char
#define false 0
#define true 1
#define MAX_PACKETS 65535
#define TIMEOUT 1
#define MAX_ERRORS 10

#ifndef socklen_t
#define socklen_t int
#endif /* socklen_t */

#include <signal.h>
int stats[256];

void interrupt_handler() {
   FILE* f;
   int i;

   f = fopen( "stats.txt", "w+" );
   for (i=0; i<256; i++) {
     fprintf( f, "Znak: %d wystapien: %d\n", i, stats[i] );
   }
   fclose( f );
   printf( "Zapisano statystyke\n" );
   exit(0);
}

void initCount() {
   int i;
   for (i = 0; i<256; i++) {
     stats[i] = 0;
   }
}

void countChars( char* s, int len ) {
   int p;

   p = 0;
   while ( p < len ) {
     stats[(unsigned char) s[p]]++;
     p++;
   }
}


clock_t MAX_CLOCK_T = (clock_t)-1;
unsigned int CLOCK_LEN; /* dlugosc przedzialu zegara */

unsigned int clock_diff( clock_t from, clock_t to ) {
   return (to - from + MAX_CLOCK_T) % MAX_CLOCK_T;
}

void changeCase( char* s, int len ) {
   int p = 0;
   while (p<len) {
     if ((s[p]>='A') && (s[p]<='Z')) { s[p] = s[p]+32; }
     else if ((s[p]>='a') && (s[p]<='z')) { s[p] = s[p]-32; }
     p++;
   }
}


int main( int argc, char** argv ) {

   struct sockaddr_in cli_address;
   struct sockaddr_in serv_address;
   int s;
   int port;
   packet p;

   initCount();
   if (signal( SIGINT, interrupt_handler ) == SIG_ERR) {
     printf( "Blad przechwytywacza sygnalu SIGINT\n" );
   };


   if ( argc < 2 )
   {
     printf( "Syntax error: %s <port>\n", argv[0] );
     exit( 1 );
   }

   memset(&serv_address, 0, sizeof(serv_address)); /* na wszelki wypadek wyzeruj 
calosc */
   port = atol( argv[1] );
   printf( "Port: %d\n", port );

   /* tworzy gniazdo UDP */
   s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
   if ( s == -1 ) { perror( "Socket error" ); exit( 2 ); }

   /* przygotuj strukture zawierajaca nr portu, na którym chcemy nasluchiwac */
   memset(&serv_address, 0, sizeof(serv_address));
   serv_address.sin_family = AF_INET;
   serv_address.sin_addr.s_addr = htonl(INADDR_ANY);
   serv_address.sin_port = htons(port);

   /* zwiaz lokalny koniec gniazda z przygotowanym adresem */
   if ( bind(s, (struct sockaddr *) &serv_address, sizeof(serv_address)) == -1 ) {
     perror( "Cannot bind socket" );
     exit(1);
   };

   while (1)
   {
     int rd;
     int i;
     socklen_t from_size;

     rd = recvfrom( s, (char*)&p, sizeof(p), 0, (struct sockaddr *)&cli_address, 
&from_size);
     printf("Received packet from %s:%d\n\n",
            inet_ntoa(cli_address.sin_addr), ntohs(cli_address.sin_port));
     if ( rd == -1 ) { perror( "recvfrom() failed\n" ); exit( 3 ); }
     if ( rd != sizeof(packet)) {
       printf( "Bad size of packet\n" );
     }
                 countChars( p.buf, ntohs(p.len) );
     changeCase( p.buf, ntohs(p.len) );

     sendto( s, &p, sizeof(p), 0, (struct sockaddr *)&cli_address, (size_t) 
sizeof(cli_address) );
   }

   return 0;
}


$ cat client.c
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h> /* clock() */

#include <netdb.h>

#include <stropts.h> /* ioctl */

#include "str.h"

#ifndef socklen_t
#define socklen_t int
#endif /* socklen_t */

#define boolean unsigned char
#define false 0
#define true 1
#define MAX_PACKETS 65535
#define TIMEOUT 1
#define MAX_ERRORS 10



clock_t MAX_CLOCK_T = (clock_t)-1;
unsigned int CLOCK_LEN; /* dlugosc przedzialu zegara */

unsigned int clock_diff( clock_t from, clock_t to ) {
   if ( from > to ) { return MAX_CLOCK_T - from + to; }
   return (to - from);
}

int try_to_relay( int s, char* buf, int len, struct sockaddr_in address,  void* 
answer ) {
   int wr;
   int rd;
   clock_t start_clock;
   static int packet_number = 0;
   packet p;
   packet p_answer;
   socklen_t from_size;

   if ( len > MAX_PACKET ) return -1;

   packet_number++;

   p.nr = packet_number;
   p.len = htons(len);
   memcpy( p.buf, buf, len );

   printf("Sending\n");
   wr = sendto(s, &p, sizeof(p), 0, (struct sockaddr *)&address, (size_t) 
sizeof(address));

   if (wr != sizeof(p)) {
     printf( "ERROR sending\n" );
     return -1;
   }

   start_clock = clock();

   /* czekanie */
   while (clock_diff(start_clock, clock()) < CLOCKS_PER_SEC * TIMEOUT) {
     rd = recvfrom( s, &p_answer, sizeof(p_answer), 0, (struct sockaddr 
*)&address, &from_size);
     if ( rd == sizeof(p_answer)) {
       if ( p_answer.nr == packet_number ) {
         p_answer.len = ntohs( p_answer.len );
         if ( p_answer.len == len ) {
           memcpy( answer, p_answer.buf, len );
           return 0;
         }
         else {
           printf( "Good packet number, but corrupted length.\n" );
           exit(1);
         }
       }
     }
   }
   printf( "Timeout has been exceeded for packet %d\n", packet_number );
   return -2;
}

int main( int argc, char** argv ) {

   struct sockaddr_in address;
   int s;
   int r;
   FILE* f;
   FILE* g;
   int f_fd;
   int fionbio_int;

   memset(&address, 0, sizeof(address)); /* na wszelki wypadek wyzeruj calosc */
   address.sin_family = AF_INET;

   if ( argc < 3 )
   {
     printf( "Syntax error: %s <server addresss> <port>\n", argv[0] );
     exit( 1 );
   }

   if (argc>1)
   {
       struct hostent *h;

       h = gethostbyname(argv[1]);
       if (h == NULL)
       {
         printf("Could not solve the host address %s\n", argv[1]);
         exit(1);
       };
       memcpy(&address.sin_addr, h->h_addr, 4);
   }

   address.sin_port = htons(atol(argv[2]));

   s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
         fionbio_int = 1;
   ioctl( s, FIONBIO, &fionbio_int );

   f = fopen( "in.txt", "r" );
   f_fd = fileno( f );
   if ( f == NULL )
   {
      printf( "Could not open 'in.txt' file for reading\n" );
   }
   g = fopen( "out.txt", "w+" );
   if ( g == NULL )
   {
     printf( "Could not open 'out.txt' for writing\n" );
   }

   while (!feof(f))
   {
     int i;
     int pos;
     int c;
     char buf[MAX_PACKET];
     char buf_out[MAX_PACKET];
     int errors;

     pos = 0;
     errors = 0;

     for (i = 0; i<MAX_PACKET; i++) {
       if ( (c = fgetc( f ))==EOF ) { break; }
       buf[ pos ] = c;
       pos++;
     }
     while( try_to_relay( s, buf, pos, address, buf_out ) != 0 ) {
       errors++;
       if ( errors > MAX_ERRORS ) {
         printf( "Maximum number of errors exceeded\n" );
         exit(2);
       };
     }
     for (i=0; i<pos; i++) {
       fputc( buf_out[i], g );
     }
   }
   printf( "EOF\n" );
   fclose( f );
   fclose( g );
   close( s );

   return 0;
}

$ scripts/ver_linux
Linux paweusz 2.6.15-1-k7 #2 Tue Mar 7 02:52:03 CET 2006 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.81
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2.2
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.3
nfs-utils              1.0.7
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   089
Modules Loaded         ipv6 lp nls_cp437 vfat fat nls_iso8859_1 ntfs nvidia 
usblp joydev parport_pc parport snd_ens1371 snd_rawmidi snd_seq_device 
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore 
snd_page_alloc snd_ac97_bus ehci_hcd ide_cd floppy rtc amd64_agp agpgart 
i2c_nforce2 ohci_hcd cdrom forcedeth psmouse analog usbcore i2c_core pcspkr 
serio_raw shpchp pci_hotplug gameport ext3 jbd mbcache ide_disk ide_generic 
amd74xx generic ide_core sata_nv libata scsi_mod evdev mousedev

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 4
model name      : AMD Athlon(tm) 64 Processor 2800+
stepping        : 8
cpu MHz         : 1808.679
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 3620.09

$ cat /proc/modules
ipv6 230080 10 - Live 0xe0bad000
lp 11012 0 - Live 0xe0b53000
nls_cp437 5824 2 - Live 0xe0b13000
vfat 12288 2 - Live 0xe0b18000
fat 47836 1 vfat, Live 0xe0b5d000
nls_iso8859_1 4160 3 - Live 0xe09fd000
ntfs 200208 1 - Live 0xe0b1c000
nvidia 4091216 12 - Live 0xe0f0f000
usblp 12160 0 - Live 0xe08bf000
joydev 9408 0 - Live 0xe097a000
parport_pc 33028 1 - Live 0xe0a10000
parport 33160 2 lp,parport_pc, Live 0xe0a1b000
snd_ens1371 22368 1 - Live 0xe0a09000
snd_rawmidi 23264 1 snd_ens1371, Live 0xe0a02000
snd_seq_device 8396 1 snd_rawmidi, Live 0xe0920000
snd_ac97_codec 83488 1 snd_ens1371, Live 0xe09c0000
snd_pcm_oss 46944 0 - Live 0xe09ed000
snd_mixer_oss 16576 1 snd_pcm_oss, Live 0xe09a1000
snd_pcm 79048 3 snd_ens1371,snd_ac97_codec,snd_pcm_oss, Live 0xe09d8000
snd_timer 22148 1 snd_pcm, Live 0xe09a9000
snd 50724 10 
snd_ens1371,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer, 
Live 0xe09b2000
soundcore 9312 1 snd, Live 0xe0953000
snd_page_alloc 10440 1 snd_pcm, Live 0xe094f000
snd_ac97_bus 2304 1 snd_ac97_codec, Live 0xe094d000
ehci_hcd 29640 0 - Live 0xe0957000
ide_cd 39172 0 - Live 0xe096f000
floppy 57092 0 - Live 0xe0960000
rtc 11892 0 - Live 0xe091c000
amd64_agp 12036 1 - Live 0xe08bb000
agpgart 33096 2 nvidia,amd64_agp, Live 0xe0943000
i2c_nforce2 6400 0 - Live 0xe087e000
ohci_hcd 18564 0 - Live 0xe0901000
cdrom 36576 1 ide_cd, Live 0xe090d000
forcedeth 20804 0 - Live 0xe08c3000
psmouse 33796 0 - Live 0xe08d6000
analog 10592 0 - Live 0xe0881000
usbcore 117636 4 usblp,ehci_hcd,ohci_hcd, Live 0xe0925000
i2c_core 19984 1 i2c_nforce2, Live 0xe0871000
pcspkr 1924 0 - Live 0xe082b000
serio_raw 6916 0 - Live 0xe0802000
shpchp 42752 0 - Live 0xe08ca000
pci_hotplug 26228 1 shpchp, Live 0xe0886000
gameport 14536 2 snd_ens1371,analog, Live 0xe0877000
ext3 126792 2 - Live 0xe08e1000
jbd 51028 1 ext3, Live 0xe08ad000
mbcache 8964 1 ext3, Live 0xe0842000
ide_disk 16320 7 - Live 0xe0848000
ide_generic 1408 0 [permanent], Live 0xe0827000
amd74xx 13468 0 [permanent], Live 0xe082d000
generic 4612 0 [permanent], Live 0xe0805000
ide_core 116000 5 ide_cd,ide_disk,ide_generic,amd74xx,generic, Live 0xe088f000
sata_nv 9220 0 - Live 0xe0823000
libata 53132 1 sata_nv, Live 0xe0834000
scsi_mod 135784 1 libata, Live 0xe084e000
evdev 9216 0 - Live 0xe081f000
mousedev 11232 1 - Live 0xe081b000

$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0970-0977 : 0000:00:0a.0
   0970-0977 : sata_nv
09f0-09f7 : 0000:00:0a.0
   09f0-09f7 : sata_nv
0b70-0b73 : 0000:00:0a.0
   0b70-0b73 : sata_nv
0bf0-0bf3 : 0000:00:0a.0
   0bf0-0bf3 : sata_nv
0cf8-0cff : PCI conf1
1000-107f : motherboard
   1000-1003 : PM1a_EVT_BLK
   1004-1005 : PM1a_CNT_BLK
   1008-100b : PM_TMR
   1020-1027 : GPE0_BLK
1080-10ff : motherboard
   1080-10ff : pnp 00:00
1400-147f : motherboard
   1400-147f : pnp 00:00
1480-14ff : motherboard
   14a0-14af : GPE1_BLK
1800-187f : motherboard
   1800-187f : pnp 00:00
1880-18ff : motherboard
   1880-18ff : pnp 00:00
1c00-1c3f : 0000:00:01.1
   1c00-1c07 : nForce2_smbus
2000-203f : 0000:00:01.1
   2000-2007 : nForce2_smbus
9000-9fff : PCI Bus #02
   9000-903f : 0000:02:0a.0
     9000-903f : Ensoniq AudioPCI
a800-a807 : 0000:00:05.0
   a800-a807 : forcedeth
c400-c40f : 0000:00:0a.0
   c400-c40f : sata_nv
c800-c87f : 0000:00:0a.0
   c800-c87f : sata_nv
cc00-cc1f : 0000:00:01.1
f000-f00f : 0000:00:08.0
   f000-f007 : ide0
   f008-f00f : ide1

$ cat /proc/iomem
00000000-0009f7ff : System RAM
   00000000-00000000 : Crash kernel
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf7ff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
   00100000-0026e97c : Kernel code
   0026e97d-00303f03 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e8000000-efffffff : 0000:00:00.0
   e8000000-efffffff : aperture
f0000000-f7ffffff : PCI Bus #01
   f0000000-f7ffffff : 0000:01:00.0
f8000000-f9ffffff : PCI Bus #01
   f8000000-f8ffffff : 0000:01:00.0
     f8000000-f8ffffff : nvidia
   f9000000-f901ffff : 0000:01:00.0
fa000000-fa0000ff : 0000:00:02.2
   fa000000-fa0000ff : ehci_hcd
fa001000-fa001fff : 0000:00:05.0
   fa001000-fa001fff : forcedeth
fa003000-fa003fff : 0000:00:02.0
   fa003000-fa003fff : ohci_hcd
fa004000-fa004fff : 0000:00:02.1
   fa004000-fa004fff : ohci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

# lspci -vvv
0000:00:00.0 Host bridge: nVidia Corporation: Unknown device 00e1 (rev a1)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [44] #08 [01c0]
         Capabilities: [c0] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 00e0 (rev a2)
         Subsystem: Giga-byte Technology: Unknown device 0c11
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Latency: 0

0000:00:01.1 SMBus: nVidia Corporation: Unknown device 00e4 (rev a1)
         Subsystem: Giga-byte Technology: Unknown device 0c11
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at cc00 [size=32]
         Region 4: I/O ports at 1c00 [size=64]
         Region 5: I/O ports at 2000 [size=64]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation: Unknown device 00e7 (rev a1) 
(prog-if 10 [OHCI])
         Subsystem: Giga-byte Technology: Unknown device 5004
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 193
         Region 0: Memory at fa003000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation: Unknown device 00e7 (rev a1) 
(prog-if 10 [OHCI])
         Subsystem: Giga-byte Technology: Unknown device 5004
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin B routed to IRQ 177
         Region 0: Memory at fa004000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.2 USB Controller: nVidia Corporation: Unknown device 00e8 (rev a2) 
(prog-if 20 [EHCI])
         Subsystem: Giga-byte Technology: Unknown device 5004
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin C routed to IRQ 185
         Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [44] #0a [2098]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:05.0 Bridge: nVidia Corporation: Unknown device 00df (rev a2)
         Subsystem: Giga-byte Technology: Unknown device e000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Latency: 0 (250ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 185
         Region 0: Memory at fa001000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at a800 [size=8]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:00:08.0 IDE interface: nVidia Corporation: Unknown device 00e5 (rev a2) 
(prog-if 8a [Master SecP PriP])
         Subsystem: Giga-byte Technology: Unknown device 5002
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Region 4: I/O ports at f000 [size=16]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0a.0 IDE interface: nVidia Corporation: Unknown device 00e3 (rev a2) 
(prog-if 85 [Master SecO PriO])
         Subsystem: Giga-byte Technology: Unknown device b002
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 177
         Region 0: I/O ports at 09f0 [size=8]
         Region 1: I/O ports at 0bf0 [size=4]
         Region 2: I/O ports at 0970 [size=8]
         Region 3: I/O ports at 0b70 [size=4]
         Region 4: I/O ports at c400 [size=16]
         Region 5: I/O ports at c800 [size=128]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.0 PCI bridge: nVidia Corporation: Unknown device 00e2 (rev a2) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 16
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=10
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: f8000000-f9ffffff
         Prefetchable memory behind bridge: f0000000-f7ffffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:0e.0 PCI bridge: nVidia Corporation: Unknown device 00ed (rev a2) 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=128
         I/O behind bridge: 00009000-00009fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
         Capabilities: [80] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 
5200] (rev a1) (prog-if 00 [VGA])
         Subsystem: PROLINK Microsystems Corp: Unknown device 1152
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 209
         Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at f9000000 [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3+ Rate=x4,x8
                 Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8

0000:02:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
         Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ 
<MAbort+ >SERR- <PERR-
         Latency: 32 (3000ns min, 32000ns max)
         Interrupt: pin A routed to IRQ 201
         Region 0: I/O ports at 9000 [size=64]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

$ cat /proc/scsi/scsi
Attached devices:

$ workarounds
My friend told me the program works when he creates

char buff[xxxx]; /* xxxx - size of the structure */

and recv_from puts data to this buffer and he memcpys that to the structure.

When I was trying to test it I used dynamic array:

char* buff = malloc(sizeof(packet));

and it also didn't work.

$ thanks
Thanks for reading my e-mail. I'm sorry if it isn't kernel bug - i don't know 
where to post it to. Please tell me if applies. Hope to hear from you soon.
Pawel Jaworski <paweusz@mallorn.ii.uj.edu.pl>

