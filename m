Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUBJHVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265683AbUBJHVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:21:09 -0500
Received: from data.idl.com.au ([203.32.82.9]:58505 "EHLO smtp.idl.net.au")
	by vger.kernel.org with ESMTP id S265681AbUBJHVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:21:01 -0500
From: Athol Mullen <athol_SPIT_SPAM@idl.net.au>
Subject: Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Newsgroups: linux.kernel
References: <1n9OA-6lu-17@gated-at.bofh.it> <1n9OA-6lu-23@gated-at.bofh.it> <1n9OA-6lu-15@gated-at.bofh.it> <1nu6y-XO-3@gated-at.bofh.it>
Organization: Mullen Automotive Engineering
Date: Tue, 10 Feb 2004 18:16:28 +1100
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402101816.28067.athol_SPIT_SPAM@idl.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> On Monday 09 of February 2004 03:50, Athol Mullen wrote:
(Don't CC.  I read lkml via linux.kernel newsgroup.)

>> +     u16 cr_flag             = 0x10 << drive->dn;

>> +                         pci_read_config_word(dev, 0x54, &reg54);
>> +                         return ((reg54 & cr_flag) ? 1 : 0);

> This is plain wrong, piix.c already does it for you.
> piix.c:init_hwif_piix():

The penny drops...

I missed this code because I was looking for cable detection on
a drive-by-drive basis, and this is taking drives in pairs.

That's why the drive was being correctly initialised as a UDMA5
drive even though eighty_ninty_three() was returning zero.

The existing code was written before the ICH5 came out, and will
always work for ICH4 and older, but is wrong in its method of
detecting 80-core cables on an ICH5, and could fail if SATA and
PATA drives are mixed and used in compatability mode.  The bit
flags should be taken on a drive-by-drive basis, because the ICH5
is capable of logical mapping such as:

SATA0 -> IDE0 Master
SATA1 -> IDE0 Slave
PATA0 master -> IDE1 Master
PATA1 master -> IDE1 Slave

Note that this now sees two PATA drives on different physical
interfaces looking like master and slave on one interface.  In this
scenario, if PATA1 has a 40-core and PATA0 an 80-core or vise versa,
both would be detected as having 80-core with the existing code.

Why do I feel like I just pulled the lid off a can of worms?

The options are essentially that we:
1. Always force the SATA interfaces into native mode and PATA
   into native or normal mode (desirable - the compatability mode
   described above make only 2 PATA drives visible),
2. Modify the above code to work on a drive-by-drive basis instead
   of interface-by-interface (according to Intel, this is the
   correct answer),
3. Do nothing, and hope nobody notices.  :-)

> Please make sure you have CONFIG_IDEDMA_IVB=n in your config.
> If it is okay, please send me a copy of /proc/ide/hdX/identify.

I definately had CONFIG_IDEDMA_IVB=n.

/proc/ide/hda/identify and /proc/ide/hda/model emailed.

(Apologies if messages don't thread properly.)

-- 
Athol
<http://cust.idl.com.au/athol>
Linux Registered User # 254000
I'm a Libran Engineer. I don't argue, I discuss.


