Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVAPUML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVAPUML (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVAPUML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:12:11 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:50686 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S262573AbVAPUMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:12:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Jan 2005 15:11:00 -0500 (EST)
To: karim@opersys.com
Cc: Christoph Hellwig <hch@infradead.org>, tglx@linutronix.de,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Robert Wisniewski <bob@watson.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41EAC560.30202@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	<1105740276.8604.83.camel@tglx.tec.linutronix.de>
	<41E85123.7080005@opersys.com>
	<20050116162127.GC26144@infradead.org>
	<41EAC560.30202@opersys.com>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16874.50688.68959.36156@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour writes:
 > 
 > Christoph Hellwig wrote:
 > > the lockless mode is really just loops around cmpxchg.  It's spinlocks
 > > reinvented poorly.

Christoph,
     Sadly they're not the same, atomic operations provide a set of
functionality that simple spin locks do not give you.  Consider two
different processes each executing the following code

int global_val;

modify_val_spin()
{
	acquire_spin_lock()
	// calculate some_value based on global_val
	// for example c=global_val; if (c%0) some_value=10; else some_value=20;
	global_val = global_val + some_value
	release_spin_lock()
}

modify_val_atomic()
{
	do
	// calculate some_value based on global_val
	// for example c=global_val; if (c%0) some_value=10; else some_value=20;
	global_val = global_val + some_value
	while (compare_and_store(global_val, , ))
}

What's the difference.  The deal is if two processes execute this code
simultaneously and one gets interrupted in the middle of modify_val_spin,
then the other wastes its entire quantum spinning for the lock.  In the
modify_val_atomic if one process gets interrupted, no problem, the other
process can proceed through, then when the first one runs again the CAS
will fail, and it will go around the loop again.  Now imagine it was the
kernel involved...

I don't claim to have all the answers and am happy to have discussion on
something, but the attitude expressed by "It's spinlocks reinvented
poorly."  is not conducive to a useful exchange even if you were correct.

 > 
 > I beg to differ. You have to use different spinlocks depending on
 > where you are:
 > - serving user-space
 > - bh-derivatives
 > - irq
 > 
 > lockless is the same primitive regardless of your current state,
 > it's not the same as spinlocks.
 > 
 > Karim
 > -- 
 > Author, Speaker, Developer, Consultant
 > Pushing Embedded and Real-Time Linux Systems Beyond the Limits
 > http://www.opersys.com || karim@opersys.com || 1-866-677-4546

Robert Wisniewski
The K42 MP OS Project
http://www.research.ibm.com/K42/
bob@watson.ibm.com
