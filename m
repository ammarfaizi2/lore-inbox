Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVGEPLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVGEPLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 11:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVGEPLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:11:04 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:33565 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261873AbVGEO4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 10:56:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M8yQqrZ1k9CYvl4h+PIpZ7TGRVugha0ouBiV5/iWl4/CYSgtIJke7ns7vTr9DHQVEZ4NSq17XEqWPmV/4DSsWg2Z1ZIBTD6qcWifjymMvSjCG9gfqDxDz1LWQ3JGrq5Vrenfm94BX2HfIkFsnyCYwyFiD9m7hP+wvZ7faGkIl1M=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Marcel Selhorst <selhorst@crypto.rub.de>
Subject: Re: [PATCH] tpm: Support for new chip type
Date: Tue, 5 Jul 2005 19:03:22 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Kylene Jo Hall <kjhall@us.ibm.com>
References: <42CA81D4.5020906@crypto.rub.de>
In-Reply-To: <42CA81D4.5020906@crypto.rub.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507051903.22727.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 July 2005 16:49, Marcel Selhorst wrote:
> this patch supports the Infineon Trusted Platform Module SLD 9630 (TPM 1.1b),
> which is embedded on Intel-mainboards or in HP/Fujitsu-Siemens/Toshiba-Notebooks.

Please feed it to scripts/Lindent. It will at least place all curly bracers
right.

> --- linux-2.6.13-rc1-mm1/drivers/char/tpm/tpm_infineon.c
> +++ linux-2.6.13-rc-mm1-tpm_inf/drivers/char/tpm/tpm_infineon.c

> +/* Register */
> +enum tpm_register {

> +/* Command Bits */
> +enum tpm_command_bits {

> +/* Status Bits */
> +enum tpm_status_bits {

IMO, useless comments.

> +/* Global variable to count the Waiting-Time-Extensions */

Well, we see it's a variable and it's global in this file.

> +static int number_of_wtx = 0;	

You can also remove " = 0" and make it go to .bss.

> +static int empty_fifo(struct tpm_chip *chip, int clear_wrfifo) {

> +	int i=0;

Unneeded initialisation.

> +	/* Note: The Values which are currently in the FIFO of the TPM

values

> +	are thrown away since there is no usage for them. Usually,
> +	this has nothing to say, since the TPM will give its answer immidiately

immediately

> +	return(0);

return 0;

> +static int wait(struct tpm_chip *chip, int wait_for_bit) {

> +  int i = 0;

Unneeded initialisation.

> +  for (i = 0; i < TPM_MAX_TRIES; i++) {		/* Check the TPM_TIMEOUT-Variable in the definitions in Infineon.h */

There is no Infineon.h

> +  return(0);

return 0; everywhere, please.

> +static int tpm_inf_recv(struct tpm_chip *chip, u8 *buf, size_t count) {

> +	    return (size);

return size;

> +static struct attribute * inf_attrs[] = {
> +	0,

NULL

> +int __init tpm_inf_probe(struct pci_dev *pci_dev, const struct pci_device_id *pci_id) {

static

> +	    /* Finally, we're done, print some infos */	
> +	    dev_info(&pci_dev->dev,"************************************************\n");
> +	    dev_info(&pci_dev->dev,"*    TPM found with IO-Base 0x%x             *\n",tpm_inf.base);
> +	    dev_info(&pci_dev->dev,"*    Chip    ID %02x%02x                           *\n",version[0], version[1]);
> +	    dev_info(&pci_dev->dev,"*    Vendor  ID %x%x (Infineon)                *\n",vendor[0], vendor[1]);
> +	    if ((vendor[2] == 0) && (vendor[3] == 6))
> +		dev_info(&pci_dev->dev,"*    Product ID %02x%02x (SLD 9630 TT 1.1)         *\n",vendor[2],vendor[3]);
> +	    else
> +		dev_info(&pci_dev->dev,"*    Product ID %02x%02x                           *\n",vendor[2],vendor[3]);
> +	    dev_info(&pci_dev->dev,"************************************************\n");

Remove this silly banner.

	dev_info(&pci_dev->dev, ": TPM found: "
				"io base 0x%x, "
				"chip id %02x%02x, "
				"vendor id %x%x (Infineon), "
				"product id %02x%02x"
				"%s\n",
		tpm_inf.base,
		version[0], version[1],
		vendor[0], vendor[1],
		vendor[2],vendor[3],
		((vendor[2] == 0) && (vendor[3] == 6)) ? " (SLD 9630 TT 1.1)" : "");

should be enough. BTW, care to explain why something called "chip id" is in
something called "version" and something called "product id" in in something
called "vendor"?

> +	    /* Let's register our hardware */

Useless comment.

> +	    dev_dbg(&pci_dev->dev,"Registering TPM-Infineon-Driver: %x\n",rc);	

Will always print 0. Could you please also remove Studly Caps from debug, info
and error messages?

> +	    rc = tpm_register_hardware(pci_dev, &tpm_inf);	
> +	    if (rc < 0) {
> +		pci_disable_device(pci_dev);
> +		return -ENODEV;
> +	    }
> +	    return 0;
> +
> +	} else {
> +	    dev_err(&pci_dev->dev,": No Infineon TPM found! Sorry! \n");

Trailing space. Why be sorry? :-)

> +MODULE_AUTHOR("Marcel Selhorst (selhorst@crypto.rub.de)");

People usually enclose emails in <>.
