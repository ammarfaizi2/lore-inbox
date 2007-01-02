Return-Path: <linux-kernel-owner+w=401wt.eu-S932775AbXABK3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbXABK3T (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbXABK3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:29:19 -0500
Received: from poczta.o2.pl ([193.17.41.142]:55037 "EHLO poczta.o2.pl"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932777AbXABK3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:29:18 -0500
Date: Tue, 2 Jan 2007 11:30:53 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: David Miller <davem@davemloft.net>
Cc: hadi@cyberus.ca, netdev@vger.kernel.org, jeff@garzik.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ifb error path loop fix
Message-ID: <20070102103053.GA2798@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070101.235132.85409619.davem@davemloft.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-01-2007 08:51, David Miller wrote:
> From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> Date: Tue, 2 Jan 2007 00:55:51 +0100
> 
>> On error we should start freeing resources at [i-1] not [i-2].
>>
>> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
> Patch applied, thanks Mariusz.
> 
>> diff -upr linux-2.6.20-rc2-mm1-a/drivers/net/ifb.c linux-2.6.20-rc2-mm1-b/drivers/net/ifb.c
>> --- linux-2.6.20-rc2-mm1-a/drivers/net/ifb.c	2006-12-24 05:00:32.000000000 +0100
>> +++ linux-2.6.20-rc2-mm1-b/drivers/net/ifb.c	2007-01-02 00:25:34.000000000 +0100
>> @@ -271,8 +271,7 @@ static int __init ifb_init_module(void)
>>  	for (i = 0; i < numifbs && !err; i++)
>>  		err = ifb_init_one(i);
>>  	if (err) {
>> -		i--;
>> -		while (--i >= 0)
>> +		while (i--)
>>  			ifb_free_one(i);
>>  	}

After this patch:

for (i = 0 ...); // i == 0
err = ifb_init_one(i); // err != 0
i++; // i == 1
for (... !err ...); // break 

if (err) {
	while (i--) // i == 1 (when testing)
		ifb_free_one(i); // i == 0 (not initialized)
}

Btw. wasn't this place patched yet?

Regards,
Jarek P.
