Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbUKVXHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbUKVXHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbUKVXDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:03:45 -0500
Received: from palrel11.hp.com ([156.153.255.246]:60119 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261224AbUKVXBu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:01:50 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [Lse-tech] scalability of signal delivery for Posix Threads
Date: Mon, 22 Nov 2004 15:01:27 -0800
Message-ID: <65953E8166311641A685BDF71D865826058B5F@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lse-tech] scalability of signal delivery for Posix Threads
Thread-Index: AcTQ2y6kOBdUuD/ETpmxd0CjfItlfQACpcGQ
From: "Boehm, Hans" <hans.boehm@hp.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Ray Bryant" <raybry@sgi.com>, "Andreas Schwab" <schwab@suse.de>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>,
       "lse-tech" <lse-tech@lists.sourceforge.net>, <holt@sgi.com>,
       "Dean Roe" <roe@sgi.com>, "Brian Sumner" <bls@sgi.com>,
       "John Hawkes" <hawkes@tomahawk.engr.sgi.com>
X-OriginalArrivalTime: 22 Nov 2004 23:01:27.0851 (UTC) FILETIME=[329ED7B0:01C4D0E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to clarify:

I have no problem with special-casing signals sent to a specific
thread.  Our garbage collector uses pthread_kill, and thus should
also benefit from that change.  And it makes sense to me that this
kind of signal should be cheaper to deliver.

SIGSEGV delivery also matters to me.  But that should presumably
also fall into the same class.

I would prefer to avoid special handling for just SIGPROF.
If that was never proposed, please ignore my comments.

Hans

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de]
> Sent: Monday, November 22, 2004 1:35 PM
> To: Boehm, Hans
> Cc: Ray Bryant; Andi Kleen; Andreas Schwab; Kernel Mailing List;
> linux-ia64@vger.kernel.org; lse-tech; holt@sgi.com; Dean Roe; Brian
> Sumner; John Hawkes
> Subject: Re: [Lse-tech] scalability of signal delivery for 
> Posix Threads
> 
> 
> > I think this is a more general issue.  Special casing one
> 
> It just cannot be done in the general case without slowing
> down sigaction significantly. Or maybe it can, but nobody
> has proposed a way to do it so far. 
> 
> It's difficult to design for machines where a simple spinlock
> doesn't work properly anymore.
> 
> > piece of it is only going to make performance more surprising,
> > something I think should be avoided if at all possible.
> 
> The special case in particular would be signals directed to a 
> specific TID;
> compared to signals load balanced over the thread group which needs
> shared writable state. To simplify the fast path you could also make
> more simplications: no queueing (otherwise you would need to duplicate
> a lot of state to handle that into the task_struct) and probably
> no SIGCHILD which is also full of special cases.
> 
> -And
> 
