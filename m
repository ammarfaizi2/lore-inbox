Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTESBOG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 21:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTESBOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 21:14:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:152 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262283AbTESBOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 21:14:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Naming devices
Date: Sun, 18 May 2003 18:22:51 -0700
User-Agent: KMail/1.4.1
References: <20030518213358.GE8994@krispykreme>
In-Reply-To: <20030518213358.GE8994@krispykreme>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305181822.51612.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 May 2003 02:33 pm, Anton Blanchard wrote:
> Hi,
>
> I just spent 2 hours trying to make a machine boot. It had one bad disk
> and one bad network card. Normally not a problem, but this thing had 40
> cards in it so identifying the problem ones was not straight forward.
>
> I was wondering why we dont have a consistent way of printing a device
> location? If all drivers used the same thing, eg:
>
> struct pci_dev *foo;
> ...
> printf("%s: could not enable card\n", PCI_LOCATION(foo));
>
> Which by default would print pci bus/devfn and an arch could override eg
> on ppc64 it would also print a location code:
>
> U1.6-P1-I2/E1 (90:0c.0)
>
> This sounds like the domain of the event logging guys but I havent seen
> anything from them in a while. The nice thing about this is that when we
> get pci domains nothing needs to be changed in the driver, we just
> update the PCI_LOCATION macro.
>
> Also the tendency of network drivers to print "eth0: foo" during
> initialisation is even more of a problem. If you get a bad card then you
> could end up reusing the eth0 name for a subsequent device, making
> pinpointing the problem card difficult. On top of that some drivers use
> dev->name between calling alloc_netdev() and register_netdev() so that
> you end up with error messages like "eth%d: failed".


Hi Anton,

We have been working on device macros that add standard prefixes to printk 
messages. The purpose of the prefix is to identify the device in the message 
with a specific device or sysfs directory. Generic device macros already are 
in the 2.5 kernel in include/linux/device.h - dev_err, dev_info, etc. They 
prefix printk messages with dev->bus_id and driver name. 

Just last week or so, Jim Keniston asked for comments on network device 
specific macros - netdev_printk. I thought these were handy when I was 
working on a system with 4 ethernet cards. With the e1000 patch, I could 
identify the device without having to use ethtool because netdev_printk 
appends the PCI device id in the prefix of the message. I could tell which 
device eth0 referred to from the message.

One of the reasons why we decided on the wrapper macros is the ability to 
change the prefix in the future without impacting device drivers that have 
implemented those macros. We could add more infromation from the device 
structure to the message without requiring device drivers to change anything. 
We could also use those macros as a hook to provide more functionality, like 
building templates based on calling function and format string to idenify the 
message uniquely, without impacting the driver.

Yet the macros we've been supplying are a bit rigid. Perhaps we should have 
something like you've suggested that could be used by driver writers to tag a 
message with a specific device location while not requiring the use of a 
whole wrapper macro. Plus, you could override the result based on arch. You 
wouldn't get the benefits of the current device macros, but you would be able 
to identify the message with a specific device.


Thanks,

Dan





> Anton
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

