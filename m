Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWAQVlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWAQVlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWAQVlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:41:45 -0500
Received: from outbound-mail-22.bluehost.com ([70.103.189.17]:40609 "HELO
	outbound-mail-22.bluehost.com") by vger.kernel.org with SMTP
	id S1751348AbWAQVlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:41:44 -0500
Message-ID: <43CD647F.2080205@secretlab.ca>
Date: Tue, 17 Jan 2006 14:41:19 -0700
From: Grant Likely <gl1@secretlab.ca>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <galak@gate.crashing.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Kumar Gala <galak@kernel.crashing.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 6/6] serial8250: convert to the new platform device interface
References: <Pine.LNX.4.44.0601161752560.6677-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0601161752560.6677-100000@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box56.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - secretlab.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:
> On Mon, 16 Jan 2006, Russell King wrote:
>>On Mon, Jan 16, 2006 at 04:27:17PM -0600, Kumar Gala wrote:
>>
>>Mea Culpa - should've spotted that - that patch is actually rather
>>broken.  platform_driver_register() can't be moved from where it
>>initially was.
> 
> 
> This seems to fix my issue on arch/powerpc and arch/ppc, please push to 
> Linus ASAP.

Ditto for ML403 (Virtex), thanks

g.

> 
> 
>>diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
>>--- a/drivers/serial/8250.c
>>+++ b/drivers/serial/8250.c
>>@@ -2595,15 +2595,11 @@ static int __init serial8250_init(void)
>> 	if (ret)
>> 		goto out;
>> 
>>-	ret = platform_driver_register(&serial8250_isa_driver);
>>-	if (ret)
>>-		goto unreg_uart_drv;
>>-
>> 	serial8250_isa_devs = platform_device_alloc("serial8250",
>> 						    PLAT8250_DEV_LEGACY);
>> 	if (!serial8250_isa_devs) {
>> 		ret = -ENOMEM;
>>-		goto unreg_plat_drv;
>>+		goto unreg_uart_drv;
>> 	}
>> 
>> 	ret = platform_device_add(serial8250_isa_devs);
>>@@ -2612,12 +2608,13 @@ static int __init serial8250_init(void)
>> 
>> 	serial8250_register_ports(&serial8250_reg, &serial8250_isa_devs->dev);
>> 
>>-	goto out;
>>+	ret = platform_driver_register(&serial8250_isa_driver);
>>+	if (ret == 0)
>>+		goto out;
>> 
>>+	platform_device_del(serial8250_isa_devs);
>>  put_dev:
>> 	platform_device_put(serial8250_isa_devs);
>>- unreg_plat_drv:
>>-	platform_driver_unregister(&serial8250_isa_driver);
>>  unreg_uart_drv:
>> 	uart_unregister_driver(&serial8250_reg);
>>  out:
>>
>>
>>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 

