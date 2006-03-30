Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWC3K3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWC3K3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWC3K3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:29:53 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56011 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932162AbWC3K3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:29:53 -0500
Subject: Re: why no option for 'ide=nocddma'?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jack Howarth <howarth@bromo.msbb.uc.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0603300110p43c33040hdb95a8c871f4b50d@mail.gmail.com>
References: <20060324184338.7A87511003E@bromo.msbb.uc.edu>
	 <1143396437.2540.7.camel@localhost.localdomain>
	 <58cb370e0603300110p43c33040hdb95a8c871f4b50d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Mar 2006 11:37:28 +0100
Message-Id: <1143715048.29388.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-03-30 at 11:10 +0200, Bartlomiej Zolnierkiewicz wrote:
> EOF handling error has nothing to do with IDE layer,
> the same problem can be reproduced using libata+PATA patches.

I've never been able to reproduce it with libata+PATA patches, with
ide-scsi or with scsi devices. One clear reason for that is they handle
partial write returns correctly which unpatched drivers/ide does not.

So ide-cd goes  "Read 64K" and the CD goes "umm erp splat have 8K" and
it tells the block layer "failed". ide-scsi goes "here is 8K, fail 56K"
and also adjusts the volume size (without proper locking)

The underlying problem is the block layer certainly but ide-cd is an
offender too. One simple hack for ide-cd would be to return success and
fill the excess buffer space with "JensAxboeAteMyComputer"[1] or similar
as padding providing the write fail is coming from end of media in the
last 150K or so.

Alan

[1] I'm kidding about this, zero would be the right padding.


