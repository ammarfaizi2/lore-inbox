Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268437AbUHLAND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268437AbUHLAND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUHLAMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:12:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:53477 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268389AbUHKXlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:41:40 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Nathan Bryant <nbryant@optonline.net>, Pavel Machek <pavel@ucw.cz>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1092231462.2087.3.camel@mulgrave>
References: <4119611D.60401@optonline.net>
	 <20040811080935.GA26098@elf.ucw.cz>  <411A1B72.1010302@optonline.net>
	 <1092231462.2087.3.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1092267400.2136.24.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 09:36:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually, the answer is to most intents and purposes "yes".  You are
> technically correct: there's no way to disable DMA in SCSI.  However,
> once a device is quiesced, it has no outstanding commands, so there will
> be no outstanding DMA to that device.  When all devices on a host have
> been quiesced, then there will be no DMA at all going on *except* if the
> user initiates any via another interface (like sending a device probe or
> doing a unit scan).  The guarantee should be strong enough for swsusp to
> proceed, but we can look at quiescing a host properly (however, we'd
> need to move to a better host state model than we currently possess).

Some hosts will continuously DMA to memory iirc.. I remember having a
problem with 53c8xx on some macs when transitionning from MacOS to Linux
because of that.

We need to properly quisce the host, but that's a per host driver thing
and shouldn't be too difficult.

Regarding suspend-to-disk, it's fairly easy for the sd driver not to
spin down the disk for S4 (only for S3). However, we will still probably
do at least a bus reset when waking up...

Pavel: That's one of the reason I wanted an argument to resume() too so
drivers can make a difference between the immediate wakeup that happens
for writing the image to disk, vs. the real wakeup on resume. In the first
case, SCSI can avoid the bus reset, and any kind of re-configuring, in the 
second case, the full stuff might be necessary. 

Ben.


