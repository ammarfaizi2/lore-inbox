Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUCKOaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCKOaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:30:08 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:40457 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261368AbUCKO3d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:29:33 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jens Axboe <axboe@suse.de>
Subject: 2.6.4-rc-bk3: hdparm -X locks up IDE
Date: Thu, 11 Mar 2004 16:14:08 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <200403111614.08778.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered that hdparm -X <mode> /dev/hda can lock up IDE
interface if there is some activity.

I walked up from via driver's handler for it:

via_set_speed(): directly programs IDE controller timings.

via_set_drive -> via_set_speed

via82cxxx_tune_drive -> via_set_drive
via82cxxx_ide_dma_check -> via_set_drive

init_hwif_via82cxxx:
        hwif->tuneproc = &via82cxxx_tune_drive;
        hwif->speedproc = &via_set_drive;
	...
	hwif->ide_dma_check = &via82cxxx_ide_dma_check;

I think via_set_drive is eventually gets called
by hdparm -X, not other two functions.

ide_set_xfer_rate -> HWIF(drive)->speedproc

pre_reset -> check_dma_crc -> ide_set_xfer_rate

set_xfer_rate -> ide_set_xfer_rate

void ide_add_generic_settings(drive):
...
ide_add_setting(drive, "current_speed", SETTING_RW,
	-1, -1, TYPE_BYTE, 0, 70, 1, 1, &drive->current_speed,
	set_xfer_rate);
        ^^^^^^^^^^^^^

Seems like there is no locking protecting mode change.
--
vda
