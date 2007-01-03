Return-Path: <linux-kernel-owner+w=401wt.eu-S1750712AbXACLA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbXACLA6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 06:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbXACLA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 06:00:58 -0500
Received: from [217.111.56.2] ([217.111.56.2]:34896 "EHLO semtex.sncag.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750712AbXACLA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 06:00:57 -0500
To: Greg KH <greg@kroah.com>
Cc: Rainer Weikusat <rweikusat@sncag.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] fix for bugzilla #7544 (keyspan USB-to-serial converter)
In-Reply-To: <20070103013736.GA18198@kroah.com> (Greg KH's message of "Tue, 2 Jan 2007 17:37:36 -0800")
References: <877iw5l2eh.fsf@semtex.sncag.com>
	<20070103013736.GA18198@kroah.com>
From: Rainer Weikusat <rainer.weikusat@sncag.com>
Date: Wed, 03 Jan 2007 12:00:51 +0100
Message-ID: <87d55w5q8s.fsf@semtex.sncag.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> On Tue, Jan 02, 2007 at 07:16:54PM +0100, Rainer Weikusat wrote:
>> At least the Keyspan USA-19HS USB-to-serial converter supports
>> two different configurations, one where the input endpoints
>> have interrupt transfer type and one where they are bulk endpoints.
>> The default UHCI configuration uses the interrupt input endpoints.
>> The keyspan driver, OTOH, assumes that the device has only bulk
>> endpoints (all URBs are initialized by calling usb_fill_bulk_urb
>> in keyspan.c/ keyspan_setup_urb).
>
> So, this means that Keyspan changed the USB configuration of this
> device?

No, it means what I have written several times: The UHCI code up to
2.6.17.11 accepted URBs initialized as bulk URBs for interrupt
endpoints, the UHCI code since 2.6.18 doesn't anymore. This is all
somewhat idealized, but these endpoints should be interrupt endpoints
and the driver should initialize its URBs correctly.

> Can you send me the output of 'cat /proc/bus/usb/devices' with this
> keyspan device plugged in?  I'll compare it with the devices I have
> here.

In plain English, this means 'I am fairly convinced that the actual
problem is that you are certainly too stupid to read'.

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=ff Prot=ff MxPS= 8 #Cfgs=  2
P:  Vendor=06cd ProdID=0121 Rev= 1.00
S:  Manufacturer=Keyspan, a division of InnoSys Inc.
S:  Product=Keyspan USA-19H 
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 5 Cls=ff(vend.) Sub=00 Prot=00 Driver=keyspan
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
C:  #Ifs= 1 Cfg#= 2 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 5 Cls=ff(vend.) Sub=00 Prot=00 Driver=
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

NB: This indicates that the input buffer size (32) is wrong as well.

[...]

>>  /* Helper functions used by keyspan_setup_urbs */
>> +static struct usb_endpoint_descriptor const *
>> +find_ep_desc_for(struct usb_serial const *serial, int endpoint)
>> +{
>> +	struct usb_host_endpoint const *p, *e;
>> +
>> +	p = serial->interface->cur_altsetting->endpoint;
>> +	e = p + serial->interface->cur_altsetting->desc.bNumEndpoints;
>> +	while (p < e && p->desc.bEndpointAddress != endpoint) ++p;
>> +	
>> +	if (unlikely(p == e)) panic("found no endpoint descriptor for "
>> +				    "endpoint %d\n", endpoint);
>
> No need for "unlikely" on such a slow path.

It doesn't hurt and documents that this is the proverbial impossible
condition check.

> Also, panic() should be on the next line for the proper coding
> style.

It is somewhat unreasonable to expect random people to 'just know'
about things that aren't documented.

> And, we don't want to panic() for such a trivial thing.  Just abort the
> probe sequence at most, but never shut down the machine for an odd
> device that we find.

I actually thought about that this morning: Considering the path this
came from, this is not 'an odd device' but rather something like 'kernel
memory corruption' (the 'endpoint' value originally came from the
exact same descriptor).
