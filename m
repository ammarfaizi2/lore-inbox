Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVCVHhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVCVHhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVCVHhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:37:06 -0500
Received: from mato.luukku.com ([193.209.83.251]:49298 "EHLO mato.luukku.com")
	by vger.kernel.org with ESMTP id S262195AbVCVHcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:32:32 -0500
Subject: Re: Fusion-MPT much faster as module
From: Janne Pikkarainen <jaba@mikrobitti.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, "Moore, Eric Dean" <emoore@lsil.com>
In-Reply-To: <20050321152723.4b86dc3a.akpm@osdl.org>
References: <Pine.LNX.4.61.0503081327560.28812@praktifix.dwd.de>
	 <20050321152723.4b86dc3a.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 09:32:30 +0200
Message-Id: <1111476750.9640.56.camel@82-203-174-157.dsl.gohome.fi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Mon, 2005-03-21 at 15:27 -0800, Andrew Morton wrote:
> > On a four CPU Opteron compiling the Fusion-MPT as module gives much better
> > performance when compiling it in, here some bonnie++ results:
> > 
> > Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
> >                      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> > Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> > compiled in  15872M 38366 71  65602  22 18348   4 53276 84  57947   7 905.4   2
> > module       15872M 51246 96 204914  70 57236  14 59779 96 264171  33 923.0   2
> > 
> > This happens with 2.6.10, 2.6.11 and 2.6.11-bk2. Controller is a
> > Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI.
> > 
> > Why is there such a large difference?
> > 
> 
> Holger, this problem remains unresolved, does it not?  Have you done any
> more experimentation?

Quick summary: 
- older IBM xSeries 335 + kernel 2.4.26 = surprisingly slow
- older IBM xSeries 335 + kernel 2.6.8 = pretty fast
- newer IBM xSeries 335 + kernel 2.6.9 = pretty fast
- newer IBM xSeries 335 (and a 336) + kernel 2.6.10 = surprisingly slow

Longer story:
I'm administering bunch of IBM xSeries 335 servers (and one 336, too),
all equipped with the exactly same SCSI controller than in the case
above. In every server Fusion MPT module is compiled straight into
kernel and disk setup is two identical SCSI hard drives in RAID-1 mode.
For the 2.6.x servers about the same kernel .config file is used.

One of the older servers (still using kernel 2.6.8) with P4 Xeon 2.0 GHz
and ~70 GB U320 SCSI disk gives me pretty good results:

---
hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  136 MB in  3.02 seconds =  45.01 MB/sec
---

Identical hardware, but with kernel 2.4.25:

---
hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  64 MB in  3.35 seconds = 19.10 MB/sec
---

A newer generation of x335 (using kernel 2.6.9) with dual P4 Xeon 3.0
GHz and ~70 GB U320 SCSI disk:

---
hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  130 MB in  3.07 seconds =  42.35 MB/sec
---

Still a bit newer generation of x335 with P4 Xeon 3.06 GHz and ~140 GB
U320 SCSI disk, using kernel 2.6.10 is a big disappoitment:

---
hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:   48 MB in  3.11 seconds =  15.43 MB/sec
---

And the latest x336 with dual P4 Xeon 3.2 GHz (using kernel 2.6.10) with
~140 GB U320 SCSI disk is also very disappointing:

---
hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:   58 MB in  3.02 seconds =  19.20 MB/sec
---

Some info about the oldest x335:

---
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
Fusion MPT SCSI Host driver 3.01.09
scsi0 : ioc0: LSI53C1030, FwRev=01000e00h, Ports=1, MaxQ=222, IRQ=177
  Vendor: LSILOGIC  Model: 1030 IM           Rev: 1000
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 143372288 512-byte hdwr sectors (73407 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
  Vendor: IBM       Model: 25P3495a S320  1  Rev: 1
  Type:   Processor                          ANSI SCSI revision: 02
---

A bit newer x335 with kernel 2.6.9:

---
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
Fusion MPT SCSI Host driver 3.01.16
scsi0 : ioc0: LSI53C1030, FwRev=01000e00h, Ports=1, MaxQ=222, IRQ=22
  Vendor: LSILOGIC  Model: 1030 IM           Rev: 1000
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 143372288 512-byte hdwr sectors (73407 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
  Vendor: IBM       Model: 25P3495a S320  1  Rev: 1
  Type:   Processor                          ANSI SCSI revision: 02
Attached scsi generic sg1 at scsi0, channel 0, id 8, lun 0,  type 3
---

And the latest x335 we have:

---
Fusion MPT base driver 3.01.18
Copyright (c) 1999-2004 LSI Logic Corporation
ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 169
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
Fusion MPT SCSI Host driver 3.01.18
scsi0 : ioc0: LSI53C1030, FwRev=01032316h, Ports=1, MaxQ=222, IRQ=169
  Vendor: LSILOGIC  Model: 1030 IM           Rev: 1000
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 286746624 512-byte hdwr sectors (146814 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 286746624 512-byte hdwr sectors (146814 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
  Vendor: IBM       Model: 25P3495a S320  1  Rev: 1
  Type:   Processor                          ANSI SCSI revision: 02
Attached scsi generic sg1 at scsi0, channel 0, id 8, lun 0,  type 3
---

x336:

---
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
Fusion MPT SCSI Host driver 3.01.18
scsi0 : ioc0: LSI53C1030, FwRev=01032316h, Ports=1, MaxQ=222, IRQ=169
  Vendor: LSILOGIC  Model: 1030 IM           Rev: 1000
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 286746624 512-byte hdwr sectors (146814 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 286746624 512-byte hdwr sectors (146814 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
  Vendor: IBM       Model: 25P3495a S320  1  Rev: 1
  Type:   Processor                          ANSI SCSI revision: 02
Attached scsi generic sg1 at scsi0, channel 0, id 8, lun 0,  type 3
---

I'll gladly be your test puppet and provide you any further information
you may need and can also upgrade the 2.6.8 server to be a 2.6.11 one
and/or test the Fusion MPT as a kernel module. I cannot boot the servers
at will, though, except the 2.6.8 one which is more or less only a
testbed server.


Best regards,

Janne Pikkarainen
 

