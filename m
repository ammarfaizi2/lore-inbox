Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272166AbTG3UGC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTG3UGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:06:02 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:12976 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S272166AbTG3UF7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:05:59 -0400
Date: Wed, 30 Jul 2003 15:05:39 -0500
From: linas@austin.ibm.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730150539.A28284@forte.austin.ibm.com>
References: <20030729135643.2e9b74bc.akpm@osdl.org> <Pine.LNX.4.44.0307300733200.25010-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307300733200.25010-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Jul 30, 2003 at 07:57:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 07:57:32AM +0200, Ingo Molnar wrote:
> 
> and i dont think Linas' patch is correct either - how can the timer base
> change under us? We are holding the timer spinlock.

I deduced the need for the patch by looking at the locking code immediately
above it, which takes pains to get old_base and new_base correctly locked.
My patch was to handle the case of old_base being NULL, which seemed to be 
unhandled.  

Comments & disclaimers:
-- I don't quite have the 'big picture' for the timer code yet,
   so please excuse any thinko's below.
-- I don't know under what cases timer->base can be NULL, but clearly
   there are checks for it being NULL, ergo...
-- I then see a race where timer->base is NULL, and so old_base is NULL, 
   then some other CPU sets timer->base, then we get the lock
   on new_base, and blandly assume timer->base is NULL, which it no longer 
   is.

A bit more graphically ... 

timer->base = NULL;  /* starting condition */

cpu 1                                   cpu 2
--------                                ---------
mod_timer()  {                          

old_base = timer->base;
if (old_base &&  ) { /* not taken */
}
else
.                                       spin_lock(&cpu2_base->lock);
.                                       timer->base = cpu2_base;
.                                       spin_unlock(&cpu2_base->lock);
.
spin_lock(&new_base->lock);
                                                                                
/* Uhh oh, timer->base is not null,
   in fact its cpu2 base, and we aren't
   checking for this before we clobber it.
 */


I don't see what prevents the above from happening.  And if the 
above really can't happen, then I also don't understand why the fancy
old_base, new-base locking code is required at all. 


> What i'd propose is the attached (tested, against 2.6.0-test2) patch

Due to technical difficulties at this end, I'm having trouble testing
any patches.  The guy who knows how to run the test case to reproduce
this is out sick,  its a big hairy testcase with all sorts of stuff 
going on, and I can't make it go.  It can take 8+ hours to hit it.
I'll need a few days ... 

The other machine that hits it is a 6-way smp powerpc running nothing 
but 6 copies of setiathome, but it takes 48+ hours to reproduce there, 
so testing is even slower there ...

--linas
