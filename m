Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277494AbRJJW32>; Wed, 10 Oct 2001 18:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277496AbRJJW3U>; Wed, 10 Oct 2001 18:29:20 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:3337 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S277494AbRJJW3G>;
	Wed, 10 Oct 2001 18:29:06 -0400
Date: Wed, 10 Oct 2001 16:24:19 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, Paul Mackerras <paulus@samba.org>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010162419.A13116@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16510.1002751003@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 07:56:43AM +1000, Keith Owens wrote:
> On Wed, 10 Oct 2001 09:54:36 -0600, 
> Victor Yodaiken <yodaiken@fsmlabs.com> wrote:
> >Although I kind of like the idea of
> >	normal operation create mess by avoiding synchronization
> >	when system seems idle, get BKL, and clean up. 
> 
> That does not work.  A process can read an entry from a list then
> perform an operation that puts the process to sleep.  When it wakes up
> again, how can it tell if the list has been changed?  How can the

In general you're right, and always its better to 
reduce contention than to come up with silly algorithms for 
reducing the cost of contention, but  if you want to live
dangerously:

reader:
	atomic increment read_count
	do stuff; skip queue elements marked
		as zombie
	atomic decrement read_count


writer:
	spin lock queue
	to delete element
	mark element as zombie
	unspin

cleanup:
	spin lock queue
	if(read_count == 0){
		get big kernel lock
		if(read_count is still 0)
			// now nobody will be able to get to queue
			clean up queue
		unlock kernel
		}
	unlock spin


So you accomplished making the code harder to read and maintain, slowing
down worst case, and maybe reducing average case read spinlock delay.
For some very carefully selected cases this may be a win, but ...



