Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbTJGTfc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 15:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTJGTfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 15:35:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:6832 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262732AbTJGTfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 15:35:21 -0400
Message-ID: <3F8314A9.6FDD0274@us.ibm.com>
Date: Tue, 07 Oct 2003 12:31:53 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
CC: acme@conectiva.com.br, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, jkenisto <jkenisto@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Net device error logging
References: <3F7C967F.A06A512E@us.ibm.com>
		 <1065141377.6667.27.camel@localhost.localdomain>
		 <3F820028.D931E08E@us.ibm.com> <1065491087.2601.103.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches wrote:
> 
> On Mon, 2003-10-06 at 16:52, Jim Keniston wrote:
> > I would like to see it in v2.6 because it's in demand now [1] and its
> > impact is negligible on drivers that don't use it [2].
> 
> It does add another static buffer, not too good for embedded.

Yes, my proposed implementation incurs a one-time cost in RAM
(512 bytes, which could probably be dialed down some).  But
putting more code into the macro (as in your proposal) costs ROM.
I plugged in your version of netdev_printk below (with the
msglevel test added back in to the macro) and rebuilt.  On my
system, the code size of tg3.o grew from 49548 to 50496 (948 bytes),
and e1000.o grew from 61813 to 63357 (1544 bytes).

Linux coding style seems to favor big macros and inline functions,
but I'd think embedded systems would be more interested in
economizing on ROM than on RAM.

> The current implementation makes it more difficult to add __FILE__,
> __LINE__, __FUNCTION__ if anyone wanted to add even more debugging
> content.

Somewhat.  If you don't mind having the __FILE__:__LINE__:__FUNCTION__
info between the interface name and the rest of the message, you can just
stuff them into the arg list -- e.g:
#define netdev_printk(sevlevel, netdev, msglevel, format, arg...	\
	__netdev_printk(sevlevel , netdev , NETIF_MSG_##msglevel ,	\
	"%s:%d:%s: " format , __FILE__ , __LINE__ , __FUNCTION__ , ## arg)

Otherwise you have to modify __netdev_printk() to explicitly incorporate
these values into the message prefix.  Not hard to do.

This issue begs questions such as:
1. Is __netdev_printk's message-prefix format the right one?  If not,
what should it be?
2. Should we support some sort of configurable prefix format?  E.g.,
In my driver, I want the prefix to give the driver name, interface
name, and source file and line number, so...
	netdev->msg_prefix = "%D:%I: %F:%L: ";
3. Should netdev_* instead be used to enforce the "right" format?

> 
> I'd rather use stack space like so:
> 
> static int netdev_printk_prefix(char* message, size_t size, const struct netdevice * netdev)
> {
>         if (netdev->reg_state == NETREG_REGISTERED || !netdev->class_dev.dev)
>                 return snprintf(message, size, "%s: ", netdev->name);
>         return snprintf(msg_header, sizeof(msg_header), "%s (%s %s): ", netdev->name,
>                         netdev->class_dev.dev->driver->name, netdev->class_dev.dev->bus_id);
> }
> 
> #define netdev_printk(sevlevel, netdev, msglevel, format, arg...)       \
> do {    \
>         char msg_header[64];    \
>         netdev_printk_prefix(msg_header, sizeof(msg_header), netdev);   \
>         printk("%s" "%s" format , sevlevel , msg_header , ## arg);      \
> } while (0);
> 
> This still allows __FILE__, etc to be added.

As mentioned above, you need to test NETIF_MSG_##msglevel for a fair comparison.
Also, including 'static int netdev_printk_prefix' in netdevice.h gets me a lot
of messages of the form
   include/linux/netdevice.h:930: warning: `netdev_printk_prefix' defined but not used
when I build.  An obvious solution is to make netdev_printk_prefix extern, but then
it's no more accessible than __netdev_printk() is now.

Jim
