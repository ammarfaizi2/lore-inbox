Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVDFTqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVDFTqC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 15:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVDFTqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 15:46:02 -0400
Received: from ida.rowland.org ([192.131.102.52]:10756 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262300AbVDFTp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 15:45:58 -0400
Date: Wed, 6 Apr 2005 15:45:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>
cc: David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <Pine.LNX.4.50.0504060032260.17888-100000@monsoon.he.net>
Message-ID: <Pine.LNX.4.44L0.0504061535140.1511-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2005, Patrick Mochel wrote:

> > Third, why does device_release_driver() call klist_del() instead of
> > klist_remove() for dev->knode_driver?  Is that just a simple mistake?
> > The klist_node doesn't seem to get unlinked anywhere.
> 
> It can be called from driver_for_each_device() when the driver has been
> unloaded. Since that increments the reference count for the node when it's
> unregistering it, klist_remove() will deadlock. Instead klist_del() is
> called, and when the next node is grabbed, that one will be let go and
> removed from the list.

The patch looks good.  But isn't there still a problem with
device_release_driver()?  It doesn't wait for the klist_node to be removed
from the klist before unlocking the device and moving on.  As a result, if
another driver was waiting to bind to the device you would corrupt the
list pointers, by calling klist_add_tail() for the new driver before
klist_release() had run for the old driver.

I'll be interested to see how you manage to solve this.  The only way I 
can think of is to avoid using driver_for_each_device() in 
driver_detach().

Alan Stern

