Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbTAFX1K>; Mon, 6 Jan 2003 18:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbTAFX1K>; Mon, 6 Jan 2003 18:27:10 -0500
Received: from wencor.com ([12.30.196.34]:9124 "EHLO wencor.com")
	by vger.kernel.org with ESMTP id <S267197AbTAFX1E>;
	Mon, 6 Jan 2003 18:27:04 -0500
Message-ID: <3E1A12B5.4020505@xmission.com>
Date: Mon, 06 Jan 2003 16:35:17 -0700
From: Chris Wood <cwood@xmission.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to kswapd problems in Redhat's 2.4.9 kernel, I have had to upgrade 
to the 2.4.20 kernel with the IBM Summit Patches for our IBM x440.  It 
has run very well with one exception, between 8:00am and 9:00am our 
server will see a cpu usage hit under the system resources (in top) and 
start to drag the server to a very slow situation where people can't 
access the server.

See the following jpg of top as an example of the system usage.  It 
doesn't seem to be any one program.

http://www.wencor.com/slow2.4.20.jpg

When we start to have users log off the server (we have 300 telnet users 
that login) the system usually bounces right back to normal.  We have 
had to reboot once or twice to get it fully working again (lpd went into 
limbo and wouldn't come back).  After the server bounces back to normal, 
we can run the rest of the day without any trouble and under full heavy 
load.  I have never seen it happen at any other time of day and it 
doesn't happen every day.

With some tips from James Cleverdon (IBM), I turned on some kernel 
debugging and got the following from readprofile when the server was 
having problems (truncated to the first 22 lines):
16480 total                                      0.0138
   6383 .text.lock.swap                          110.0517
   4689 .text.lock.vmscan                         28.2470
   4486 shrink_cache                               4.6729
    168 rw_swap_page_base                          0.6176
    124 prune_icache                               0.5167
     81 statm_pgd_range                            0.1534
     51 .text.lock.inode                           0.0966
     38 system_call                                0.6786
     31 .text.lock.tty_io                          0.0951
     31 .text.lock.locks                           0.1435
     18 .text.lock.sched                           0.0373
     16 _stext                                     0.2000
     15 fput                                       0.0586
     11 .text.lock.read_write                      0.0924
      9 strnicmp                                   0.0703
      9 do_wp_page                                 0.0110
      9 do_page_fault                              0.0066
      9 .text.lock.namei                           0.0073
      9 .text.lock.fcntl                           0.0714
      8 sys_read                                   0.0294

Here is a snapshot when the server is fine, no problems (truncated):
1715833 total                                      1.4317
1677712 default_idle                             26214.2500
   4355 system_call                               77.7679
   2654 file_read_actor                           11.0583
   2159 bounce_end_io_read                         5.8668
   1752 put_filp                                  18.2500
   1664 do_page_fault                              1.2137
   1294 fget                                      20.2188
   1246 do_wp_page                                 1.5270
   1233 fput                                       4.8164
   1138 posix_lock_file                            0.7903
   1120 kmem_cache_alloc                           3.6842
   1098 do_softirq                                 4.9018
   1042 statm_pgd_range                            1.9735
    882 kfree                                      6.1250
    732 __loop_delay                              15.2500
    673 flush_tlb_mm                               6.0089
    610 fcntl_setlk64                              1.3616
    554 __kill_fasync                              4.9464
    498 zap_page_range                             0.4716
    414 do_generic_file_read                       0.3696
    409 __free_pages                               8.5208
    401 sys_semop                                  0.3530

I have to admit that most of this doesn't make a lot of sense to me and 
I don't know what the .text.lock.* processes are doing.  Any ideas? 
Anything I can try?

Chris Wood
Wencor West, Inc.

-----------------------------------
System Info From Here Down:
IBM x440 - Dual Xeon 1.4ghz MP, with Hyperthreading turned on
6 gig RAM
2 internal 36gig drives mirrored
1 additional intel e1000 network card
2 IBM fibre adapters (QLA2300s) connected to a FastT700 SAN
RedHat Advanced Server 2.1
2.4.20 kernel built using the RH 2.4.9e8summit .config file as template

These things are listed below (hopefully this isn't overkill):
x440:/proc$ cat modules (see results below)
x440:/proc$ cat scsi/scsi (see results below)
x440:/proc$ cat cpuinfo (see results below)
x440:/proc$ cat ioports (see results below)
x440:/proc$ cat iomem (see results below)

x440:/proc$ cat modules
autofs                 11876   0 (autoclean) (unused)
e1000                  59280   1
bcm5700                95076   1
ipchains               50728  28
usb-uhci               26724   0 (unused)
usbcore                76448   1 [usb-uhci]
ext3                   69888   7
jbd                    51808   7 [ext3]
qla2300               236608   2
ips                    45184   6
aic7xxx               133376   0
sd_mod                 13020  16
scsi_mod              121304   4 [qla2300 ips aic7xxx sd_mod]

x440:/proc$ cat scsi/scsi
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: IBM      Model: SERVERAID        Rev: 1.00
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 15 Lun: 00
   Vendor: IBM      Model: SERVERAID        Rev: 1.00
   Type:   Processor                        ANSI SCSI revision: 02
Host: scsi2 Channel: 01 Id: 09 Lun: 00
   Vendor: IBM      Model: GNHv1 S2         Rev: 0
   Type:   Processor                        ANSI SCSI revision: 02
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: IBM      Model: 1742             Rev: 0520
   Type:   Direct-Access                    ANSI SCSI revision: 03


x440:/proc$ cat cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1397.190
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
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2785.28

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1397.190
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
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2791.83

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1397.190
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
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2791.83

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1397.190
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
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2791.83

x440:/proc$ cat ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0440-044f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0700-070f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
   0700-0707 : ide0
   0708-070f : ide1
0cf8-0cff : PCI conf1
1800-187f : PCI device 1014:010f (IBM)
1880-189f : VIA Technologies, Inc. USB
   1880-189f : usb-uhci
18a0-18bf : VIA Technologies, Inc. USB (#2)
   18a0-18bf : usb-uhci
2000-20ff : Adaptec AIC-7899P U160/m
2100-21ff : Adaptec AIC-7899P U160/m (#2)
2800-28ff : QLogic Corp. QLA2300 64-bit FC-AL Adapter
   2800-28fe : qla2300
4000-40ff : QLogic Corp. QLA2300 64-bit FC-AL Adapter (#2)
   4000-40fe : qla2300
7000-701f : Intel Corp. 82544EI Gigabit Ethernet Controller
   7000-701f : e1000

x440:/proc$ cat iomem
00000000-0009c7ff : System RAM
0009c800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cffff : Extension ROM
000d0000-000d01ff : Extension ROM
000f0000-000fffff : System ROM
00100000-dffb707f : System RAM
   00100000-0022b615 : Kernel code
   0022b616-002a525f : Kernel data
dffb7080-dffbf7ff : ACPI Tables
dffbf800-dfffffff : reserved
e0000000-e7ffffff : S3 Inc. Savage 4
e8400000-e8401fff : IBM Netfinity ServeRAID controller
   e8400000-e8401fff : ips
f0c20000-f0c3ffff : Intel Corp. 82544EI Gigabit Ethernet Controller
   f0c20000-f0c3ffff : e1000
f0c40000-f0c5ffff : Intel Corp. 82544EI Gigabit Ethernet Controller
   f0c40000-f0c5ffff : e1000
f1000000-f11fffff : PCI device 1014:010f (IBM)
f1200000-f127ffff : S3 Inc. Savage 4
f1600000-f160ffff : Broadcom Corporation NetXtreme BCM5700 Gigabit Ethernet
   f1600000-f160ffff : bcm5700
f1610000-f1610fff : Adaptec AIC-7899P U160/m
   f1610000-f1610fff : aic7xxx
f1611000-f1611fff : Adaptec AIC-7899P U160/m (#2)
   f1611000-f1611fff : aic7xxx
f1820000-f1820fff : QLogic Corp. QLA2300 64-bit FC-AL Adapter
f1920000-f1920fff : QLogic Corp. QLA2300 64-bit FC-AL Adapter (#2)
fec00000-ffffffff : reserved


