Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTICRcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbTICRcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:32:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8898 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264144AbTICRcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:32:16 -0400
Message-ID: <3F562590.60101@pobox.com>
Date: Wed, 03 Sep 2003 13:32:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Keniston <jkenisto@us.ibm.com>
CC: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       netdev <netdev@oss.sgi.com>, "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>, Randy Dunlap <rddunlap@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Net device error logging, revised
References: <3F4A8027.6FE3F594@us.ibm.com> <20030826183221.GB3167@kroah.com> <3F4BEE68.A6C862C2@us.ibm.com> <3F4BF265.5050101@pobox.com> <3F4C046D.77CF7E03@us.ibm.com>
In-Reply-To: <3F4C046D.77CF7E03@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Keniston wrote:
> Jeff Garzik wrote:
>>"NETIF_MSG_" is silly and should be eliminated.
> 
> 
>>From this, I infer that you think that the option to "omit" the msglevel arg --
> e.g.,
> 	netdev_err(dev,, "NIC is fried!\n");	/* always logged */
> -- is silly.  No big deal.  Its sole purpose is to help keep netdev_* calls terse.

yes


>>A separate "NETIF_MSG_ALL" test is not needed, because msg_enable is a
>>bitmask.  A msg_enable of 0xffffffff will naturally create a NETIF_MSG_ALL.
> 
> 
> But how do you code a netdev_* call where you ALWAYS want the message (including
> netdev_printk-style prefix) logged, regardless of the value of msg_enable?  That's
> what NETIF_MSG_ALL is for (and why it might be better called NETIF_MSG_ALWAYS)...

I understand the purpose of NETIF_MSG_ALL; re-read what I said.  You 
don't need a separate _test_, as your implementation includes.  Defining 
NETIF_MSG_ALL to 0xffffffff will naturally create the effect you seek.


>>Also, whatever mechanism is created, it needs to preserve the feature of
>>the existing system:
>>
>>        if (a quick bitmask test)
>>                do something
>>
>>And preferably "do something" is not inlined, because printk'ing --
>>although it may appear in a fast path during debugging -- cannot be
>>considered a fast path itself.

> Sorry, I'm not sure what you're getting at here.  netdev_* doesn't prevent
> people from using the existing netif_msg_* macros; it just provides shorthand
> for the (usual) case where "do something" is "printk".


I would prefer to be more ambitious.  If we're gonna go in and change 
every printk in a driver, we might as well do it right, and (a) make 
sure the driver does msg_enable, and (b) make the source code a bit more 
clean by hiding the "if (test bitmap)" test in your netdev_xxx stuff.

	Jeff


