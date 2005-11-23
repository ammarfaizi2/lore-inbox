Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVKWQB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVKWQB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVKWQB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:01:26 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:41905 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751173AbVKWQBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:01:24 -0500
Date: Wed, 23 Nov 2005 11:01:23 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Chandra Seetharaman <sekharan@us.ibm.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Optimizing notifier_call_chain
In-Reply-To: <1132716475.27586.7.camel@linuxchandra>
Message-ID: <Pine.LNX.4.44L0.0511231057430.4477-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Chandra Seetharaman wrote:

> Hello,
> 
> While making the notifier chain safe, i found room for some optimization.
> Please comment on if it is worth pursuing.
> 
> notifier_call_chain() calls registered callouts for _all_ events. But, many
> of the callouts handle only few events.
> 
> If we change notifier_call_chain() to call the callout only on registered
> events, we can avoid few function overhead.
> 
> Currently, events is of free format, we have to make it bit per event.
> Among the existing users, ia64die_chain uses the highest number(25) of 
> events. i think 64 bit event would suffice.
> 
> simplified logic:
> 	notifier_call_chain(event) 
> 	{
> 		if ((head->event & event) != 0)
> 			return;
> 		for_each_callout {
> 			if ((notifier_block->event & event) != 0)
> 				notifier_block->call(event);
> 		}
> 	}

You would need to mask against (1ull << event), not against event.  
tset_bit() might work better.

Do you really want to do this?  It will mean changing every single 
notifier_block definition in the kernel, in addition to all the the 
notifier_heads.  That's an awful lot of work for a relatively small gain.  
I believe that notifier_call_chain does not run very often, but I don't 
have any actual figures.

Alan Stern

