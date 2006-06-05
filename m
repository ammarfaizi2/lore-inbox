Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750844AbWFEVJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWFEVJH (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWFEVJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:09:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:33746 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750840AbWFEVJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:09:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=r9np2kZLpB2jjV2rQJSsp3+bwPnfOg9EY+2mLQEUG68qcUeoAfaMX/76g/+Ii0i213zMsZB+zToG/YFqhTt40dcbjQPMCcKVGwgNofcSnVtwGIvzE+5u16plxLEwwxWHxHG34G9kny14Bn9ScXJBJuuNstv/pitxqOj73DjHYrs=
Message-ID: <44849D76.3020201@gmail.com>
Date: Mon, 05 Jun 2006 23:08:47 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Greg KH <gregkh@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
        netdev@vger.kernel.org, mb@bu3sch.de, st3@riseup.net,
        linville@tuxdriver.com
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
References: <2005123213211@nnikde.cz> <20060605202007.B464FC7B73@atrey.karlin.mff.cuni.cz> <20060605205309.GA31061@kroah.com>
In-Reply-To: <20060605205309.GA31061@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH napsal(a):
> On Mon, Jun 05, 2006 at 10:20:07PM +0200, Jiri Slaby wrote:
>> bcm43xx avoid pci_find_device
>>
>> Change pci_find_device to safer pci_get_device with support for more
>> devices.
>>
>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>>
>> ---
>> commit 4b73c16f5411d97360d5f26f292ffddeb670ff75
>> tree 6e43c8bd02498eb1ceec6bdc64277fa8408da9e2
>> parent d59f9ea8489749f59cd0c7333a4784cab964daa8
>> author Jiri Slaby <ku@bellona.localdomain> Mon, 05 Jun 2006 22:01:03 +0159
>> committer Jiri Slaby <ku@bellona.localdomain> Mon, 05 Jun 2006 22:01:03 +0159
>>
>>  drivers/net/wireless/bcm43xx/bcm43xx_main.c |   21 ++++++++++++++++-----
>>  1 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
>> index 22b8fa6..d1a9975 100644
>> --- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
>> +++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
>> @@ -2133,6 +2133,13 @@ out:
>>  	return err;
>>  }
>>  
>> +#ifdef CONFIG_BCM947XX
>> +static struct pci_device_id bcm43xx_47xx_ids[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x4324) },
>> +	{ 0 }
>> +};
>> +#endif
>> +
>>  static int bcm43xx_initialize_irq(struct bcm43xx_private *bcm)
>>  {
>>  	int res;
>> @@ -2142,11 +2149,15 @@ static int bcm43xx_initialize_irq(struct
>>  	bcm->irq = bcm->pci_dev->irq;
>>  #ifdef CONFIG_BCM947XX
>>  	if (bcm->pci_dev->bus->number == 0) {
>> -		struct pci_dev *d = NULL;
>> -		/* FIXME: we will probably need more device IDs here... */
>> -		d = pci_find_device(PCI_VENDOR_ID_BROADCOM, 0x4324, NULL);
>> -		if (d != NULL) {
>> -			bcm->irq = d->irq;
>> +		struct pci_dev *d;
>> +		struct pci_device_id *id;
>> +		for (id = bcm43xx_47xx_ids; id->vendor; id++) {
>> +			d = pci_get_device(id->vendor, id->device, NULL);
>> +			if (d != NULL) {
>> +				bcm->irq = d->irq;
>> +				pci_dev_put(d);
>> +				break;
>> +			}
> 
> This will not work if you have more than one of the same devices in the
> system.
> 
> Well, the original code will not either :(
> 
> Why not just use the proper pci interface?  Why poke around in another
> pci device to steal an irq, when that irq might not even be valid?
> (irqs are not valid until pci_enable_device() is called on them...)
Ok, this is some bus or something, not "real" device, so no pci probing or
anything else could be done. There is only one in the system, if any, since
CONFIG_BCM947XX is set for some sort of embedded systems, but this would be
uttered by somebody more responsible.

Should I call pci_enable_device anyway, I am confused now :/? And then, should I
hold the reference all time until ifdown for this "some kind of parent"?

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
