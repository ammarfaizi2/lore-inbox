Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271391AbTHDFyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 01:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271393AbTHDFyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 01:54:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:61132 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271391AbTHDFyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 01:54:36 -0400
Date: Sun, 3 Aug 2003 22:54:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: do_div considered harmful
In-Reply-To: <UTC200308040203.h7423rv14876.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0308032249300.11175-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Aug 2003 Andries.Brouwer@cwi.nl wrote:
>
> Now that I compare, he wrote
> 	nativeMb = do_div(nativeMb, 1000000);
> to divide nativeMb by 1000000.
> 
> So, it seems natural to expect that do_div() gives the quotient.
> But it gives the remainder.
> (Strange, Erik showed correct output.)

Actually, the above is "undefined behaviour", since it has _two_ 
assignments in the same thing. Exactly because "do_div()" modifies both 
the first argument _and_ returns a value. So depending on the 
implementation of do_div() (whether there are any sequence points etc) and 
on random compiler behaviour (if there are no sequence points in do_div() 
internally), in the example above "nativeMb" migth be totally undefined 
after the above.

And yes, as a special case, it might be the divisor.

I agree that "do_div()" has strange semantics and is very likely misnamed,
but they are kind of forced upon us by the fact that C functions cannot
return two values. Renaming do_div() at this point is just going to make
it harder to write kernel- portable source, so I suspect we're better off
just commenting it, and making people aware of how do_div() works.

Not very many people should use "do_div()" directly (and a quick grep
shows that not very many people do). It's generally a mistake to do so, I
suspect. The thing was originally written explicitly for "printk()" and
nothing else.

		Linus

