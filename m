Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268052AbUIJENb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268052AbUIJENb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 00:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUIJENb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 00:13:31 -0400
Received: from scrye.com ([216.17.180.1]:20920 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S268052AbUIJENX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 00:13:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 9 Sep 2004 22:13:16 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com, pavel@ucw.cz
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: FYI: my current bigdiff
X-Draft-From: ("scrye.linux.kernel" 66164)
References: <20040909134421.GA12204@elf.ucw.cz>
Message-Id: <20040910041320.DF700E7504@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

Pavel> Hi!  This is my bigdiff. It is not for inclusion (I'll have to
Pavel> split it), but it contains some usefull code (I believe :-).

Pavel> Oh, it speeds up swsusp quite a lot.

Indeed it does. 

After 42 days of uptime with 2.6.8-rc2-mm1 I decided to upgrade. 
swsusp was very stable, but was getting slower and slower. Eariler
tonight I suspended and it took about 15min to finish suspending. 

So, I built a new 2.6.9-rc1-mm4 + this bigdiff for swsusp. 

First suspend worked. 
First resume came back, but all kinds of problems with my network,
with my usb, and with sound. 

After looking around a bit it seems this is the issue: 

Sep  9 21:32:27 voldemort kernel: ** PCI interrupts are no longer routed automatically.  If this
Sep  9 21:32:27 voldemort kernel: ** causes a device to stop working, it is probably because the
Sep  9 21:32:27 voldemort kernel: ** driver failed to call pci_enable_device().  As a temporary
Sep  9 21:32:27 voldemort kernel: ** workaround, the "pci=routeirq" argument restores the old
Sep  9 21:32:27 voldemort kernel: ** behavior.  If this argument makes the device work again,
Sep  9 21:32:27 voldemort kernel: ** please email the output of "lspci" to bjorn.helgaas@hp.com
Sep  9 21:32:27 voldemort kernel: ** so I can fix the driver.

After that first suspend/resume:

Sep  9 21:35:28 voldemort kernel: Stopping tasks: ====================================|
Sep  9 21:35:28 voldemort kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H
\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-
^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^
H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^Hdone (44436 pages freed)

(BTW, that looks pretty nasty in the logs, even though it's very nice
to watch)

Sep  9 21:35:28 voldemort kernel: swsusp: Need to copy 13410 pages
Sep  9 21:35:28 voldemort kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
Sep  9 21:35:28 voldemort kernel: ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
Sep  9 21:35:28 voldemort kernel: ACPI: PCI interrupt 0000:02:0e.1[B] -> GSI 10 (level, low) -> IRQ 10
Sep  9 21:35:28 voldemort kernel: Restarting tasks... done
Sep  9 21:35:30 voldemort kernel: usbcore: registered new driver usbfs
Sep  9 21:35:30 voldemort kernel: usbcore: registered new driver hub
Sep  9 21:35:30 voldemort kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Sep  9 21:35:30 voldemort kernel: ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
Sep  9 21:35:30 voldemort kernel: ohci_hcd 0000:02:0e.0: NEC Corporation USB
Sep  9 21:35:31 voldemort kernel: irq 10: nobody cared!
Sep  9 21:35:31 voldemort kernel:  [<c01083ef>] __report_bad_irq+0x2a/0x8b
Sep  9 21:35:31 voldemort kernel:  [<c01085e1>] note_interrupt+0x7c/0xde
Sep  9 21:35:31 voldemort kernel:  [<c0108847>] do_IRQ+0xf7/0x116
Sep  9 21:35:31 voldemort kernel:  [<c010678c>] common_interrupt+0x18/0x20
Sep  9 21:35:31 voldemort kernel:  [<c011fa5f>] __do_softirq+0x2f/0x87
Sep  9 21:35:31 voldemort kernel:  [<c011fadd>] do_softirq+0x26/0x28
Sep  9 21:35:31 voldemort kernel:  [<c0108826>] do_IRQ+0xd6/0x116
Sep  9 21:35:31 voldemort kernel:  [<c010678c>] common_interrupt+0x18/0x20
Sep  9 21:35:31 voldemort kernel:  [<c0108c71>] setup_irq+0x69/0xaa
Sep  9 21:35:31 voldemort kernel:  [<f88b68aa>] usb_hcd_irq+0x0/0x67 [usbcore]
Sep  9 21:35:31 voldemort kernel:  [<c010891c>] request_irq+0x83/0xc5
Sep  9 21:35:31 voldemort kernel:  [<f88ba6af>] usb_hcd_pci_probe+0x1f5/0x4dc [usbcore]
Sep  9 21:35:31 voldemort kernel:  [<f88b68aa>] usb_hcd_irq+0x0/0x67 [usbcore]
Sep  9 21:35:31 voldemort kernel:  [<c01863e1>] sysfs_make_dirent+0x2b/0x97
Sep  9 21:35:31 voldemort kernel:  [<c01e3e58>] pci_device_probe_static+0x52/0x61
Sep  9 21:35:31 voldemort kernel:  [<c01e3ea2>] __pci_device_probe+0x3b/0x4e
Sep  9 21:35:31 voldemort kernel:  [<c01e3ee1>] pci_device_probe+0x2c/0x4a
Sep  9 21:35:31 voldemort kernel:  [<c0229acd>] bus_match+0x3f/0x6a
Sep  9 21:35:31 voldemort kernel:  [<c0229bdf>] driver_attach+0x56/0x80
Sep  9 21:35:31 voldemort kernel:  [<c022a032>] bus_add_driver+0x91/0xaf
Sep  9 21:35:31 voldemort kernel:  [<c022a54d>] driver_register+0x2f/0x33
Sep  9 21:35:31 voldemort kernel:  [<c01e4120>] pci_register_driver+0x5c/0x84
Sep  9 21:35:31 voldemort kernel:  [<f887e037>] ohci_hcd_pci_init+0x37/0x44 [ohci_hcd]
Sep  9 21:35:31 voldemort kernel:  [<c0130ea8>] sys_init_module+0x135/0x1ba
Sep  9 21:35:31 voldemort kernel:  [<c0105dcd>] sysenter_past_esp+0x52/0x71
Sep  9 21:35:31 voldemort kernel: handlers:
Sep  9 21:35:31 voldemort kernel: [<f88b68aa>] (usb_hcd_irq+0x0/0x67 [usbcore])
Sep  9 21:35:31 voldemort kernel: Disabling IRQ #10
Sep  9 21:35:31 voldemort kernel: ohci_hcd 0000:02:0e.0: irq 10, pci mem 0x40180000
Sep  9 21:35:31 voldemort kernel: ohci_hcd 0000:02:0e.0: new USB bus registered, assigned bus number 1
Sep  9 21:35:32 voldemort kernel: hub 1-0:1.0: USB hub found
Sep  9 21:35:32 voldemort kernel: hub 1-0:1.0: 3 ports detected
Sep  9 21:35:32 voldemort kernel: ACPI: PCI interrupt 0000:02:0e.1[B] -> GSI 10 (level, low) -> IRQ 10
Sep  9 21:35:32 voldemort kernel: ohci_hcd 0000:02:0e.1: NEC Corporation USB (#2)
Sep  9 21:35:32 voldemort kernel: ohci_hcd 0000:02:0e.1: irq 10, pci mem 0x40200000
Sep  9 21:35:32 voldemort kernel: ohci_hcd 0000:02:0e.1: new USB bus registered, assigned bus number 2
Sep  9 21:35:33 voldemort kernel: hub 2-0:1.0: USB hub found
Sep  9 21:35:33 voldemort kernel: hub 2-0:1.0: 2 ports detected
Sep  9 21:35:33 voldemort kernel: Loaded prism54 driver, version 1.2
Sep  9 21:35:33 voldemort kernel: ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Sep  9 21:35:33 voldemort kernel: divert: allocating divert_blk for eth1
Sep  9 21:36:07 voldemort kernel: eth1: resetting device...
Sep  9 21:36:07 voldemort kernel: eth1: uploading firmware...
Sep  9 21:36:08 voldemort kernel: eth1: firmware upload complete
Sep  9 21:36:09 voldemort kernel: eth1: reset problem: no 'reset complete' IRQ seen
Sep  9 21:36:09 voldemort kernel: eth1: timeout waiting for mgmt response 1000, triggering device
Sep  9 21:36:10 voldemort kernel: eth1: timeout waiting for mgmt response
Sep  9 21:36:10 voldemort kernel: eth1: mgt_commit_list: failure. oid=ff020008 err=-110
Sep  9 21:36:10 voldemort kernel: eth1: timeout waiting for mgmt response 1000, triggering device
Sep  9 21:36:11 voldemort kernel: eth1: timeout waiting for mgmt response
Sep  9 21:36:11 voldemort kernel: eth1: mgt_commit_list: failure. oid=ff020003 err=-110
Sep  9 21:36:11 voldemort kernel: eth1: timeout waiting for mgmt response 1000, triggering device
Sep  9 21:36:12 voldemort kernel: eth1: timeout waiting for mgmt response
Sep  9 21:36:12 voldemort kernel: eth1: mgt_commit_list: failure. oid=10000000 err=-110
Sep  9 21:36:12 voldemort kernel: eth1: timeout waiting for mgmt response 1000, triggering device
Sep  9 21:36:13 voldemort kernel: eth1: timeout waiting for mgmt response
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=17000007 err=-110
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=19000001 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=10000002 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=19000004 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=12000000 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=12000001 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=12000002 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=12000004 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=12000005 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=12000006 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=12000007 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=12000003 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=150007e0 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=ff02000c err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit_list: failure. oid=ff020003 err=-12
Sep  9 21:36:13 voldemort kernel: eth1: mgmt tx queue is still full
Sep  9 21:36:13 voldemort kernel: eth1: mgt_update_addr: failure
Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit: failure
Sep  9 21:36:13 voldemort kernel: eth1: interface reset complete

Seems the usb and prism54 didn't play nice. 

After booting with the pci=routeirq as suggested wireless and usb
played nice on suspend resume again. 
I am copying this to the email address that is mentioned. 

So, after that glitch:

- - The display is much nicer. Congrats. 

- - Speed does seem to be nicer. It's taking me 40 seconds to do a
complete suspend/resume cycle. 

- - Should PREEMPT and/or HIMEM work with this version? I can test them
if support has been added/fixed/tweaked for them. 

I have only done a few cycles, but it looks nice and stable. I would
suggest you break it into smaller patches and get it applied. 
Being applied to the main tree would be nice. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBQSng3imCezTjY0ERAjT0AJwNvCL3WbN2ypJQedPOjL3nlF8DMwCeJYss
WNY5zEepODMsOoq2GNrWhfI=
=vFww
-----END PGP SIGNATURE-----
