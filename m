Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUI1TZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUI1TZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 15:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUI1TZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 15:25:21 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:53633 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S268138AbUI1TZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 15:25:02 -0400
Date: Tue, 28 Sep 2004 23:24:34 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Ingvar Hagelund <ingvar@linpro.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27: md RAID1 oops on alpha revisited
Message-ID: <20040928232434.A18395@jurassic.park.msu.ru>
References: <ujcr7onnup3.fsf@nfsd.linpro.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <ujcr7onnup3.fsf@nfsd.linpro.no>; from ingvar@linpro.no on Tue, Sep 28, 2004 at 01:44:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 01:44:24AM +0200, Ingvar Hagelund wrote:
> We have a Compaq Alphaserver DS10 466 MHz running Debian Woody with a
> self compiled 2.4.27 from kernel.org. We have not been able to make it
> run stable on md RAID1. It always crashes in less than an hour
> uptime, presumely while stressing the RAID code. Running on single
> disks, it's rock stable.

The problem seems to be in qlogic isp1020 driver, not in the RAID code.
I've seen exactly the same oops report, but that had happened while
writing to SCSI tape.

> Code;  fffffc000050da00 <isp1020_intr_handler+300/420>
>   14:   49 00 40 d3       bsr  ra,13c <_PC+0x13c> fffffc000050db28 <isp1020_return_status+8/100>
> Code;  fffffc000050da04 <isp1020_intr_handler+304/420>   <=====
>   18:   40 02 09 b0       stl  v0,576(s0)   <=====

It's the line 1052 in drivers/scsi/qlogicisp.c:

		if (sts->hdr.entry_type == ENTRY_STATUS)
			Cmnd->result = isp1020_return_status(sts);

The "Cmnd" pointer happened to be a NULL somehow...

Ivan.
