Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268156AbUH3Qh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268156AbUH3Qh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 12:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268536AbUH3Qh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 12:37:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7841 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268156AbUH3QhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 12:37:16 -0400
Message-ID: <413357AE.3000009@pobox.com>
Date: Mon, 30 Aug 2004 12:37:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata ATA vs SATA detection and workaround.
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com> <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com> <41321F7F.7050300@pobox.com> <41333CDC.5040106@wasp.net.au> <41334058.4050902@wasp.net.au> <413350A2.1000003@pobox.com> <41335723.40907@wasp.net.au>
In-Reply-To: <41335723.40907@wasp.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> 
>> I'm still pondering what Alan was hinting at, a bit.  You (Brad) are 
>> correct in pointing out that this code should only trigger for the 
>> correct situations (lba48, etc.) which are only present on modern 
>> drives, but...  there is still a chance that word 93 will be zero on 
>> some weird (probably non-compliant) device.
> 
> 
> I agree completely, though my feeling is that if someone plugs a device 
> that broken into a SATA controller via a bridge then there "aint nuffin 
> we can do about it" anyway and if it breaks it breaks. I guess we could 
> offer the option you suggested before where we load the individual 
> drivers as modules and provide a "knobble" module parm that will limit 
> max_sectors to 200 and udma_mask to udma/100.
> Then we get the hassle if someone wants to use it as the root device, 
> but I guess then you move to an initrd and load the module from there.
> 
> How far do we want to take it?

For now I think moving your code to ata_dev_config() function is 
sufficient, with one modification:

Move the
	((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device)))
test into a separate function all its own, "ata_knobble_device" or 
somesuch.  static inline if you wish.

Then it will be trivial to add a 'knobble' module parm later on, by 
simply modifying ata_knobble_device() to also check the module parameter 
in addition to the existing tests.

	Jeff


