Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTLBBfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 20:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTLBBfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 20:35:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:59612 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264267AbTLBBf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 20:35:27 -0500
Subject: Re: [PATCH 2.6.0-test9-mm5] aio-dio-fallback-bio_count-race.patch
From: Daniel McNeil <daniel@osdl.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20031126075513.GA3902@in.ibm.com>
References: <20031112233002.436f5d0c.akpm@osdl.org>
	 <1068761038.1805.35.camel@ibm-c.pdx.osdl.net>
	 <20031117052518.GA11184@in.ibm.com>
	 <1069118109.1842.31.camel@ibm-c.pdx.osdl.net>
	 <1069119433.1842.43.camel@ibm-c.pdx.osdl.net>
	 <20031118115520.GA4291@in.ibm.com>
	 <1069199273.1906.14.camel@ibm-c.pdx.osdl.net>
	 <20031124094249.GA11349@in.ibm.com>
	 <1069804171.1841.23.camel@ibm-c.pdx.osdl.net>
	 <20031126075513.GA3902@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1070328918.29903.30.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Dec 2003 17:35:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna,

Sorry I did not respond sooner, I was on vacation.

Your patch should also fix the problem.  I like mine with the
cleaner locking.

I am not sure your approach has less overhead.  At least
on x86, cli/sti are fairly inexpensive.  The locked xchange or locked
inc/dec is what is expensive (from what I understand).

So comparing:

my patch:				Your patch:

dio_bio_submit()		
	spin_lock()			atomic_inc(bio_count);
	bio_count++			atomic_inc(bios_in_flight);
	bios_in_flight++
	spin_unlock

My guess is that the spin_lock/spin_unlock is faster than 2 atomic_inc's
since it is only 1 locked operation (spin_lock) verses 2 (atomic_inc's)

finished_one_bio() (normal case)

My patch:
	spin_lock()			atomic_dec_and_test(bio_count)
	bio_count--
	spin_unlock()	
	
1 locked instruction each, so very close -- atomic_dec_and_test() does
not disable interrupts, so it is probabably a little bit faster.

finished_one-bio (fallback case):

	spin_lock()			spin_lock()
	bio_count--;			dio->waiter = null
	spin_unlock()			spin_unlock()

Both approaches are the same.
	
dio_bio_complete()

	spin_lock()			spin_lock()
	bios_in_flight--		atomic_dec()
	spin_unlock			spin_unlock()

My patch is faster since it removed 1 locked instruction.

Conclusion:

My guess would be that both approaches are close, but my patch
has less locked instructions but does disable interrupts more.
My preference is for the cleaner locking approach that is easier
to understand and modify in the future.

Daniel

On Tue, 2003-11-25 at 23:55, Suparna Bhattacharya wrote:
> On Tue, Nov 25, 2003 at 03:49:31PM -0800, Daniel McNeil wrote:
> > Suparna,
> > 
> > Yes your patch did help.  I originally had CONFIG_DEBUG_SLAB=y which
> > was helping me see problems because the the freed dio was getting
> > poisoned.  I also tested with CONFIG_DEBUG_PAGEALLOC=y which is
> > very good at catching these.
> 
> Ah I see - perhaps that explains why neither Janet nor I could
> recreate the problem that you were hitting so easily. So we 
> should probably try running with CONFIG_DEBUG_SLAB and
> CONFIG_DEBUG_PAGEALLOC as well.
> 
> > 
> > I updated your AIO fallback patch plus your AIO race plus I fixed
> > the bio_count decrement fix.  This patch has all three fixes and
> > it is working for me.
> > 
> > I fixed the bio_count race, by changing bio_list_lock into bio_lock
> > and using that for all the bio fields.  I changed bio_count and
> > bios_in_flight from atomics into int.  They are now proctected by
> > the bio_lock.  I fixed the race, by in finished_one_bio() by
> > leaving the bio_count at 1 until after the dio_complete()
> > and then do the bio_count decrement and wakeup holding the bio_lock.
> > 
> > Take a look, give it a try, and let me know what you think.
> 
> I had been trying a slightly different kind of fix -- appended is
> the updated version of the patch I last posted. It uses the bio_list_lock
> to protect the dio->waiter field, which finished_one_bio sets back
> to NULL after it has issued the wakeup; and the code that waits for
> i/o to drain out checks the dio->waiter field instead of bio_count.
> This might not seem very obvious given the nomenclature of the 
> bio_list_lock, so I was holding back wondering if it could be 
> improved. 
> 
> Your approach looks clearer in that sense -- its pretty unambiguous
> about what lock protects what fields. The only thing that bothers me (and
> this is what I was trying to avoid in my patch) is the increased
> use of spin_lock_irq 's (overhead of turning interrupts off and on)
> instead of simple atomic inc/dec in most places.
> 
> Thoughts ?
> 
> Regards
> Suparna

