Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289547AbSBEOoO>; Tue, 5 Feb 2002 09:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289545AbSBEOoF>; Tue, 5 Feb 2002 09:44:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31493 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289537AbSBEOoC>;
	Tue, 5 Feb 2002 09:44:02 -0500
Date: Tue, 5 Feb 2002 15:24:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Ralf Oehler <R.Oehler@GDAmbH.com>
Cc: Scsi <linux-scsi@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <andrea@suse.de>, Jens Axboe <axboe@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
Message-ID: <20020205152434.A16105@suse.de>
In-Reply-To: <XFMail.20020205153210.R.Oehler@GDAmbH.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20020205153210.R.Oehler@GDAmbH.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05 2002, Ralf Oehler wrote:
> Hi, List
> 
> I think, I found a very simple solution for this annoying BUG().

You fail to understand that the BUG triggering indicates that their is a
BUG _somewhere_ -- the triggered BUG is not the bug itself, of course,
that would be stupid :-)

> Since at least kernel 2.4.16 there is a BUG() in pci.h,
> that crashes the kernel on any attempt to read a SCSI-Sector
> from an erased MO-Medium and on any attempt to read
> a sector from a SCSI-disk, which returns "Read-Error".
> 
> There seems to be a thinko in the corresponding code, which 
> does not take into account the case where a SCSI-READ
> does not return any data because of a "sense code: read error"
> or a "sense code: blank sector".
> 
> I simply commented out this BUG() statement (see below)
> and everything worked well from there on. The BUG()
> seems to be inadequate.

The BUG is dangerous, because it means mapping DMA to a 0 address (plus
offset). Naturally there is no way in hell your "fix" will be applied,
since it a pretty bad bandaid.

A safer solution for you right now would be to just terminate the
mapping when you encounter this. So something ala

	if (!sg[i].page && !sg[i].address)
		return i;

That's not a bug fix either, but at least it's safer than your version.
Stock kernel won't be patched until the real problem is found, though.

-- 
Jens Axboe

