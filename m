Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270335AbTG3L03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272820AbTG3L0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:26:21 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14720
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272460AbTG3LZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:25:52 -0400
Date: Wed, 30 Jul 2003 13:28:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linas@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730112819.GK23835@dualathlon.random>
References: <20030730083726.GE23835@dualathlon.random> <Pine.LNX.4.44.0307301232220.13891-100000@localhost.localdomain> <20030730035140.7c834268.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730035140.7c834268.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 03:51:40AM -0700, Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > But on 2.6 the timer will run precisely on the CPU it was added, so i
> >  think the race is not possible.
> 
> well there is add_timer_on()...
> 
> I still don't see the race in the itimer code actually.  On return
> from del_timer_sync() we know that the timer is not pending, even
> if it_real_fn() tried to re-add it.
> 
> ie: why does the below "crash"?
> 
> 
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > 	cpu0			cpu1
> >  	------------		--------------------
> > 
> >  	do_setitimer
> >  				it_real_fn
> >  	del_timer_sync		add_timer	-> crash
> 
> 
> (Does the timer_pending() test in del_timer_sync() needs some
> barriers btw?)

it might be possible to use ordered writes on one side and ordered reads
on the other side to fix this instead of spinlock. I suggested to use my
spinlock-by-hand idea to fix it in 2.4 (like I previously did with
mod_timer), but we might try to do something more efficient in 2.6 if
you've some idea. I don't think it matters much anyways since the
cacheline wouldn't be exlusive anyways if we get into the above path,
and the above isn't the common path, but maybe it does. I think the
unified way of locking with mod_timer/add_timer/del_timer I'm currently
used is simple and clean, but if you see any significant performance
advantage we can change it of course.

If my last email where I analyzed the problem in more detail is not
clear or you see fault please let me know of course.

thanks,

Andrea
