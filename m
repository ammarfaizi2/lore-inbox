Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWDYOh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWDYOh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWDYOh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:37:29 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:27353 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932215AbWDYOh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:37:29 -0400
In-Reply-To: <20060425152202.ad8f16c8.khali@linux-fr.org>
References: <Pine.LNX.4.44.0604181122360.15940-100000@gate.crashing.org> <20060425152202.ad8f16c8.khali@linux-fr.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <59B7166D-F2C4-4490-82B4-C6C25D63CEC3@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] I2C-MPC: Fix up error handling
Date: Tue, 25 Apr 2006 09:37:24 -0500
To: Jean Delvare <khali@linux-fr.org>
X-Mailer: Apple Mail (2.749.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 25, 2006, at 8:22 AM, Jean Delvare wrote:

> Hi Kumar,
>
> Is there a datasheet available for this chip?
>
>> * If we have an Unfinished (MCF) or Arbitration Lost (MAL) error and
>>   the bus is still busy reset the controller.  This prevents the
>>   controller from getting in a hung state for transactions for other
>>   devices.
>
> What "other devices" are you talking about? If the _bus_ is busy, it
> might be caused by any chip on the bus. Resetting the controller  
> may or
> may not help. But it's hard for me to say more without technical
> documentation. Can you explain what the CSR_MBB bit means exactly?
> Please also explain the scenario you are trying to address here.

Here's the definintion of CSR_MBB:

Bus busy. Indicates the status of the bus. When a START condition is  
detected, MBB is set. If a STOP condition
is detected, it is cleared.

What I meant is that I have a I2C slave device which is hanging up  
the bus on some transactions.  In those cases we will end up in one  
of the error conditions CSR_MCF, or CSR_MAL.  If I don't reset the  
controller all future transactions regardless of which device they  
are to fail.

>> * Fixed up propogating the errors from i2c_wait.
>
> Yes, I like this.
>
>> --- a/drivers/i2c/busses/i2c-mpc.c
>> +++ b/drivers/i2c/busses/i2c-mpc.c
>> @@ -115,11 +115,20 @@ static int i2c_wait(struct mpc_i2c *i2c,
>>
>>  	if (!(x & CSR_MCF)) {
>>  		pr_debug("I2C: unfinished\n");
>> +
>> +		/* reset the controller if the bus is still busy */
>> +		if (x & CSR_MBB)
>> +			writeccr(i2c, 0);
>> +
>>  		return -EIO;
>>  	}
>>
>>  	if (x & CSR_MAL) {
>>  		pr_debug("I2C: MAL\n");
>> +
>> +		/* reset the controller if the bus is still busy */
>> +		if (x & CSR_MBB)
>> +			writeccr(i2c, 0);
>>  		return -EIO;
>>  	}
>>
>
> Please try being consistent with your blank lines.
>
>> @@ -246,8 +259,13 @@ static int mpc_xfer(struct i2c_adapter *
>>  			return -EINTR;
>>  		}
>>  		if (time_after(jiffies, orig_jiffies + HZ)) {
>> -			pr_debug("I2C: timeout\n");
>> -			return -EIO;
>> +			writeccr(i2c, 0);
>> +
>> +			/* try one more time before we error */
>> +			if (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
>> +				pr_debug("I2C: timeout\n");
>> +				return -EIO;
>> +			}
>>  		}
>>  		schedule();
>>  	}
>> @@ -325,6 +343,7 @@ static int fsl_i2c_probe(struct platform
>>  			goto fail_irq;
>>  		}
>>
>> +	writeccr(i2c, 0);
>>  	mpc_i2c_setclock(i2c);
>>  	platform_set_drvdata(pdev, i2c);
>
> These last two changes are not mentioned in your header comment. What
> are they? Why are they needed? They look like hacks to me.

Sorry about that, figured they fell in a catch all.

The first is an attempt to reduce the errors related to the buggy  
slave device.

The second (writeccr(i2c, 0)) is just ensure the controller is in a  
known state when we startup.

The

