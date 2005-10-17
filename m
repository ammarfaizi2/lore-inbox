Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVJQRQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVJQRQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVJQRQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:16:52 -0400
Received: from mail.dvmed.net ([216.237.124.58]:60814 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751044AbVJQRQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:16:51 -0400
Message-ID: <4353DC7C.6090705@pobox.com>
Date: Mon, 17 Oct 2005 13:16:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       davej@redhat.com
Subject: Re: [PATCH] libata: fix broken Kconfig setup
References: <20051017044606.GA1266@havoc.gtf.org> <200510170952.34174.jbarnes@virtuousgeek.org> <4353D96F.90805@pobox.com> <200510171006.39206.jbarnes@virtuousgeek.org>
In-Reply-To: <200510171006.39206.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> So sometimes the legacy IDE driver will lock up when it tries to drive 
> both ports in a combined configuration?  In that case, can't we just 

-sometimes- When it tries to drive the SATA port, it locks up.  My best 
guess is that this is due to the fact that SATA emulates IDE shadow 
registers in silicon, and the IDE driver does something weird that 
confused the silicon's IDE emulation logic.

Under SATA, the IDE shadow registers are nothing but a buffer.  Writing 
to the Command or Control registers causes this buffer to be batched 
into a SATA frame (a "FIS"), and sent to the device.


> disable the legacy IDE driver for these chips and force the use of the 
> libata version?

More than a little ugly:  The piix driver already excludes the SATA 
device (unless CONFIG_BLK_DEV_IDE_SATA is defined), so the driver that 
picks up the IDE is the non-PCI "generic IDE" legacy driver.

You would need to add code somewhere in a non-PCI driver to specifically 
exclude a few PCI devices.

Removing the quirk means users/distros would simply have to know to 
disable CONFIG_IDE completely.  Doable, but also guaranteed to generate 
bug reports.

	Jeff


