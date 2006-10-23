Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWJWKud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWJWKud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWJWKud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:50:33 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:48846 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751876AbWJWKud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:50:33 -0400
Message-ID: <453C9E76.80700@gmail.com>
Date: Mon, 23 Oct 2006 12:50:30 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/4] Char: stallion, convert to pci probing
References: <242814652263746404@wsc.cz> <200610231051.16847.eike-kernel@sf-tec.de>
In-Reply-To: <200610231051.16847.eike-kernel@sf-tec.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Am Sonntag, 22. Oktober 2006 17:48 schrieb Jiri Slaby:
>> stallion, convert to pci probing
>>
>> Convert stallion driver to pci probing instead of pci_dev_get iteration.
>>
>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>>
>> ---
>> commit c4a0f4d15661fe74b8c67b0258d5dfbcff57071b
>> tree 5da405798c9d47c7a07b63868e9fec1748908b6b
>> parent fcf3d1f86671d8e01a238935d906356442c92749
>> author Jiri Slaby <ku@bellona.localdomain> Sun, 22 Oct 2006 16:40:25 +0159
>> committer Jiri Slaby <ku@bellona.localdomain> Sun, 22 Oct 2006 16:40:25
>> +0159
>>
>>  drivers/char/stallion.c |  165
>> ++++++++++++++++++++++++----------------------- 1 files changed, 83
>> insertions(+), 82 deletions(-)
>>
>> diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
>> index d2cbdb7..592bd6e 100644
>> --- a/drivers/char/stallion.c
>> +++ b/drivers/char/stallion.c
>> @@ -381,8 +381,6 @@ #define	STL_CLOSEDELAY		(5 * HZ / 10)
>>
>>
>> /**************************************************************************
>> ***/
>>
>> -#ifdef CONFIG_PCI
>> -
>>  /*
>>   *	Define the Stallion PCI vendor and device IDs.
>>   */
>> @@ -402,22 +400,19 @@ #endif
>>  /*
>>   *	Define structure to hold all Stallion PCI boards.
>>   */
>> -typedef struct stlpcibrd {
>> -	unsigned short		vendid;
>> -	unsigned short		devid;
>> -	int			brdtype;
>> -} stlpcibrd_t;
>> -
>> -static stlpcibrd_t	stl_pcibrds[] = {
>> -	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI864, BRD_ECH64PCI },
>> -	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_EIOPCI, BRD_EASYIOPCI },
>> -	{ PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI832, BRD_ECHPCI },
>> -	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410, BRD_ECHPCI },
>> -};
>>
>> -static int	stl_nrpcibrds = ARRAY_SIZE(stl_pcibrds);
>> -
>> -#endif
>> +static struct pci_device_id stl_pcibrds[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI864),
>> +		.driver_data = BRD_ECH64PCI },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_EIOPCI),
>> +		.driver_data = BRD_EASYIOPCI },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_STALLION, PCI_DEVICE_ID_ECHPCI832),
>> +		.driver_data = BRD_ECHPCI },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410),
>> +		.driver_data = BRD_ECHPCI },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(pci, stl_pcibrds);
>>
>>
>> /**************************************************************************
>> ***/
>>
>> @@ -2392,24 +2387,52 @@ static int __init stl_getbrdnr(void)
>>  	return(-1);
>>  }
>>
>> -/*************************************************************************
>> ****/ +static void stl_cleanup_panels(struct stlbrd *brdp)
>> +{
>> +	struct stlpanel *panelp;
>> +	struct stlport *portp;
>> +	unsigned int j, k;
>>
>> -#ifdef	CONFIG_PCI
>> +	for (j = 0; j < STL_MAXPANELS; j++) {
>> +		panelp = brdp->panels[j];
>> +		if (panelp == NULL)
>> +			continue;
>> +		for (k = 0; k < STL_PORTSPERPANEL; k++) {
>> +			portp = panelp->ports[k];
>> +			if (portp == NULL)
>> +				continue;
>> +			if (portp->tty != NULL)
>> +				stl_hangup(portp->tty);
>> +			kfree(portp->tx.buf);
>> +			kfree(portp);
>> +		}
>> +		kfree(panelp);
>> +	}
>> +}
>>
>> +/*************************************************************************
>> ****/ /*
>>   *	We have a Stallion board. Allocate a board structure and
>>   *	initialize it. Read its IO and IRQ resources from PCI
>>   *	configuration space.
>>   */
>>
>> -static int __init stl_initpcibrd(int brdtype, struct pci_dev *devp)
>> +static int __devinit stl_pciprobe(struct pci_dev *pdev,
>> +		const struct pci_device_id *ent)
>>  {
>> -	struct stlbrd	*brdp;
>> +	struct stlbrd *brdp;
>> +	unsigned int brdtype = ent->driver_data;
>>
>>  	pr_debug("stl_initpcibrd(brdtype=%d,busnr=%x,devnr=%x)\n", brdtype,
>> -		devp->bus->number, devp->devfn);
>> +		pdev->bus->number, pdev->devfn);
>> +
>> +	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE)
>> +		return -ENODEV;
>> +
>> +	dev_info(&pdev->dev, "please, report this to LKML: %x/%x/%x\n",
>> +			pdev->vendor, pdev->device, pdev->class);
> 
> I guess you wanted the dev_info _before_ the return? And why could this ever 
> happen?

Nope, I want to know which CLASSes we want to control (to push it into the table
not to take care of it here...).

>> -	if (pci_enable_device(devp))
>> +	if (pci_enable_device(pdev))
>>  		return(-EIO);
>>  	if ((brdp = stl_allocbrd()) == NULL)
>>  		return(-ENOMEM);
>> @@ -2425,8 +2448,8 @@ static int __init stl_initpcibrd(int brd
>>   *	so set up io addresses based on board type.
>>   */
>>  	pr_debug("%s(%d): BAR[]=%Lx,%Lx,%Lx,%Lx IRQ=%x\n", __FILE__, __LINE__,
>> -		pci_resource_start(devp, 0), pci_resource_start(devp, 1),
>> -		pci_resource_start(devp, 2), pci_resource_start(devp, 3), devp->irq);
>> +		pci_resource_start(pdev, 0), pci_resource_start(pdev, 1),
>> +		pci_resource_start(pdev, 2), pci_resource_start(pdev, 3), pdev->irq);
>>  /*
>>   *	We have all resources from the board, so let's setup the actual
> 
> I would vote for deleting this completely. If someone wants to know lspci and 
> sysfs can tell the whole story.

Yup, this is done in patch named 'Char: stallion, prints cleanup'.

>> @@ -2434,63 +2457,52 @@ static int __init stl_initpcibrd(int brd
>>   */
>>  	switch (brdtype) {
>>  	case BRD_ECHPCI:
>> -		brdp->ioaddr2 = pci_resource_start(devp, 0);
>> -		brdp->ioaddr1 = pci_resource_start(devp, 1);
>> +		brdp->ioaddr2 = pci_resource_start(pdev, 0);
>> +		brdp->ioaddr1 = pci_resource_start(pdev, 1);
>>  		break;
>>  	case BRD_ECH64PCI:
>> -		brdp->ioaddr2 = pci_resource_start(devp, 2);
>> -		brdp->ioaddr1 = pci_resource_start(devp, 1);
>> +		brdp->ioaddr2 = pci_resource_start(pdev, 2);
>> +		brdp->ioaddr1 = pci_resource_start(pdev, 1);
>>  		break;
>>  	case BRD_EASYIOPCI:
>> -		brdp->ioaddr1 = pci_resource_start(devp, 2);
>> -		brdp->ioaddr2 = pci_resource_start(devp, 1);
>> +		brdp->ioaddr1 = pci_resource_start(pdev, 2);
>> +		brdp->ioaddr2 = pci_resource_start(pdev, 1);
>>  		break;
> 
> Is it really that important to name it pdev instead of devp? This causes tons 
> of noise in the patch.

Hmm, that's correct note, but pci device is called pdev in most cases, I wanted
to keep it consistent (and thought that it doesn't want to be in separate patch).

>> +	release_region(brdp->ioaddr1, brdp->iosize1);
>> +	if (brdp->iosize2 > 0)
>> +		release_region(brdp->ioaddr2, brdp->iosize2);
> 
> pci_release_region() maybe? This would be a conversion that actually would 
> make the code more readable. Since this code path looks PCI only...

I'm definitely going to do this in the next patch serie.

>> -	return(0);
>> +	stl_brds[brdp->brdnr] = NULL;
>> +	kfree(brdp);
>>  }
>>
>> -#endif
>> +static struct pci_driver stl_pcidriver = {
>> +	.name = "stallion",
>> +	.id_table = stl_pcibrds,
>> +	.probe = stl_pciprobe,
>> +	.remove = __devexit_p(stl_pciremove)
>> +};
>>
>>
>> /**************************************************************************
>> ***/
>>
>> @@ -2537,9 +2549,6 @@ static int __init stl_initbrds(void)
>>   *	line options or auto-detected on the PCI bus.
>>   */
>>  	stl_argbrds();
>> -#ifdef CONFIG_PCI
>> -	stl_findpcibrds();
>> -#endif
>>
>>  	return(0);
>>  }
>> @@ -4778,7 +4787,7 @@ static void stl_sc26198otherisr(struct s
>>   */
>>  static int __init stallion_module_init(void)
>>  {
>> -	unsigned int i;
>> +	unsigned int i, retval;
>>
>>  	printk(KERN_INFO "%s: version %s\n", stl_drvtitle, stl_drvversion);
>>
>> @@ -4787,6 +4796,10 @@ static int __init stallion_module_init(v
>>
>>  	stl_initbrds();
>>
>> +	retval = pci_register_driver(&stl_pcidriver);
>> +	if (retval)
>> +		goto err;
>> +
>>  	stl_serial = alloc_tty_driver(STL_MAXBRDS * STL_MAXPORTS);
>>  	if (!stl_serial)
> 
> pci_unregister_driver() here?

Good catch, I'll post a fix (As I see it now, stl_initbrds should be checked for
the returned value too.). I have no idea, why did I omit this changes in fail
paths patch :/.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
