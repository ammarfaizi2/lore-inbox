Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVJ1OXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVJ1OXF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVJ1OXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:23:05 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46051 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030188AbVJ1OXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:23:04 -0400
Date: Fri, 28 Oct 2005 10:23:03 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: Keith Owens <kaos@ocs.com.au>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe
In-Reply-To: <1130463257.3586.278.camel@linuxchandra>
Message-ID: <Pine.LNX.4.44L0.0510280956370.4862-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005, Chandra Seetharaman wrote:

> So, requirements to fix the bug are:
> 	- no sleeping in register/unregister(if we want to keep the
>           current way of use. We can change it and make the relevant
>           changes in the kernel code, if it is agreeable)

I think we will have to make these changes.  In principal it shouldn't be 
hard to add a simple "enabled" flag to each callout which currently is
registered/unregistered atomically or while running.  We could even put 
such a flag into the notifier_block structure and add routines to set or 
clear it, using appropriate barriers.

> 	- notifier_call_chain could be called from any context
> 	- callout function could sleep
> 	- no acquiring locks in notifier_call_chain
>         - make sure the list is consistent :) (which is problem Alan
>           started to fix)
> 	- anything else ?

Let's clarify the "list is consistent" statement.  Obviously it implies 
that no more than one thread can modify the list pointers at any time.  
Beyond that, there should be a guarantee that when unregister returns, the 
routine being removed is not in use and will not be called by any thread.  
Likewise, after register returns, any invocation of notifier_call_chain 
should see the new routine.

Alan Stern

