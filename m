Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313056AbSC0SRO>; Wed, 27 Mar 2002 13:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313062AbSC0SRF>; Wed, 27 Mar 2002 13:17:05 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:43405 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313056AbSC0SRA>; Wed, 27 Mar 2002 13:17:00 -0500
Message-ID: <3CA20C9B.20309@us.ibm.com>
Date: Wed, 27 Mar 2002 10:16:59 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: BKL in do_exit
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was asked by a coworker why the BKL was held in do_exit().  I didn't 
have a good answer for him, so I went digging and found a couple of 
Linus quotations on the subject (thank you Google).

 > And the do_exit() case should be _trivial_ to fix: almost none of the
 > code protected by the kernel lock in the exit path actually needs the
 > lock. I suspect you could cut down the kernel lock there to much
 > smaller.

> Andrew Morton  <akpm@zip.com.au> wrote:
>>That'll be where exit() takes down the tasks's address spaces.  
>>zap_page_range().  That's a nasty one.
 > No, lock_kernel happens after exit_mm, and in fact I suspect it's not
 > really needed at all any more except for the current "sem_exit()". I
 > think most everything else is threaded already.
 >
 > (Hmm.. Maybe disassociate_ctty() too).
 >
 > So minimizing the BLK footprint in do_exit() should be pretty much
 > trivial: all the really interesting stuff should be ok already.

Because of Linus's optimism, I went looking at do_exit(). Here is my 
take on it:

         lock_kernel();
         sem_exit();
// This is questionable, but appears safe to me.  Several
// sem_(un)lock()s are done the semid.  What else needs to be protected
// here?  What was Linus talking about that looks unsafe?  Is there a
// chance for another process to be mucking with the current process's
// semaphore lists?

// these hold the task lock and look safe
         __exit_files(tsk);
         __exit_fs(tsk);

         exit_sighand(tsk); // does spin_lock_irq(&tsk->sigmask_lock);
                            // looks safe			

         exit_thread(); // nop on most architectures
                        // FPU cleanup on most others
                        // looks safe

// there is no locking of the tty.  As Linus said, this appears to
// be the bad one now
         if (current->leader)
                 disassociate_ctty(1);

// I can't see why these would need BKL. Looks safe
         put_exec_domain(tsk->exec_domain);
         if (tsk->binfmt && tsk->binfmt->module)
                 __MOD_DEC_USE_COUNT(tsk->binfmt->module);

// Does the task lock need to be taken for this?
         tsk->exit_code = code;

// Does this need to make sure that none of the relatives exit?
         exit_notify();

// BKL implicitly released by calling this, if it is held
         schedule();

Can we just hold the BKL around the operations that actually need it? 
Is there any other reason to hold it the whole time?

P.S. There are some really fork-happy benchmarks which could see an 
improvement from a reduction of lock contention here.  It isn't just 
theoretical.
-- 
Dave Hansen
haveblue@us.ibm.com

