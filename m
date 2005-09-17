Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbVIQGxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVIQGxf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 02:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVIQGxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 02:53:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750972AbVIQGxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 02:53:34 -0400
Date: Fri, 16 Sep 2005 23:52:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unusually long delay in the kernel
Message-Id: <20050916235259.61b87069.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509161236440.4523-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0509161236440.4523-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> This code excerpt is taken from the start of the control thread for the 
>  usb-storage driver in 2.6.14-rc1:
> 
> 
>  static int usb_stor_control_thread(void * __us)
>  {
>  	struct us_data *us = (struct us_data *)__us;
>  	struct Scsi_Host *host = us_to_host(us);
> 
>  printk(KERN_INFO "Before thread start\n");
>  	lock_kernel();
> 
>  	/*
>  	 * This thread doesn't need any user-level access,
>  	 * so get rid of all our resources.
>  	 */
>  	daemonize("usb-storage");
>  	current->flags |= PF_NOFREEZE;
>  	unlock_kernel();
>  printk(KERN_INFO "After thread start\n");
> 
> 
>  The code between the two printk's takes a long time to run.  I don't have 
>  precise numbers, but it feels like more than 1 second.
> 
>  (1) Can anyone explain why, or indicate how to speed it up?

What's it doing at the time?  (kgdb is great for this sort of thing: hit
^C, go for a wander through the thread callchains).

Presumably it's spinning on the bkl.  Is this actually an SMP machine?  If
so, perhaps some other process is holding the bkl for a long time.  Perhaps
a netdevice spending a long time diddling hardware in an ioctl, something
like that.

>  (2) Are the {un}lock_kernel calls really needed?

Definitely not.

That code could be converted to the kthread API btw.
