Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262594AbTCRW7k>; Tue, 18 Mar 2003 17:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbTCRW7k>; Tue, 18 Mar 2003 17:59:40 -0500
Received: from web10105.mail.yahoo.com ([216.136.130.55]:13851 "HELO
	web10105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262594AbTCRW7i>; Tue, 18 Mar 2003 17:59:38 -0500
Message-ID: <20030318231033.31663.qmail@web10105.mail.yahoo.com>
Date: Tue, 18 Mar 2003 15:10:33 -0800 (PST)
From: Eric Benson <eric_a_benson@yahoo.com>
Subject: ide-scsi failure on 2.5.65
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed Red Hat 8.0 on an IBM NetVista 2283-55U,
an all-in-one desktop 1.8ghz P4. I downloaded and
compiled the 2.5.65 kernel with ide-scsi emulation and
kernel debugging enabled.

These are probably the relevant settings from the
config:
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_SCSI=y
CONFIG_DEBUG_KERNEL=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y

And these are extracted from the bootup messages:
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
ICH2: IDE controller at PCI slot 00:1f.1

hdb: SAMSUNG CDRW/DVD SM-308B, ATAPI CD/DVD-ROM drive
scsi0 : SCSI host adapter emulation for IDE ATAPI
devices
  Vendor: SAMSUNG   Model: CDRW/DVD SM-308B  Rev: T103

 The application was "cdrdao read-cd", a recent
version that worked without difficulty on Red Hat's
2.4.18 kernels. Running the same command on 2.5.65
causes a failure that prints the following into
/var/log/messages.

14:18:02 hdb: irq timeout: status=0xd0 { Busy }
14:18:02 hdb: DMA disabled
14:18:02 hdb: ATAPI reset complete
14:18:02 hdb: status error: status=0x08 { DataRequest
}
14:18:02 hdb: drive not ready for command
14:18:02 hdb: irq timeout: status=0xd0 { Busy }
14:18:02 hdb: ATAPI reset complete
14:18:02 hdb: irq timeout: status=0x80 { Busy }
14:18:02 hdb: status timeout: status=0x80 { Busy }
14:18:02 hdb: drive not ready for command
14:18:02 hdb: ATAPI reset complete
14:18:02 hdb: status error: status=0x08 { DataRequest
}
14:18:02 hdb: drive not ready for command
14:18:02 hdb: status error: status=0x08 { DataRequest
}
14:18:02 hdb: drive not ready for command
14:18:03 hdb: status error: status=0x08 { DataRequest
}
14:18:33 hdb: drive not ready for command
14:18:33 ide-scsi: reset called for 0
14:18:33 bad: scheduling while atomic!
14:18:33 Call Trace:
14:18:33  [<c028c366>] ide_dma_intr+0x0/0xba
14:18:33  [<c01160fb>] schedule+0x3a3/0x3a8
14:18:33  [<c028c366>] ide_dma_intr+0x0/0xba
14:18:33  [<c0120f36>] schedule_timeout+0x5a/0xac
14:18:33  [<c0119d31>] printk+0x11d/0x17c
14:18:33  [<c0120ed0>] process_timeout+0x0/0xc
14:18:33  [<c0299641>] idescsi_reset+0x105/0x11c
14:18:33  [<c0293245>]
scsi_try_bus_device_reset+0x57/0x8e
14:18:33  [<c02932e1>]
scsi_eh_bus_device_reset+0x65/0x108
14:18:33  [<c0293ab0>] scsi_eh_ready_devs+0x28/0x74
14:18:33  [<c0293c2c>] scsi_unjam_host+0xc2/0xcc
14:18:33  [<c0293d16>] scsi_error_handler+0xe0/0x124
14:18:33  [<c0293c36>] scsi_error_handler+0x0/0x124
14:18:33  [<c0107289>] kernel_thread_helper+0x5/0xc
14:18:33 
14:18:33 ------------[ cut here ]------------
14:18:33 kernel BUG at kernel/timer.c:155!
14:18:33 invalid operand: 0000
14:18:33 CPU:    0
14:18:33 EIP:    0060:[<c0120286>]    Not tainted
14:18:33 EFLAGS: 00010002
14:18:33 EIP is at add_timer+0x124/0x132
14:18:33 eax: 00000001   ebx: f7daa4a4   ecx: c03d3360
  edx: c048b5c4
14:18:33 esi: f7d06000   edi: 00000092   ebp: f7d07e90
  esp: f7d07e88
14:18:33 ds: 007b   es: 007b   ss: 0068
14:18:33 Process scsi_eh_0 (pid: 9,
threadinfo=f7d06000 task=f7db6700)
14:18:33 Stack: f7d07ed0 f7daa480 f7d07ec0 c02817d1
f7daa4a4 c011602e 00000060 00000246 
14:18:33        00000000 00000032 c02818c4 00000000
c048b5c4 c048b5c4 f7d07ef0 c0281eb2 
14:18:33        c048b5c4 c02818c4 00000032 00000000
f7daa480 c048b240 00000092 00000000 
14:18:33 Call Trace:
14:18:33  [<c02817d1>] ide_set_handler+0x5f/0xa0
14:18:33  [<c011602e>] schedule+0x2d6/0x3a8
14:18:33  [<c02818c4>] atapi_reset_pollfunc+0x0/0x11a
14:18:33  [<c0281eb2>] do_reset1+0x214/0x232
14:18:33  [<c02818c4>] atapi_reset_pollfunc+0x0/0x11a
14:18:33  [<c0281f01>] ide_do_reset+0x31/0x84
14:18:33  [<c029961a>] idescsi_reset+0xde/0x11c
14:18:33  [<c0293245>]
scsi_try_bus_device_reset+0x57/0x8e
14:18:33  [<c02932e1>]
scsi_eh_bus_device_reset+0x65/0x108
14:18:33  [<c0293ab0>] scsi_eh_ready_devs+0x28/0x74
14:18:33  [<c0293c2c>] scsi_unjam_host+0xc2/0xcc
14:18:33  [<c0293d16>] scsi_error_handler+0xe0/0x124
14:18:33  [<c0293c36>] scsi_error_handler+0x0/0x124
14:18:33  [<c0107289>] kernel_thread_helper+0x5/0xc
14:18:33 
14:18:33 Code: 0f 0b 9b 00 8b 8a 37 c0 e9 01 ff ff ff
90 55 31 c0 89 e5 53 
14:18:33  <6>note: scsi_eh_0[9] exited with
preempt_count 3
14:18:33 hda: ATAPI reset 


__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
