Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVAOBfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVAOBfw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVAOBdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:33:07 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:4494 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S262025AbVAOBb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:31:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Jan 2005 20:30:44 -0500 (EST)
To: Greg KH <greg@kroah.com>
Cc: Robert Wisniewski <bob@watson.ibm.com>, trz@us.ibm.com, karim@opersys.com,
       richardj_moore@uk.ibm.com, michel.dagenais@polymtl.ca,
       linux-kernel@vger.kernel.org, ltt-dev@shafik.org
Subject: Re: [PATCH 3/4] relayfs for 2.6.10: locking/lockless implementation
In-Reply-To: <20050114234817.GA6786@kroah.com>
References: <16872.19899.179380.51583@kix.watson.ibm.com>
	<20050114234817.GA6786@kroah.com>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16872.28149.139878.872756@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
 > 
 > A: Because it messes up the order in which people normally read text.
 > Q: Why is top-posting such a bad thing?

Okay - sorry about that - will respond inline.


 > A: Top-posting.
 > Q: What is the most annoying thing in e-mail?

ACTUALLY I HATE ALL CAPS MORE :-)

 > A: No.
 > Q: Should I include quotations after my reply?
 > 
 > On Fri, Jan 14, 2005 at 05:57:21PM -0500, Robert Wisniewski wrote:
 > > Greg,
 > >      There are a couple variables used throughout relayfs code that could
 > > be modified at any point "simultaneously" by different processes.  These
 > > variables were not declared volatile, thus when we modify them we need to
 > > tell the compiler to refetch from memory as another process could have
 > > changed out from under the current stream of execution since the last time
 > > there were accessed in the function.  An alternative would be to mark the
 > > variables that we care about as volatile.
 > 
 > marking them volatile does not protect across cpus.  Just using a normal
 > atomic_t will work properly.

I believe the below illustrates the problem that will be seen without
volatile.

int g;

funct1()
{
	g = 0;
	while (g == 0) ;
	printf("here\n");
}

funct2()
{
	g = 1;
}


If funct1 and funct2 are executed either by different processes on the same
processor (which is the case for relayfs as we have per-processor buffers),
or across processors, and if g is not marked volatile, then if a process
gets into funct1, does the first line, gets interrupted, funct2 executes,
then funct1 continues, funct1 will never get out of the while loop.  If
however g is marked volatile then it will get out of the loop.  Is this not
true?  If we agree that in this case g needs to be marked volatile there
are now two choices.  Either mark it volatile in the declaration or
while(g==0) barrier(); If I understand it correctly barrier() invalidates
all current register values and forces a reload from memory.

 > > I am not sure how best to make
 > > that tradeoff (i.e., always forcing a refetch by marking a variable
 > > volatile or only at points were we know we need to by memory clobbering) or
 > > on what side the Linux community comes down on.  We certainly would be
 > > happy to go either way with the relayfs code, i.e., mark them variable and
 > > used the standard atomic operations.
 > 
 > Just use atomic_t and don't mess with volatile.  See the archives for
 > why that (volatile) doesn't work like that.
 > 
 > > That explains compare_and_store, atomic_add, and atomic_sub.
 > 
 > No it doesn't, why do your own version of this function with the
 > barrier() function?
 > 
 > > It does not explain the memory clobbering around the atomic set
 > > operation, which I'm guessing was there just to be consistent with the
 > > other operations, and could, I believe, be removed.  Hopefully that
 > > helps answer the question.  If it doesn't please feel free to ask
 > > more.  Thanks.
 > 
 > So these can just be removed, and the code changed to use the proper
 > atomic calls?  If so, please do so.

Yes we can remove the code and use the standard atomic calls, but based on
the above example, I think we need to mark a couple variables volatile.  Do
you agree, if so, and unless there's dissenting opinion we can make the
change.

Thanks.

-bob

 > 
 > thanks,
 > 
 > greg k-h
