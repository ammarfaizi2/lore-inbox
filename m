Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292924AbSB0WJN>; Wed, 27 Feb 2002 17:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292991AbSB0WIs>; Wed, 27 Feb 2002 17:08:48 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60876 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292989AbSB0WIb>;
	Wed, 27 Feb 2002 17:08:31 -0500
Date: Wed, 27 Feb 2002 17:09:13 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Joshua MacDonald <jmacd@namesys.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020227170913.A2021@elinux01.watson.ibm.com>
In-Reply-To: <20020227163834.GF322@reload.nmd.msu.ru> <20020227115842.C1308@elinux01.watson.ibm.com> <20020227173307.GH322@reload.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227173307.GH322@reload.nmd.msu.ru>; from jmacd@namesys.com on Wed, Feb 27, 2002 at 08:33:07PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To followup on this. I have posted the latest version of this under
http://prdownloads.sourceforge.net/lse/ulocks-2.4.17.tar.bz2

- I followed the suggestion below to minimize ulock_t datastructure
  to do so go to ./make.setup and comment out the -DLOCK_STATISTICS flag
  this will bring the ulockt_t down to 2 words, otherwise 28 bytes.
- The ulockflex program will irrespectively allocate all locks on cacheline
  boundaries regardless of size.
- I fixed a problem in ulockflex that was introduced in the last version.
- I have now number of queues instead of an explicite lock type. Hence
  the kernel only knows about number of queues to maintain.

-- Hubertus Franke

On Wed, Feb 27, 2002 at 08:33:07PM +0300, Joshua MacDonald wrote:
> On Wed, Feb 27, 2002 at 11:58:42AM -0500, Hubertus Franke wrote:
> > On Wed, Feb 27, 2002 at 07:38:34PM +0300, Joshua MacDonald wrote:
> > > Hi Hubertus,
> > > 
> > > I have a question for you about these semaphores.  I took a glance at
> > > <linux/ulocks.h> to try and find out how large an object the
> > > user-space lock is.  I see that you have it written like this:
> > > 
> > > typedef struct ulock_t {
> > > 	unsigned long  status;
> > > 	unsigned long  type;
> > > 	unsigned long  counters[ULOCK_STAT_COUNTERS];
> > > 	char           pad[SMP_CACHE_BYTES - 
> > > 			   (ULOCK_STAT_COUNTERS+2)*sizeof(unsigned long)];
> > > } ulock_t ____cacheline_aligned;
> > > 
> > > I would like to suggest that you offer a version of the ulock_t that
> > > is as small as possible so that the user can make use of the entire
> > > cacheline rather than waste it on padding.
> > > 
> > > The reason I'm interested is that I have written a concurrent,
> > > cache-optimized skip list and I did all of my testing using the
> > > standard Linux spinlocks.  Those are 4 bytes per lock.  I use one lock
> > > per cacheline-sized node of the data structure.  If you can get your
> > > locks down to one or two words that would be really interesting, since
> > > spinlocks don't work terribly well in user-space.  I would really like
> > > to be able to use this data structure outside of the kernel, and your
> > > locks might just solve my problem, but only if they are small enough.
> > > 
> > > Do you see my point?  You can find my latest skiplist code at:
> > 
> > I have seen the light. Seriously, I initially had it as you said, but
> > Linus was strongly recommending cacheline size objects to 
> > avoid false sharing other than on the lock word
> > However, there should be no problem whatsoever to bring that back
> > to 2 words.
> 
> Sounds good.  There is nothing to prevent the declaration of a ulock_t
> variable from using __cacheline_aligned, so I think Linus is off on
> this one.
> 
> I'd like to test this out sometime.  The SLPC code uses a lots of CPP
> trickery to configure itself with various different read/write or
> exclusive locking packages, so its fairly easy to port to a new
> locking primitive.
> 
> -josh

