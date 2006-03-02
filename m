Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWCBRco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWCBRco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWCBRco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:32:44 -0500
Received: from mxout5.netvision.net.il ([194.90.9.29]:55255 "EHLO
	mxout5.netvision.net.il") by vger.kernel.org with ESMTP
	id S932267AbWCBRcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:32:42 -0500
Date: Thu, 02 Mar 2006 19:32:48 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: Re:Re: problems with scsi_transport_fc and qla2xxx
In-reply-to: <20060301210802.GA7288@spe2>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Stefan Kaltenbrunner <mm-mailinglist@madness.at>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <957728045.20060302193248@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
References: <1413265398.20060227150526@netvision.net.il>
 <978150825.20060227210552@netvision.net.il>
 <20060228221422.282332ef.akpm@osdl.org> <4406034B.9030105@madness.at>
 <20060301210802.GA7288@spe2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!
Today I tested disconnecting QLogic port.
Adapter 4 is connected via switch to a storage and 3 LUNs are seen via
the adapter.
Only 1 rport is created (for FCP Target) while in Emulex case there
were 3: (Fabric Port, Directory Server and FCP Target, FCP Initiator).
# ls /sys/class/fc_remote_ports/
rport-4:0-0
# cat /sys/class/fc_remote_ports/*/roles
FCP Target

Default dev_loss_tmo is 6 (1+5) while in Emulex case the default was 35.

After disconnecting the cable between the HBA and the switch
qla2xxx 0000:03:01.0: LOOP DOWN detected (2).
 rport-4:0-0: blocked FC remote port time out: removing target and saving binding

# ls /sys/class/fc_remote_ports/
rport-4:0-0
# cat /sys/class/fc_remote_ports/*/roles
unknown

Relevant scsi devices are removed from /proc/scsi/scsi.

After reconnecting the cable
qla2xxx 0000:03:01.0: LIP reset occured (f7f7).
qla2xxx 0000:03:01.0: LOOP UP detected (2 Gbps).

# ls /sys/class/fc_remote_ports/
rport-4:0-0
# cat /sys/class/fc_remote_ports/*/roles
FCP Target

However, scsi devices don't reappear in /proc/scsi/scsi.
When I issue rescan, the command is stuck
echo - - - > /sys/class/scsi_host/host4/scan

Please advise.

Thanks,

Maxim.

I'm including /var/log/messages output:
# egrep -v 'Vendor|cron' /var/log/messages
Mar  2 19:13:49 multipath kernel: QLogic Fibre Channel HBA Driver
Mar  2 19:13:49 multipath kernel: GSI 24 sharing vector 0xE9 and IRQ 24
Mar  2 19:13:49 multipath kernel: ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 48 (level, low) -> IRQ 233
Mar  2 19:13:49 multipath kernel: qla2xxx 0000:03:01.0: Found an ISP2312, irq 233, iobase 0xffffc20000004000
Mar  2 19:13:49 multipath kernel: qla2xxx 0000:03:01.0: Configuring PCI space...
Mar  2 19:13:49 multipath kernel: qla2xxx 0000:03:01.0: Configure NVRAM parameters...
Mar  2 19:13:49 multipath kernel: qla2xxx 0000:03:01.0: Verifying loaded RISC code...
Mar  2 19:13:49 multipath kernel: qla2xxx 0000:03:01.0: Waiting for LIP to complete...
Mar  2 19:13:51 multipath kernel: qla2xxx 0000:03:01.0: LIP reset occured (f7f7).
Mar  2 19:13:51 multipath kernel: qla2xxx 0000:03:01.0: LOOP UP detected (2 Gbps).
Mar  2 19:13:51 multipath kernel: qla2xxx 0000:03:01.0: Topology - (F_Port), Host Loop address 0xffff
Mar  2 19:13:52 multipath kernel: scsi4 : qla2xxx
Mar  2 19:13:52 multipath kernel: qla2xxx 0000:03:01.0:
Mar  2 19:13:52 multipath kernel:  QLogic Fibre Channel HBA Driver: 8.01.04-k
Mar  2 19:13:52 multipath kernel:   QLogic QLA2340 -
Mar  2 19:13:52 multipath kernel:   ISP2312: PCI-X (133 MHz) @ 0000:03:01.0 hdma-, host#=4, fw=3.03.18 IPX
Mar  2 19:13:52 multipath kernel: GSI 25 sharing vector 0x32 and IRQ 25
Mar  2 19:13:52 multipath kernel: ACPI: PCI Interrupt 0000:06:01.0[A] -> GSI 72 (level, low) -> IRQ 50
Mar  2 19:13:52 multipath kernel: qla2xxx 0000:06:01.0: Configuring PCI space...
Mar  2 19:13:52 multipath kernel: qla2xxx 0000:06:01.0: Configure NVRAM parameters...
Mar  2 19:13:52 multipath kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  2 19:13:52 multipath kernel: SCSI device sdb: 33554432 512-byte hdwr sectors (17180 MB)
Mar  2 19:13:52 multipath kernel: sdb: Write Protect is off
Mar  2 19:13:52 multipath kernel: SCSI device sdb: drive cache: write through
Mar  2 19:13:52 multipath kernel: SCSI device sdb: 33554432 512-byte hdwr sectors (17180 MB)
Mar  2 19:13:52 multipath kernel: sdb: Write Protect is off
Mar  2 19:13:52 multipath kernel: SCSI device sdb: drive cache: write through
Mar  2 19:13:52 multipath kernel:  sdb: unknown partition table
Mar  2 19:13:52 multipath kernel: sd 4:0:0:0: Attached scsi disk sdb
Mar  2 19:13:52 multipath kernel: qla2xxx 0000:06:01.0: Verifying loaded RISC code...
Mar  2 19:13:52 multipath kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  2 19:13:52 multipath scsi.agent[4288]: disk at /devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:01.0/host4/rport-4:0-0/target4:0:0/4:0:0:0
Mar  2 19:13:52 multipath kernel: SCSI device sdc: 67108864 512-byte hdwr sectors (34360 MB)
Mar  2 19:13:52 multipath kernel: sdc: Write Protect is off
Mar  2 19:13:52 multipath kernel: SCSI device sdc: drive cache: write through
Mar  2 19:13:52 multipath kernel: SCSI device sdc: 67108864 512-byte hdwr sectors (34360 MB)
Mar  2 19:13:52 multipath kernel: sdc: Write Protect is off
Mar  2 19:13:52 multipath kernel: SCSI device sdc: drive cache: write through
Mar  2 19:13:52 multipath kernel:  sdc: unknown partition table
Mar  2 19:13:52 multipath kernel: sd 4:0:0:1: Attached scsi disk sdc
Mar  2 19:13:52 multipath kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Mar  2 19:13:52 multipath kernel: sdd : very big device. try to use READ CAPACITY(16).
Mar  2 19:13:52 multipath kernel: SCSI device sdd: 9797894144 512-byte hdwr sectors (5016522 MB)
Mar  2 19:13:52 multipath kernel: sdd: Write Protect is off
Mar  2 19:13:52 multipath kernel: SCSI device sdd: drive cache: write through
Mar  2 19:13:52 multipath kernel: sdd : very big device. try to use READ CAPACITY(16).
Mar  2 19:13:52 multipath kernel: SCSI device sdd: 9797894144 512-byte hdwr sectors (5016522 MB)
Mar  2 19:13:52 multipath kernel: sdd: Write Protect is off
Mar  2 19:13:52 multipath kernel: SCSI device sdd: drive cache: write through
Mar  2 19:13:52 multipath scsi.agent[4313]: disk at /devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:01.0/host4/rport-4:0-0/target4:0:0/4:0:0:1
Mar  2 19:13:52 multipath kernel:  sdd: unknown partition table
Mar  2 19:13:52 multipath kernel: sd 4:0:0:2: Attached scsi disk sdd
Mar  2 19:13:52 multipath scsi.agent[4331]: disk at /devices/pci0000:00/0000:00:02.0/0000:01:00.2/0000:03:01.0/host4/rport-4:0-0/target4:0:0/4:0:0:2
Mar  2 19:13:52 multipath kernel: qla2xxx 0000:06:01.0: Waiting for LIP to complete...
Mar  2 19:14:12 multipath kernel: qla2xxx 0000:06:01.0: Cable is unplugged...
Mar  2 19:14:12 multipath kernel: scsi5 : qla2xxx
Mar  2 19:14:12 multipath kernel: qla2xxx 0000:06:01.0:
Mar  2 19:14:12 multipath kernel:  QLogic Fibre Channel HBA Driver: 8.01.04-k
Mar  2 19:14:12 multipath kernel:   QLogic QLA2340 -
Mar  2 19:14:12 multipath kernel:   ISP2312: PCI-X (133 MHz) @ 0000:06:01.0 hdma-, host#=5, fw=3.03.18 IPX
Mar  2 19:14:17 multipath kernel: qla2xxx 0000:06:01.0: Unable to retrieve host statistics (65535).
Mar  2 19:14:18 multipath last message repeated 19 times
Mar  2 19:22:02 multipath kernel: qla2xxx 0000:03:01.0: LOOP DOWN detected (2).
Mar  2 19:22:08 multipath kernel:  rport-4:0-0: blocked FC remote port time out: removing target and saving binding
Mar  2 19:24:04 multipath kernel: qla2xxx 0000:03:01.0: LIP reset occured (f7f7).
Mar  2 19:24:04 multipath kernel: qla2xxx 0000:03:01.0: LOOP UP detected (2 Gbps).

