Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbWHOM3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWHOM3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWHOM3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:29:17 -0400
Received: from outgoing3.smtp.agnat.pl ([193.239.44.85]:56535 "EHLO
	outgoing3.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S932756AbWHOM3Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:29:16 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-scsi@vger.kernel.org
Subject: Re: qlogic 2312 problems on 2.6.16.22, 2.6.18rc4
Date: Tue, 15 Aug 2006 14:29:09 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200608140946.50411.arekm@pld-linux.org> <200608141437.05269.arekm@pld-linux.org>
In-Reply-To: <200608141437.05269.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608151429.09082.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 14:37, Arkadiusz Miskiewicz wrote:
> On Monday 14 August 2006 09:46, Arkadiusz Miskiewicz wrote:
> > Hi,
> >
> > I was using QLA2312 FC card on 32-bit machine with 6GB ram
> > without problems. Recently I've switched to opteron dual core machine
> > also with 6GB ram and I'm having serious problem with access to FC array.
> >
> > When I switch back to 32-bit machine the problem disappears. Some qla2312
> > problems with 64bit machines?
>
> I've tested latest git (same as 2.6.18rc4 I guess) using latest ql2300
> firmware from qlogic site.

I have simply no idea what's going here :-(

Everything works fine on 32-bit dual xeon machine with card inserted into PCI 
slot. Here in new dual core opteron machine the card sits in PCI-X slot. It's 
Thunder K8SRE S2891 mainboard, Transport GT24 B2891 1U barebone, Tyan M2075 
riser card, 2 x Opteron 270, 6GB ram.

Note that booting with 32-bit kernel (which works fine on Xeon system) doesn't 
cure the problem on Opteron system. Booting 64bit 2.6.18rc4 kernel with 
mem=3G also doesn't fix anything.

/t is on tmpfs, /dev/sda2 in on FC array. Reading the same data several times 
and I get different md5sum results each time, see below.

How I can track where corruption occurs?

[root@pldmachine /t]# dd if=/dev/sda2 of=test-from-sda2-2 bs=1M count=1024
1024+0 records in
1024+0 records out
[root@pldmachine /t]# md5sum test-from-sda2-2
90b831662a5d3bd2501028eee3c00264  test-from-sda2-2
[root@pldmachine /t]# rm test-from-sda2-2
[root@pldmachine /t]# dd if=/dev/sda2 of=test-from-sda2-2 bs=1M count=1024
1024+0 records in
1024+0 records out
[root@pldmachine /t]# md5sum test-from-sda2-2
c06dadfc0726aa07cccdfbe7804e646f  test-from-sda2-2
[root@pldmachine /t]# rm test-from-sda2-2
[root@pldmachine /t]# dd if=/dev/sda2 of=test-from-sda2-2 bs=1M count=1024
1024+0 records in
1024+0 records out
[root@pldmachine /t]# md5sum test-from-sda2-2
06d61f81245bd242e9420277cfca65e4  test-from-sda2-2

dd'ing over tmpfs only is fine of course:
[root@pldmachine /t]# md5sum tmpfs-test
ddaaa7eb8da403f6079c55b1391ee1e3  tmpfs-test
[root@pldmachine /t]# rm tmpfs-test
[root@pldmachine /t]# dd if=test of=tmpfs-test bs=1M count=1024
1024+0 records in
1024+0 records out
[root@pldmachine /t]# md5sum tmpfs-test
ddaaa7eb8da403f6079c55b1391ee1e3  tmpfs-test
[root@pldmachine /t]# rm tmpfs-test
[root@pldmachine /t]# dd if=test of=tmpfs-test bs=1M count=1024
1024+0 records in
1024+0 records out
[root@pldmachine /t]# md5sum tmpfs-test
ddaaa7eb8da403f6079c55b1391ee1e3  tmpfs-test

QLogic Fibre Channel HBA Driver
PCI: Enabling device 0000:09:08.0 (0150 -> 0153)
ACPI: PCI Interrupt 0000:09:08.0[A] -> GSI 24 (level, low) -> IRQ 209
qla2xxx 0000:09:08.0: Found an ISP2312, irq 209, iobase 0xffffc20000004000
qla2xxx 0000:09:08.0: Configuring PCI space...
qla2xxx 0000:09:08.0: Configure NVRAM parameters...
qla2xxx 0000:09:08.0: Verifying loaded RISC code...
scsi(1): **** Load RISC code ****
scsi(1): Verifying Checksum of loaded RISC code.
scsi(1): Checksum OK, start firmware.
qla2xxx 0000:09:08.0: Allocated (412 KB) for firmware dump...
scsi(1): Issue init firmware.
scsi(1): Asynchronous LIP RESET (f7f7).
qla2xxx 0000:09:08.0: LIP reset occured (f7f7).
qla2xxx 0000:09:08.0: Waiting for LIP to complete...
scsi(1): Asynchronous P2P MODE received.
scsi(1): Asynchronous LOOP UP (2 Gbps).
qla2xxx 0000:09:08.0: LOOP UP detected (2 Gbps).
scsi(1): Asynchronous PORT UPDATE.
scsi(1): Port database changed ffff 0006 0000.
scsi(1): F/W Ready - OK
scsi(1): fw_state=3 curr time=10002c93c.
qla2xxx 0000:09:08.0: Topology - (F_Port), Host Loop address 0xffff
scsi(1): Configure loop -- dpc flags =0x4080040
scsi(1): RSCN queue entry[0] = [00/000000].
scsi(1): device_resync: rscn overflow.
scsi(1): RFT_ID exiting normally.
scsi(1): RFF_ID exiting normally.
scsi(1): RNN_ID exiting normally.
scsi(1): RSNN_NN exiting normally.
scsi(1): GID_PT entry - nn 500508b300917e50 pn 500508b300917e51 portid=010000.
scsi(1): GID_PT entry - nn 200000e08b8051d6 pn 210000e08b8051d6 portid=010100.
scsi(1): GID_PT entry - nn 200000e08b950428 pn 210000e08b950428 portid=010200.
scsi(1): device wrap (010200)
scsi(1): Trying Fabric Login w/loop id 0x0081 for port 010000.
scsi(1): Trying Fabric Login w/loop id 0x0082 for port 010100.
scsi(1): LOOP READY
DEBUG: detect hba 1 at address = ffff81017d9344b0
scsi1 : qla2xxx
qla2xxx 0000:09:08.0:
 QLogic Fibre Channel HBA Driver: 8.01.05-k3-debug
  QLogic QLA2340 -
  ISP2312: PCI-X (133 MHz) @ 0000:09:08.0 hdma+, host#=1, fw=3.03.20 IPX
  Vendor: COMPAQ    Model: MSA1000           Rev: 4.96
  Type:   RAID                               ANSI SCSI revision: 04
  Vendor: COMPAQ    Model: MSA1000 VOLUME    Rev: 4.96
  Type:   Direct-Access                      ANSI SCSI revision: 04
SCSI device sda: 513790830 512-byte hdwr sectors (263061 MB)
sda: Write Protect is off
sda: Mode Sense: 83 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 513790830 512-byte hdwr sectors (263061 MB)
sda: Write Protect is off
sda: Mode Sense: 83 00 00 08
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 1:0:0:2: Attached scsi disk sda
  Vendor: COMPAQ    Model: MSA1000 VOLUME    Rev: 4.96
  Type:   Direct-Access                      ANSI SCSI revision: 04
SCSI device sdb: 1381590 512-byte hdwr sectors (707 MB)
sdb: Write Protect is off
sdb: Mode Sense: 83 00 00 08
SCSI device sdb: drive cache: write back
SCSI device sdb: 1381590 512-byte hdwr sectors (707 MB)
sdb: Write Protect is off
sdb: Mode Sense: 83 00 00 08
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
 sdb: p2 exceeds device capacity
sd 1:0:0:4: Attached scsi disk sdb
scsi(1): Asynchronous PORT UPDATE ignored 0000/0006/be3e.
scsi(1): Asynchronous PORT UPDATE ignored 0000/0007/be3e.
scsi(1): Asynchronous PORT UPDATE ignored 0000/0004/be3e.


btw. there is a "8131 Errata 56 PCLK" option in BIOS which is related to 
AMD-8131 Errata 56. This option is needed for ,, four-function PCI-X cards''. 
What's is four-function PCI-X card ? Card which is visible in lspci as 4 
devices? (This option also doesn't fix the problem unfortunately).

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
