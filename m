Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbUCRP4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbUCRP4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:56:44 -0500
Received: from mail.convergence.de ([212.84.236.4]:65432 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262721AbUCRP4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:56:39 -0500
Message-ID: <4059C6AE.7010102@convergence.de>
Date: Thu, 18 Mar 2004 16:56:30 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com
Subject: Re: [RFC][2.6] Additional i2c adapter flags for i2c client isolation
References: <4056C805.8090004@convergence.de> <20040316154454.GA13854@kroah.com>
In-Reply-To: <20040316154454.GA13854@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 16.03.2004 16:44, Greg KH wrote:
> On Tue, Mar 16, 2004 at 10:25:25AM +0100, Michael Hunold wrote:
> 
>>Here, all client drivers are unconditionally told to try and attach to
>>the adapter. There is no way that an i2c adapter can keep an i2c driver
>>away from the bus.
> 
> 
> Yes, but the different i2c chip drivers all check for the class setting
> to be correct before they really do anything, right?

As you've already noticed below, it's completely up to the driver -- and 
I don't trust i2c drivers I haven't written... ;-)

>>Currently, adapters can already specify a class, for DVB
>>I2C_ADAP_CLASS_TV_DIGITAL matches perfectly.

> Yes, and that is what you should check for.  It's a bug if any of the
> non-DVB i2c drivers probe devices with the .class set to
> I2C_ADAP_CLASS_TV_DIGITAL.  Fix that and you should be fine, right?

In theory this should be sufficient, but doesn't help if you have some 
"I don't care which bus this is and I'll probe it anyway" device.

Just think of all the i2c client drivers that are not part of the 
official kernel. I don't want to fix all these, just keep them away from 
"my" i2c busses...

>>What I'd like to have is that client can specify some sort of "class",
>>too, and that i2c adapters can tell the core that only clients where the
>>class is matching are allowed to probe their existence.

> Yeah, right now it's up to the chip drivers to be honest.  If you want
> to implement a change to do this instead, I'll be glad to apply it.

Ok, thanks. I'm heading for the small solution that doesn't break any 
existing "functionality" (if it's desired or not) and that doesn't 
require to touch every i2c driver in the kernel.

Here is the agenda:

- add a "class" field to the i2c client driver struct (ie. let the 
driver specify "I'm a DVB device" for example)
- add a flag to the adapter struct telling the i2c core "I only want 
drivers with a matching class to probe on this bus"
- make the i2c core actually check if an adapter has set the flag 
mentioned above and only let any i2c clientprobe on the bus if it has 
the matching class field

This won't break existing functionality (because all "old" i2c client 
drivers don't have the "class" field set and all "old" i2c adapters 
don't have the new flag specified) and will keep all i2c client drivers 
away from my DVB i2c busses.

The DVB i2c drivers, however, will be able to probe on the DVB i2c bus.

> thanks,
> greg k-h

CU
Michael.

