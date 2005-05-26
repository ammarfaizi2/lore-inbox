Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVEZU2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVEZU2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVEZU2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:28:05 -0400
Received: from colin.muc.de ([193.149.48.1]:16147 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261672AbVEZU1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:27:55 -0400
Date: 26 May 2005 22:27:47 +0200
Date: Thu, 26 May 2005 22:27:47 +0200
From: Andi Kleen <ak@muc.de>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, bhuey@lnxw.com,
       nickpiggin@yahoo.com.au, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050526202747.GB86087@muc.de>
References: <20050525005942.GA24893@nietzsche.lynx.com> <1116982977.19926.63.camel@dhcp153.mvista.com> <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here, I am talking about separating out the patch, and applying it
> first, not dropping it from the RT implementation. 

I really dislike the idea of interrupt threads. It seems totally
wrong to me to make such a fundamental operation as an interrupt
much slower.  If really any interrupts take too long they should
move to workqueues instead and be preempted there. But keep
the basic fundamental operations fast please (at least that used to be one
of the Linux mottos that served it very well for many years, although more
and more people seem to forget it now) 

> > What I dislike with RT mutexes is that they convert all locks.
> > It doesnt make much sense to me to have a complex lock that
> > only protects a few lines of code (and a lot of the spinlock
> > code is like this). That is just a waste of cycles.
> > 
> 
> It is NOT just a few lines of code. Millisecond latencies on high-
> powered CPU systems means more code than is probably required to send a
> rocket 'round the moon and back.

Most spinlocks only protect small code parts. Those that protect
larger codes can probably use optionally some different lock.

But dont attack it with "one size fits all" locking please.

> In addition, there are lock-ordering and lock-nesting issues (not to be
> confused with the Scottish sea creature :) that make this approach non-
> trivial whatsoever.

Hmm? Sorry that didnt make any sense. If the code was correct
before changing to a different spin like type should not
make any difference.

The only problem you have is interrupt code, which cannot sleep,
but I dont think you will eventually get around of fixing these
properly (= checking the code if it is slow and yes move it 
over and if not leave it alone) 


> > spin for a short time and then sleep. Then convert some selected
> > locks over. e.g. the mm_sem and the i_sem would be primary users of this.
> > And maybe some of the heavier spinlocks.
> 
> This is a bottom up approach, that simply doesn't work. I spent months
> considering this same scenario, so did a lot of other folks. This type
> of hybrid solution would blow the complexity and patch size through the
> roof, and render it unmaintainable. It is precisely why we introduced

Of course you would not do it as a big patch. Instead you do it one
by one, every time you identify a problem you submit a patch, it gets
accepted etc.

This way you never have a big pile of patches, just a small patchset in a current
queue. 

Of course big patches dont work, but there is no reason you have to keep
big patches for this.

That is how most other Linux maintainers work too. Why should that code
be any different?

It sounds to me like you did not understand how Linux kernel code 
submission is

> You will find a very good explanation of the dependencies in my original
> post on October 9. Also, please see my comment above, under "allow
> examination of that code without the clutter."

If you tried it with a big patchkit I am not surprised that the approach
didnt work. But did you ever consider the problem might be with the
way you submitted patches, not with the basic code?

-Andi
