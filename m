Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274067AbRISOPS>; Wed, 19 Sep 2001 10:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274068AbRISOO7>; Wed, 19 Sep 2001 10:14:59 -0400
Received: from pD951DE4B.dip.t-dialin.net ([217.81.222.75]:61670 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S274067AbRISOOs>;
	Wed, 19 Sep 2001 10:14:48 -0400
To: linux-kernel@vger.kernel.org
Subject: ISSUE: Heavy NFS brings (SMP) machine down in 2.4.9-ac10
From: Joachim Breuer <jmbreuer@gmx.net>
Date: 19 Sep 2001 16:15:10 +0200
Message-ID: <m3d74ncln5.fsf@terra.fo.et.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


[1.] One line summary of the problem:
        Heavy NFS brings (SMP) machine down in 2.4.9-ac10

[2.] Full description of the problem/report:

I was creating a largeish (12GB) tar, reading from a local disk and
writing to an NFS-mounted directory. Performance was about what I
expected (ca. 1MByte/s). About 15-25 Minutes into the process the NFS
server appeared to become congested (network load meter of my desktop
hub dropping rapidly); investigation showed the server (which could
still be ssh'd into) at load 7.something with one of the nfsds and
kupdated eating up all CPU they could get (and heavy disk thrashing
when I went to hake a look). At this point, the 'top' I used to gather
that information itself used up 50%-70% CPU. I interrupted (Ctrl-C)
the tar on the client (which took some time, as could be
expected). After the tar client had stopped the server did *not*
recover from the aforementioned condition (load 7.x, nfsd/kupdated
eating CPU, heavy disk thrashing) within 30 minutes. At that time I
decided to stop the nfs server (which was impossible) and then reboot
the server (which did not work cleanly, as well - only with Magic
SysRq and some patience I could sync/unmount/reboot).

netstat -au showed the RecvQ of nfsd with about 600000 entries (in one
case 715000), that number did not change *at all* until the reboot.

According to top, the machine used a stable 600-700k of swap during the
thrashing with 3.5MB memory free and 100-150MB of memory used for
cache/buffers; IMHO the thrashing seems fs-related.

I tried the same tar 2 more times, always encountering exactly these
same symptoms.

No other NFS clients were active during the whole process mentioned
above.

After switching to kernel 2.4.9 (no ac) on the server only (client
still using 2.4.9-ac10) the same tar completed without incident.

A possibly related (or not) effect is this: While rebooting the server
with the client in question active, but idle the client's load went up
to around 8 without any processes using up significant amounts of CPU
time (winner was 'top' at <3%), load normalised after it regained
connectivity with the NFS server. The client used 2.4.9-ac10 as well.


[3.] Keywords (i.e., modules, networking, kernel):
        nfs, SMP, kupdated

[4.] Kernel version (from /proc/version):

2.4.9-ac10, verbatim version line not available as the server
is "semi-production" and it's running 2.4.9 right now.

[5.] Output of Oops.. message with symbolic information resolved
       (see Kernel Mailing List FAQ, Section 1.5):
        N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

        tar cvf /mnt/server/foo.tar /local/tree/about/12GB/

[7.] Environment

The filesystem the server was writing to uses reiserfs, default
parameters. Client used same kernel version as server, reading from an
ext2 filesystem.

Both filesystems (client and server) reside on software raid0 volumes,
composed of one SCSI and one IDE ((U)DMA-something) disk each.

Both machines use RedHat 7.1 + fairly recent updates, with a
custom-built as-modular-as-possibly 2.4.9-ac10 (no other patches)
kernel tailored to the respective CPU types (Pentium Pro SMP on the
server, Celeron Coppermine on the client).

The client's HW is a Celeron 800, GA-6OX, 256 MB SDRAM; aic7xxx,
NetGear FA-310TX (tulip driver).


[7.1.] Software (add the output of the ver_linux script here)
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux sol.fo.et.local 2.4.9 #1 SMP Tue Sep 18 22:46:46 CEST 2001 i686 unknown
[At the time of the problem it was 2.4.9-ac10]
Kernel modules         2.4.2
Gnu C                  2.96
Binutils               2.10.91.0.2
Linux C Library        2.2.2
Dynamic Linker (ld.so) 2.2.2
ls: /usr/lib/libg++.so: No such file or directory
Procps                 2.0.7
Mount                  2.11b
Net-tools              (2000-05-21)
Kbd                    0.3.3
Sh-utils               2.0

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 7
cpu MHz         : 198.950
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
bogomips        : 396.49

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 7
cpu MHz         : 198.950
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
bogomips        : 397.31

[7.3.] Module information (from /proc/modules):
nfsd                   70304   8 (autoclean)
lockd                  50704   1 (autoclean) [nfsd]
sunrpc                 68208   1 (autoclean) [nfsd lockd]
autofs                 11456   2 (autoclean)
natsemi                13184   1 (autoclean)
ipchains               38368   0 (unused)
st                     26976   1
reiserfs              157904   1 (autoclean)
sr_mod                 13312   0 (autoclean) (unused)
cdrom                  28192   0 (autoclean) [sr_mod]
raid0                   3648   2
md                     43424   2 [raid0]
sd_mod                 11360   4
aic7xxx               115440   5
scsi_mod               96080   4 [st sr_mod sd_mod aic7xxx]
usb-uhci               22336   0 (unused)
usbcore                53024   1 [usb-uhci]
unix                   17152  21
ide-disk                7104   4
ide-probe-mod           8368   0
ide-mod               157936   4 [ide-disk ide-probe-mod]

[7.4.] SCSI information (from /proc/scsi/scsi):
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-309170      Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DGHS09Z          Rev: 0350
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DDRS-34560       Rev: S97B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: DPSS-309170N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: SONY     Model: SDT-9000         Rev: 0400
  Type:   Sequential-Access                ANSI SCSI revision: 02

[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
        think to be relevant):

Server board: Tyan 1662 (Titan Pro AT), 2x Pentium Pro 200, 256 MB
EDO.

HW in the Server is all-PCI, I'll just include `lspci`:
00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:07.2 USB Controller: Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II] (rev 01)
00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01)
00:0c.0 Ethernet controller: National Semiconductor Corporation: Unknown device 0020
        [This is a NetGear FA-311 TX]
00:0d.0 SCSI storage controller: Adaptec AIC-7881U
00:0e.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871

(Despite the Matrox Millenium the server is a "cellar machine", no X
or other interactive use).

[X.] Other notes, patches, fixes, workarounds:

The problem certainly looks reproducible here and seems to be hidden
away somewhere in the differences between 2.4.9 and 2.4.9-ac10.

As the machine is "semi-production" I did not do a lot of further
testing once I saw the 2.4.9 no ac solved the problem for me, but if
the bug is deemed worthy of investigation I will try to be of further
assistance; I will always respond with further information about the
setup if asked and will try patches etc. as far as my time permits.


So long,
        Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
