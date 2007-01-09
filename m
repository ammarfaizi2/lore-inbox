Return-Path: <linux-kernel-owner+w=401wt.eu-S932135AbXAIPCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbXAIPCw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbXAIPCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:02:51 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:10626 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932127AbXAIPCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:02:50 -0500
To: Dmitriy Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, linux-pci@atrey.karlin.mff.cuni.cz,
       netdev@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 5/5] fixing errors handling during pci_driver resume stage [serial]
References: <87ps9omv3t.fsf@sw.ru>
	<20070109122752.GA26337@flint.arm.linux.org.uk>
From: Dmitriy Monakhov <dmonakhov@sw.ru>
Date: Tue, 09 Jan 2007 18:02:44 +0300
In-Reply-To: <20070109122752.GA26337@flint.arm.linux.org.uk> (Russell King's message of "Tue, 9 Jan 2007 12:27:53 +0000")
Message-ID: <87y7ocqm3v.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> On Tue, Jan 09, 2007 at 12:01:58PM +0300, Dmitriy Monakhov wrote:
>> serial pci drivers have to return correct error code during resume stage in
>> case of errors.
>
> Sigh.  *hate* *hate* *hate*.
>
>> diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
>> index 52e2e64..e26e4a6 100644
>> --- a/drivers/serial/8250_pci.c
>> +++ b/drivers/serial/8250_pci.c
>> @@ -1805,6 +1805,7 @@ static int pciserial_suspend_one(struct
>>  static int pciserial_resume_one(struct pci_dev *dev)
>>  {
>>  	struct serial_private *priv = pci_get_drvdata(dev);
>> +	int err;
>>  
>>  	pci_set_power_state(dev, PCI_D0);
>>  	pci_restore_state(dev);
>> @@ -1813,7 +1814,12 @@ static int pciserial_resume_one(struct p
>>  		/*
>>  		 * The device may have been disabled.  Re-enable it.
>>  		 */
>> -		pci_enable_device(dev);
>> +		err = pci_enable_device(dev);
>> +		if (err) {
>> +			dev_err(&dev->dev, "Cannot enable PCI device, "
>> +				"aborting.\n");
>> +			return err;
>> +		}
>>  
>>  		pciserial_resume_ports(priv);
>>  	}
>
> So if pci_enable_device() fails, what do we do with the still suspended
> serial port?  Does it clean up that state?  Probably not.
>
> Look, merely going around bunging this stupid "oh lets propagate the
> error" crap into the kernel doesn't actually fix _anything_.  In fact
> it potentially _hides_ the warnings produced by __must_check which
> give a hint that _something_ needs to be done to _properly_ fix the
> problem.
>
> And by "properly", I mean not just merely propagating the error.
>
> In this particular case, the above may result in resources not being
> freed.
Yep 100% true. But the question is _HOW_? We want shutdown not enabled device.
Is it safe just call pciserial_remove_ports() for this device? 
>
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

