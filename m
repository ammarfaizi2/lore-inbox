Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTKXXnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbTKXXnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:43:47 -0500
Received: from ns.tasking.nl ([195.193.207.2]:27402 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S261724AbTKXXnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:43:41 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <Pine.LNX.4.58.0311241524310.1245@morpheus> <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos> <20031124173527.GA1561@mail.shareable.org> <1069700224.459.60.camel@hosts> <Pine.LNX.4.58.0311241457330.575@death> <Pine.LNX.4.58.0311241524310.1245@morpheus> <Pine.LNX.4.58.0311241549110.758@death>
From: dick.streefland@xs4all.nl (Dick Streefland)
Subject: Re: aic7xxx loading oops in 2.6.0-test10
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <fc3.3fc2976d.2018a@altium.nl>
Date: Mon, 24 Nov 2003 23:42:37 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Witherow <ken@krwtech.com> wrote:
| On Mon, 24 Nov 2003, Burton Windle wrote:
| 
| > http://marc.theaimsgroup.com/?l=linux-scsi&m=106965748506343&w=2
| >
| > This one-liner fixed my hang-on-boot with my AIC7880.
| 
| This patch does indeed fix the hang for me

I can confirm that. My 2.6.0-test10 kernel was hanging between the IDE
and SCSI probes:

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
hda: max request size: 128KiB
hda: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4
hdb: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
PCI: Enabling device 0000:00:14.0 (0000 -> 0003)
*** hang ***
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

The patch fixes the hang, but causes another problem:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
Badness in kobject_get at /work/kernel/linux-2.6.0-test10/lib/kobject.c:439
Call Trace:
 [kobject_get+80/96] kobject_get+0x50/0x60
 [get_device+24/32] get_device+0x18/0x20
 [scsi_device_get+44/128] scsi_device_get+0x2c/0x80
 [__scsi_iterate_devices+75/128] __scsi_iterate_devices+0x4b/0x80
 [scsi_run_host_queues+23/80] scsi_run_host_queues+0x17/0x50
 [ahc_linux_release_simq+148/208] ahc_linux_release_simq+0x94/0xd0
 [ahc_linux_dv_thread+506/592] ahc_linux_dv_thread+0x1fa/0x250
 [ahc_linux_dv_thread+0/592] ahc_linux_dv_thread+0x0/0x250
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

  Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0b
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: ARCHIVE   Model: VIPER 150  21247  Rev: -005
  Type:   Sequential-Access                  ANSI SCSI revision: 01

The following patch seems to fix this second problem:

http://marc.theaimsgroup.com/?l=linux-scsi&m=106940008217622&w=2

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

