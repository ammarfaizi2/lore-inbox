Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030682AbWLETuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682AbWLETuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030629AbWLETuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:50:44 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:42172 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030613AbWLETum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:50:42 -0500
In-Reply-To: <1165298581.29784.58.camel@localhost.localdomain>
References: <E1GrTGu-0005QS-OH@lucciola> <1165298581.29784.58.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1DFF488A-7BF4-4BC7-A398-A27753335028@freescale.com>
Cc: Amy Fong <amy.fong@windriver.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, jeff@garzik.org
Content-Transfer-Encoding: 7bit
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Add Broadcom PHY support
Date: Tue, 5 Dec 2006 13:50:22 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 5, 2006, at 00:03, Benjamin Herrenschmidt wrote:

>
>> I believe that this fiber enabling can be done by defining  
>> config_init in the phy_driver struct.
>>
>> struct phy_driver {
>> <snip>
>>         /* Called to initialize the PHY,
>> 	 * including after a reset */
>> 	int (*config_init)(struct phy_device *phydev);
>> <snip>
>> };
>
> Well... I don't know for sure... thing is, enabling the fiber mode  
> is a
> rather platform specific thing. So it's the MAC driver that knows  
> wether
> it wants it on a PHY and should call into the driver.
>
> It's difficult to abstract all possible PHY config options tho... some
> MACs might want to enable low power, some don't because they have  
> issues
> with it, that sort of thing, though.
>
> Not sure what the best solution is at this point... Maybe an ascii
> string to pass the PHY driver is the most flexible, though a bit  
> yucky,
> or we try to have a list of all the possible configuration options in
> phy.h and people just add new ones that they need as they add support
> for them...
>
> Sounds grossly like an in-kernel ioctl tho...


Each phy_device structure now has a dev_flags field that can be  
modified by the controller's code upon connecting.  The PHY driver  
can then check that field for PHY-specific, platform-specific  
interactions.  For instance, on the newer CDS, there's a Marvell PHY  
which requires configurable resistance changes to work in RGMII  
mode.  So there's a flag for that.  Basically, each PHY driver  
specifies its own flags, and the platform code is currently  
responsible for setting those flags appropriately.  A string might be  
more flexible, but I'm operating on the hope that there shouldn't be  
too many of these.

For Fiber mode, or other such changes, we might want to add another  
field, like the interface field, to describe standard external  
interfaces.  The call to phy_connect() is beginning to get a bit  
long, though.

Andy
