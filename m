Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUBJOgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUBJOgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:36:44 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:3280 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265900AbUBJOgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:36:37 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Date: Tue, 10 Feb 2004 15:41:31 +0100
User-Agent: KMail/1.5.3
References: <1n9OA-6lu-17@gated-at.bofh.it> <1nu6y-XO-3@gated-at.bofh.it> <200402101816.28067.athol_SPIT_SPAM@idl.net.au>
In-Reply-To: <200402101816.28067.athol_SPIT_SPAM@idl.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402101541.31033.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 of February 2004 08:16, Athol Mullen wrote:
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > On Monday 09 of February 2004 03:50, Athol Mullen wrote:
>
> (Don't CC.  I read lkml via linux.kernel newsgroup.)
>
> >> +     u16 cr_flag             = 0x10 << drive->dn;
> >>
> >> +                         pci_read_config_word(dev, 0x54, &reg54);
> >> +                         return ((reg54 & cr_flag) ? 1 : 0);
> >
> > This is plain wrong, piix.c already does it for you.
> > piix.c:init_hwif_piix():
>
> The penny drops...
>
> I missed this code because I was looking for cable detection on
> a drive-by-drive basis, and this is taking drives in pairs.
>
> That's why the drive was being correctly initialised as a UDMA5
> drive even though eighty_ninty_three() was returning zero.
>
> The existing code was written before the ICH5 came out, and will
> always work for ICH4 and older, but is wrong in its method of
> detecting 80-core cables on an ICH5, and could fail if SATA and
> PATA drives are mixed and used in compatability mode.  The bit
> flags should be taken on a drive-by-drive basis, because the ICH5
> is capable of logical mapping such as:
>
> SATA0 -> IDE0 Master
> SATA1 -> IDE0 Slave
> PATA0 master -> IDE1 Master
> PATA1 master -> IDE1 Slave
>
> Note that this now sees two PATA drives on different physical
> interfaces looking like master and slave on one interface.  In this
> scenario, if PATA1 has a 40-core and PATA0 an 80-core or vise versa,
> both would be detected as having 80-core with the existing code.
>
> Why do I feel like I just pulled the lid off a can of worms?

:-)

> The options are essentially that we:
> 1. Always force the SATA interfaces into native mode and PATA
>    into native or normal mode (desirable - the compatability mode
>    described above make only 2 PATA drives visible),
> 2. Modify the above code to work on a drive-by-drive basis instead
>    of interface-by-interface (according to Intel, this is the
>    correct answer),
> 3. Do nothing, and hope nobody notices.  :-)

Solution 1. is good also for other things, but changes order of the drives
so it is 2.7.x thing.  For now you can just add code for ICH5 setting
hwif->udma_four only if both drives report 80-c, something like:

	if ((reg54h & mask) == mask)
		ata66 = 1;

--bart

