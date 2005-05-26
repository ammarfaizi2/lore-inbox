Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVEZTco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVEZTco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVEZTcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:32:43 -0400
Received: from colin.muc.de ([193.149.48.1]:35600 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261711AbVEZTcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:32:32 -0400
Date: 26 May 2005 21:32:30 +0200
Date: Thu, 26 May 2005 21:32:30 +0200
From: Andi Kleen <ak@muc.de>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, bhuey@lnxw.com,
       nickpiggin@yahoo.com.au, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050526193230.GY86087@muc.de>
References: <20050525001019.GA18048@nietzsche.lynx.com> <1116981913.19926.58.camel@dhcp153.mvista.com> <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 11:00:19AM -0700, Sven-Thorsten Dietrich wrote:
> 
> > I have no reason to believe this is any different with all
> > this RT testing. 
> > 
> 
> And that's why we have been testing and benchmarking, to
> produce number sets that supersede faith, belief, and 
> conjecture. But ultimately, you can trust your senses,
> and I think the audio / video test would allow your eyes 
> to see, and your ears to hear the difference.

I understand that you have some real improvements that are measurable.
What I objected to was the claim that it actually made any difference
to interactive users.

> 
> > -Andi (who also would prefer to not have interrupt threads, locks like
> > a maze and related horribilities in the mainline kernel) 
> 
> I am definitely for breaking out an IRQ threads patch,
> separate from the RT-mutex patches, even if just to
> allow examination of that code without the clutter.

What I dislike with RT mutexes is that they convert all locks.
It doesnt make much sense to me to have a complex lock that
only protects a few lines of code (and a lot of the spinlock
code is like this). That is just a waste of cycles.

But I always though we should have a new lock type that is between
spinlocks and semaphores and is less heavyweight than a semaphore
(which tends to be quite slow due to its many context switches). Something
like a spinaphore, although it probably doesnt need full semaphore
semantics (rarely any code in the kernel uses that anyways). It could
spin for a short time and then sleep. Then convert some selected
locks over. e.g. the mm_sem and the i_sem would be primary users of this.
And maybe some of the heavier spinlocks.

If you drop irq threads then you cannot convert all locks
anymore or have to add ugly in_interrupt()checks. So any conversion like
that requires converting locks.

-Andi

