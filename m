Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135771AbRDTBUj>; Thu, 19 Apr 2001 21:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135772AbRDTBUb>; Thu, 19 Apr 2001 21:20:31 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27914 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135771AbRDTBUR>; Thu, 19 Apr 2001 21:20:17 -0400
Date: Fri, 20 Apr 2001 03:42:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: rwsem benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]
Message-ID: <20010420034215.K752@athlon.random>
In-Reply-To: <01042000280900.01311@orion.ddi.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01042000280900.01311@orion.ddi.co.uk>; from dhowells@astarte.free-online.co.uk on Fri, Apr 20, 2001 at 12:28:09AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 12:28:09AM +0100, D . W . Howells wrote:
> I benchmarked four different environments:
> 
> 	(1) 2.4.4-pre3 + Andrea's generic rwsem patch
> 	(2) 2.4.4-pre4 using XADD to implement the rwsems
> 	(3) same as (2) but with a tweak to make rwsem_wake() less fair
> 	(4) 2.4.4-pre3 using my generic spinlock code to implement the rwsems
> 
> David
> 
> 
> TEST		NUM READERS	NUM WRITERS	CONTENTION
> ===============	===============	===============	==========
> rwsem-rw	4		2		r-w & w-w
> rwsem-ro	4		0		no
> rwsem-wo	0		4		w-w only
> rwsem-r1	1		0		no
> rwsem-w1	0		1		no
> rwsem-r2	2		0		no
> 
> 
> ENVIRONMENT			TEST	SCHED	READERS		WRITERS
> ===============================	=======	=======	===============	=======
> Linux-2.4.4-pre3 + AA-rwsem	rws-rw	no	 3330281	    1009
> 						 3331972	     994
[..]
> -------------------------------	-------	-------	---------------	-------
> Linux-2.4.4-pre4 [GENERIC-SPIN]	rws-rw	no	  545138	  274002
> 						  545378	  273785
> 					yes	  755343	  187874
> 						  745888	  185562

Some explanation on the above extreme difference. In the misc rw benchmark the
reason in the same amount of time I get a total number of down 3332966 and you
get only 819163 is that I provide recursive down_read and that in turn can
starve the down_write (my first patches weren't implementing fair semaphores).

As you can see in my post of yesterday I made my semaphores fair in my last
patches (from rwsem-generic-5). (you didn't said which patch you used exactly
but obviously it was earlier than the -5 revision)

I'm uncertain if I should drop the list_empty() check from the fast path and if
I should still allow up_* to be called from irq/softirq, if I reduce the max
number of sleepers to 2^16 and I will provide weaker wakeup semantics I won't
be penalizied anymore and then we'll really compare apples to orange making the
comparison more interesting (probably I will do because later on I can probably
re-add that two features without too much pain).

About the benchmark you wrote it looks good measure to me, thanks.

Andrea
