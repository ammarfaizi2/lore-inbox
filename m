Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVAXQgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVAXQgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVAXQgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:36:48 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:61160 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261517AbVAXQgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:36:40 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Adding an async I2C interface
Date: Mon, 24 Jan 2005 08:36:38 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501240836.38669.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Corey Minyard:
> I would really like add asynchronous interface to the I2C bus drivers. 

Applause!  This is IMO overdue, but maybe sensor systems don't need it
as much as other I2C applications do.  For example, see the isp1301_omap
driver, which could have been hugely simpler if there were an async I2C
framework to build on.  That's probably one of the more complex examples
floating around ... but it's hardly the only place where needing to talk
synchronously to I2C chips creates trouble.


> I propose: 
> 
>    * Adding an async send interface to the busses that does a callback
>      when the operation is complete.

It'd have to have a queue, so that several different chips could have
operations pending concurrently.  I suspect you wouldn't need to cancel
operations once they're queued ... useful simplification, compared to
for example USB.  (Which in retrospect needs a "kill queue" operation,
per endpoint, rather than the "cancel request" operation we've got.
But when 2.2 started with USB, we didn't quite know that ... ;)


>    * Adding a poll interface to the busses.  The I2C core code could
>      call this if a synchronous call is made from task context (much
>      like all the current drivers do right now).  For asyncronous
>      operation, the I2C core code would call it from a timer
>      interrupt.  If the driver supported interrupts, polling from the
>      timer interrupt would not be necessary.
>    * Add async operations for the user to call, including access to the
>      polling code.
>    * If the driver didn't support an async send, it would work as it
>      does today and the async calls would return ENOSYS.

To the extent I've thought about it, that sounds like a good approach.

- Dave
 
