Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265753AbUA1Bzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 20:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUA1Bzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 20:55:33 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:20944 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265753AbUA1BzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 20:55:14 -0500
Date: Wed, 28 Jan 2004 10:54:28 +0900
From: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Subject: [RFC/PATCH, 1/4] readX_check() performance evaluation
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Message-id: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are planning recovery from the PCI bus intermittent errors.
PCI-X standard describes it as "5.4 Error Handling and Fault
Tolerance" in PCI-X 1.0b.  There were several discussions in lkml,
how to recover from PCI errors.

Seto posted "[RFC] How drivers notice a HW error?" (readX_check() I/F)
   http://marc.theaimsgroup.com/?l=linux-kernel&m=106992207709400&w=2

Grant will show his idea near future,
   http://marc.theaimsgroup.com/?l=linux-kernel&m=107453681120603&w=2

I made a readX_check() prototype which Seto proposed to measure
performance disadvantage of this kind of I/F. And I made a performance
evaluation of Disk I/O with this prototype.
Comments are welcome.


Conclusion:
    Performance disadvantage of readX_check() is a very small.
    I'd like you to understand that such a function will not 
    cause severe performance disadvantage as you imagine.

This patch:
     - is for Fusion MPT driver.
     - has no error recovery code yet, sorry.
     - currently supports ia64 only. But I believe that
       some other CPU(such as SPARC, PPC, PA-RISC) can also
       support this kind of I/F. 
       I know, unfortunately, that i386 can't support this kind
       of I/F, because it can't recover from machine check state.

How to use this patch:
        - Apply to vanilla 2.6.1.
        - Rename drivers/message/fusion/mptbase.c to mptbase_main.c
          (Because we make mptbase.ko from mptbase.c and read_check.S,
          so source file name has to be renamed.  Though I know
          read_check.S should go under the architecture directory,
          because this patch is only for performance evaluation,
          forgive me. )

Evaluation Environment:
    Kernel:
        vanilla 2.6.1 and  2.6.1+readX_check patch
    Platform:   Intel Tiger-4 (1-CPU)
        processor  : 0
        vendor     : GenuineIntel
        arch       : IA-64
        family     : Itanium 2
        model      : 1
        revision   : 5
        archrev    : 0
        features   : branchlong
        cpu number : 0
        cpu regs   : 4
        cpu MHz    : 1296.473997
        itc MHz    : 1296.473997
        BogoMIPS   : 1941.96
    SCSI HBA/driver:
        onboard LSI Logic 53C1030(FwRev=01030600h, MaxQ=255)
        Fusion MPT driver(kernel 2.6.1)
    Disks
        Host: scsi0 Channel: 00 Id: 00 Lun: 00
          Vendor: FUJITSU  Model: MAP3367NC        Rev: 5207
          Type:   Direct-Access                    ANSI SCSI revision: 03
        Host: scsi0 Channel: 00 Id: 01 Lun: 00
          Vendor: FUJITSU  Model: MAP3367NC        Rev: 5207
          Type:   Direct-Access                    ANSI SCSI revision: 03
        Host: scsi0 Channel: 00 Id: 02 Lun: 00
          Vendor: FUJITSU  Model: MAP3367NC        Rev: 5207
          Type:   Direct-Access                    ANSI SCSI revision: 03

    Test tool:
        rawread 1.0.3
        http://www-124.ibm.com/developerworks/opensource/linuxperf/rawread/rawread.html

Results:
    To avoid buffer cache, we measured performance by O_DIRECT.

1-1) ./rawread -p 1 -d 1 -s 512 -n 131072 -x -z
     (1 disk, 512-bytes/1-read,)
                                        avg. sys(%) 
                    MB/s        IOPS    of vmstat
---------------------------------------------------
patched 2.6.1       5.245       10741   16.2
vanilla 2.6.1       5.269       10790   15.7
---------------------------------------------------
patched/vanilla     0.995               1.032

1-2) ./rawread -p 2 -d 1 -s 512 -n 131072 -x -z
     (2 disks, 512-bytes/1-read,)
                                        avg. sys(%) 
                    MB/s        IOPS    of vmstat
---------------------------------------------------
patched 2.6.1       10.473      21448   30.6
vanilla 2.6.1       10.548      21602   30.6
---------------------------------------------------
patched/vanilla     0.993               1.000


1-3) ./rawread -p 3 -d 1 -s 512 -n 131072 -x -z
     (3 disks, 512-bytes/1-read,)
                                        avg. sys(%) 
                    MB/s        IOPS    of vmstat
---------------------------------------------------
patched 2.6.1      11.267       23074   29.9
vanilla 2.6.1      11.251       23042   30.5
---------------------------------------------------
patched/vanilla     1.001               0.980


2-1) ./rawread -p 1 -d 1 -s 4096 -n 131072 -x -z
     (1 disk, 4096-bytes/1-read,)
                                        avg. sys(%) 
                    MB/s        IOPS    of vmstat
---------------------------------------------------
patched 2.6.1      39.422       10092   14.1
vanilla 2.6.1      39.389       10083   14.0
---------------------------------------------------
patched/vanilla    1.001                1.007
   
2-2) ./rawread -p 2 -d 1 -s 4096 -n 131072 -x -z
     (2 disks, 4096-bytes/1-read,)
                                        avg. sys(%) 
                    MB/s        IOPS    of vmstat
---------------------------------------------------
patched 2.6.1      70.438       18032   24.1
vanilla 2.6.1      70.390       18019   24.1
---------------------------------------------------
patched/vanilla    1.001                1.000


2-3) ./rawread -p 3 -d 1 -s 4096 -n 131072 -x -z
     (3 disks, 4096-bytes/1-read,)
                                        avg. sys(%) 
                    MB/s        IOPS    of vmstat
---------------------------------------------------
patched 2.6.1      70.588       18070   24.5
vanilla 2.6.1      70.861       18140   24.4
---------------------------------------------------
patched/vanilla    0.996                1.004

3-1) ./rawread -p 1 -d 1 -s 32768 -n 131072 -x -z
     (1 disk, 32768-bytes/1-read,)
                                        avg. sys(%) 
                    MB/s        IOPS    of vmstat
---------------------------------------------------
patched 2.6.1      69.226       2215     3.5
vanilla 2.6.1      68.546       2190     3.4
---------------------------------------------------
patched/vanilla    1.010                1.029

   
3-2) ./rawread -p 2 -d 1 -s 32768 -n 131072 -x -z
     (2 disk, 32768-bytes/1-read,)
                                        avg. sys(%) 
                    MB/s        IOPS    of vmstat
---------------------------------------------------
patched 2.6.1     139.315       4458     7.0
vanilla 2.6.1     139.188       4454     6.6
---------------------------------------------------
patched/vanilla    1.010                1.029

3-3) ./rawread -p 3 -d 1 -s 32768 -n 131072 -x -z
     (3 disks, 32768-bytes/1-read,)
                                        avg. sys(%) 
                    MB/s        IOPS    of vmstat
---------------------------------------------------
patched 2.6.1     208.883       6684    10.0
vanilla 2.6.1     209.193       6694    10.2
---------------------------------------------------
patched/vanilla    0.999                0.980

-------
Thanks,
Hironobu Ishii

