Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUDCNVR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 08:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUDCNVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 08:21:17 -0500
Received: from pop.gmx.net ([213.165.64.20]:10185 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261725AbUDCNVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 08:21:13 -0500
X-Authenticated: #402920
Message-ID: <406EBA38.1030203@gmx.de>
Date: Sat, 03 Apr 2004 15:20:56 +0200
From: Michael Hunold <m.hunold@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sensors@stimpy.netroedge.com
CC: LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
 isolation
References: <40686476.7020603@convergence.de> <20040330213418.195dc972.khali@linux-fr.org>
In-Reply-To: <20040330213418.195dc972.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jean,

On 03/30/04 21:34, Jean Delvare wrote:
>>First of all I was surprised that "struct i2c_adapter" already contained 
>>a "flags" field. It doesn't seem to be used anywhere, though -- please 
>>correct me if I'm wrong.

> You seem to be correct. It looks like the flags member was added to all
> i2c structures, but for adapters it was left unused.

Ok.

>>I added one flag named "I2C_ADAP_FLAG_CLASS_MATCH" which adapters can 
>>set if they want the type of the i2c driver match the type of the i2c 
>>adapter.

> Why would an adapter want to accept non-matching clients once we will have
> added a clean isolation method?

My goal was to keep all non-dvb i2c clients away from my dvb i2c adapters.

Because the "probe every device on every bus" policy is currently used,
I didn't want to touch every i2c driver and break things.

>>At both places, the flags field is checked against the newly introduced 
>>flags I2C_ADAP_FLAG_CLASS_MATCH. If this flag is set and the adapter 
>>class and the driver class don't match, the driver is not probed on the bus.

> My initial approach was different. I wouldn't have introduced a new
> flag. Instead I would have defined a "neutral" class I2C_ADAP_CLASS_ANY
> 0xFFFF, suitable for chips that can belong to any bus (such as
> eeprom.c). This same value could be used for busses that don't care
> about which chips are connected to it (i2c-parport comes to mind). No
> flag needed.
> 
> Finding whether a chip and an adapter match is as easy as checking if
> ((chip->class & adapter->class) != 0).

Yes, agreed.

>>All "old" drivers don't have this flag set, so everything works just 
>>like before this change.

> This is where your approach looks slightly better than mine. With my
> method, backward compatibility isn't provided. However, fixing existing
> drivers would be rather easy, and I share Greg KH's view that drivers
> living outside the kernel tree get the pain they deserve.

8-) If this is the way to go, I totally agree, even if that means that
some drivers will fail to work in the beginning.

> My main point is that if we start defining classes for both chips and
> adapters and go on using them, we better consider it a policy and do it
> consistently, or it will probably look confusing to newcomers.

Sure.

>>Now it's only possible to load these 5 i2c drivers against the MXB 
>>saa7146 i2c bus -- all other i2c drivers don't get the chance to probe, 
>>which is exactly what I wanted.

> I guess you mean "against busses of class I2C_ADAP_CLASS_TV_ANALOG,
> amongst which is the MXB saa7146 bus"? Or I just lost you.

Yes, sorry. If other drivers are in the I2C_ADAP_CLASS_TV_ANALOG class, 
they will be probed, too.

Hm, perhaps we should add another method where an adapter can specify 
the I2C_DRIVERID_*s from the clients it's expecting. The rationale 
behind this is, that most PCI cards can be identified uniquely by their 
vendor/subvendor ids, so the driver author definately knows which i2c 
clients are on the card and what are expected to be present. No need to 
probe every i2c client.

What do you think?

>>- Should the I2C_ADAP_CLASS_* be renamed to I2C_CLASS_*, so they can be 
>>used by both i2c adapters and i2c drivers?

> I would say yes, but I'm not the authority.

If we agree that this change should be done, this sound reasonable to me.

CU
Michael.
