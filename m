Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264850AbSJPDvz>; Tue, 15 Oct 2002 23:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSJPDvz>; Tue, 15 Oct 2002 23:51:55 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:38020 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264850AbSJPDvs>; Tue, 15 Oct 2002 23:51:48 -0400
From: "Tervel Atanassov" <noxidog@earthlink.net>
To: <linux-kernel@vger.kernel.org>
Subject: aio bug report
Date: Tue, 15 Oct 2002 20:58:01 -0700
Message-ID: <004101c274c8$3d2e2230$0e00000a@turchodog>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
Completed asynchronous I/O WRITES are blocked by uncompleted
asynchronous I/O WRITES for sockets.
 
[2.] Full description of the problem/report:
Under Windows, one can issue both asynchronous writes and reads
concurrently on the same handle and which ever one completes first is
the one that gets passed to the signal handler thread.  Under Linux, I
do a similar strategy where the completions are handled in a signal
handler function which routes the signal to the waiting worker threads -
I am trying to keep the same exact interfaces for both the windows and
the Linux version.  However, I have debugged my problem and it comes
down to the fact that under Linux the read which is posted before the
write keeps the completed write signal from being handled until a read
actually completes.  So what happens is:
 
1.                   a read request gets posted
2.                   a write request gets posted
3.                   nothing happens until the client on the other side
of the socket actually writes something, which causes the read from (1)
to complete.
4.                   right after that the write signal comes to the
signal handler code.  I am certain however that the write has competed a
long time ago because the client has received the message.
 
So, is this how aio* is supposed to work, or is there still a bug in the
aio code?  I wrote my code on the Linux side based upon the POSIX.4 book
by O'Reilly.  Unfortunately the example illustrates a thread doing only
writes and only reads, not the two interlaced.
 
Thanks for your help,
 
Tervel Atanassov
 
[3.] Keywords (i.e., modules, networking, kernel):
networking, asynchronous I/O, aio_read, aio_write, signal, sockets
 
[4.] Kernel version (from /proc/version):
Linux version 2.5.42 (root@chichibird) (gcc version 3.2) #1 SMP Sun Oct
13 22:26:19 PDT 2002
 
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
 
[6.] A small shell script or example program which triggers the
     problem (if possible)
 
[7.] Environment
 
[7.1.] Software (add the output of the ver_linux script here) my own
asynchronous i/o socket server. Linux chichibird 2.5.42 #1 SMP Sun Oct
13 22:26:19 PDT 2002 i686 unknown
 
Gnu C                  gcc (GCC) 3.2 Copyright (C) 2002 Free Software
Foundation, Inc. This is free software; see the source for copying
conditions. There is NO warranty; not even for MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.28
PPP                    2.4.1
isdn4k-utils           3.2p1
Linux C Library        10 09:51 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Linux C++ Library      5.0.0
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         
 
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 669.583
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1323.00
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 669.583
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1335.29
 
[7.3.] Module information (from /proc/modules):
<nothing>
 
[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
/proc/ioports
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
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
9400-941f : Intel Corp. 82801AA USB
  9400-941f : uhci-hcd
9800-980f : Intel Corp. 82801AA IDE
  9800-9807 : ide0
  9808-980f : ide1
a800-a8ff : Adaptec AHA-2940U/UW/D / AIC-7881U
  a800-a8ff : aic7xxx
b000-b007 : Creative Labs SB Live! MIDI/Game Port
b400-b41f : Creative Labs SB Live! EMU10k1
b800-b8ff : D-Link System Inc RTL8139 Ethernet
  b800-b8ff : 8139too
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X e800-e80f :
Intel Corp. 82801AA SMBus
 
/proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cefff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffbfff : System RAM
  00100000-0040b990 : Kernel code
  0040b991-004fc7cf : Kernel data
0fffc000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
cc800000-cc800fff : Adaptec AHA-2940U/UW/D / AIC-7881U
  cc800000-cc800fff : aic7xxx
cd000000-cd0000ff : D-Link System Inc RTL8139 Ethernet
  cd000000-cd0000ff : 8139too
cd800000-cfdfffff : PCI Bus #01
  cd800000-cd800fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
  ce000000-ceffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
cff00000-cfffffff : PCI Bus #01 d0000000-dfffffff : Intel Corp. 82820
820 (Camino) Chipset Host Bridge
(MCH)
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
 
[7.5.] PCI information ('lspci -vvv' as root)
 
[7.6.] SCSI information (from /proc/scsi/scsi)
 
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
 
[X.] Other notes, patches, fixes, workarounds:

