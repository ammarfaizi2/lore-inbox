Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTEGAgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTEGAgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:36:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:59861 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262258AbTEGAgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:36:44 -0400
Message-ID: <3EB857BC.D8501E51@us.ibm.com>
Date: Tue, 06 May 2003 17:47:56 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Joe Perches <joe@perches.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Feldman, Scott" <scott.feldman@intel.com>, Greg KH <greg@kroah.com>,
       Janice Girard <girouard@us.ibm.com>, LOS team <losteam@intel.com>,
       Phil Cayton <phil.cayton@intel.com>, Randy Dunlap <rddunlap@osdl.org>,
       Larry Kessler <kessler@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Net device error logging
References: <3EB15849.D0E1556D@us.ibm.com>		 <1051816594.29929.32.camel@localhost.localdomain>		 <3EB1A718.1084972F@us.ibm.com> <1051894225.2664.62.camel@localhost.localdomain> <3EB3026C.604D6F4C@us.ibm.com> <3EB6A909.9090901@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Jim Keniston wrote:
[SNIP] 
> > I think message filtering is a good idea.  I also think the following
> > features
> > would be useful:
> > a. Identify which device and driver the message refers to.
> 
> this is already done in net drivers

In some of them, but not in most of them.  Looking at explicit calls to
printk in drivers/net, I see that about 1 in 3 is tagged with what
appears to be the interface name.  3/4 of the source files that call
printk explicitly tag fewer than half their printks.  It's pretty rare
for a printk to be tagged with the driver name.  We'd probably get a
more promising picture if we took into account the various macros that
wrap printk, and some untagged printks are continuations of tagged
printks, but with over 8000 untagged printks in drivers/net, it's by no
means an ideal situation.  Maybe the "poorly behaved" drivers are no
longer of interest?

> 
> > b. Call net_ratelimit() in appropriate contexts.
> 
> this is questionable.  The netif_xxx messages are _already_ designed to
> be used in order of increasing verbosity.  If the user selects the more
> verbose class of messages, then rate-limiting may not be appropriate.
> 
> > c. Capture caller info (__FILE__ and/or __FUNCTION__).
> 
> No need, in net drivers.  All of them already print out network
> interface, which is all you need to know.

1. Not nearly all of them do.  (See above.)
2. Depending on the driver and how familar you are with your system's
configuration, it may take some work to map the interface name to the
driver.

Net-driver support for sysfs should eventually reach the point where you
can find useful info in sysfs given the interface name, right?  Until
then, I still think messages should report the driver as well as the
interface name.  If you do this via netdev_xxx, then once we're at sysfs
nirvana, you just redefine the netdev_xxx macros to drop the bus ID and
driver name.

> 
> > e. Standardize certain messages so that all drivers log predictable,
> > standard
> > messages (perhaps along with driver-specific info) under certain
> > circumstances.
> 
> Yes, standardization of net driver messages is desired.
> 
>         Jeff

Jim
