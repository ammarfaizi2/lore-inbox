Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263434AbVCEAhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbVCEAhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263454AbVCEAKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:10:48 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:10418 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263314AbVCDXYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:24:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Date: Sat, 5 Mar 2005 00:26:05 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com, Nigel Cunningham <ncunningham@cyclades.com>
References: <200502252237.04110.rjw@sisk.pl> <200503041415.35162.rjw@sisk.pl> <20050304201109.GB2385@elf.ucw.cz>
In-Reply-To: <20050304201109.GB2385@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503050026.06378.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 4 of March 2005 21:11, Pavel Machek wrote:
> Hi!
> 
> > > > > IIRC kernel code/data is marked as PageReserved(), that's why we need
> > > > > to save that :(. Not sure what to do with data e820 marked as
> > > > > reserved...
> > > > 
> > > > Perhaps we need another page flag, like PG_readonly, and mark the pages
> > > > reserved by the e820 as PG_reserved | PG_readonly (the same for the areas
> > > > that are not returned by e820 at all).  Would that be acceptable?
> > > 
> > > This flags are little in the short supply, but being able to tell
> > > kernel code from memory hole seems like "must have", so yes, that
> > > looks ok.
> > > 
> > > You could get subtle and reuse some other pageflag. I do not think
> > > PG_reserved can have PG_locked... So using for example PG_locked for
> > > this purpose should be okay.
> > 
> > The following patch does this.  It is only for x86-64 without
> > CONFIG_DISCONTIGMEM, but it has no effect in other cases.
> 
> Actually, take a look at Nigel's patch. He simply uses PageNosave
> instead of PageLocked -- that is cleaner.

Yes.  I thought about using PG_nosave in the begining, but there's a

BUG_ON(PageReserved(page) && PageNosave(page));

in swsusp.c:saveable() that I just didn't want to trigger.  It seems to me,
though, that we don't need it any more, do we?

> He also found a few places where reserved page becomes un-reserved,
> and you probably need to fix those, too.

Yes, I think I'll just port the Nigel's patch to x86-64.  BTW, it's striking
that we found similar solutions independently (I didn't know the Nigel's
patch before :-)).

Unfortunately, it turns out that the patch does not fix my problem with random
reboots during resume on battery power, but I really think that we need to mark
non-RAM areas with PG_nosave, at least for sanity reasons (eg to be sure that
we do not break things by dumping stuff to where we should not write to).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
