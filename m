Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVAUAQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVAUAQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVAUAPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:15:05 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:39114 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261789AbVAUAOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:14:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Date: Fri, 21 Jan 2005 01:14:14 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       hugang@soulinfo.com, LKML <linux-kernel@vger.kernel.org>
References: <200501202032.31481.rjw@sisk.pl> <200501202358.53918.rjw@sisk.pl> <20050120230616.GD22201@elf.ucw.cz>
In-Reply-To: <20050120230616.GD22201@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501210114.14859.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 21 of January 2005 00:06, Pavel Machek wrote:
> Hi!
> 
> > > > The readability of code is also important, IMHO.
> > > 
> > > It did not seem too much better to me.
> > 
> > Well, the beauty is in the eye of the beholder. :-)
> > 
> > Still, it shrinks the code (22 lines vs 37 lines), it uses less GPRs (5 vs 7), it uses less
> > SIB arithmetics (0 vs 4 times), it uses a well known scheme for copying data pages.
> > As far as the result is concerned, it is equivalent to the existing code, but it's simpler
> > (and faster).  IMO, simpler code is always easier to understand.
> > 
> > 
> > > > > If you want cheap way to speed it up, kill cr3 manipulation.
> > > > 
> > > > Sure, but I think it's there for a reason.
> > > 
> > > Reason is "to crash it early if we have wrong pagetables".
> > > 
> > > > > Anyway, this is likely to clash with hugang's work; I'd prefer this not to be applied.
> > > > 
> > > > I am aware of that, but you are not going to merge the hugang's patches soon, are you?
> > > > If necessary, I can change the patch to work with his code (hugang, what do you think?).
> > > 
> > > I think it is just not worth the effort.
> > 
> > Why?  It won't take much time.  I've spent more time for writing the messages
> > in this thread ... ;-)
> 
> Well, I know that current code works. It was produced by C compiler,
> btw. Now, new code works for you, but it was not in kernel for 4
> releases, and... this code is pretty subtle.

Now, I'm confused. :-)  It's roughly this:

struct pbe *pbe = pagedir_nosave, *end;
unsigned n = nr_copy_pages;
if (n) {
	end = pbe + n;
	do {
		memcpy((void *)pbe->orig_address, (void *)pbe->address, PAGE_SIZE);
		pbe++;
	} while (pbe < end);
}

where memcpy() is of course a hand-written inline that includes the cr3 manipulation,
and pbe, end, n are registers.

> And it is hand-made, not C produced.

Yes, it is.

> So... your code may be better but I do not think it is so much better
> that I'd like to risk it.

Now, that's clear. :-)

Anyway, if anyone could test it or look at it and say a word, please do so.

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
