Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbTAMFMc>; Mon, 13 Jan 2003 00:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267887AbTAMFMc>; Mon, 13 Jan 2003 00:12:32 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:32172 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S267890AbTAMFM3>; Mon, 13 Jan 2003 00:12:29 -0500
Date: Mon, 13 Jan 2003 00:21:18 -0500
To: Greg Ungerer <gerg@snapgear.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
Subject: Re: exception tables in 2.5.55
Message-ID: <20030113052118.GA4539@gnu.org>
References: <Pine.LNX.4.44.0301121921570.24605-100000@home.transmeta.com> <3E223756.3010200@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E223756.3010200@snapgear.com>
User-Agent: Mutt/1.3.28i
Blat: Foop
From: Miles Bader <miles@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 01:49:42PM +1000, Greg Ungerer wrote:
> >There are exceptions that have nothing to do with MMU's, and a no-mmu 
> >architecture should still support them.  On x86, we have a number of such 
> >exceptions, for example general protection stuff for wrong values for 
> >special registers etc.
> 
> OK, heres an alternative patch that fully supports exception tables
> for m68knommu (Miles you'll need to do the same for v850).

On the v850, there are, to my knowledge, no usable exceptions (the only such
thing is illegal insn, which shouldn't occur, I think).

The latest patches I already sent to Linus handle this by just making
search_extable an inline in asm/module.h:

   /* We don't do exception tables.  */
   struct exception_table_entry;
   static inline const struct exception_table_entry *
   search_extable(const struct exception_table_entry *first,
		  const struct exception_table_entry *last,
	          unsigned long value)
   {
	   return 0;
   }

This allows gcc to remove a bit of the generic exception-table code, but I
was sort of hoping to have something like CONFIG_EXTABLES to get rid of the
rest of it (or maybe CONFIG_INHIBIT_EXTABLES since most archs want them).

As greg showed, this is simple to do, though I suppose the resulting savings
isn't much, and there are many many other places which might more profitably
be pruned...

[OTOH, little bits do add up, and for some reason this particular bit of code
seems extra gratuitous since it was previously arch-specific and I didn't
have to worry about it]

-Miles 
-- 
"I distrust a research person who is always obviously busy on a task."
   --Robert Frosch, VP, GM Research
