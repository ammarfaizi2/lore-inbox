Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVKWVOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVKWVOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVKWVOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:14:07 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:57524 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932466AbVKWVOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:14:06 -0500
Subject: Re: Optimizing notifier_call_chain
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0511231057430.4477-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0511231057430.4477-100000@iolanthe.rowland.org>
Content-Type: text/plain
Organization: IBM
Date: Wed, 23 Nov 2005 13:13:59 -0800
Message-Id: <1132780439.6492.13.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 11:01 -0500, Alan Stern wrote:
> On Tue, 22 Nov 2005, Chandra Seetharaman wrote:
> 
> > Hello,
> > 
> > While making the notifier chain safe, i found room for some optimization.
> > Please comment on if it is worth pursuing.
> > 
> > notifier_call_chain() calls registered callouts for _all_ events. But, many
> > of the callouts handle only few events.
> > 
> > If we change notifier_call_chain() to call the callout only on registered
> > events, we can avoid few function overhead.
> > 
> > Currently, events is of free format, we have to make it bit per event.
> > Among the existing users, ia64die_chain uses the highest number(25) of 
> > events. i think 64 bit event would suffice.
> > 
> > simplified logic:
> > 	notifier_call_chain(event) 
> > 	{
> > 		if ((head->event & event) != 0)
> > 			return;
> > 		for_each_callout {
> > 			if ((notifier_block->event & event) != 0)
> > 				notifier_block->call(event);
> > 		}
> > 	}
> 
> You would need to mask against (1ull << event), not against event.  
> tset_bit() might work better.

event will be a bit field, not a sequential number.
> 
> Do you really want to do this?  It will mean changing every single 
> notifier_block definition in the kernel, in addition to all the the 
> notifier_heads.  That's an awful lot of work for a relatively small gain.  

Valid question. That is one of the reason of my posting this question.

I was planning to make the interface change to handle bitwise events
with zero being "all events". Future users will use the bitwise events. 

w.r.t existing users, i would change only the macros(that were listed)
and let the module owners do the change to the notifier blocks when they
want (or file a kernel janitor bug).

The object was to move towards optimization.

> I believe that notifier_call_chain does not run very often, but I don't 
> have any actual figures.
> 
> Alan Stern
> 
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


