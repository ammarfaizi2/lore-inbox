Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUIBIcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUIBIcr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 04:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267866AbUIBIcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 04:32:47 -0400
Received: from gsstark.mtl.istop.com ([66.11.160.162]:61824 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S266560AbUIBIcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 04:32:42 -0400
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: Crashed Drive, libata wedges when trying to recover data
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 02 Sep 2004 04:32:18 -0400
Message-ID: <87oekpvzot.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had a hard drive crash yesterday. I'm trying to recover as much data as
possible from it, and I'm having some success. The bad blocks seem to be only
in a few spots on the disk.

For the most part I've been able to pull data off the drive, occasionally I
see errors tar or cp just gets read errors and moves on to other files.

The errors look like:

Sep  2 03:22:07 stark kernel: ata1: DMA timeout, stat 0x21
Sep  2 03:22:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  2 03:22:07 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 12 f7 f7 92 00 00 06 00 
Sep  2 03:22:07 stark kernel: Current sda: sense = 70  3
Sep  2 03:22:07 stark kernel: ASC=11 ASCQ= 4
Sep  2 03:22:07 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00 0x11 0x04 
Sep  2 03:22:07 stark kernel: end_request: I/O error, dev sda, sector 318240658

However eventually libata seems to just stop working with that drive at all
and prints:

Sep  2 03:22:07 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7

It prints that three times and then just disappears. The rest of the machine
is fine, the other drive on the same IDE controller also controlled by libata
is also just fine. But any process that tries to read anything from the dead
drive just enters disk-wait and never comes back.

This makes it hard to recover the directories that hit more than a few bad
blocks. Once this error comes up I have to reboot to do anything else.

Ideally I need the driver to behave as it has been until now. Reset the drive,
reset the bus, whatever it takes. But return an error to user-space and
arrange for future reads to have a fighting chance.

Any clue what I need to do to achieve this? Is this a bug because this isn't a
well-travelled code-path? (Dead drives not being something you can conjure up
on demand)? Or is this indicative of more problems than just a crashed drive?

This is on a stock 2.6.6 kernel tree, btw.

-- 
greg

