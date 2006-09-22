Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWIVC3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWIVC3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWIVC3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:29:23 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:38167 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932216AbWIVC3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:29:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=RyjnXhZZE0xvuE5tKcumaRBd/Jvoi8G3JQBnfvV8rVbLvCjfJ0tGU1UbOc0yKtZbc0mphLSIEZBiJhI/+rdxVEJ6yD2QHx82K8c79TNTV9lEdr4WlNPyAoCJtDNw39Bk3zErGkSYe5LJBGel+7gqPmWKT1zTp5CSBcaRY88NvZY=
Date: Fri, 22 Sep 2006 05:29:25 +0300
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <784781139.20060922052925@gmail.com>
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       <kernel-discuss@handhelds.org>
CC: David Brownell <david-b@pacbell.net>, Richard Purdie <rpurdie@rpsys.net>
Subject: Fwd: [Kernel-discuss] [PATCH] g_ether+pxa27x_udc compiled in kernel not working
In-Reply-To: <20060920123429.GA8780@localhost>
References: <20060920123429.GA8780@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

          We at Handhelds.org are having troubles with Ethernet USB
gadget driver after upgrading kernel to 2.6.17. Our systems are
embedded ARMs. The symptom is connections not being recognized after
plugging in USB socket. After some investigation, we found this patch
and applied it to our 2.6.17 tree:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a353678d3136306c1d00f0d2319de1dac8a6b1db

          However, it appeared that there's still a problem if g_ether
is builtin. The mail below describes the issue. It is confirmed that patch
below fixes the issue. Also, 2.6.18 appears to have this issue present
(from looking at source code, we didn't try it yet). Also, the same
issue seems to be present in other USB gadget drivers.


Thanks,
Handhelds.org developers


This is a forwarded message
From: Anton <cbou-at-mail.ru>
To: kernel-discuss@handhelds.org
Date: Wednesday, September 20, 2006, 3:34:29 PM
Subject: [Kernel-discuss] [PATCH] g_ether+pxa27x_udc compiled in kernel not working

===8<==============Original message text===============
Hi all,

In recent kernels (2.6.17-hh1) g_ether compiled in kernel do not work
with pxa27x_udc. Here are code snippets:

- drivers/usb/gadget/ether.c:2609:
        static struct usb_gadget_driver eth_driver = {
        ...
               .bind           = eth_bind,
               .unbind         = __exit_p(eth_unbind),
        ...
        };

- include/linux/init.h:273
        #ifdef MODULE
        #define __exit_p(x) x
        #else
        #define __exit_p(x) NULL
        #endif

- drivers/usb/gadget/pxa27x_udc.c:1454
        int usb_gadget_register_driver(struct usb_gadget_driver *driver)
        {
        ...
                if (!driver     || driver->speed != USB_SPEED_FULL
                        || !driver->bind
                        || !driver->unbind
                        || !driver->disconnect
                        || !driver->setup)
                return -EINVAL;


Thus, pxa27x_udc will not run g_ether code if it is compiled in.

Trivial patch attached.

There is the second way to deal with it: remove "|| !driver->unbind" check
from pxa27x_udc.c.

Which solution is better?


Thanks,

-- Anton (irc: bd2)

===8<===========End of original message text===========


Index: drivers/usb/gadget/ether.c
===================================================================
RCS file: /cvs/linux/kernel26/drivers/usb/gadget/ether.c,v
retrieving revision 1.32
diff -u -p -b -B -r1.32 ether.c
--- drivers/usb/gadget/ether.c  7 Sep 2006 02:48:35 -0000       1.32
+++ drivers/usb/gadget/ether.c  20 Sep 2006 11:58:26 -0000
@@ -2606,7 +2606,7 @@ static struct usb_gadget_driver eth_driv
 
        .function       = (char *) driver_desc,
        .bind           = eth_bind,
-       .unbind         = __exit_p(eth_unbind),
+       .unbind         = eth_unbind,
 
        .setup          = eth_setup,
        .disconnect     = eth_disconnect,




-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com

