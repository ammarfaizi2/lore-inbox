Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267178AbUBMU2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUBMU2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:28:39 -0500
Received: from decay.franken.de ([194.94.249.92]:58050 "EHLO vivien.franken.de")
	by vger.kernel.org with ESMTP id S267178AbUBMU2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:28:33 -0500
Date: Fri, 13 Feb 2004 17:56:59 +0100
From: Alex Goller <alex@vivien.franken.de>
To: Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: harddisk or kernel problem?
Message-ID: <20040213165659.GA57556@vivien.franken.de>
References: <20040213075403.GC1881@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213075403.GC1881@schottelius.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 08:54:03AM +0100, Nico Schottelius wrote:
> Freeing unused kernel memory: 140k freed
> XFS mounting filesystem hda1
> Ending clean XFS mount for filesystem: hda1
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=8305458,
> sector=8305454

These result from the ide/dma code. Those errors are normally thrown
(someone correct me if i'm wrong) if ecc on that particular sector
fails. A EIO error is thrown, and is handed over to the layer above
(xfs in your case). These errors happen as well if you do raw reads
on those sectors.

> end_request: I/O error, dev hda, sector 8305454
> I/O error in filesystem ("hda3") meta-data dev hda3 block 0x776090

This is EIO handed over to xfs.

> Now I am trying the following:
> enabling Anticipatory I/O scheduler (additionaly to the Deadline I/O
> scheduler) and disabling Vector-based interrupt indexing.

I don't think this will help. The proplem is probably all about a
broken sector on your disk. And if i understand the ide code correctly
you can't do anything about that.

> This is just a guess, can someone tell me if that is senseless or if my
> harddisk is most likely broken?

Yes, that's the most likely case. Smartmontools (smartctl) should show
errors on the sectors mentioned in your dumps as well (they do here).

Error 1689 occurred at disk power-on lifetime: 703 hours
  When the command that caused the error occurred, the device was active or idle

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 00 2c 46 58 e0  Error: UNC

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  25 00 30 23 46 58 e0 00    3864.401  READ DMA EXT
  25 00 32 21 46 58 e0 00    3860.425  READ DMA EXT
  25 00 34 1f 46 58 e0 00    3843.845  READ DMA EXT
  25 00 36 1d 46 58 e0 00    3839.939  READ DMA EXT
  25 00 38 1b 46 58 e0 00    3839.914  READ DMA EXT

And so on.

bye, alex
-- 
alexander goller		alex@vivien.franken.de
