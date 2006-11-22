Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755467AbWKVQpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbWKVQpH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbWKVQpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:45:07 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:54702 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1755467AbWKVQpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:45:05 -0500
Date: Wed, 22 Nov 2006 17:45:30 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch -mm 2/2] driver core: Introduce device_move(): move a
 device
Message-ID: <20061122174530.4efa1145@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0611221024340.3038-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0611221024340.3038-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 10:32:47 -0500 (EST),
Alan Stern <stern@rowland.harvard.edu> wrote:

> Cornelia Huck wrote:
> 
> > +	if (old_parent)
> > +		klist_del(&dev->knode_parent);
> > +	klist_add_tail(&dev->knode_parent, &new_parent->klist_children);
> 
> > +			klist_del(&dev->knode_parent);
> > +			if (old_parent)
> > +				klist_add_tail(&dev->knode_parent,
> > 						&old_parent->klist_children);
> 
> This is wrong.  klist_del() does not wait for the knode to be removed from
> its klist.  You need to use klist_remove().

Hmpf, you're right.

> I don't see any protection against new_parent being removed while dev is
> being transferred under it.  Are you relying on the caller to make sure
> this never happens?

Is there any mechanism in the driver core to avoid such races? The only
locking I can see are klists and dev->sem (which only protects
probing). AFAICS, the caller needs to ensure consistency anyway (like
with the subchannel mutex we introduced in s390 to ensure device
register and unregister cannot be called concurrently).

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
