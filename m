Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUB1XYm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 18:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbUB1XYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 18:24:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44972 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261942AbUB1XYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 18:24:41 -0500
Message-ID: <4041232C.7030305@pobox.com>
Date: Sat, 28 Feb 2004 18:24:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Worrisome IDE PIO transfers...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking at the function that is used to transfer data when in PIO mode...

void taskfile_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
{
         if (drive->bswap) {
                 ata_bswap_data(buffer, wcount);
                 HWIF(drive)->ata_output_data(drive, buffer, wcount);
                 ata_bswap_data(buffer, wcount);
         } else {
                 HWIF(drive)->ata_output_data(drive, buffer, wcount);
         }
}

Swapping the data in-place is very, very wrong...   you don't want to be 
touching the data that userspace might have mmap'd ...  Additionally, 
byteswapping back and forth for each PIO sector chews unnecessary CPU.

Seems to me the architecture's OUTS[WL] hook (or a new, similar hook) 
that swaps as it writes would be _much_ preferred, and eliminate this 
possible data corruption issue.

	Jeff




