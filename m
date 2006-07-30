Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWG3NJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWG3NJv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWG3NJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:09:50 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:29119 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1750735AbWG3NJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:09:50 -0400
Message-ID: <44CCB087.8030804@keyaccess.nl>
Date: Sun, 30 Jul 2006 15:13:43 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Simon White <s_a_white@email.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Driver model ISA bus
References: <20060730122415.A17D31CE304@ws1-6.us4.outblaze.com>
In-Reply-To: <20060730122415.A17D31CE304@ws1-6.us4.outblaze.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon White wrote:

>> No, the name is just an identifier under which the driver (and 
>> devices) show up in sysfs and ndev the number of devices we want to 
>> the driver code to call our methods with -- given that ISA devices 
>> do not announce themselves we have to tell the driver core this.
> 
> If I understood correctly, it is the maximum number of devices our
> driver will support. 

Yes.

> I got confused with an earlier version of this whereby devices were
> to be registered with the isa bus on finding them.
> 
> One further thing I'd like to check.  In my case there can only be a
> maximum of 4 cards, limited by the possible hardware addresses 
> manually selectable.  Will the probe calls just happen or do they 
> require some userspace activity to occur (referring to that echo bind
> in the example).

If you provide a match() method as part of the isa_driver struct the 
calls to that method will just happen and if it returns non-zero, 
indicating a match between this driver and the device, the calls to the 
probe method will just happen. On a non-match (0), the device is 
unregistered again.

The driver model ISA bus is meant to provide a framework for ISA drivers 
close to the model from saner busses such as PCI. PCI drivers load 
always (even without their PCI ID present) since the user could do 
things such as supply a new PCI ID to the driver after it's loaded 
through sysfs (the new_id file).

As the example says, the match() method is intended only for things 
which should make the device fail to register since it could never be 
useful anymore -- in the example, if a port value hasn't been passed in 
we can't do anything so fail the device registration. Due to the fact 
that most other problems could be fixed later while the driver is loaded 
(such as by unloading a different driver which was keeping our ports 
busy) things such as that are also really the only things you should 
check in the match method, and do everything else from the probe method.

On the other hand, if you are really dead set against loading when you 
can't immediately drive something that's up to you as well -- you decide 
when to fail the match().

Rene.
