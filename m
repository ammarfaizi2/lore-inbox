Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTDRPZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 11:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbTDRPZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 11:25:47 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:2445 "EHLO
	mta4.rcnstx.swbell.net") by vger.kernel.org with ESMTP
	id S263103AbTDRPZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 11:25:46 -0400
Message-ID: <3EA01DF0.9080305@pacbell.net>
Date: Fri, 18 Apr 2003 08:46:56 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB deadlock in v2.5.67
References: <200304180202.h3I227mw032608@napali.hpl.hp.com> <20030418045006.GB1813@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------050809000509060801020803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050809000509060801020803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Thu, Apr 17, 2003 at 07:02:07PM -0700, David Mosberger wrote:
> 
>><hcd_free_dev+0x140> translates into line 1249 in hcd.c, where it
>>does:
>>
>>	spin_lock_irqsave (&hcd_data_lock, flags);
>>
>>The deadlock is pretty obvious: the same lock has already been
>>acquired urb_unlink(), 4 levels up in the call-chain.
>>
>>Anybody have a fix for this?
> 
> 
> David (Brownell, that is), does this help with the trace I sent you a
> few hours ago?

Seems to be a different problem.  The patch below should
resolve the keyboard problem -- just reorders two lines
so the lock isn't held after the device's records get
deleted, so the order is what it should always have been.

- Dave





--------------050809000509060801020803
Content-Type: text/plain;
 name="hang.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hang.patch"

--- 1.59/drivers/usb/core/hcd.c	Mon Apr 14 14:01:44 2003
+++ edited/drivers/usb/core/hcd.c	Fri Apr 18 08:20:42 2003
@@ -961,8 +961,8 @@
 	spin_lock_irqsave (&hcd_data_lock, flags);
 	list_del_init (&urb->urb_list);
 	dev = urb->dev;
-	usb_put_dev (dev);
 	spin_unlock_irqrestore (&hcd_data_lock, flags);
+	usb_put_dev (dev);
 }
 
 

--------------050809000509060801020803--

