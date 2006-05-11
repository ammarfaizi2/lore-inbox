Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWEKXxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWEKXxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 19:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWEKXxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 19:53:35 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:16565 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750838AbWEKXxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 19:53:34 -0400
Message-ID: <4463CE71.1000205@myri.com>
Date: Fri, 12 May 2006 01:53:21 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>
Subject: Re: [PATCH 5/6] myri10ge - Second half of the driver
References: <446259A0.8050504@myri.com>	<Pine.GSO.4.44.0605101441510.498-100000@adel.myri.com> <20060510152244.44fb3db7@localhost.localdomain>
In-Reply-To: <20060510152244.44fb3db7@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
>> +
>> +static int
>> +myri10ge_open(struct net_device *dev)
>>     
>
> It is preferred to put function declarations on one line.
>
> static int mril10ge_open(struct net_device *dev)
>   

Well, I have seen several threads about this in the archive, with some
people against and some people pro. I personaly like grepping for the
declaration of function using ^name.
If this codingstyle is really required, I will do.

> I would prefer to just have driver always do NAPI.  It's a 10G driver, it
> really needs to be NAPI to prevent machine starvation.
>   

When TSO is disabled, we see performance being about 300Mbs lower when
enabling NAPI. But we'll probably enable TSO by default (see below) so
we'll probably drop non-NAPI.

>> +	myri10ge_close(mgp->dev);
>> +	status = myri10ge_load_firmware(mgp);
>> +	if (status != 0) {
>> +		printk(KERN_ERR "myri10ge: %s: failed to load firmware\n",
>> +		       mgp->dev->name);
>> +		return;
>> +	}
>> +	myri10ge_open(mgp->dev);
>> +}
>>     
>
> Watchdog's are a sign of buggy hardware and drivers!
>   

Well... the watchdog is supposed to help detecting memory parity errors
in the NIC. It's rare, but it happens with cosmic rays. The recovery
part still need some work anyway. So we might drop the watchdog for now
and come back when recovery is ready.

Additionally, we are using our own watchdog because the linux netdev
watchdog does not seem to work well for devices with large hardware
transmit queues.  If there is a hardware problem, a single (or even a
handful) of TCP streams will not backup into the hardware queue in a
timely fashion, leading to a long delay before the netdev watchdog
routine is called.

>> +#if 0
>> +	/* TSO can be enabled via ethtool -K eth1 tso on */
>> +#ifdef NETIF_F_TSO
>> +	netdev->features |= NETIF_F_TSO;
>> +#endif
>> +#endif
>>     
>
> If it works enable it, if it doesn't take the code out.
>   

It works. We did not enable it by default because there were some
problems in older kernels. They seem to be fixed in recent kernels. So
we'll enable TSO by default and have people disable it if it causes
problems.


>> [PATCH 3/6] myri10ge - Driver header files
>>
>> myri10ge driver header files.
>> myri10ge_mcp.h is the generic header, while myri10ge_mcp_gen_header.h
>> is automatically generated from our firmware image.
>>     
>
> Then clean it up after the auto generation.
> Auto generated code still gets maintained by humans.
>   

Oops sorry, I forgot to apply my cleaning script before sending.


>> +#define MYRI10GE_MCP_MAJOR	1
>> +#define MYRI10GE_MCP_MINOR	4
>> +
>>     
>
> Major/Minor for what. You don't have a character device.
>   

That's the firmware version, we'll find better names.



Thanks a lot for all the comments.

Brice

