Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbUB0UGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbUB0UGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:06:38 -0500
Received: from ida.rowland.org ([192.131.102.52]:6404 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263008AbUB0UGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:06:33 -0500
Date: Fri, 27 Feb 2004 15:06:32 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Question about (or bug in?) the kobject implementation
In-Reply-To: <20040227194855.GB10864@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0402271457530.1225-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Greg KH wrote:

> On Wed, Feb 25, 2004 at 10:05:37AM -0500, Alan Stern wrote:
> > Is it supposed to be legal to repeatedly call kobject_add() and 
> > kobject_del() for the same kobject?  That is, is
> > 
> > 	kobject_add(&kobj);
> > 	...
> > 	kobject_del(&kobj);
> > 	...
> > 	kobject_add(&kobj);
> > 	...
> > 	kobject_del(&kobj);
> > 
> > supposed to work?
> 
> No.
> 
> > The API doesn't forbid it, and there's no apparent reason why it
> > should be illegal.
> 
> We prevent race conditions in kobject_put() by saying "Don't do that!"
> :)
> 
> Seriously, once kobject_del() is called, you can't safely call
> kobject_get() anymore on that object.

Are you worried about the possibility of the refcount dropping to 0 and 
the cleanup starting but then kobject_get() increasing the refcount again?
Or is there some other problem?

> If you can think of a way we can implement this in the code to prevent
> people from doing this, please send a patch.  We've been getting by
> without such a "safeguard" so far...

Maybe I could if I knew more clearly the exact issue in question.

> > Why would anyone want to do this, you ask?  Well the USB subsystem does it 
> > already.  Each USB device can have several configurations, only one of 
> > which is active at any time.  Corresponding to each configuration is a set 
> > of struct devices, and they (together with their embedded kobjects) are 
> > allocated and initialized when the USB device is first detected.  The 
> > struct devices are add()'ed and del()'ed as configurations are activated 
> > and deactivated, leading to just the sort of call sequence shown above.
> 
> Then we need to fix this.

As it happens, I have a patch to do that. :-)  I'll send it in a separate 
message.

Alan Stern

