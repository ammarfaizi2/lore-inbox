Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWEZKUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWEZKUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWEZKUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:20:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:3955 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751368AbWEZKUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:20:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=T4tdu2jzDeY/oqlcoAt4/5Cm9dF2IxV2JYI8spqvn1p9zNY4j2LtWzz4Yjiwuf7AXGABRYjxus6CwYeWH90LAu2RybomLDUhSpVLPCabGi5Y4F4OS/LibWXkKFyltKF00rjt/i3g4mQCO1DaPKjpyNudd3aohm8n35KGM3zZP6c=
Message-ID: <4476D63E.8090207@gmail.com>
Date: Fri, 26 May 2006 12:19:19 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       mb@bu3sch.de, st3@riseup.net, linville@tuxdriver.com
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
References: <20060526001053.D2349C7C58@atrey.karlin.mff.cuni.cz> <44764D4B.6050105@pobox.com>
In-Reply-To: <44764D4B.6050105@pobox.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik napsal(a):
> Jiri Slaby wrote:
>> bcm43xx avoid pci_find_device
>>
>> Change pci_find_device to safer pci_get_device with support for more
>> devices.
>>
>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>>
>> ---
>> commit 1d3b6caf027fe53351c645523587aeac40bc3e47
>> tree ae37c86b633442cdf8a7a19ac287542724081c90
>> parent ab3443d79c94d0ae6a9e020daefa4d29eccff50d
>> author Jiri Slaby <ku@bellona.localdomain> Fri, 26 May 2006 01:49:12
>> +0159
>> committer Jiri Slaby <ku@bellona.localdomain> Fri, 26 May 2006
>> 01:49:12 +0159
>>
>>  drivers/net/wireless/bcm43xx/bcm43xx_main.c |   20 ++++++++++++++++----
>>  1 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
>> b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
>> index b488f77..56d2fc6 100644
>> --- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
>> +++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
>> @@ -2131,6 +2131,13 @@ out:
>>      return err;
>>  }
>>  
>> +#ifdef CONFIG_BCM947XX
>> +static struct pci_device_id bcm43xx_ids[] = {
>> +    { PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x4324) },
>> +    { 0 }
>> +};
>> +#endif
>> +
>>  static int bcm43xx_initialize_irq(struct bcm43xx_private *bcm)
>>  {
>>      int res;
>> @@ -2141,10 +2148,15 @@ static int bcm43xx_initialize_irq(struct
>>  #ifdef CONFIG_BCM947XX
>>      if (bcm->pci_dev->bus->number == 0) {
>>          struct pci_dev *d = NULL;
>> -        /* FIXME: we will probably need more device IDs here... */
>> -        d = pci_find_device(PCI_VENDOR_ID_BROADCOM, 0x4324, NULL);
>> -        if (d != NULL) {
>> -            bcm->irq = d->irq;
>> +        struct pci_device_id *id = bcm43xx_ids;
>> +        while (id->vendor) {
>> +            d = pci_get_device(id->vendor, id->device, NULL);
>> +            if (d != NULL) {
>> +                bcm->irq = d->irq;
>> +                pci_dev_put(d);
>> +                break;
> 
> You'll want to use pci_match_device() or pci_match_one_device()
> [I forget which one]
Why? Matching is done by pci_get_device() or pci_get_subsys(), respectively.
[pci_match_device() is for matching dev <-> drv, you meant pci_match_one_device()]

thanks,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEdtY+MsxVwznUen4RAkmFAJ9FFm6nCgnGCdZAcPqv2H99rBNMzwCeK3DA
nPBv8s+ldDrSOpin+mGdDdg=
=MBag
-----END PGP SIGNATURE-----
