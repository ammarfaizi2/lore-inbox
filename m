Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268149AbTAKWLA>; Sat, 11 Jan 2003 17:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268151AbTAKWLA>; Sat, 11 Jan 2003 17:11:00 -0500
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:51084 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S268149AbTAKWKq>; Sat, 11 Jan 2003 17:10:46 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Linus BK tree crashes with PANIC: INIT: segmentation violation
References: <Pine.LNX.4.44.0301101424590.1193-100000@penguin.transmeta.com>
From: Derek Atkins <warlord@MIT.EDU>
Date: 11 Jan 2003 17:19:31 -0500
In-Reply-To: <Pine.LNX.4.44.0301101424590.1193-100000@penguin.transmeta.com>
Message-ID: <sjm65sv49e4.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> > Well, which change-point do you want?  Do you want the change-point
> > from the string-of-oppses to the "PANIC: INIT: ..."?  Or the
> > change-point from a working kernel to the string-of-oopses?  I already
> > computed the latter point.  I have not computed the former.
> 
> Well, both are interesting. Nothing says that the problems have to be
> related, but it's certainly not inconceivable, and as such both points end 
> up being interesting.
> 
> >         1) PANIC: INIT: ...
> >         2) String of Oopses
> >         3) Working Tree.
> > 
> > The changeover from 2-3 is approximately December 30 (see my previous
> > post).
> 
> I was hoping for a exact changset, your post didn't seem to be 100% sure.

Ok, I've found the culprit for the "2-3" changepoint (the
string-of-oopses).  Now that I've figured this one out, I'll go work
out the 1-2 changepoint.  The string of oopses is a result of the
attached ChangeSet (a change to kernel/kallsyms.c:kallsyms_lookup()).

It is quite clearly a problem with the "grab name" loop around line
49.  In particular, it appears that "*name" might be a "negative"
number which is sending the strncpy() into lala land.  Even if you
force *name to be unsigned (as a later patch does), it still
sign-extends the negative number and you get a HUGE positive number.

I'm trying to find a better way to do this, and I'll try pulling a
change forward before I work backwards to search for the 1-2
changepoint.  In looking at this patch, I believe that you do NOT need
the extra "namebuf" argument -- you just need to handle the loop
properly (and return the correct string).

More in a bit...

-derek

ChangeSet@1.914, 2002-12-25 21:46:32-06:00, ak@muc.de
  kbuild: Stem compression for kallsyms
  
  This patch implements simple stem compression for the kallsyms symbol
  table. Each symbol has as first byte a count on how many characters
  are identical to the previous symbol. This compresses the often
  common repetive prefixes (like subsys_) fairly effectively.
  
  On a fairly full featured monolithic i386 kernel this saves about 60k in
  the kallsyms symbol table.
  
  The changes are very simple, so the 60k are not shabby.
  
  One visible change is that the caller of kallsyms_lookup has to pass in
  a buffer now, because it has to be modified. I added an arbitary
  127 character limit to it.
  
  Still >210k left in the symbol table unfortunately. Another idea would be to
  delta encode the addresses in 16bits (functions are all likely to be smaller
  than 64K).  This would especially help on 64bit hosts. Not done yet, however.
  
  No, before someone asks, I don't want to use zlib for that. Far too fragile
  during an oops and overkill too and it would require to link it into all
  kernels.

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available
