Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291280AbSBGUdY>; Thu, 7 Feb 2002 15:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291282AbSBGUdJ>; Thu, 7 Feb 2002 15:33:09 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:6661 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S291281AbSBGUbl>;
	Thu, 7 Feb 2002 15:31:41 -0500
Date: Thu, 7 Feb 2002 13:31:09 -0700
From: yodaiken@fsmlabs.com
To: Ingo Molnar <mingo@elte.hu>
Cc: yodaiken <yodaiken@fsmlabs.com>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@zip.com.au>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>,
        nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020207133109.B21935@hq.fsmlabs.com>
In-Reply-To: <20020207125601.A21354@hq.fsmlabs.com> <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Feb 07, 2002 at 11:09:16PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 11:09:16PM +0100, Ingo Molnar wrote:
> 
> On Thu, 7 Feb 2002, yodaiken wrote:
> 
> > So what's the difference between combi_spin and combi_mutex?
> > combi_spin becomes
> > 	if not mutex locked, spin
> > 	else sleep
> > Bizzare
> 
> no, the real optimization is that when spin meets spin, they will not
> mutex. If a mutex-user has it then spins turn into mutex, but that (is
> supposed to) happen rarely.

It seems like what you want is:
	if the lock is about to be released, spin, else sleep.
But what is proposed is
	if the lock is locked as a mutex, sleep, else spin
although I doubt either of these work - they seem like attempts to avoid
designing the code.

> 
> i think one example *could* be to turn inode->i_sem into a combi-lock. Eg.
> generic_file_llseek() could use the spin variant.
> 
> this is a real performance problem, i've seen scheduling storms in
> dbench-type runs due to llseek taking the inode semaphore.
	llseek:
		atomic_enquee request
		if no room gotta sleep
		else if trylock mutex
			return
		     else
			do work
			loop:
			     process any pending requests
			     release lock;
			     if pending_requests && !(trylock mutex) goto loop

			
			
> whether combi-locks truly bring performance benefits remains to be seen,
> but the patch definitely needs to provide some working example and some
> hard numbers for some real workload.

I think it's a lot easier to propose lock structures than to work on
reducing synchronization problems.

> 
> 	Ingo

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

