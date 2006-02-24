Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWBXR7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWBXR7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 12:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWBXR7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 12:59:20 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:7121 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932381AbWBXR7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 12:59:19 -0500
Date: Fri, 24 Feb 2006 12:59:18 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, <sekharan@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
In-Reply-To: <20060224164415.GA7999@kvack.org>
Message-ID: <Pine.LNX.4.44L0.0602241255240.5177-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Benjamin LaHaise wrote:

> On Fri, Feb 24, 2006 at 11:44:23AM -0500, Alan Stern wrote:
> > In that case you should be worried not about acquiring and releasing the 
> > rwsem at the beginning and end of blocking_notifier_call_chain; you should 
> > be worried about all the RCU serialization in the core 
> > notifier_call_chain routine.
> 
> RCU doesn't synchronize readers.

It does on architectures where smp_read_barrier_depends() expands into
something nontrivial.  Maybe that doesn't include any of the machines
you're interested in.

> > The atomic chains are a different matter.  The ones that don't run in NMI 
> > context could use an rw-spinlock for protection, allowing them also to 
> > avoid memory barriers while going through the list.  The notifier chains 
> > that do run in NMI don't have this luxury.  Fortunately I don't think 
> > there are very many of them.
> 
> A read lock is a memory barrier.  That's why I'm opposed to using non-rcu 
> style locking for them.

But RCU-style locking can't be used in situations where the reader may 
block.  So it's not possible to use it with blocking notifier chains.

Alan Stern

