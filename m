Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266166AbRGQMCl>; Tue, 17 Jul 2001 08:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266164AbRGQMCc>; Tue, 17 Jul 2001 08:02:32 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:43794 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266161AbRGQMCY> convert rfc822-to-8bit; Tue, 17 Jul 2001 08:02:24 -0400
Message-ID: <3B54293F.DA675AD3@aixigo.de>
Date: Tue, 17 Jul 2001 14:02:07 +0200
From: Tobias Haustein <tobias.haustein@aixigo.de>
Organization: aixigo AG
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: _List: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: alarm() does not work/ping only sends one packet on SMP machine (2.2.16)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've got a problem on a production database server (SuSE Linux 7.0,
Kernel 2.2.16 SMP). On this machine, a ping to any network (also ping
localhost) does only send one packet. However, a ping -l 10 sends
exactly 11 packets. Thus, the problem seems not to be the network, but
another part of the system. I've tracked the problem down to the alarm()
function. The following program runs forever:

---
#include <unistd.h>

int main()
{
   alarm( 1 );

   while( 1 );
}
---

On any other machine, the program receives an SIGALRM, but on this
particular machine, nothing happens.


Question: What might be the cause for this?

Then, I think that the following is strange: There are two uptime
counters accessible through /proc/uptime. These counters show a
difference of about 28 hours! The difference is still growing, as the
following skript shows:

--
#!/bin/bash
while true; do =

   sleep 2
   echo -n `date`
   cat /proc/uptime | awk '{FS=3D" ";printf "  - %02d:%02d:%02d\n",
int(($1-$2)/3600), int(($1-$2)/60)%60, int(($1-$2)%60);}'
done
--

Output: =


Fri Jun 22 21:49:53 CEST 2001  - 28:30:40
Fri Jun 22 21:49:55 CEST 2001  - 28:30:40
Fri Jun 22 21:49:57 CEST 2001  - 28:30:41
Fri Jun 22 21:49:59 CEST 2001  - 28:30:41


Question: Is this normal?

Hardware: 2 x Pentium III, ServerWorks chipset on Intel board, 512 MB
RAM, GDT Vortex RAID, 3c905C-TX



-------------------------------------------------- =

Some info from /proc follows:
--------------------------------------------------
root # cat /proc/interrupts =

           CPU0       CPU1       =

  0: 1211049447          0          XT-PIC  timer
  1:          8          8    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          1    IO-APIC-edge  rtc
 12:          0          0    IO-APIC-edge  PS/2 Mouse
 13:          1          0          XT-PIC  fpu
 15:       7708       8516    IO-APIC-edge  ide1
 18:   25888364   26299521   IO-APIC-level  gdth
 20:   37673025   39437027   IO-APIC-level  eth0
 22:         20         20   IO-APIC-level  HiSax
 31:    3755190    4144920   IO-APIC-level  eth1
NMI:          0
ERR:          0

root # # cat /proc/cpuinfo =

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 799.643
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr xmm
bogomips        : 1595.80

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 799.643
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr xmm
bogomips        : 1599.08

root # cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  1:
    Host bridge: Unknown vendor CNB30LE PCI Bridge (rev 5).
      Medium devsel.  Master Capable.  Latency=3D16.  =

  Bus  0, device   0, function  0:
    Host bridge: Unknown vendor CNB30LE PCI Bridge (rev 5).
      Medium devsel.  Master Capable.  Latency=3D32.  =

  Bus  0, device   1, function  0:
    VGA compatible controller: ATI Unknown device (rev 122).
      Vendor id=3D1002. Device id=3D4756.
      Medium devsel.  Fast back-to-back capable.  IRQ 16.  Master
Capable.  Latency=3D64.  Min Gnt=3D8.
      Prefetchable 32 bit memory at 0xfd000000 [0xfd000008].
      I/O at 0xd800 [0xd801].
      Non-prefetchable 32 bit memory at 0xfeaff000 [0xfeaff000].
  Bus  0, device   2, function  0:
    SCSI storage controller: VORTEX Unknown device (rev 0).
      Vendor id=3D1119. Device id=3D139.
      Medium devsel.  Fast back-to-back capable.  IRQ 18.  Master
Capable.  Latency=3D64.  =

      Prefetchable 32 bit memory at 0xfe6fc000 [0xfe6fc008].
  Bus  0, device   3, function  0:
    Ethernet controller: 3Com Unknown device (rev 116).
      Vendor id=3D10b7. Device id=3D9200.
      Medium devsel.  IRQ 20.  Master Capable.  Latency=3D64.  Min
Gnt=3D10.Max Lat=3D10.
      I/O at 0xdc00 [0xdc01].
      Non-prefetchable 32 bit memory at 0xfeafef00 [0xfeafef00].
  Bus  0, device   4, function  0:
    Network controller: AVM A1 (Fritz) (rev 2).
      Medium devsel.  Fast back-to-back capable.  IRQ 22.  =

      Non-prefetchable 32 bit memory at 0xfeafefe0 [0xfeafefe0].
      I/O at 0xdf80 [0xdf81].
  Bus  0, device   6, function  0:
    Ethernet controller: Intel 82557 (rev 8).
      Medium devsel.  Fast back-to-back capable.  IRQ 31.  Master
Capable.  Latency=3D64.  Min Gnt=3D8.Max Lat=3D56.
      Non-prefetchable 32 bit memory at 0xfeaee000 [0xfeaee000].
      I/O at 0xd400 [0xd401].
      Non-prefetchable 32 bit memory at 0xfe900000 [0xfe900000].
  Bus  0, device  15, function  0:
    ISA bridge: Unknown vendor Unknown device (rev 79).
      Vendor id=3D1166. Device id=3D200.
      Medium devsel.  Master Capable.  No bursts.  =

  Bus  0, device  15, function  1:
    IDE interface: Unknown vendor Unknown device (rev 0).
      Vendor id=3D1166. Device id=3D211.
      Medium devsel.  Master Capable.  Latency=3D64.  =

      I/O at 0xffa0 [0xffa1].
  Bus  0, device  15, function  2:
    USB Controller: Unknown vendor Unknown device (rev 4).
      Vendor id=3D1166. Device id=3D220.
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master
Capable.  Latency=3D64.  Max Lat=3D80.
      Non-prefetchable 32 bit memory at 0xfeaef000 [0xfeaef000].
  Bus  1, device   3, function  0:
    SCSI storage controller: Adaptec AIC-7892 (rev 2).
      Medium devsel.  Fast back-to-back capable.  BIST capable.  IRQ
28.  Master Capable.  Latency=3D64.  Min Gnt=3D40.Max Lat=3D25.
      I/O at 0xe800 [0xe801].
      Non-prefetchable 64 bit memory at 0xfebff000 [0xfebff004].


--

Ciao,

Tobias 

--
Dipl. Inform. Tobias Haustein

aixigo AG - financial training, research and technology
Schloﬂ-Rahe-Straﬂe 15, 52072 Aachen, Germany
fon: +49 (0)241 936737-40, fax: +49 (0)241 936737-99
eMail: tobias.haustein@aixigo.de, web: http://www.aixigo.de
