Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270158AbTGPH1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 03:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270175AbTGPH1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 03:27:00 -0400
Received: from mail.convergence.de ([212.84.236.4]:42186 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S270158AbTGPH05
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 03:26:57 -0400
Message-ID: <3F1501B9.8010603@convergence.de>
Date: Wed, 16 Jul 2003 09:41:45 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] Add a driver for the Technisat Skystar2 DVB card
References: <1058271657827@convergence.de> <10582716573394@convergence.de> <20030716012841.GA2017@kroah.com>
In-Reply-To: <20030716012841.GA2017@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg KH,

thanks for reviewing these patches.

>>+
>>+/////////////////////////////////////////////////////////////////////
>>+//              register functions
>>+/////////////////////////////////////////////////////////////////////
>>+
>>+void WriteRegDW(struct adapter *adapter, u32 reg, u32 value)
> 
> 
> Hm, this really isn't the proper Linux coding style.  Please read
> Documentation/CodingStyle on how to name functions.

Yes, I know. The code was imported from an external source, and the code 
was kept mostly unchanged to keep syncing easier.

But with all the problems you mentioned, I'm now going to review the 
code. I'll send an updated patch later.

>>+{
>>+	u32 flags;
> 
> 
> flags has to be a unsigned long.

Yes.

> 
> 
>>+
>>+	save_flags(flags);
>>+	cli();
> 
> 
> Huh?  Did you even compile this on a SMP kernel on 2.5?  (Hint, it will
> not...)  Please fix this up.

OMG. I'm sorry for having submitted something like this. It was not 
tested by me, no. I'll fix it and test compiling for SMP.

> 
> 
>>+u32 ReadRegDW(struct adapter *adapter, u32 reg)
>>+{
>>+	return readl(adapter->io_mem + reg);
>>+}
> 
> 
> Why?  Why not just write the readl() function whereever you call
> ReadRegDW?

I don't want to defend the original author, but perhaps these functions 
were copy&pasted from a Windoze driver.

>>+/////////////////////////////////////////////////////////////////////
>>+//                      I2C
>>+////////////////////////////////////////////////////////////////////
>>+
>>+u32 i2cMainWriteForFlex2(struct adapter * adapter, u32 command, u8 * buf, u32 retries)
> 
> 
> kernel functions traditionally return an int.  A negative number if
> there is an error, and 0 if there isn't.

I'll review it.

> Oh, any reason for not tying this to the existing i2c core?
> Or is that done somewhere else?

No.  I2C is used by all devices at least to access the different 
chipsets that make up the tuning.

In former times, the project had a hard time getting tuning to work in a 
reliable way, because some of these chipsets are particularly picky when 
it comes to timing and expect messages in a fixed form. Especially 
probing of other i2c devices was a problem, which locked up the i2c bus 
often.

I know that an class field for i2c adapters exists now and that i2c 
clients can check if they want to probe that bus at all now.

The DVB core is quite self contained and we decided to copy the i2c 
functionality needed for our purposes. So we ended up in using about 100 
lines of code instead of the whole i2c core.

Now that you have finished improving the i2c core, perhaps we can switch 
back to the kernel i2c system at a later time.

> thanks,
> 
> greg k-h

CU
Michael.

