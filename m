Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVAPVIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVAPVIi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVAPVHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:07:44 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:51848 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S262606AbVAPVHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:07:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Jan 2005 16:06:37 -0500 (EST)
To: Andrew Morton <akpm@osdl.org>
Cc: Robert Wisniewski <bob@watson.ibm.com>, karim@opersys.com,
       hch@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <20050116123212.1b22495b.akpm@osdl.org>
References: <20050114002352.5a038710.akpm@osdl.org>
	<1105740276.8604.83.camel@tglx.tec.linutronix.de>
	<41E85123.7080005@opersys.com>
	<20050116162127.GC26144@infradead.org>
	<41EAC560.30202@opersys.com>
	<16874.50688.68959.36156@kix.watson.ibm.com>
	<20050116123212.1b22495b.akpm@osdl.org>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16874.54187.919814.272833@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Robert Wisniewski <bob@watson.ibm.com> wrote:
 > >
 > > modify_val_spin()
 > >  {
 > >  	acquire_spin_lock()
 > >  	// calculate some_value based on global_val
 > >  	// for example c=global_val; if (c%0) some_value=10; else some_value=20;
 > >  	global_val = global_val + some_value
 > >  	release_spin_lock()
 > >  }
 > > 
 > >  modify_val_atomic()
 > >  {
 > >  	do
 > >  	// calculate some_value based on global_val
 > >  	// for example c=global_val; if (c%0) some_value=10; else some_value=20;
 > >  	global_val = global_val + some_value
 > >  	while (compare_and_store(global_val, , ))
 > >  }
 > > 
 > >  What's the difference.  The deal is if two processes execute this code
 > >  simultaneously and one gets interrupted in the middle of modify_val_spin,
 > >  then the other wastes its entire quantum spinning for the lock.  In the
 > >  modify_val_atomic if one process gets interrupted, no problem, the other
 > >  process can proceed through, then when the first one runs again the CAS
 > >  will fail, and it will go around the loop again.
 > 
 > One could use spin_lock_irq().  The performance would be similar.

Yes on some architectures I think you right (on some archs though I'm not
so sure) - Ingo and I had that debate a bit ago.  But as you astutely noted
or asked below, the original intent was to be able to use a single shared
buffer for user and kernel space.  In fact, the lockless design of tracing
in K42, which motivated this design does that.  For a couple of reasons we
have not (yet?) done that for LTT.  But, for example, NPTL could have made
use of it when they were investigating a tracing facility.  Recently,
another company using LTT for device driver and video debugging is very
interested in cheap user space tracing in conjunction with kernel tracing
because they need both sets of events to understand what is up.  The debate
is still open for the best way to get cheap user space logging, but there
seems to be an increasing need for it by the community.

 > 
 > > Now imagine it was the kernel involved...
 > 
 > Or are you saying that userspace does the above as well?

:-) - as above.  Furthermore, it seems that reducing the places where
interrupts are disabled would be a good thing?  By not introducing
additional disable interrupts tracing has less of an impact.  I was also
pointing out Christoph's statement that spin locks and atomic ops are the
same is not accurate (except for perhaps limited cases, but then you must
make such arguments - not necessarily good), and we had good reasons for
using an atomic op.

Thanks.

-bob

Robert Wisniewski
The K42 MP OS Project
http://www.research.ibm.com/K42/
bob@watson.ibm.com
