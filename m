Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWBXQoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWBXQoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWBXQoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:44:25 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:10965 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932072AbWBXQoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:44:25 -0500
Date: Fri, 24 Feb 2006 11:44:23 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, <sekharan@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
In-Reply-To: <20060224151510.GC7101@kvack.org>
Message-ID: <Pine.LNX.4.44L0.0602241135450.5177-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Benjamin LaHaise wrote:

> On Fri, Feb 24, 2006 at 10:04:23AM -0500, Alan Stern wrote:
> > What do you think of the two suggestions in my previous message?
> 
> Even if the read version of the lock only touches a cacheline local to 
> the cpu, you'd still have to use the lock prefix to allow for correctness 
> when a writer comes along.  It is not cacheline bouncing that worries me, 
> it is serialising instructions and memory barriers as those hurt immensely 
> when the data is in the cache.  I've been looking at a lot of profiles on 
> P4s of late, and every single locked instruction is painful as it means 
> all of the memory ordering rules come into play.  Neither suggestion 
> addresses that overhead that has been introduced.

In that case you should be worried not about acquiring and releasing the 
rwsem at the beginning and end of blocking_notifier_call_chain; you should 
be worried about all the RCU serialization in the core 
notifier_call_chain routine.

In fact, that could be changed for blocking notifier chains.  Since we own 
the readlock, we know that the list won't get changed while we're using 
it.  So the blocking version of the call-chain routine could avoid using 
the RCU dereferencing mechanism.

The atomic chains are a different matter.  The ones that don't run in NMI 
context could use an rw-spinlock for protection, allowing them also to 
avoid memory barriers while going through the list.  The notifier chains 
that do run in NMI don't have this luxury.  Fortunately I don't think 
there are very many of them.

Alan Stern

