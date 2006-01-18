Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWARWTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWARWTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWARWTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:19:25 -0500
Received: from kanga.kvack.org ([66.96.29.28]:52186 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932562AbWARWTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:19:24 -0500
Date: Wed, 18 Jan 2006 17:15:25 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Chandra Seetharaman <sekharan@us.ibm.com>,
       Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
Message-ID: <20060118221525.GI16285@kvack.org>
References: <20060118220122.GH16285@kvack.org> <Pine.LNX.4.44L0.0601181706210.14089-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601181706210.14089-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 05:09:10PM -0500, Alan Stern wrote:
> On Wed, 18 Jan 2006, Benjamin LaHaise wrote:
> 
> > The notifier interface is supposed to be *light weight*.
> 
> Again, where is that documented?

Read the kernel.  Notifiers are called from all sorts of hot paths, so they 
damned well better be light.

> Which is worse: overhead due to cache misses or an oops caused by code 
> being called after it was unloaded?

Given that the overhead need not be present at all, neither.

> Do you have a better proposal for a way to prevent blocking notifier 
> chains from being modified while in use?  Or would you prefer to rewrite 
> all the callout routines that currently block, so that all the notifier 
> chains can be made atomic and we don't need the blocking notifier API?

Easy: in register_notifier stuff a serial number for each entry put on 
a notifier chain.  Remember the serial number of the entry before performing 
->notifier_call in notifier_call_chain.  Upon return, if the chain has been 
modified (easy to detect by nature of the serial number changing), walk 
the chain looking for the entry following the last serial number run.  Voila, 
rcu can be used to protect the chain's contents.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
