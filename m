Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932790AbWCRPeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbWCRPeG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbWCRPeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:34:06 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:39881 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932790AbWCRPeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:34:04 -0500
Date: Sat, 18 Mar 2006 16:10:10 +0100
From: Sander <sander@humilis.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, jgarzik@favonius.humilis.net, lkml@rtr.ca
Subject: sata_mv success on 2.6.16-rc6-mm2  (was: Re: 2.6.16-rc6-mm2)
Message-ID: <20060318151010.GA19568@favonius>
Reply-To: sander@humilis.net
References: <20060318044056.350a2931.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
X-Uptime: 14:11:09 up 15 days, 18:21, 32 users,  load average: 4.47, 5.47, 6.56
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote (ao):
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/

Good news! This kernel lets me use eight Maxtor sata disks in raid5 over
nForce4 and Marvell MV88SX6081.

I do:
mdadm -C -l5 -n8 /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1 \
/dev/sdd1 /dev/sde1 /dev/sdf1 /dev/sdg1 /dev/sdh1

mke2fs -j -m1 /dev/md0
mount -o data=writeback,nobh /dev/md0 /mnt

for i in `seq 10`
do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
done
md5sum bigfile.*
rm bigfile.*

and

for i in `seq 10`
do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000 &
done
sleep 1200
md5sum bigfile.*
rm bigfile.*

and

for i in `seq 4`
do ( dd if=/dev/zero of=bigfile.$i bs=1024k count=10000 ; \
time md5sum bigfile.$i ) &
done

I experience no crash and no data corruption with these simple tests.

2.6.16-rc6 crashes with no output of the crash on netconsole (have to
find a screen to connect to the system).

2.6.16-rc3 crashes too:
http://www.ussg.iu.edu/hypermail/linux/kernel/0602.2/0360.html

I haven't tried 2.6.16-rc6-mm1.

With 2.6.16-rc6-mm2 I do get "BUG: warning ..." and "Call Trace: ..."
messages during boot (see dmesg below), which are not there with 2.6.16-rc6.
But that seems not to cause any problems.

I also see these appear during the tests:

[ 3584.499415] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 3584.499469] ata5: status=0xd0 { Busy }
[ 4430.676302] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 4430.676355] ata9: status=0xd0 { Busy }

But with no visible effect.

Thanks!

	Kind regards, Sander


[   82.078411] libata version 1.20 loaded.
[   82.078449] sata_nv 0000:00:07.0: version 0.8
[   82.078457] ACPI (acpi_bus-0216): Device 'SAT0' is not power manageable [20060210]
[   82.078917] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 23
[   82.078967] GSI 20 sharing vector 0xD1 and IRQ 20
[   82.079015] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 23 (level, high) -> IRQ 20
[   82.079376] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   82.079446] ata1: SATA max UDMA/133 cmd 0x1440 ctl 0x1436 bmdma 0x1410 irq 20
[   82.079520] ata2: SATA max UDMA/133 cmd 0x1438 ctl 0x1432 bmdma 0x1418 irq 20
[   82.295014] ata1: SATA link up 3.0 Gbps (SStatus 123)
[   82.494850] ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f69 84:4773 85:7c69 86:3e01 87:4763 88:407f
[   82.494854] ata1: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
[   82.496131] nv_sata: Primary device added
[   82.496184] nv_sata: Primary device removed
[   82.496228] nv_sata: Secondary device added
[   82.496273] nv_sata: Secondary device removed
[   82.524820] ata1: dev 0 configured for UDMA/133
[   82.524865] scsi0 : sata_nv
[   82.744454] ata2: SATA link down (SStatus 0)
[   82.744500] scsi1 : sata_nv
[   82.744637]   Vendor: ATA       Model: Maxtor 7H500F0    Rev: HA43
[   82.745399]   Type:   Direct-Access                      ANSI SCSI revision: 05
[   82.745582] ACPI (acpi_bus-0216): Device 'SAT1' is not power manageable [20060210]
[   82.746058] ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 22
[   82.746108] GSI 21 sharing vector 0xD9 and IRQ 21
[   82.746157] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 22 (level, high) -> IRQ 21
[   82.746485] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   82.746551] ata3: SATA max UDMA/133 cmd 0x1458 ctl 0x144E bmdma 0x1420 irq 21
[   82.746628] ata4: SATA max UDMA/133 cmd 0x1450 ctl 0x144A bmdma 0x1428 irq 21
[   82.964178] ata3: SATA link down (SStatus 0)
[   82.964222] scsi2 : sata_nv
[   83.183902] ata4: SATA link down (SStatus 0)
[   83.183946] scsi3 : sata_nv
[   83.184069] sata_mv 0000:0a:03.0: version 0.6
[   83.184129] GSI 22 sharing vector 0xE1 and IRQ 22
[   83.184174] ACPI: PCI Interrupt 0000:0a:03.0[A] -> GSI 30 (level, low) -> IRQ 22
[   83.187740] sata_mv 0000:0a:03.0: 32 slots 8 ports SCSI mode IRQ via INTx
[   83.187857] ata5: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000222120 bmdma 0x0 irq 22
[   83.187951] ata6: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000224120 bmdma 0x0 irq 22
[   83.188042] ata7: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000226120 bmdma 0x0 irq 22
[   83.188132] ata8: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000228120 bmdma 0x0 irq 22
[   83.188222] ata9: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000232120 bmdma 0x0 irq 22
[   83.188314] ata10: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000234120 bmdma 0x0 irq 22
[   83.188404] ata11: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000236120 bmdma 0x0 irq 22
[   83.188495] ata12: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000238120 bmdma 0x0 irq 22
[   83.244314] BUG: warning at drivers/scsi/sata_mv.c:1896/__msleep()
[   83.244362] 
[   83.244362] Call Trace: <IRQ> <ffffffff80408d00>{__mv_phy_reset+242}
[   83.244509]        <ffffffff804081ec>{mv_channel_reset+133} <ffffffff80409361>{mv_interrupt+565}
[   83.244669]        <ffffffff8023bf2c>{handle_IRQ_event+41} <ffffffff8023bffa>{__do_IRQ+155}
[   83.244828]        <ffffffff8020c13b>{do_IRQ+59} <ffffffff8020834c>{default_idle+0}
[   83.244989]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804eb96d>{thread_return+86}
[   83.245172]        <ffffffff80208379>{default_idle+45} <ffffffff80208406>{cpu_idle+98}
[   83.245329]        <ffffffff807c4018>{start_secondary+1224}
[   86.569852] ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:007f
[   86.569856] ata5: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[   86.570840] BUG: warning at drivers/scsi/libata-core.c:3884/__ata_qc_complete()
[   86.570902] 
[   86.570903] Call Trace: <IRQ> <ffffffff80401694>{__ata_qc_complete+98}
[   86.571046]        <ffffffff8040939e>{mv_interrupt+626} <ffffffff8023bf2c>{handle_IRQ_event+41}
[   86.571208]        <ffffffff8023bffa>{__do_IRQ+155} <ffffffff8020c13b>{do_IRQ+59}
[   86.571365]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804eccd2>{__reacquire_kernel_lock+39}
[   86.571552]        <ffffffff804eb9bd>{thread_return+166} <ffffffff804ebfe5>{schedule_timeout+138}
[   86.571713]        <ffffffff8022a66c>{process_timeout+0} <ffffffff804eaeaf>{wait_for_completion_timeout+137}
[   86.571878]        <ffffffff8021cc6f>{default_wake_function+0} <ffffffff80407402>{ata_exec_command+36}
[   86.572042]        <ffffffff804038b8>{ata_exec_internal+266} <ffffffff80404473>{ata_set_mode+667}
[   86.575479]        <ffffffff8023c4d1>{request_irq+130} <ffffffff804049f4>{ata_device_add+1163}
[   86.575639]        <ffffffff80409a41>{mv_init_one+1547} <ffffffff8036c8b2>{pci_device_probe+221}
[   86.575799]        <ffffffff803b999d>{driver_probe_device+82} <ffffffff803b9a52>{__driver_attach+0}
[   86.575959]        <ffffffff803b9aa8>{__driver_attach+86} <ffffffff803b8f5a>{bus_for_each_dev+67}
[   86.576121]        <ffffffff803b925a>{bus_add_driver+116} <ffffffff8036c918>{pci_bus_match+0}
[   86.576279]        <ffffffff8036c418>{__pci_register_driver+85} <ffffffff8020720c>{init+455}
[   86.576438]        <ffffffff8020a6b6>{child_rip+8} <ffffffff80207045>{init+0}
[   86.576582]        <ffffffff8020a6ae>{child_rip+0}
[   86.599812] ata5: dev 0 configured for UDMA/133
[   86.599856] scsi4 : sata_mv
[   89.975572] ata6: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
[   89.975576] ata6: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[   89.976575] BUG: warning at drivers/scsi/libata-core.c:3884/__ata_qc_complete()
[   89.976637] 
[   89.976638] Call Trace: <IRQ> <ffffffff80401694>{__ata_qc_complete+98}
[   89.976780]        <ffffffff8040939e>{mv_interrupt+626} <ffffffff8023bf2c>{handle_IRQ_event+41}
[   89.976943]        <ffffffff8023bffa>{__do_IRQ+155} <ffffffff8020c13b>{do_IRQ+59}
[   89.977100]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804eb96d>{thread_return+86}
[   89.977287]        <ffffffff804ebfe5>{schedule_timeout+138} <ffffffff8022a66c>{process_timeout+0}
[   89.977450]        <ffffffff804eaeaf>{wait_for_completion_timeout+137}
[   89.977546]        <ffffffff8021cc6f>{default_wake_function+0} <ffffffff80407402>{ata_exec_command+36}
[   89.977710]        <ffffffff804038b8>{ata_exec_internal+266} <ffffffff80404473>{ata_set_mode+667}
[   89.977871]        <ffffffff804049f4>{ata_device_add+1163} <ffffffff80409a41>{mv_init_one+1547}
[   89.978032]        <ffffffff8036c8b2>{pci_device_probe+221} <ffffffff803b999d>{driver_probe_device+82}
[   89.978195]        <ffffffff803b9a52>{__driver_attach+0} <ffffffff803b9aa8>{__driver_attach+86}
[   89.978355]        <ffffffff803b8f5a>{bus_for_each_dev+67} <ffffffff803b925a>{bus_add_driver+116}
[   89.978514]        <ffffffff8036c918>{pci_bus_match+0} <ffffffff8036c418>{__pci_register_driver+85}
[   89.978676]        <ffffffff8020720c>{init+455} <ffffffff8020a6b6>{child_rip+8}
[   89.978832]        <ffffffff80207045>{init+0} <ffffffff8020a6ae>{child_rip+0}
[   90.005534] ata6: dev 0 configured for UDMA/133
[   90.005579] scsi5 : sata_mv
[   93.381295] ata7: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:007f
[   93.381299] ata7: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[   93.382285] BUG: warning at drivers/scsi/libata-core.c:3884/__ata_qc_complete()
[   93.382347] 
[   93.382348] Call Trace: <IRQ> <ffffffff80401694>{__ata_qc_complete+98}
[   93.382491]        <ffffffff8040939e>{mv_interrupt+626} <ffffffff8023bf2c>{handle_IRQ_event+41}
[   93.382652]        <ffffffff8023bffa>{__do_IRQ+155} <ffffffff8020c13b>{do_IRQ+59}
[   93.382810]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804ecb0e>{_spin_lock_irqsave+2}
[   93.382996]        <ffffffff8022a1d9>{lock_timer_base+27} <ffffffff8022addd>{try_to_del_timer_sync+22}
[   93.383157]        <ffffffff8022ae2c>{del_timer_sync+12} <ffffffff804ebfed>{schedule_timeout+146}
[   93.383317]        <ffffffff8022a66c>{process_timeout+0} <ffffffff804eaeaf>{wait_for_completion_timeout+137}
[   93.383480]        <ffffffff8021cc6f>{default_wake_function+0} <ffffffff80407402>{ata_exec_command+36}
[   93.383642]        <ffffffff804038b8>{ata_exec_internal+266} <ffffffff80404473>{ata_set_mode+667}
[   93.383803]        <ffffffff804049f4>{ata_device_add+1163} <ffffffff80409a41>{mv_init_one+1547}
[   93.383965]        <ffffffff8036c8b2>{pci_device_probe+221} <ffffffff803b999d>{driver_probe_device+82}
[   93.384125]        <ffffffff803b9a52>{__driver_attach+0} <ffffffff803b9aa8>{__driver_attach+86}
[   93.384285]        <ffffffff803b8f5a>{bus_for_each_dev+67} <ffffffff803b925a>{bus_add_driver+116}
[   93.384446]        <ffffffff8036c918>{pci_bus_match+0} <ffffffff8036c418>{__pci_register_driver+85}
[   93.384606]        <ffffffff8020720c>{init+455} <ffffffff8020a6b6>{child_rip+8}
[   93.384762]        <ffffffff80207045>{init+0} <ffffffff8020a6ae>{child_rip+0}
[   93.411257] ata7: dev 0 configured for UDMA/133
[   93.411304] scsi6 : sata_mv
[   96.787019] ata8: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:007f
[   96.787023] ata8: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[   96.788019] BUG: warning at drivers/scsi/libata-core.c:3884/__ata_qc_complete()
[   96.788081] 
[   96.788081] Call Trace: <IRQ> <ffffffff80401694>{__ata_qc_complete+98}
[   96.788224]        <ffffffff8040939e>{mv_interrupt+626} <ffffffff8023bf2c>{handle_IRQ_event+41}
[   96.788385]        <ffffffff8023bffa>{__do_IRQ+155} <ffffffff8020c13b>{do_IRQ+59}
[   96.788541]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff8022a1c4>{lock_timer_base+6}
[   96.788726]        <ffffffff8022addd>{try_to_del_timer_sync+22} <ffffffff8022ae2c>{del_timer_sync+12}
[   96.788886]        <ffffffff804ebfed>{schedule_timeout+146} <ffffffff8022a66c>{process_timeout+0}
[   96.789046]        <ffffffff804eaeaf>{wait_for_completion_timeout+137}
[   96.789142]        <ffffffff8021cc6f>{default_wake_function+0} <ffffffff804ecb5d>{_spin_unlock_irqrestore+8}
[   96.789302]        <ffffffff804038b8>{ata_exec_internal+266} <ffffffff80404473>{ata_set_mode+667}
[   96.789462]        <ffffffff804049f4>{ata_device_add+1163} <ffffffff80409a41>{mv_init_one+1547}
[   96.789625]        <ffffffff8036c8b2>{pci_device_probe+221} <ffffffff803b999d>{driver_probe_device+82}
[   96.789787]        <ffffffff803b9a52>{__driver_attach+0} <ffffffff803b9aa8>{__driver_attach+86}
[   96.789947]        <ffffffff803b8f5a>{bus_for_each_dev+67} <ffffffff803b925a>{bus_add_driver+116}
[   96.790110]        <ffffffff8036c918>{pci_bus_match+0} <ffffffff8036c418>{__pci_register_driver+85}
[   96.790270]        <ffffffff8020720c>{init+455} <ffffffff8020a6b6>{child_rip+8}
[   96.790426]        <ffffffff80207045>{init+0} <ffffffff8020a6ae>{child_rip+0}
[   96.816981] ata8: dev 0 configured for UDMA/133
[   96.817025] scsi7 : sata_mv
[  100.192743] ata9: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
[  100.192747] ata9: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  100.193757] BUG: warning at drivers/scsi/libata-core.c:3884/__ata_qc_complete()
[  100.193819] 
[  100.193820] Call Trace: <IRQ> <ffffffff80401694>{__ata_qc_complete+98}
[  100.193963]        <ffffffff8040939e>{mv_interrupt+626} <ffffffff8023bf2c>{handle_IRQ_event+41}
[  100.194124]        <ffffffff8023bffa>{__do_IRQ+155} <ffffffff8020c13b>{do_IRQ+59}
[  100.194283]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804eb973>{thread_return+92}
[  100.194469]        <ffffffff804ebfe5>{schedule_timeout+138} <ffffffff8022a66c>{process_timeout+0}
[  100.194629]        <ffffffff804eaeaf>{wait_for_completion_timeout+137}
[  100.194724]        <ffffffff8021cc6f>{default_wake_function+0} <ffffffff80407402>{ata_exec_command+36}
[  100.194887]        <ffffffff804038b8>{ata_exec_internal+266} <ffffffff80404473>{ata_set_mode+667}
[  100.195048]        <ffffffff804049f4>{ata_device_add+1163} <ffffffff80409a41>{mv_init_one+1547}
[  100.195208]        <ffffffff8036c8b2>{pci_device_probe+221} <ffffffff803b999d>{driver_probe_device+82}
[  100.195372]        <ffffffff803b9a52>{__driver_attach+0} <ffffffff803b9aa8>{__driver_attach+86}
[  100.195531]        <ffffffff803b8f5a>{bus_for_each_dev+67} <ffffffff803b925a>{bus_add_driver+116}
[  100.195690]        <ffffffff8036c918>{pci_bus_match+0} <ffffffff8036c418>{__pci_register_driver+85}
[  100.195853]        <ffffffff8020720c>{init+455} <ffffffff8020a6b6>{child_rip+8}
[  100.196010]        <ffffffff80207045>{init+0} <ffffffff8020a6ae>{child_rip+0}
[  100.222704] ata9: dev 0 configured for UDMA/133
[  100.222749] scsi8 : sata_mv
[  103.598467] ata10: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:007f
[  103.598471] ata10: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  103.599467] BUG: warning at drivers/scsi/libata-core.c:3884/__ata_qc_complete()
[  103.599530] 
[  103.599531] Call Trace: <IRQ> <ffffffff80401694>{__ata_qc_complete+98}
[  103.599674]        <ffffffff8040939e>{mv_interrupt+626} <ffffffff8023bf2c>{handle_IRQ_event+41}
[  103.599834]        <ffffffff8023bffa>{__do_IRQ+155} <ffffffff8020c13b>{do_IRQ+59}
[  103.599992]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804eccd2>{__reacquire_kernel_lock+39}
[  103.600179]        <ffffffff804eb9bd>{thread_return+166} <ffffffff804ebfe5>{schedule_timeout+138}
[  103.600340]        <ffffffff8022a66c>{process_timeout+0} <ffffffff804eaeaf>{wait_for_completion_timeout+137}
[  103.600502]        <ffffffff8021cc6f>{default_wake_function+0} <ffffffff80407402>{ata_exec_command+36}
[  103.600666]        <ffffffff804038b8>{ata_exec_internal+266} <ffffffff80404473>{ata_set_mode+667}
[  103.600826]        <ffffffff804049f4>{ata_device_add+1163} <ffffffff80409a41>{mv_init_one+1547}
[  103.600986]        <ffffffff8036c8b2>{pci_device_probe+221} <ffffffff803b999d>{driver_probe_device+82}
[  103.601152]        <ffffffff803b9a52>{__driver_attach+0} <ffffffff803b9aa8>{__driver_attach+86}
[  103.601314]        <ffffffff803b8f5a>{bus_for_each_dev+67} <ffffffff803b925a>{bus_add_driver+116}
[  103.604759]        <ffffffff8036c918>{pci_bus_match+0} <ffffffff8036c418>{__pci_register_driver+85}
[  103.604919]        <ffffffff8020720c>{init+455} <ffffffff8020a6b6>{child_rip+8}
[  103.605075]        <ffffffff80207045>{init+0} <ffffffff8020a6ae>{child_rip+0}
[  103.628428] ata10: dev 0 configured for UDMA/133
[  103.628473] scsi9 : sata_mv
[  106.994203] ata11: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
[  106.994207] ata11: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
[  106.995198] BUG: warning at drivers/scsi/libata-core.c:3884/__ata_qc_complete()
[  106.995261] 
[  106.995262] Call Trace: <IRQ> <ffffffff80401694>{__ata_qc_complete+98}
[  106.995405]        <ffffffff8040939e>{mv_interrupt+626} <ffffffff8023bf2c>{handle_IRQ_event+41}
[  106.995565]        <ffffffff8023bffa>{__do_IRQ+155} <ffffffff8020c13b>{do_IRQ+59}
[  106.995722]        <ffffffff80209d64>{ret_from_intr+0} <EOI> <ffffffff804eb917>{thread_return+0}
[  106.995907]        <ffffffff804eb9bd>{thread_return+166} <ffffffff804eb9ec>{thread_return+213}
[  106.996069]        <ffffffff804ebfe5>{schedule_timeout+138} <ffffffff8022a66c>{process_timeout+0}
[  106.996228]        <ffffffff804eaeaf>{wait_for_completion_timeout+137}
[  106.996325]        <ffffffff8021cc6f>{default_wake_function+0} <ffffffff80407402>{ata_exec_command+36}
[  106.996486]        <ffffffff804038b8>{ata_exec_internal+266} <ffffffff80404473>{ata_set_mode+667}
[  106.996646]        <ffffffff804049f4>{ata_device_add+1163} <ffffffff80409a41>{mv_init_one+1547}
[  106.996808]        <ffffffff8036c8b2>{pci_device_probe+221} <ffffffff803b999d>{driver_probe_device+82}
[  106.996969]        <ffffffff803b9a52>{__driver_attach+0} <ffffffff803b9aa8>{__driver_attach+86}
[  106.997129]        <ffffffff803b8f5a>{bus_for_each_dev+67} <ffffffff803b925a>{bus_add_driver+116}
[  106.997291]        <ffffffff8036c918>{pci_bus_match+0} <ffffffff8036c418>{__pci_register_driver+85}
[  106.997453]        <ffffffff8020720c>{init+455} <ffffffff8020a6b6>{child_rip+8}
[  106.997611]        <ffffffff80207045>{init+0} <ffffffff8020a6ae>{child_rip+0}
[  107.024165] ata11: dev 0 configured for UDMA/133
[  107.024210] scsi10 : sata_mv
[  107.073907] ata12: no device found (phy stat 00000000)
[  107.073953] scsi11 : sata_mv
[  107.074082]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  107.074841]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  107.075044]   Vendor: ATA       Model: Maxtor 6L300S0    Rev: BACE
[  107.075798]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  107.075994]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  107.076749]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  107.076944]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  107.077701]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  107.077900]   Vendor: ATA       Model: Maxtor 6L300S0    Rev: BACE
[  107.078653]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  107.078857]   Vendor: ATA       Model: Maxtor 6B300S0    Rev: BANC
[  107.079610]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  107.079806]   Vendor: ATA       Model: Maxtor 6L300S0    Rev: BACE
[  107.080559]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  107.080785] SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
[  107.080848] sda: Write Protect is off
[  107.080893] sda: Mode Sense: 00 3a 00 00
[  107.080905] SCSI device sda: drive cache: write back
[  107.081014] SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
[  107.081069] sda: Write Protect is off
[  107.081112] sda: Mode Sense: 00 3a 00 00
[  107.081124] SCSI device sda: drive cache: write back
[  107.081170]  sda: sda1
[  107.099237] sd 0:0:0:0: Attached scsi disk sda

etc, etc.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
