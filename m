Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbUB0TtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbUB0TtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:49:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:60868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263004AbUB0TtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:49:00 -0500
Date: Fri, 27 Feb 2004 11:48:55 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Question about (or bug in?) the kobject implementation
Message-ID: <20040227194855.GB10864@kroah.com>
References: <Pine.LNX.4.44L0.0402250955090.790-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0402250955090.790-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 10:05:37AM -0500, Alan Stern wrote:
> Is it supposed to be legal to repeatedly call kobject_add() and 
> kobject_del() for the same kobject?  That is, is
> 
> 	kobject_add(&kobj);
> 	...
> 	kobject_del(&kobj);
> 	...
> 	kobject_add(&kobj);
> 	...
> 	kobject_del(&kobj);
> 
> supposed to work?

No.

> The API doesn't forbid it, and there's no apparent reason why it
> should be illegal.

We prevent race conditions in kobject_put() by saying "Don't do that!"
:)

Seriously, once kobject_del() is called, you can't safely call
kobject_get() anymore on that object.

If you can think of a way we can implement this in the code to prevent
people from doing this, please send a patch.  We've been getting by
without such a "safeguard" so far...

> Why would anyone want to do this, you ask?  Well the USB subsystem does it 
> already.  Each USB device can have several configurations, only one of 
> which is active at any time.  Corresponding to each configuration is a set 
> of struct devices, and they (together with their embedded kobjects) are 
> allocated and initialized when the USB device is first detected.  The 
> struct devices are add()'ed and del()'ed as configurations are activated 
> and deactivated, leading to just the sort of call sequence shown above.

Then we need to fix this.

thanks,

greg k-h
