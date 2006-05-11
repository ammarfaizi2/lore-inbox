Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWEKVIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWEKVIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 17:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWEKVIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 17:08:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34968 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750786AbWEKVIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 17:08:24 -0400
Subject: Re: [PATCH] PIIX: fix 82371MX enablebits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <44639F4C.7040709@ru.mvista.com>
References: <446395A0.20806@ru.mvista.com>
	 <1147379225.26130.81.camel@localhost.localdomain>
	 <44639F4C.7040709@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 May 2006 22:20:33 +0100
Message-Id: <1147382434.26130.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-05-12 at 00:32 +0400, Sergei Shtylyov wrote:
>     Erm, simplex stuff shouldn't be touched at all since the chip is not 
> DMA-capable. The same should be true about the native/legacy mode...

Native/legacy appplies to PIO too, and predates DMA stuff. Read
ide_setup_pci_baseregs and you'll see the problem. I hit that with
pata_mpiix and similar assumptions copied into libata and when I tried
the piix driver on the laptop I have.

> > Finally the PIIX driver pokes several registers it doesn't even have.
> 
>     Hm, as I can see, it avoids touching anything at all on MPIIX. This may 
> rather be said of PIIX -- this chip didn't have SIDETIM register yet, so slave 
> tuning won't work on it...

It avoids it for the MPIIX but not the early PIIX chip. And you can do
slave timing just fine, you need to flip the timings when you flip drive
which is how pata_mpiix does it and pata_oldpiix.

>     There's no great need in splitting, just the separate tune_chipset() 
> functions for PIIX/MPIIX and the rest of the crowd would suffice, IMHO...

Have fun 8) Having been there and done that already the list of bugs in
the piix driver is huge. Good to see someone beginning on it. However
you need more than to skip tuning and you need to reload the timings on
master/slave switches to get any performance.

If you want to fight the PIIX driver then other stuff I fixed in
pata_piix included
- Touching UDMA registers not found on earlier UDMA chips
- Setting IORDY on the wrong modes
- Setting prefetch/postwrite related options on devices it isnt safe for
(ATAPI shouldn't set PPE0 etc)

There's a nice Intel manual on the PIIX/ICH tuning rules separate to the
chip docs btw, I found it really helpful, dunno if you've already got a
copy.

Alan

