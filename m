Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269171AbUHaXuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269171AbUHaXuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUHaXst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:48:49 -0400
Received: from lakermmtao03.cox.net ([68.230.240.36]:55243 "EHLO
	lakermmtao03.cox.net") by vger.kernel.org with ESMTP
	id S269171AbUHaXdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:33:43 -0400
In-Reply-To: <200409010016.36570.mbuesch@freenet.de>
References: <1093964782.434.7054.camel@cube> <1093973977.434.7097.camel@cube> <F8184F90-FB94-11D8-9B58-000393ACC76E@mac.com> <200409010016.36570.mbuesch@freenet.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0C734E72-FBA6-11D8-9B58-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Albert Cahalan <albert@users.sourceforge.net>, axboe@suse.de,
       bunk@fs.tum.de, Linus Torvalds <torvalds@osdl.org>,
       Albert Cahalan <albert@users.sf.net>, arjanv@redhat.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: What policy for BUG_ON()?
Date: Tue, 31 Aug 2004 19:32:39 -0400
To: Michael Buesch <mbuesch@freenet.de>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 31, 2004, at 18:16, Michael Buesch wrote:
> So, back to the real world. ;)
> - Where do we insert BUG_ON()s?
> Only in places, where we are going to crash or corrupt data soon.
>
> - Do we insert "expensive unnecessary function calls" in a BUG_ON()?
> No we don't. Could you give a good example, which
> needs an expensive call inside a BUG_ON()?

BUG_ON(len != strlen(string));

I don't want the strlen() executed on an embedded machine every time
I hit that piece of code, heck, probably not even my server if string 
is big
or if this code is executed many times.

> In a shiny good world we expect BUG()s to never trigger. So I think
> it's a bit crazy to check for things that theoretically can't happen
> and waste tons of CPU cycles for this, with expensive calls.
> If we really want to check this while debugging, I think we
> should explicitely honor the DEBUG define in the code and have
> our own debug printk() that shows the mess.
>
> I think here's a general confusion about what BUG_ON() is intended
> for. I think (I'm not the author of it, so I can't say 100%. :) )
> it is _not_ for debugging while development. It is for checking 
> unpossible
> things, that blow up the whole machine if they trigger nevertheless.
> So I think it's wrong to let BUG_ON() depend on a DEBUG define, because
> DEBUG is, by definition, not enabled in the kernels people use.
> But I think we _want_ that people evaluate the BUG_ON()s.

Ok, so then we need an additional config directive:

CONFIG_EMBEDDED_NODEBUG

Then:

#ifdef CONFIG_EMBEDDED_NODEBUG
# define BUG_ON(cond) do { if (cond); } while(0)
# define BUG_CHECK(cond) do { } while(0)
#else
# define BUG_ON(cond) do { if (cond) BUG(); } while(0)
# define BUG_CHECK(cond) do { if (cond) BUG(); } while(0)
#endif

#ifdef CONFIG_DEBUG
# define DEBUG_ON(cond) do { } while(0)
#else
# define DEBUG_ON(cond) do { if (cond) BUG(); } while(0)
#endif

It's the _exact_same_ problem, with different definitions for which
mode is "debugging mode" in this particular case.  I agree with the
above email, but I think that for the embedded people, we should
define an extra macro that removes all excess tests, whether they
are expensive or inexpensive.  Then the BUG_ON() macro would
leave any checks in place in such a specialized compile, because
they may have required side effects.  A similar DEBUG_ON()
macro would be disabled for general users, but could be enabled
with DEBUG to provide the expensive checks, when a user is
experiencing problems.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------

