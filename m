Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVCaBJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVCaBJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVCaBJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:09:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38872 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262569AbVCaBJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:09:45 -0500
Message-ID: <424B4DCB.2040805@pobox.com>
Date: Wed, 30 Mar 2005 20:09:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dbrownell@users.sourceforge.net, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] USB: usbnet uses netif_msg_*() ethtool filtering
References: <200503302319.j2UNJEBP019719@hera.kernel.org> <424B44C3.4040804@pobox.com> <200503301650.17486.david-b@pacbell.net>
In-Reply-To: <200503301650.17486.david-b@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> On Wednesday 30 March 2005 4:30 pm, Jeff Garzik wrote:
> 
>>Linux Kernel Mailing List wrote:
>>
>>>ChangeSet 1.2181.4.72, 2005/03/24 15:31:29-08:00, david-b@pacbell.net
>>>
>>>	[PATCH] USB: usbnet uses netif_msg_*() ethtool filtering
>>>	
>>>	This converts most of the usbnet code to actually use the ethtool
>>>	message flags.  The ASIX code is left untouched, since there are
>>>	a bunch of patches pending there ... that's where the remaining
>>>	handful of "sparse -Wbitwise" warnings come from.
>>>	
>>>	Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>>>	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>>
>>It would be nice if people at least CC'd me on net driver patches.
> 
> 
> Sorry.  When drivers fit multiple classifications (e.g. USB _and_ NET,
> or USB _and_ PCI _and_ PM, etc) it's unfortunately routine that not all
> interested parties see them until something hits LKML.  Even when the
> changes have significant cross-subsystem impact (these don't).

I don't care who merges the patches -- presumably the current system 
works just fine -- but netdev@oss.sgi.com and I should be reviewing the 
patches.


>>netfi_msg_ifdown() is only for __interface__ up/down events; as such, 
>>there should be only one message of this type in dev->open(), and one 
>>message of this type in dev->stop().
> 
> 
> I was going by the only writeup I've ever seen, which doesn't mention
> such a rule at all.  The messages you highlighted are compatible with
> these rules:  the interface is actually going down at that point.
> 
>   http://www.tux.org/hypermail/linux-vortex/2001-Nov/0021.html
> 
> If there are other rules, they belong in Documentation/netif-msg.txt
> don't they?  That way folk won't be forced to guess.  Or risk
> accidentally following the "wrong" set of rules...

I don't see from the code that the struct net_device interface is going 
down (via dev->stop) at that point.  Am I mistaken?

Moreover, if you look at any other user of netif_msg_if{up,down}, you 
will see that it does not produce multiple lines of status register 
information opaque to anyone but the programmer.  Its not a debugging 
message, but something a user should feel comfortable enabling (if not 
enabled by default).


>>>@@ -3044,7 +3047,7 @@
>>> 
>>> 	memset(urb->transfer_buffer, 0, urb->transfer_buffer_length);
>>> 	status = usb_submit_urb (urb, GFP_ATOMIC);
>>>-	if (status != 0)
>>>+	if (status != 0 && netif_msg_timer (dev))
>>> 		deverr(dev, "intr resubmit --> %d", status);
>>> }
>>> 
>>
>>this looks more like a debugging message?
> 
> 
> It's an error of the "what do I do now??" variety, triggered by
> what's effectively a timer callback.  USB interrupt transfers
> are polled by the host controller according to a schedule that's
> maintained by the HCD.

The above example seems more like netif_msg_tx_err() or even just KERN_ERR ?

	Jeff


