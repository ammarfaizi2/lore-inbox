Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWEDNBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWEDNBF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 09:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWEDNBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 09:01:05 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:7322 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1750997AbWEDNBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 09:01:04 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200605041256.k44CuFLf004425@wildsau.enemy.org>
Subject: Re: cdrom: a dirty CD can freeze your system
In-Reply-To: <4459F757.8070408@tls.msk.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
Date: Thu, 4 May 2006 14:56:15 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org, Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> It's worse than that.  See http://marc.theaimsgroup.com/?t=114003595500002&r=1&w=2
> and other similar reports.  So far, noone cares it seems (for several years already).

woops ... fortunately, I dont have that kind of problem. my code just does:

 loop {
   ioctl( SG_IO - timeout=3 seconds);
   write block to disk.
 }

SG_IO behaves a bit more friendly.... than, say, "CDROMREAD{MODE1,MODE2,AUDIO}" does.
nevertheless, the IDE interface becomes unusable until you reboot the system.

e.g., just right now, I did:

  o insert bad CD
  o read it until an error occurs.
  o "hdparm -w /dev/hdb" - this will turn DMA off. kernel log shows:
        hdb: DMA disabled
        hdb: ATAPI reset complete
  o "hdparm -d 1 /dev/hdb" to reenable DMA, "hdparm /dev/hdb" to look at the
    drive settings. the kernel log then shows:
        hdb: irq timeout: status=0xd0 { Busy }
        ide: failed opcode was: unknown
        hdb: ATAPI reset complete
        hdb: status error: status=0x49 { DriveReady DataRequest Error }
        hdb: status error: error=0x04 { AbortedCommand }
        ide: failed opcode was: unknown
        hdb: drive not ready for command
        hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
        hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
        ide: failed opcode was: unknown
        hdb: request sense failure: status=0x51 { DriveReady SeekComplete Error }
        hdb: request sense failure: error=0x44 { AbortedCommand LastFailedSense=0x04 }

  hdparm is now in state "D" -> reboot required.
  not so good, da?

kind regards,
herbert rosmanith
