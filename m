Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751890AbWJWKzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWJWKzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWJWKzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:55:25 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:34021 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751890AbWJWKzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:55:24 -0400
Message-ID: <453C9F97.4020605@gmail.com>
Date: Mon, 23 Oct 2006 12:55:19 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       R.E.Wolff@bitwizard.nl, support@specialix.co.uk
Subject: Re: [PATCH 1/5] Char: sx, convert to pci probing
References: <651531477799512100@wsc.cz> <200610231056.47011.eike-kernel@sf-tec.de>
In-Reply-To: <200610231056.47011.eike-kernel@sf-tec.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Jiri Slaby wrote:
>> sx, convert to pci probing
>>
>> convert old pci code to pci probing.
>>
>> Cc: <R.E.Wolff@BitWizard.nl>
>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>>
>> ---
>> commit 56b6b52313a48cbda4c84bd35252337063269d88
>> tree 1f32778374ad0eb5d2671cc94674753d1198dbff
>> parent d8e4a1a052b460b07936030bc99d8d9fe2b4bbf9
>> author Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 01:51:54 +0200
>> committer Jiri Slaby <jirislaby@gmail.com> Sun, 22 Oct 2006 01:51:54 +0200
>>
>>  drivers/char/sx.c |  183
>> ++++++++++++++++++++++++++++++----------------------- 1 files changed, 105
>> insertions(+), 78 deletions(-)
>>
>> diff --git a/drivers/char/sx.c b/drivers/char/sx.c
>> index cf08be7..9b800bd 100644
>> --- a/drivers/char/sx.c
>> +++ b/drivers/char/sx.c
>> @@ -246,14 +246,6 @@ #ifndef PCI_DEVICE_ID_SPECIALIX_SX_XIO_I
>>  #define PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8 0x2000
>>  #endif
>>
>> -#ifdef CONFIG_PCI
>> -static struct pci_device_id sx_pci_tbl[] = {
>> -	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8,
>> PCI_ANY_ID, PCI_ANY_ID }, -	{ 0 }
>> -};
>> -MODULE_DEVICE_TABLE(pci, sx_pci_tbl);
>> -#endif /* CONFIG_PCI */
>> -
>>  /* Configurable options:
>>     (Don't be too sure that it'll work if you toggle them) */
>>
>> @@ -2373,7 +2365,6 @@ static void __exit sx_release_drivers(vo
>>  	func_exit();
>>  }
>>
>> -#ifdef CONFIG_PCI
>>   /********************************************************
>>   * Setting bit 17 in the CNTRL register of the PLX 9050  *
>>   * chip forces a retry on writes while a read is pending.*
>> @@ -2404,22 +2395,112 @@ #define CNTRL_REG_GOODVALUE     0x182600
>>  	}
>>  	iounmap(rebase);
>>  }
>> -#endif
>>
>> +static int __devinit sx_pci_probe(struct pci_dev *pdev,
>> +	const struct pci_device_id *ent)
>> +{
>> +	struct sx_board *board;
>> +	unsigned int i;
>> +	int retval = -EIO;
>> +
>> +	for (i = 0; i < SX_NBOARDS; i++)
>> +		if (!(boards[i].flags & SX_BOARD_PRESENT))
>> +			break;
>> +
>> +	if (i == SX_NBOARDS)
>> +		goto err;
>> +
>> +	retval = pci_enable_device(pdev);
>> +	if (retval)
>> +		goto err;
>> +
>> +	board = &boards[i];
> 
> I'm rather sure you need some type of locking here.

Yes, correct, it's gonna to be done.

>> +
>> +	board->flags &= ~SX_BOARD_TYPE;
>> +	board->flags |= (pdev->subsystem_vendor == 0x200) ? SX_PCI_BOARD :
>> +				SX_CFPCI_BOARD;
>> +
>> +	/* CF boards use base address 3.... */
>> +	if (IS_CF_BOARD (board))
>> +		board->hw_base = pci_resource_start(pdev, 3);
>> +	else
>> +		board->hw_base = pci_resource_start(pdev, 2);
>> +	board->base2 =
>> +	board->base = ioremap(board->hw_base, WINDOW_LEN (board));
>> +	if (!board->base) {
>> +		dev_err(&pdev->dev, "ioremap failed\n");
>> +		goto err;
>> +	}
> 
> pci_iomap() or something?

I agree, not in this patch.

>> +
>> +	/* Most of the stuff on the CF board is offset by 0x18000 ....  */
>> +	if (IS_CF_BOARD (board))
>> +		board->base += 0x18000;
>> +
>> +	board->irq = pdev->irq;
> 
> Is this extra copy of the IRQ number needed?
> 
> 
>> @@ -2585,6 +2611,7 @@ static void __exit sx_exit (void)
>>  	struct sx_board *board;
>>
>>  	func_enter();
>> +	pci_unregister_driver(&sx_pcidriver);
>>  	for (i = 0; i < SX_NBOARDS; i++) {
>>  		board = &boards[i];
>>  		if (board->flags & SX_BOARD_INITIALIZED) {
> 
> Locking?

There are many more places, that needs to be locked due to these flags. I will
post them, this is only part I of changes. (If somebody objects to something it
will brake everything on the top of that patch. That's the reason, why I post in
batches.)

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
