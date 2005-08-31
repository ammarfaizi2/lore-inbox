Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVHaHLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVHaHLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVHaHLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:11:13 -0400
Received: from styx.suse.cz ([82.119.242.94]:36233 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932382AbVHaHLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:11:12 -0400
Date: Wed, 31 Aug 2005 09:11:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
Message-ID: <20050831071126.GA7502@midnight.ucw.cz>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 08:06:21PM +0000, Holger Kiehl wrote:
> >>How does one determine the PCI-X bus speed?
> >
> >Usually only the card (in your case the Symbios SCSI controller) can
> >tell. If it does, it'll be most likely in 'dmesg'.
> >
> There is nothing in dmesg:
> 
>    Fusion MPT base driver 3.01.20
>    Copyright (c) 1999-2004 LSI Logic Corporation
>    ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 24 (level, low) -> IRQ 217
>    mptbase: Initiating ioc0 bringup
>    ioc0: 53C1030: Capabilities={Initiator,Target}
>    ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 25 (level, low) -> IRQ 225
>    mptbase: Initiating ioc1 bringup
>    ioc1: 53C1030: Capabilities={Initiator,Target}
>    Fusion MPT SCSI Host driver 3.01.20
> 
> >To find where the bottleneck is, I'd suggest trying without the
> >filesystem at all, and just filling a large part of the block device
> >using the 'dd' command.
> >
> >Also, trying without the RAID, and just running 4 (and 8) concurrent
> >dd's to the separate drives could show whether it's the RAID that's
> >slowing things down.
> >
> Ok, I did run the following dd command in different combinations:
> 
>    dd if=/dev/zero of=/dev/sd?1 bs=4k count=5000000

I think a bs of 4k is way too small and will cause huge CPU overhead.
Can you try with something like 4M? Also, you can use /dev/full to avoid
the pre-zeroing.

> Here the results:
> 
>    Each disk alone
>    /dev/sdc1 59.094636 MB/s
>    /dev/sdd1 58.686592 MB/s
>    /dev/sde1 55.282807 MB/s
>    /dev/sdf1 62.271240 MB/s
>    /dev/sdg1 60.872891 MB/s
>    /dev/sdh1 62.252781 MB/s
>    /dev/sdi1 59.145637 MB/s
>    /dev/sdj1 60.921119 MB/s

>    All 8 disks in parallel
>    /dev/sdc1 24.120545 MB/s
>    /dev/sdd1 24.419801 MB/s
>    /dev/sde1 24.296588 MB/s
>    /dev/sdf1 25.609548 MB/s
>    /dev/sdg1 24.572617 MB/s
>    /dev/sdh1 25.552590 MB/s
>    /dev/sdi1 24.575616 MB/s
>    /dev/sdj1 25.124165 MB/s

You're saturating some bus. It almost looks like it's the PCI-X,
although that should be able to deliver up (if running at the full speed
of AMD8132) up to 1GB/sec, so it SHOULD not be an issue.

> So from these results, I may assume that md is not the cause of the problem.
> 
> What comes as a big surprise is that I loose 25% performance with only
> two disks and each hanging on its own channel!
> 
> Is this normal? I wonder if other people have the same problem with
> other controllers or the same.

No, I don't think this is OK.

> What can I do next to find out if this is a kernel, driver or hardware
> problem?
 
You need to find where the bottleneck is, by removing one possible
bottleneck at a time in your test.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
