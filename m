Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423403AbWJZFE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423403AbWJZFE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 01:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423406AbWJZFE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 01:04:56 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:13810 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423403AbWJZFEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 01:04:55 -0400
Message-ID: <45404237.3070307@oracle.com>
Date: Wed, 25 Oct 2006 22:05:59 -0700
From: "Randy.Dunlap" <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: toralf.foerster@gmx.de, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, greg@kroah.com,
       akpm@osdl.org, zippel@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Subject: Re: [PATCH 1/2] !CONFIG_NET_ETHERNET unsets CONFIG_PHYLIB, but  CONFIG_USB_USBNET
 also needs CONFIG_PHYLIB
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061025222709.A13681C5E0B@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20061025165957.4c390137.randy.dunlap@oracle.com> <200610251924.04321.david-b@pacbell.net>
In-Reply-To: <200610251924.04321.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> On Wednesday 25 October 2006 4:59 pm, Randy Dunlap wrote:
>> On Wed, 25 Oct 2006 15:27:09 -0700 David Brownell wrote:
>>
>>> The other parts are right, this isn't.
>>>
>>> Instead, "usbnet.c" should #ifdef the relevant ethtool hooks
>>> according to CONFIG_MII ... since it's completely legit to
>>> use usbnet with peripherals that don't need MII.
>> Ugh.  OK.  How's this?  (2 patches)
> 
> Looks about right, but ...
> 
> 
>> However, the MII config symbol should not be in the 10/100 Ethernet
>> menu, so that other drivers can use (enable) it or so that users
>> can enable it without needing to enable 10/100 Ethernet.
> 
> ... MII should still depend on ETHERNET, right?
> Just not limited to 10/100 Ethernet.

There is no such config symbol.  NET_ETHERNET means 10/100 ethernet.
Gigabit ethernet doesn't use the ETHERNET symbol (and doesn't use
this flavor of MII IIRC).
And all of this config space is surrounded by:

# All the following symbols are dependent on NETDEVICES - do not repeat
# that for each of the symbols.
if NETDEVICES

so it is actually
config MII
	depends on NETDEVICES

What do you suggest?

>> --- linux-2619-rc3-pv.orig/drivers/net/Kconfig
>> +++ linux-2619-rc3-pv/drivers/net/Kconfig
>> @@ -145,6 +145,13 @@ config NET_SB1000
>>  
>>  source "drivers/net/arcnet/Kconfig"
>>  
>> +config MII
>> +	tristate "Generic Media Independent Interface device support"
>> +	help
>> +	  Most ethernet controllers have MII transceiver either as an external
>> +	  or internal device.  It is safe to say Y or M here even if your
>> +	  ethernet card lacks MII.
>> +
>>  source "drivers/net/phy/Kconfig"
>>  
>>  #
>> @@ -180,14 +187,6 @@ config NET_ETHERNET
>>  	  kernel: saying N will just cause the configurator to skip all
>>  	  the questions about Ethernet network cards. If unsure, say N.
>>  
>> -config MII
>> -	tristate "Generic Media Independent Interface device support"
>> -	depends on NET_ETHERNET
>> -	help
>> -	  Most ethernet controllers have MII transceiver either as an external
>> -	  or internal device.  It is safe to say Y or M here even if your
>> -	  ethernet card lack MII.
>> -
>>  source "drivers/net/arm/Kconfig"
>>  
>>  config MACE
>>


-- 
~Randy
