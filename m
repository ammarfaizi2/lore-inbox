Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTFKVgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTFKVgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:36:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:42379 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264487AbTFKVge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:36:34 -0400
Date: Wed, 11 Jun 2003 14:51:47 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>, Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in driver model class.c
Message-ID: <20030611215147.GA27029@kroah.com>
References: <Pine.LNX.4.44L0.0306111305300.668-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0306111305300.668-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:12:47PM -0400, Alan Stern wrote:
> Greg:
> 
> There is a bug in drivers/base/class.c in 2.5.70.  Near the start of the
> routine class_device_add() are the lines
> 
>         if (class_dev->dev)
>                 get_device(class_dev->dev);
> 
> But there's nothing to undo this get_device, either in the error return 
> part of class_device_add() or in class_device_del().
> 
> I assume that either this get_device() doesn't belong there or else there
> should be corresponding put_device() calls in the other two spots.  
> Whichever is the case, it should be easy for you to fix.

You are correct.  I took out the other put_device() in the -bk tree in
class_device_del() but forgot to remove this one.  Good catch.

Pat, here's a patch to fix this up, against the latest -bk tree.

thanks,

greg k-h


# Driver core: fix unbounded get_device() in class_device_add()
#
# This was found by Alan Stern.

diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Wed Jun 11 14:47:20 2003
+++ b/drivers/base/class.c	Wed Jun 11 14:47:20 2003
@@ -264,8 +264,6 @@
 		return -EINVAL;
 
 	parent = class_get(class_dev->class);
-	if (class_dev->dev)
-		get_device(class_dev->dev);
 
 	pr_debug("CLASS: registering class device: ID = '%s'\n",
 		 class_dev->class_id);
