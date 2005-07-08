Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVGHHJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVGHHJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 03:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVGHHJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 03:09:49 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:15936 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261438AbVGHHJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 03:09:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VO4QmO9cp1bOFcQKFBQfipimBQd/DiDblKzQ0q3UlAaETlE9Ji7PstE4+kN0/LP4wRcRkkxrSTZg75lqysH46kztMl7TJ/9qffT/nJ67DE2GNrC8F1hbM86KxcmTIetQ+GxVqa4BIEkekEPoKU5QyXKFZ93TAuh1QNbXZFO1KqE=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Marcel Selhorst <selhorst@crypto.rub.de>
Subject: Re: [PATCH] tpm: Support for new chip type
Date: Fri, 8 Jul 2005 11:16:31 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, kjhall@us.ibm.com
References: <42CDAFBA.5080005@crypto.rub.de>
In-Reply-To: <42CDAFBA.5080005@crypto.rub.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507081116.32029.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 July 2005 02:42, Marcel Selhorst wrote:
> after some corrections here is a newer patch supporting the Infineon Trusted
> Platform Module SLD 9630 (TPM 1.1b), which is embedded on Intel-mainboards or
> in HP/Fujitsu-Siemens/Toshiba-Notebooks.

> --- linux-2.6.12.2/drivers/char/tpm/tpm_infineon.c
> +++ linux/drivers/char/tpm/tpm_infineon.c

> +static int empty_fifo(struct tpm_chip *chip, int clear_wrfifo)
> +{
> +	int status;
> +	int check = 0;
> +	int i;
> +	int j = 0;
> +
> +	if (clear_wrfifo) {
> +		for (i = 0; i < 4096; i++) {
> +			status = inb(chip->vendor->base + WRFIFO);
> +			if (status == 0xff) {
> +				if (check == 5)
> +					break;
> +				else
> +					check++;
> +			}
> +		}
> +	}
> +	/* Note: The values which are currently in the FIFO of the TPM
> +	   are thrown away since there is no usage for them. Usually,
> +	   this has nothing to say, since the TPM will give its answer immediately
> +	   or will be aborted anyway, so the data here is usually garbage and useless.
> +	   We have to clean this, because the next communication with the TPM would
> +	   be rubbish, if there is still some old data in the Read FIFO.
> +	 */

Could you reformat it a little to fit in 80 columns?

> +	i = 0;

i is used only in clear_wrfifo loop. Or sacrifice j instead.

> +	do {
> +		status = inb(chip->vendor->base + RDFIFO);
> +		status = inb(chip->vendor->base + STAT);
> +		j++;
> +		if (j == TPM_MAX_TRIES)
> +			return -EIO;
> +	} while ((status & (1 << STAT_RDA)) != 0);
> +	return 0;
> +}

> +static int wait(struct tpm_chip *chip, int wait_for_bit)
> +{

> +	if (i == TPM_MAX_TRIES) {	/* when timeout occurs, print information and return -EIO */

We see dev_err() calls, we see -EIO. So only "timeout occurs" should be left.

> +		dev_err(&chip->pci_dev->dev, "Timeout in wait(");
> +		if (wait_for_bit == STAT_XFE)
> +			dev_err(&chip->pci_dev->dev, "STAT_XFE)\n");
> +		if (wait_for_bit == STAT_RDA)
> +			dev_err(&chip->pci_dev->dev, "STAT_RDA)\n");
> +		return -EIO;
> +	}

> +/* Note: WTX means Waiting-Time-Extension. Whenever the TPM
> +needs more calculation time, it sends a WTX-package, which has to
> +be acknowledged or aborted. This usually occurs if you are hammering
> +the TPM with key creation. Set the maximum number of WTX-packages in
> +the definitions above, if the number is reached, the waiting-time will be denied
> +and the TPM command has to be resend.
> +*/

Be consistent with the rest of the driver:

	/* This style
	   is OK.
	 */

> +static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
> +{

> +      recv_begin:

Labels are placed at column zero usually.

> +	dev_dbg(&chip->pci_dev->dev, "Receiving header: ");
> +
> +	for (i = 0; i < 4; i++) {
> +		ret = wait(chip, STAT_RDA);
> +		if (ret)
> +			return -EIO;
> +
> +		buf[i] = inb(chip->vendor->base + RDFIFO);
> +		dev_dbg(&chip->pci_dev->dev, "%02x ", buf[i]);
> +	}
> +	dev_dbg(&chip->pci_dev->dev, "\n");

One of dev_dbg jobs is to print KERN_DEBUG, but only at the very beginning of
the line.

> +		dev_dbg(&chip->pci_dev->dev, "Receiving data: ");
> +
> +		for (i = 0; i < size; i++) {
> +			wait(chip, STAT_RDA);
> +			buf[i] = inb(chip->vendor->base + RDFIFO);
> +			dev_dbg(&chip->pci_dev->dev, "%02x ", buf[i]);
> +		}
> +		dev_dbg(&chip->pci_dev->dev, "\n");

dev_dbg() in the middle.

> +				"-> Negative acknowledgement - retransmit commando!\n");

command?

> +static int tpm_inf_send(struct tpm_chip *chip, u8 * buf, size_t count)
> +{

> +	count_high = 0;
> +	count_low = 0;

What's the point?

> +
> +	count_high = (count & 0xffff0000);
> +	count_low = (count & 0x0000ffff);

> +	dev_dbg(&chip->pci_dev->dev,
> +		"Sending data   %02x %02x %02x %02x %02x %02x ", TPM_VL_VER,
> +		TPM_VL_CHANNEL_TPM, count_4, count_3, count_2, count_1);
> +
> +	wait_and_send(chip, TPM_VL_VER);
> +	wait_and_send(chip, TPM_VL_CHANNEL_TPM);
> +	wait_and_send(chip, count_4);
> +	wait_and_send(chip, count_3);
> +	wait_and_send(chip, count_2);
> +	wait_and_send(chip, count_1);
> +
> +	for (i = 0; i < count; i++) {
> +		wait_and_send(chip, buf[i]);
> +		dev_dbg(&chip->pci_dev->dev, "%02x ", buf[i]);
> +	}

dev_dbg in the middle.

> +static int __init tpm_inf_probe(struct pci_dev *pci_dev,
> +				const struct pci_device_id *pci_id)
> +{

> +		dev_dbg(&pci_dev->dev,
> +			"Device activate register status : %x \n", status);

%x\n
