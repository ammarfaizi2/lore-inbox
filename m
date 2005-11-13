Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVKMQr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVKMQr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 11:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVKMQr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 11:47:29 -0500
Received: from mx1.rowland.org ([192.131.102.7]:9480 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S964934AbVKMQr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 11:47:28 -0500
Date: Sun, 13 Nov 2005 11:47:26 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Chandra Seetharaman <sekharan@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Subject: [RFC][PATCH] Fix for unsafe notifier chain
 mechanism
In-Reply-To: <20051112223856.GA5709@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0511131125590.2643-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2005, Paul E. McKenney wrote:

> Any advice on how to change the documentation so as to make the intent
> more clear would of course be most welcome!

Well, I thought the intent _was_ clear -- but it turned out not to be what 
you really meant!

Actually in this particular case I don't think it matters either way.  The 
difference amounts to an unnecessary memory barrier on an 
infrequently-used code path.  If you want to change the comment, you 
could say that using rcu_assign_pointer helps document which pointers 
might be rcu-dereferenced by readers at the time the assignment is being 
made.  Right now it just says "will be dereferenced", which could refer to 
any time in the future.


There is one other aspect where more documentation would be welcome: the 
description of rcu_dereference in Documentation/RCU/checklist.txt and why 
it is necessary on the Alpha.  (On the whole, I think the kernel's 
documentation of read_barrier_depends could be improved.)  It would be 
good to point out that when evaluating "*p", an Alpha can speculatively 
access memory before it knows the value of p!  If p's value then turns out 
not to match the address that was read, the processor does another fetch.  

Intuitively we don't normally think of the need to evaluate p before
fetching *p, because it's hard to imagine doing them in the wrong order.
Furthermore the C language isn't conducive to putting a read-barrier
between the evaluation of p and the evaluation of *p, but on the Alpha
such a barrier is important when pointers are updated without locking (as
in RCU).  Hence the need for rcu_dereference, which essentially does
nothing more than add that barrier.

I don't know, this may be more detail than you want to add at that spot.  
Maybe a different location in the documentation would be better; I haven't 
read all of it.

Alan Stern

