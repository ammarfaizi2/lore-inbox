Return-Path: <linux-kernel-owner+w=401wt.eu-S932741AbWLNOiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbWLNOiA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWLNOiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:38:00 -0500
Received: from smtp.nokia.com ([131.228.20.172]:53416 "EHLO
	mgw-ext13.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932741AbWLNOh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:37:59 -0500
X-Greylist: delayed 1818 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 09:37:58 EST
Message-ID: <45815B3A.1010805@indt.org.br>
Date: Thu, 14 Dec 2006 10:10:02 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: ext Frank Seidel <frank@kernalert.de>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/4] Add MMC Password Protection (lock/unlock) support
 V8: mmc_key_retention.diff
References: <20061213155531.1kpbmi3pk40kkoos@webmail.kernalert.de>
In-Reply-To: <20061213155531.1kpbmi3pk40kkoos@webmail.kernalert.de>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2006 14:05:19.0581 (UTC) FILETIME=[E37A60D0:01C71F88]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ext Frank Seidel wrote:
> Quoting Anderson Briglia <anderson.briglia@indt.org.br>:
>> [...]
> Hi,
> thats really cool stuff you're providing with your patches. :)
> I have some feedback or questions some parts here.
> But as i just started trying to get into kernelhacking you probably
> better don't take my notes to serious, please.

All comments are welcome, thanks for the revision. :)

> 
>> Index: linux-linus-2.6/drivers/mmc/mmc_sysfs.c
>> ===================================================================
>> --- linux-linus-2.6.orig/drivers/mmc/mmc_sysfs.c        2006-12-04 [...]
>> +static int mmc_key_instantiate(struct key *key, const void *data, 
>> size_t datalen)
>> +{
>> +        struct mmc_key_payload *mpayload, *zap;
>> +        int ret;
>> +
>> +        zap = NULL;
> What is zap here for? future use?
> And wouldn't it be good to also initialize mplayload here?

The code was based on code presents at security/keys/user_defined.c. This is the reason of why the MMC PWD code was
implemented using this returns types and others implementations.
That file (user_defined.c) implements generic functions to handle keys inside the kernel, using the Kernel Key Retention
Service. Maybe you can take a look there, :).
That zap variable was used to expand the key payload when a new password exceeded a previous configured size. But the
Kernel Key Retention Service has changed and that zap variable is not used on key_instantiate function implemented at
user_defined.c, anymore. I'll update the MMC PWD code.

> 
>> +        ret = -EINVAL;
> Is there a special reason why you already assign the errors to the
> return value variable before its clear that the assignment is needed?

See the reply above.
> 
> 
>> +        if (datalen <= 0 || datalen > MMC_KEYLEN_MAXBYTES || !data) {
> Isn't the last "|| !data" redundant as you already tested if datalen ==0?

data = 0 is different from !data.

> 
>> +                pr_debug("Invalid data\n");
>> +                goto error;
>> +        }
>> +
>> +        ret = key_payload_reserve(key, datalen);
>> +        if (ret < 0) {
>> +                pr_debug("ret = %d\n", ret);
>> +                goto error;
>> +        }
>> +
>> +        ret = -ENOMEM;
> Same as above: Why do you in any case want to assign it here?

Reply above.
> 
>> +        mpayload = kmalloc(sizeof(*mpayload) + datalen, GFP_KERNEL);
> I may be totally wrong, but is dereferencing a not initialized pointer
> (even just for using sizeof) really ok? 

Yes. I believe sizeof is a compiler operation and it does not access the data pointed by that pointer, it access just
the type of the pointer.

Wouldn't it be safer to use
> a sizeof(struct mmc_key_payload) here?

I believe there is no difference on using this one and that other declaration.

Thanks,

Anderson Briglia
