Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVAPVPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVAPVPm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVAPVPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:15:42 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:64137 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S262606AbVAPVP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:15:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Jan 2005 16:14:48 -0500 (EST)
To: Christoph Hellwig <hch@infradead.org>
Cc: Robert Wisniewski <bob@watson.ibm.com>, karim@opersys.com,
       tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <20050116203914.GA29959@infradead.org>
References: <20050114002352.5a038710.akpm@osdl.org>
	<1105740276.8604.83.camel@tglx.tec.linutronix.de>
	<41E85123.7080005@opersys.com>
	<20050116162127.GC26144@infradead.org>
	<41EAC560.30202@opersys.com>
	<16874.50688.68959.36156@kix.watson.ibm.com>
	<20050116203914.GA29959@infradead.org>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16874.55284.161722.553907@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Sun, Jan 16, 2005 at 03:11:00PM -0500, Robert Wisniewski wrote:
 > > int global_val;
 > > 
 > > modify_val_spin()
 > > {
 > > 	acquire_spin_lock()
 > > 	// calculate some_value based on global_val
 > > 	// for example c=global_val; if (c%0) some_value=10; else some_value=20;
 > > 	global_val = global_val + some_value
 > > 	release_spin_lock()
 > > }
 > > 
 > > modify_val_atomic()
 > > {
 > > 	do
 > > 	// calculate some_value based on global_val
 > > 	// for example c=global_val; if (c%0) some_value=10; else some_value=20;
 > > 	global_val = global_val + some_value
 > > 	while (compare_and_store(global_val, , ))
 > > }
 > > 
 > > What's the difference.  The deal is if two processes execute this code
 > > simultaneously and one gets interrupted in the middle of modify_val_spin,
 > > then the other wastes its entire quantum spinning for the lock.  In the
 > > modify_val_atomic if one process gets interrupted, no problem, the other
 > > process can proceed through, then when the first one runs again the CAS
 > > will fail, and it will go around the loop again.  Now imagine it was the
 > > kernel involved...
 > 
 > Just prevent that with spin_lock_irq.  But anyway this example doesn't
 > fit the ltt code.  cmpxchg loops can make lots of sense for such simple
 > loops, but as soon as you need to do significant work in the loop it
 > starts to get problematic.  Your example would btw be better off using

The loop in question is where we grab the current (old) index, perform a
computation (or three).  The only expensive operation is the timestamp
acquisition which has been modified to use the cheaper rtsc, so I still
think that's within the realm of a reasonably simply loop.  I think what
you want to avoid is starting to walk a (potentially indeterminate) data
structure in such atomic op loop.

 > atomic_t and it's primitives so you abstract away the actual implementation
 > and the architecture can chose the most efficient implementation.
 > 

That's an interesting thought because it might address Andrew's concern.
We'll investigate.  Thanks.

-bob

