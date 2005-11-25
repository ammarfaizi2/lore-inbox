Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVKYID4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVKYID4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 03:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbVKYID4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 03:03:56 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:64214 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751418AbVKYIDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 03:03:55 -0500
Date: Fri, 25 Nov 2005 09:03:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: david singleton <dsingleton@mvista.com>
Cc: "David F. Carlson" <dave@chronolytics.com>,
       Dinakar Guniguntala <dino@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051125080358.GA25925@elte.hu>
References: <20051117161817.GA3935@in.ibm.com> <437D0C59.1060607@mvista.com> <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu> <43822480.6080301@mvista.com> <20051121212653.GA6143@elte.hu> <EDDB1894-5AFB-11DA-A840-000A959BB91E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDDB1894-5AFB-11DA-A840-000A959BB91E@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* david singleton <dsingleton@mvista.com> wrote:

> > why is there per-vma info needed?
> 
> I've had numerous requests to add support for pthread_mutexes that 
> have been 'malloc'd and end up in the heap.
> 
> The original robust futex patch only supported shared pthread mutexes, 
> backed either by a file in which the pthread mutex was written on in 
> anonymous memory allocated via mmap with the MAP_SHARE and 
> MAP_ANONYMOUS flags.
> 
> Anonymous memory gets backed by an inode on which we lookup and hang 
> the robust mutex structure (and which gets freed on the last reference 
> to the inode.)
> 
> The choice seemed either to back heap with the anonymous memory/inode 
> framework or just hang the struct on the vma itself.

putting it into the vma is just about the worst solution. vma size is 
something we are very sensitive to. Your patch adds:

+       int robust_init;                /* robust initialized? */
+       struct list_head robust_list;   /* list of robust futexes in this vma */
+       struct semaphore robust_sem;    /* semaphore to protect the list */

which is unacceptable. _And_ you were also talking about making it an 
rbtree... why do you want to make it a tree?

also, funky runtime flags like 'robust_init' are just sloppy.

add a separate pointer, and put the above fields into a separate SLAB.  
That way the overhead to the vma is a single pointer. (which might still 
be unacceptable to upstream!)

	Ingo
