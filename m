Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVI3GvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVI3GvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 02:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVI3GvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 02:51:03 -0400
Received: from web30315.mail.mud.yahoo.com ([68.142.201.233]:923 "HELO
	web30315.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932564AbVI3GvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 02:51:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=36nYAG3ru7PRy1utmQpkOYQEs7aXZOi5DJtpjtp+XFgRED8FRKmZGqylNgmPlQr7uK+i7iB38jkTrwAukxshUeCU8+fDdhYFg2u0ENcjZHT38K4HJC1WP1nz4TclXwIqJWu+QLxsegbRxtnIKtNYv11dE5+Vy3S9OqTMqMtKYT8=  ;
Message-ID: <20050930065058.84446.qmail@web30315.mail.mud.yahoo.com>
Date: Thu, 29 Sep 2005 23:50:58 -0700 (PDT)
From: subbie subbie <subbie_subbie@yahoo.com>
Subject: 3Ware 9500S-12 RAID controller -- poor performance
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

After almost two weeks of experimentation, google
searches and reading of posts, bug reports and
discussions I'm still far from an answer.  I'm hoping
someone on this list could shed some light on the
subject.

I'm using a 3Ware 9500S-12 card and am able to produce
up to 400MB/s sustained read from my 12-disk 4.1TB
RAID5 SATA array, 128MB cache onboard, ext3 formatted.
  All is well when performing a single read -- it
works nice and fast.

The system is a web server, serving mid-size files
(50MB, each, on average).  All hell breaks loose when
doing many concurrent reads, anywhere between 200 to
400 concurrent streams things simply grind to a halt
and the system transfers a maximum of 12-14MB/s.

I'm in the process of clearing up the array (this
would take some time) and restructuring it to JBOD
mode in order to use each disk individually.  I will
use a filesystem more suitable to streaming large
files, such as XFS.  But this would take time and I
would very much appreciate the advice of people in the
know if this is going to help at all.    It's hard for
me to make extreme experimentation (deleting,
formatting, reformatting) as this is a productio n
system with many files that I have no other place to
dump until they can be safely removed.  Though I'm
working on dumping them slowly to other, remote,
machines.

I'm running the latest kernel, 2.6.13.2 and the latest
3Ware driver, taken from the 3ware.com web site which
upon insmod, updates the card's firmware to the latest
version as well.

In my experiments, I've tried using larger readahead,
currently at 16k (this helps, higher values do not
seem to help much), using the deadline scheduler for
this device, booting the system with the 'noapic'
option and playing with a bunch of VM tunable
parameters which I'm not sure that I should really be
touching.  At the moment only the readahead
modification is used as the other stuff simply didn't
help at all.

With the stock kernel shipped with my distribution,
2.6.8 and its old 3ware driver things were just as
worse but manifested themselves differently.    The
system was visibly (top, vmstat...) spending most of
its time in io-wait and load average was extremely
high, in the area of 10 to 20.   With the recent
kernel and driver mentioned above, the excessive
io-wait and load seems to have been resolved and
observed loadavg is between 1 and 4.

I don't have much experience with systems that are
supposed to stream many files concurrently off a
hardware RAID of this configuration, but my gut
feeling is that something is very wrong and I should
be seeing a much higher read throughput.

Trying to preempt people's questions I've tried to
include as much information as possible, a lot of
stuff is pasted below.

I've just seen that the 3ware driver shares the same
IRQ with my ethernet card, which has got me a little
worried, should I be?

System uptime, exactly 1 day:

# cat /proc/interrupts 
           CPU0       CPU1       
  0:   21619638          0          XT-PIC  timer
  2:          0          0          XT-PIC  cascade
  8:          4          0          XT-PIC  rtc
 10:  268753224          0          XT-PIC  3w-9xxx,
eth0
 14:         11          0          XT-PIC  ide0
 15:     337881          0          XT-PIC  libata
NMI:          0          0 
LOC:   21110402   21557685 
ERR:          0
MIS:          0

# free
            total       used       free     shared   
buffers     cached
Mem:       2075260    2024724      50536          0   
   5184    1388408
-/+ buffers/cache:     631132    1444128
Swap:      3903784          0    3903784

# vmstat -n 1  (output of the last few seconds):
procs -----------memory---------- ---swap--
-----io---- --system-- ----cpu----
 0  0      0  49932   4760 1392980    0    0 15636   
32 3169  3697  4  6 30 60
 0  0      0  50816   4752 1392376    0    0  5844    
0 3114  3929  3  5 91  1
 0  0      0  50924   4772 1391404    0    0  9360    
0 3187  4348  6  6 76 13
 0  2      0  50552   4780 1391532    0    0 24976   
44 4077  3906  3  7 65 25
 0  1      0  50444   4780 1392688    0    0 20192    
0 5048  3914  7  8 56 30
 0  1      0  50568   4756 1392508    0    0 21248    
0 4060  3603  4  6 48 41
 0  0      0  50704   4724 1392268    0    0 30004    
0 3834  3369  4  9 65 22
 0  3      0  50556   4728 1392468    0    0  3248 
1832 2974  4514  2  5 58 35
 0  3      0  50308   4724 1392200    0    0  1288  
336 1766  1886  1  3 50 47
 0  4      0  50308   4732 1391852    0    0  2300  
408 1919  2158  0  3 51 46
 0  4      0  50556   4736 1390692    0    0  1856  
532 1488  1846  3  1 50 46
 0  3      0  50680   4740 1390620    0    0  4016 
1296 1577  1682  2  2 50 47
 0  3      0  50432   4752 1391628    0    0  2180   
72 1730  1945  2  2 51 46
 2  2      0  49924   4772 1391540    0    0 44372  
564 3403  2847  4  5 50 42
 0  0      0  50684   4784 1391528    0    0 28640  
216 3804  3847  7  8 69 16 

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.00GHz
stepping        : 1
cpu MHz         : 2993.035
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
pbe nx lm pni monitor ds_c
pl cid cx16 xtpr
bogomips        : 5993.68

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.00GHz
stepping        : 1
cpu MHz         : 2993.035
cache size      : 1024 KB
physical id     : 3
siblings        : 2
core id         : 3
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
pbe nx lm pni monitor ds_c
pl cid cx16 xtpr
bogomips        : 5985.52

# lspci
0000:00:00.0 Host bridge: Intel Corporation E7520
Memory Controller Hub (rev 0c)
0000:00:00.1 ff00: Intel Corporation E7525/E7520 Error
Reporting Registers (rev 
0c)
0000:00:01.0 System peripheral: Intel Corporation
E7520 DMA Controller (rev 0c)
0000:00:02.0 PCI bridge: Intel Corporation
E7525/E7520/E7320 PCI Express Port A 
(rev 0c)
0000:00:04.0 PCI bridge: Intel Corporation E7525/E7520
PCI Express Port B (rev 0
c)
0000:00:05.0 PCI bridge: Intel Corporation E7520 PCI
Express Port B1 (rev 0c)
0000:00:06.0 PCI bridge: Intel Corporation E7520 PCI
Express Port C (rev 0c)
0000:00:1d.0 USB Controller: Intel Corporation
82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation
82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corporation
82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #3 (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation
82801EB/ER (ICH5/ICH5R) USB2 EHCI
 Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI
Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corporation 82801EB/ER
(ICH5/ICH5R) LPC Interface
 Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation
82801EB/ER (ICH5/ICH5R) IDE Contro
ller (rev 02)
0000:00:1f.2 IDE interface: Intel Corporation 82801EB
(ICH5) SATA Controller (re
v 02)
0000:00:1f.3 SMBus: Intel Corporation 82801EB/ER
(ICH5/ICH5R) SMBus Controller (
rev 02)
0000:01:00.0 PCI bridge: Intel Corporation 6700PXH PCI
Express-to-PCI Bridge A (
rev 09)
0000:01:00.1 PIC: Intel Corporation 6700/6702PXH
I/OxAPIC Interrupt Controller A
 (rev 09)
0000:01:00.2 PCI bridge: Intel Corporation 6700PXH PCI
Express-to-PCI Bridge B (
rev 09)
0000:01:00.3 PIC: Intel Corporation 6700PXH I/OxAPIC
Interrupt Controller B (rev
 09)
0000:03:01.0 RAID bus controller: 3ware Inc
9xxx-series SATA-RAID
0000:05:00.0 Ethernet controller: Marvell Technology
Group Ltd. 88E8050 Gigabit
Ethernet Controller (rev 18)
0000:07:04.0 Ethernet controller: Intel Corporation
82541GI/PI Gigabit Ethernet 
Controller (rev 05)
0000:07:0c.0 VGA compatible controller: ATI
Technologies Inc Rage XL (rev 27)

As you can see, this is a fairly recent motherboard
that's supposed to perform well,  though I don't know
the manufacturer of this board as the machine is
hosted and I don't have physical access, though I can
ask them if anyone would like to know.

The ethernet card actually being used is the Intel
E1000 with NAPI support compiled.

If there's any bit of information that's missing,
please let me know and I'd he happy to provide it
quickly.

If you can suggest a better (non Netapp, EMC, etc)
solution that is somehow affordable and can provide
the very high read throughputs please let me know, I'm
very interested in solutions that can staturate
multiple gigabit links (of course, using more than one
machine ;)

Please CC me on any replies as I'm not subscribed to
the list.

Thank you for listening!


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
