Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292296AbSB0Q6q>; Wed, 27 Feb 2002 11:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292813AbSB0Q6U>; Wed, 27 Feb 2002 11:58:20 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7154 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292820AbSB0Q6G>;
	Wed, 27 Feb 2002 11:58:06 -0500
Date: Wed, 27 Feb 2002 11:58:42 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Joshua MacDonald <jmacd@namesys.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020227115842.C1308@elinux01.watson.ibm.com>
In-Reply-To: <20020227163834.GF322@reload.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227163834.GF322@reload.nmd.msu.ru>; from jmacd@namesys.com on Wed, Feb 27, 2002 at 07:38:34PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 07:38:34PM +0300, Joshua MacDonald wrote:
> Hi Hubertus,
> 
> I have a question for you about these semaphores.  I took a glance at
> <linux/ulocks.h> to try and find out how large an object the
> user-space lock is.  I see that you have it written like this:
> 
> typedef struct ulock_t {
> 	unsigned long  status;
> 	unsigned long  type;
> 	unsigned long  counters[ULOCK_STAT_COUNTERS];
> 	char           pad[SMP_CACHE_BYTES - 
> 			   (ULOCK_STAT_COUNTERS+2)*sizeof(unsigned long)];
> } ulock_t ____cacheline_aligned;
> 
> I would like to suggest that you offer a version of the ulock_t that
> is as small as possible so that the user can make use of the entire
> cacheline rather than waste it on padding.
> 
> The reason I'm interested is that I have written a concurrent,
> cache-optimized skip list and I did all of my testing using the
> standard Linux spinlocks.  Those are 4 bytes per lock.  I use one lock
> per cacheline-sized node of the data structure.  If you can get your
> locks down to one or two words that would be really interesting, since
> spinlocks don't work terribly well in user-space.  I would really like
> to be able to use this data structure outside of the kernel, and your
> locks might just solve my problem, but only if they are small enough.
> 
> Do you see my point?  You can find my latest skiplist code at:

I have seen the light. Seriously, I initially had it as you said, but
Linus was strongly recommending cacheline size objects to 
avoid false sharing other than on the lock word
However, there should be no problem whatsoever to bring that back
to 2 words.

> typedef struct ulock_t {
>       unsigned long  status;
>       unsigned long  qcount;   /* this will change instead of type */
> }

Counters are only there for lock statistics.
padding is only there for filling the cacheline (might be obsolute anyway.
What can be done is to make the ____cacheline_aligned a configuration
option. Nothing in the system relies on this. I'll see how I'll
do this.

Also, this can be brought down to one word, if we don't have
demand based kernel object allocation and/or multiple queue requirements
as requested by BenLeHaise.

Rusty, how would your pin based approach be effected by this ?

Comments ?

-- Hubertus

> 
>     http://sourceforge.net/projects/skiplist
> 
> I have put test results up on that site as well, but those tests were
> made using spinlocks at user-level!  In otherwords, I don't really
> believe my results are meaningful.
> 
> (And let me warn you that there's a bug and haven't uploaded the
> latest version yet...)
> 
> -josh
