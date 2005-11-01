Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVKAVUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVKAVUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVKAVUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:20:46 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:61914 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751250AbVKAVUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:20:45 -0500
Date: Tue, 1 Nov 2005 16:20:43 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe
In-Reply-To: <1130876434.3586.378.camel@linuxchandra>
Message-ID: <Pine.LNX.4.44L0.0511011610470.4473-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Chandra Seetharaman wrote:

> > Register and unregister will continue to work as before, requiring a
> > process context and the ability to sleep.  notifier_block_enable/disable
> > should be used when:
> > 
> > 	a callout wants to disable itself as it is running, or
> > 
> > 	someone running in an atomic context wants to enable or disable
> > 	a callout.
> > 
> > In the first case, unregister can't be used because it would hang.  In the 
> > second case, register/unregister can't be used because they need to be 
> > able to sleep.
> > 
> > In both cases the notifier block would have to be registered beforehand 
> > and unregistered later.
> 
> I understand. Thanks for the explanation. I like the option below better
> (no new interface).

You mean the RCU-style update?  It will hang when a callout routine tries 
to deregister itself as it is running, although we could add a new 
unregister_self API to handle that.  Just check for num_callers equal to 1 
instead of 0.

> > No; the list _won't_ be protected in call_chain.  It will be possible to
> > unregister a callout while the chain is in use.  That's how the RCU
> > approach works -- it uses no read locks, only write locks.
> 
> but, list_del poisons the next pointer which is not good for a reader
> that is walking through the list, we have to use list_del_rcu instead.

Agreed.

> Also, do you think we have to use _rcu versions of list traversal
> functions in call_chain ?

Yes.

Note that on an SMP system you run the risk of starvation (the chain gets
called so frequently that it's _always_ running on some CPU).  We can
probably ignore that possibility.

Would you like to code up these ideas?

Alan Stern

