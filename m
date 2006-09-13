Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWIMQpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWIMQpU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWIMQpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:45:19 -0400
Received: from smtp-server.carlislefsp.com ([12.28.84.26]:12496 "EHLO
	smtp-server.carlislefsp.com") by vger.kernel.org with ESMTP
	id S1750764AbWIMQpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:45:17 -0400
X-Archive-Filename: imail115816591368930577 
X-Qmail-Scanner-Mail-From: stever@carlislefsp.com via imail
X-Qmail-Scanner: 1.24st (Clear:RC:1(10.10.3.184):. Processed in 0.044546 secs Process 30577)
Message-ID: <45083587.50908@carlislefsp.com>
Date: Wed, 13 Sep 2006 11:44:55 -0500
From: Steve Roemen <stever@carlislefsp.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: isicom module oops 2.6.17.13
References: <4506DAD7.8030307.reply@wsc.cz>, <45082055.7010309@carlislefsp.com> <45082055.7010309.reply@wsc.cz>
In-Reply-To: <45082055.7010309.reply@wsc.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here's with the firmware in the (converted to .deb rpm from 
ftp://ftp.linux.org.uk/pub/linux/alan/Kernel/Drivers/ISI/ )

isicom 0000:00:10.0: ISI PCI Card(Device ID 0x2052)
isicom 0000:00:10.0: -Done
isicom 0000:00:10.0: Firmware requested, size: 6553
isicom 0000:00:10.0: Firmware loaded, last values:
        WC: 5, FD: e09cc000, FP: e09cd999
isicom 0000:00:10.0: Card is not free: 1836
isicom: probe of 0000:00:10.0 failed with error -5

here's with the firmware from ftp://ftp.multitech.com/isi-cards/linux/ 
l309_22x_24x.tar

isicom 0000:00:10.0: ISI PCI Card(Device ID 0x2052)
isicom 0000:00:10.0: -Done
isicom 0000:00:10.0: Firmware requested, size: 7325
isicom 0000:00:10.0: Firmware loaded, last values:
        WC: 1, FD: e09cc000, FP: e09cdc9d
isicom 0000:00:10.0: Card is not free: 1836
isicom: probe of 0000:00:10.0 failed with error -5

Steve

Jiri Slaby wrote:
> Steve Roemen wrote:
>   
>> after adding that patch to 2.6.18-rc6-mm2 and trying another card (an 
>> isi5634 pci/8) i get this in dmesg while loading the driver:
>>
>> faxserver2:~# modprobe isicom
>> faxserver2:~# cat /var/log/kern.log
>>
>> Sep 13 09:59:11 localhost kernel: isicom 0000:00:10.0: ISI PCI 
>> Card(Device ID 0x2052)
>> Sep 13 09:59:14 localhost kernel: isicom 0000:00:10.0: -Done
>> Sep 13 09:59:15 localhost kernel: 00, FP: e09c762c
>> Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
>> FD: e09c7000, FP: e09c7640
>> Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
>> FD: e09c7000, FP: e09c7654
>>     
>
> [snip]
>
>   
>> Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
>> FD: e09c7000, FP: e09c8964
>> Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 8, FC: 16, 
>> FD: e09c7000, FP: e09c8978
>> Sep 13 09:59:15 localhost kernel: isicom 0000:00:10.0: WC: 5, FC: 9, FD: 
>> e09c7000, FP: e09c898c
>> Sep 13 09:59:17 localhost kernel: isicom: probe of 0000:00:10.0 failed 
>> with error -5
>>     
>
> Yes, thanks a lot, but more diagnostics is needed and I forgot to correct for
> loop for checking uploaded firmware...
> Could you revert previous patch and apply this one, please?
>
> diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
> index 6cca4b2..bf371b0 100644
> --- a/drivers/char/isicom.c
> +++ b/drivers/char/isicom.c
> @@ -1756,11 +1756,18 @@ static int __devinit load_firmware(struc
>  	if (retval)
>  		goto end;
>  
> +	dev_info(&pdev->dev, "Firmware requested, size: %u\n", fw->size);
> +
> +	retval = -EIO;
> +
>  	for (frame = (struct stframe *)fw->data;
>  			frame < (struct stframe *)(fw->data + fw->size);
> -			frame++) {
> -		if (WaitTillCardIsFree(base))
> +			frame = (struct stframe *)((u8 *)frame + 4 +
> +				frame->count)) {
> +		if (WaitTillCardIsFree(base)) {
> +			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
>  			goto errrelfw;
> +		}
>  
>  		outw(0xf0, base);	/* start upload sequence */
>  		outw(0x00, base);
> @@ -1772,8 +1779,10 @@ static int __devinit load_firmware(struc
>  
>  		udelay(100); /* 0x2f */
>  
> -		if (WaitTillCardIsFree(base))
> +		if (WaitTillCardIsFree(base)) {
> +			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
>  			goto errrelfw;
> +		}
>  
>  		if ((status = inw(base + 0x4)) != 0) {
>  			dev_warn(&pdev->dev, "Card%d rejected load header:\n"
> @@ -1787,8 +1796,10 @@ static int __devinit load_firmware(struc
>  
>  		udelay(50); /* 0x0f */
>  
> -		if (WaitTillCardIsFree(base))
> +		if (WaitTillCardIsFree(base)) {
> +			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
>  			goto errrelfw;
> +		}
>  
>  		if ((status = inw(base + 0x4)) != 0) {
>  			dev_err(&pdev->dev, "Card%d got out of sync.Card "
> @@ -1796,8 +1807,9 @@ static int __devinit load_firmware(struc
>  			goto errrelfw;
>  		}
>   	}
> -
> -	retval = -EIO;
> +	dev_info(&pdev->dev, "Firmware loaded, last values: \n\tWC: %u, "
> +			"FD: %p, FP: %p\n",
> +			word_count, fw->data, frame);
>  
>  	if (WaitTillCardIsFree(base))
>  		goto errrelfw;
> @@ -1811,24 +1823,29 @@ static int __devinit load_firmware(struc
>  
>  /* XXX: should we test it by reading it back and comparing with original like
>   * in load firmware package? */
> -	for (frame = (struct stframe*)fw->data;
> -			frame < (struct stframe*)(fw->data + fw->size);
> -			frame++) {
> -		if (WaitTillCardIsFree(base))
> +	for (frame = (struct stframe *)fw->data;
> +			frame < (struct stframe *)(fw->data + fw->size);
> +			frame = (struct stframe *)((u8 *)frame + 4 +
> +				frame->count)) {
> +		if (WaitTillCardIsFree(base)) {
> +			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
>  			goto errrelfw;
> +		}
>  
>  		outw(0xf1, base); /* start download sequence */
>  		outw(0x00, base);
>  		outw(frame->addr, base); /* lsb of address */
>  
> -		word_count = (frame->count >> 1) + frame->count % 2;
> +		word_count = frame->count / 2 + frame->count % 2;
>  		outw(word_count + 1, base);
>  		InterruptTheCard(base);
>  
>  		udelay(50); /* 0xf */
>  
> -		if (WaitTillCardIsFree(base))
> +		if (WaitTillCardIsFree(base)) {
> +			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
>  			goto errrelfw;
> +		}
>  
>  		if ((status = inw(base + 0x4)) != 0) {
>  			dev_warn(&pdev->dev, "Card%d rejected verify header:\n"
> @@ -1853,8 +1870,10 @@ static int __devinit load_firmware(struc
>  
>  		udelay(50); /* 0xf */
>  
> -		if (WaitTillCardIsFree(base))
> +		if (WaitTillCardIsFree(base)) {
> +			dev_err(&pdev->dev, "Card is not free: %u\n", __LINE__);
>  			goto errrelfw;
> +		}
>  
>  		if ((status = inw(base + 0x4)) != 0) {
>  			dev_err(&pdev->dev, "Card%d verify got out of sync. "
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   
