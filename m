Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVAPUjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVAPUjm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVAPUjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:39:41 -0500
Received: from [213.146.154.40] ([213.146.154.40]:36812 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262587AbVAPUjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:39:21 -0500
Date: Sun, 16 Jan 2005 20:39:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: karim@opersys.com, Christoph Hellwig <hch@infradead.org>,
       tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050116203914.GA29959@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Wisniewski <bob@watson.ibm.com>, karim@opersys.com,
	tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050114002352.5a038710.akpm@osdl.org> <1105740276.8604.83.camel@tglx.tec.linutronix.de> <41E85123.7080005@opersys.com> <20050116162127.GC26144@infradead.org> <41EAC560.30202@opersys.com> <16874.50688.68959.36156@kix.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16874.50688.68959.36156@kix.watson.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 03:11:00PM -0500, Robert Wisniewski wrote:
> int global_val;
> 
> modify_val_spin()
> {
> 	acquire_spin_lock()
> 	// calculate some_value based on global_val
> 	// for example c=global_val; if (c%0) some_value=10; else some_value=20;
> 	global_val = global_val + some_value
> 	release_spin_lock()
> }
> 
> modify_val_atomic()
> {
> 	do
> 	// calculate some_value based on global_val
> 	// for example c=global_val; if (c%0) some_value=10; else some_value=20;
> 	global_val = global_val + some_value
> 	while (compare_and_store(global_val, , ))
> }
> 
> What's the difference.  The deal is if two processes execute this code
> simultaneously and one gets interrupted in the middle of modify_val_spin,
> then the other wastes its entire quantum spinning for the lock.  In the
> modify_val_atomic if one process gets interrupted, no problem, the other
> process can proceed through, then when the first one runs again the CAS
> will fail, and it will go around the loop again.  Now imagine it was the
> kernel involved...

Just prevent that with spin_lock_irq.  But anyway this example doesn't
fit the ltt code.  cmpxchg loops can make lots of sense for such simple
loops, but as soon as you need to do significant work in the loop it
starts to get problematic.  Your example would btw be better off using
atomic_t and it's primitives so you abstract away the actual implementation
and the architecture can chose the most efficient implementation.

