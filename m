Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129257AbQK3Udg>; Thu, 30 Nov 2000 15:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQK3Ud0>; Thu, 30 Nov 2000 15:33:26 -0500
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:63247 "HELO
        zmamail05.zma.compaq.com") by vger.kernel.org with SMTP
        id <S129257AbQK3UdP>; Thu, 30 Nov 2000 15:33:15 -0500
Date: Thu, 30 Nov 2000 15:02:42 -0500 (EST)
From: Phillip Ezolt <ezolt@perf.zko.dec.com>
Reply-To: Phillip Ezolt <ezolt@perf.zko.dec.com>
To: ink@jurassic.park.msu.ru, rth@twiddle.net, axp-list@redhat.com,
        Jay.Estabrook@compaq.com
Cc: linux-kernel@vger.kernel.org, clinux@zk3.dec.com, wcarr@perf.zko.dec.com
Subject: Alpha SCSI error on 2.4.0-test11
Message-ID: <Pine.OSF.3.96.1001130145721.15171B-100000@perf.zko.dec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Qlogic SCSI support seems broken on 2.4.0-test11 on a Miata (Digital Personal WorkStation 600au).

When starting up, we get a machine check after initialing the qlogic SCSI code. 

Using the Alpha kgdb, we figured out that the code is dying in scsi_wait_request().

Here's the backtrace: 

scsi_wait_req (SRpnt=0xfffffc0001f9b480, cmnd=0xfffffc890000a078, 
    buffer=0x100, bufflen=2, timeout=17891584, retries=6144)
    at /usr/src/linux/include/asm/atomic.h:85
(gdb) where
#0  scsi_wait_req (SRpnt=0xfffffc0001f9b480, cmnd=0xfffffc890000a078, 
    buffer=0x100, bufflen=2, timeout=17891584, retries=6144)
    at /usr/src/linux/include/asm/atomic.h:85
#1  0xfffffc00004107f0 in scan_scsis_single (channel=0, dev=41080, lun=0, 
    max_dev_lun=0xfffffc00001efa30, sparse_lun=0xfffffc00001efa34, 
    SDpnt2=0xfffffc00001efa38, shpnt=0xfffffc00005ff800, 
    scsi_result=0xfffffc00001ef930 "\001") at scsi_scan.c:516
#2  0xfffffc0000410548 in scan_scsis (shpnt=0xfffffc00005ff800, hardcoded=1, 
    hchannel=0, hid=0, hlun=0) at scsi_scan.c:403
#3  0xfffffc0000404f58 in scsi_register_host (tpnt=0xfffffc000058fb80)
    at scsi.c:1904
#4  0xfffffc00004dac50 in init_this_scsi_driver ()
#5  0xfffffc00004c2bec in do_initcalls ()
#6  0xfffffc00004c2c6c in do_basic_setup ()
#7  0xfffffc0000310078 in init (unused=0x0) at init/main.c:775
  

Note: On the working kernels, the two controllers are 0x800 apart, but
on the broken kernels, they are only 0x400.  Could the overlap
cause problems? 

Working: 2.2.14-6.0: (from 6.2 Redhat)

qlogicisp : new isp1020 revision ID (5)
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 20 irq 27 I/O base 0x9000
scsi1 : QLogic ISP1020 SCSI on PCI bus 01 device 48 irq 40 I/O base 0x9800
scsi : 2 hosts.
  Vendor: DEC       Model: RZ1CB-BA (C) DEC  Rev: LYE0
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0008
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
  Vendor: DEC       Model: RZ1BB-BA (C) DEC  Rev: LYE0
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi0, channel 0, id 2, lun 0
scsi : detected 3 SCSI disks total.

Working: vmlinux-2.2.17-4 (from 7.0 Redhat)
qlogicisp : new isp1020 revision ID (5)
qlogicisp : new isp1020 revision ID (5)
DC390: 0 adapters found
scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 20 irq 27 I/O base 0xa000
scsi1 : QLogic ISP1020 SCSI on PCI bus 01 device 48 irq 40 I/O base 0xa800
scsi : 2 hosts.
  Vendor: DEC       Model: RZ1CB-BA (C) DEC  Rev: LYE0
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0008
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
  Vendor: DEC       Model: RZ1BB-BA (C) DEC  Rev: LYE0
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi0, channel 0, id 2, lun 0
scsi : detected 3 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 8380080 [4091 MB] [4.1 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 4110480 [2007 MB] [2.0 GB]
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 4110480 [2007 MB] [2.0 GB]

Broken 2.4.0-test11:  (gcc version 2.96 20000731 (Red Hat Linux 7.0))

SCSI subsystem driver Revision: 1.00
qlogicisp : new isp1020 revision ID (5)
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 20 irq 27 I/O base 0xa000
scsi1 : QLogic ISP1020 SCSI on PCI bus 01 device 48 irq 40 I/O base 0xa400
CIA machine check: vector=0x660 pc=0xfffffc0000312644 code=0x813
machine check type: unknown
pc = [<fffffc0000312644>]  ra = [<fffffc0000312660>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000000  t1 = fffffc00005d8b20
t2 = 0000000000000001  t3 = 0000000000000001  t4 = fffffc000057a110
t5 = fffffffffffffc18  t6 = 000000000000451d  t7 = fffffc0000520000
a0 = 0000000000000019  a1 = 0000000000000032  a2 = fffffc000035d5cc
a3 = 0000000000000002  a4 = fffffc0000544080  a5 = fffffc000057a110
t8 = 0000000000000000  t9 = 00000000f96329ef  t10= 0000000000000000
t11= 0000000000000001  pv = fffffc0000329f80  at = fffffc0000520000
gp = fffffc000059dd88  sp = fffffc0000523fd0
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 


Broken 2.4.0-test11: (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release))

SCSI subsystem driver Revision: 1.00
qlogicisp : new isp1020 revision ID (5)
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 20 irq 27 I/O base 0xa000
scsi1 : QLogic ISP1020 SCSI on PCI bus 01 device 48 irq 40 I/O base 0xa400
CIA machine check: vector=0x660 pc=0xfffffc0000312464 code=0x813
machine check type: unknown
pc = [<fffffc0000312464>]  ra = [<fffffc0000312480>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000000  t1 = 0000000000000001
t2 = 0000000000000001  t3 = fffffc0000562850  t4 = fffffc0000562850
t5 = fffffffffffffc18  t6 = fffffc00005613d0  t7 = fffffc0000508000
a0 = 0000000000000019  a1 = 0000000000000032  a2 = fffffc000035b478
a3 = 0000000000000002  a4 = fffffc00003f8880  a5 = 0000000000001800
t8 = 0000000000000000  t9 = 000000001feee829  t10= 0000000000000000
t11= ffff00ff00000012  pv = fffffc0000329f80  at = fffffc000052c080
gp = fffffc0000585ed8  sp = fffffc000050bfd0
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 


Thanks,
--Phil & Bill

Compaq:  High Performance Server Division/Benchmark Performance Engineering 
---------------- Alpha, The Fastest Processor on Earth --------------------
Phillip.Ezolt@compaq.com        |C|O|M|P|A|Q|        ezolt@perf.zko.dec.com
------------------- See the results at www.spec.org -----------------------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
