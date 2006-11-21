Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030898AbWKULvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030898AbWKULvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 06:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030900AbWKULvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 06:51:21 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:29151 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1030898AbWKULvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 06:51:20 -0500
Date: Tue, 21 Nov 2006 12:51:17 +0100
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: avl@logic.at, linux-kernel@vger.kernel.org
Subject: Re: possible bug in ide-disk.c (2.6.18.2 but also older)
Message-ID: <20061121115117.GU6851@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at> <20061120152505.5d0ba6c5@localhost.localdomain> <20061120165601.GS6851@gamma.logic.tuwien.ac.at> <20061120172812.64837a0a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120172812.64837a0a@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 05:28:12PM +0000, Alan wrote:
> The reason I ask is that they put the partition in the last sector which
> means a block read of the last sector goes off the end of the disk and
> certainly used to be mishandled by the IDE code.

After reading it a second time, I'll see if I got it straight now:

.) the kernel always loads even-aligned pairs of sectors.
.) for an odd-sectored disk, this results in the GPT plus the
     following (non-existent) sector being accessed from disk.
.) the old, unmaintained ide-driver generally does not handle
     the odd-size case right, as it misinterprets the harddisks
     error for the second sector (the one after the end) as a
     general error causing dma to be turned off, after some retries.
     It would also do that, if I later accessed the last sector
     (e.g. dd if=/dev/hda ..., or by accessing a file that happens
     to be stored there per filesystem, if at all possible),
     not just during the initial GPT-check.
.) If I remove the "addr++;", then the harddisk is actually
     believed to be 1 sector smaller than it really is, which
     means that it looks like an even-sized disk. This could mean
     that an eventually existing GPT could be missed. What would
     be the "worst-case" consequences?
.) if ((old ide-driver) && (odd # of sectors)) youre_doomed_anyway(); ?

Right so far?

If yes, then wouldn't it be most sane to generally *ignore*
any trailing single sectors, at least as long as we still have
to deal with old ide driver:
    addr = (addr & ~1) + 1;
Since this piece of code is in the old ide-disk.c, it would
become ineffective automatically, once libpata (or what it's
called) is ready to take over.

Thanks for caring.

