Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbTH0BKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbTH0BKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:10:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:49831 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263032AbTH0BKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:10:14 -0400
Message-ID: <3F4C046D.77CF7E03@us.ibm.com>
Date: Tue, 26 Aug 2003 18:07:57 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       netdev <netdev@oss.sgi.com>, "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>, Randy Dunlap <rddunlap@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/4] Net device error logging, revised
References: <3F4A8027.6FE3F594@us.ibm.com> <20030826183221.GB3167@kroah.com> <3F4BEE68.A6C862C2@us.ibm.com> <3F4BF265.5050101@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Jim Keniston wrote:
> > #define netdev_printk(sevlevel, netdev, msglevel, format, arg...)     \
> > do {                                                                  \
> > if (NETIF_MSG_##msglevel == NETIF_MSG_ALL || ((netdev)->msg_enable & NETIF_MSG_##msglevel)) { \
> >       char pfx[40];                                                   \
> >       printk(sevlevel "%s: " format , make_netdev_msg_prefix(pfx, netdev) , ## arg);  \
> > }} while (0)
> >
> > This would make your code bigger, but not that much bigger for the common case where
> > the msglevel is omitted (and the 'if(...)' is optimized out).
> 
> "NETIF_MSG_" is silly and should be eliminated.

>From this, I infer that you think that the option to "omit" the msglevel arg --
e.g.,
	netdev_err(dev,, "NIC is fried!\n");	/* always logged */
-- is silly.  No big deal.  Its sole purpose is to help keep netdev_* calls terse.

> A separate "NETIF_MSG_ALL" test is not needed, because msg_enable is a
> bitmask.  A msg_enable of 0xffffffff will naturally create a NETIF_MSG_ALL.

But how do you code a netdev_* call where you ALWAYS want the message (including
netdev_printk-style prefix) logged, regardless of the value of msg_enable?  That's
what NETIF_MSG_ALL is for (and why it might be better called NETIF_MSG_ALWAYS)...
	netdev_err(dev, ALL, "NIC is fried!\n");	/* always logged */
or
	netdev_err(dev, ALWAYS, "NIC is fried!\n");	/* always logged */

> 
> Also, whatever mechanism is created, it needs to preserve the feature of
> the existing system:
> 
>         if (a quick bitmask test)
>                 do something
> 
> And preferably "do something" is not inlined, because printk'ing --
> although it may appear in a fast path during debugging -- cannot be
> considered a fast path itself.
> 
>         Jeff

Sorry, I'm not sure what you're getting at here.  netdev_* doesn't prevent
people from using the existing netif_msg_* macros; it just provides shorthand
for the (usual) case where "do something" is "printk".

Jim
