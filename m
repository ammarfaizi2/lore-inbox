Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbUKLNBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbUKLNBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 08:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbUKLNBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 08:01:09 -0500
Received: from fmr06.intel.com ([134.134.136.7]:11668 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262527AbUKLNBA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 08:01:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Add pci_save_state() to ALSA
Date: Fri, 12 Nov 2004 21:00:30 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD5836@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add pci_save_state() to ALSA
Thread-Index: AcTImXpMU0NFbFDWQcWCCcQtmXw/ZAAHI9+g
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Takashi Iwai" <tiwai@suse.de>,
       "Martin Josefsson" <gandalf@wlug.westbo.se>
Cc: <perex@suse.cz>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Nov 2004 13:00:31.0147 (UTC) FILETIME=[9704EFB0:01C4C8B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> pci_save_state() is called internally in
> drivers/pci/pci-driver.c:pci_device_suspend(), so it's redundant.
> 
>> My laptop doesn't resume (gets what I assume is an ACPI timeout and
>> hangs solid) without this small obvious patch.
> 
> I'm wondering how this can fix your problem...

For example, some devices call pci_save_state before pci_disable_device
in
->suspend, but don't pci_enable_device in ->resume. This works before,
but 
is broken after the pci_save_state() change. We need to find those
drivers out
and change the individual drivers instead of this simple fix.

Martin, which sound driver do you use?

Thanks,
-yi

>> Signed-off-by: Martin Josefsson <gandalf@wlug.westbo.se>
>> 
>> --- linux-2.6.10-rc1-bk21.orig/sound/core/init.c
> 2004-11-11 18:51:17.000000000 +0100
>> +++ linux-2.6.10-rc1-bk21/sound/core/init.c	2004-11-11
>> 20:57:52.000000000 +0100 @@ -789,6 +789,8 @@ int
>>  	snd_card_pci_suspend(struct pci_dev  		return 0; if
>>  		(card->power_state == SNDRV_CTL_POWER_D3hot) return 0;
>> +	/* save the PCI config space */
>> +	pci_save_state(dev);
>>  	/* FIXME: correct state value? */
>>  	return card->pm_suspend(card, 0);
>>  }
>> 
>> --
>> /Martin
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

