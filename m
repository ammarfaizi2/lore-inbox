Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWKEOtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWKEOtD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 09:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWKEOtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 09:49:03 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:62103 "EHLO urquell.c3sl.ufpr.br")
	by vger.kernel.org with ESMTP id S1030319AbWKEOtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 09:49:01 -0500
Date: Sun, 5 Nov 2006 12:48:57 -0200
From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061105144857.GA7305@c3sl.ufpr.br>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0611041633110.25218@g5.osdl.org> <Pine.LNX.4.64.0611050410210.29515@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611050410210.29515@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 05:14:06AM +0100, Mikulas Patocka wrote:
> On Sat, 4 Nov 2006, Linus Torvalds wrote:
> 
> >On Thu, 2 Nov 2006, Mikulas Patocka wrote:
> >>
> >>As my PhD thesis, I am designing and writing a filesystem, and it's now 
> >>in a
> >>state that it can be released. You can download it from
> >>http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
> >
> >Ok, not having actually tested any of this, I only have a few comments on
> >the source code:
> >
> >- the source tree layout is very confusing. Can you please separate the
> >  mkfs/fsck parts more clearly from the kernel driver parts?
> 
> Yes, fsck is already separated, mkfs could be too.
> 
> >- you have a _very_ confusing usage of upper-case. Not only are a lot of
> >  functions upper-case, some filenames are also upper-case. What would
> >  otherwise be more readable just ends up being hard to read because it's
> >  so odd and unexpected.
> >
> >  I'm sure there is some logic to it, but it escapes me.
> 
> I'm used to this. I usually make important functions with uppercase 
> letters and nonimportant temporary functions with lowercase letters.
> 
> But I see that it contradicts general kernel coding style, so I can change 
> it.
> 
> BTW do you find uppercase typedefs like
> typedef struct {
> 	...
> } SPADFNODE;
> confusing too?
> 
> Uppercase filenames are there because the files are taken from another 
> (not yet released) project. But the kernel driver does not share any code 
> except definitions of disk structures, I saw how badly an attempt to share 
> kernel code affected XFS.
> 
> >- your whitespace usage needs some work: please put empty lines between
> >  the declarations and the code in a function, and since you use a fair
> >  amount of "goto"s, please do NOT indent them into the code (it's almost
> >  impossible to pick out the target labels because you hide them with the
> >  code).
> >
> >- your whitespace, part 2: you have a fair number of one-liner
> >  if-statements, where again there is no indentation, and thus the flow
> >  is almost impossible to see. Don't wrote
> >
> >	if (somecomplexconditional) return;
> >
> >  but please instead write
> >
> >	if (somecomplexcondifional)
> >		return;
> >
> >  and perhaps use a few more empty lines to separate out the "paragraphs"
> >  of code (the same way you write email - nobody wants to see one solid
> >  block of code, you'd prefer to see "logical sections").
> >
> >  Here's a prime example of what NOT to do:
> >
> >	if (__likely(!(((*c)[1] - 1) & (*c)[1]))) (*c)[0] = key;
> >
> >  I dare anybody to be able to read that. That wasn't even the worst one:
> >  some of those if-statements were so long that you couldn't even _see_
> >  what the statement inside the if-statement even was (and I don't use a
> >  80-column wide terminal, this was in a 112-column xterm)
> 
> I see, that is fixable easily.
> 
> >- why use "__d_off" etc hard-to-read types? You seem to have typedef'ed
> >  it from sector_t, but you use a harder-to-read name than the original
> >  type was. Hmm?
> 
> I am used to __d_off from elsewhere. The same reason why I use 
> __likely/__unlikely instead of likely/unlikely.
> 
> __d_off may have some little meaning --- if someone wants to run 32-bit 
> spadfs filesystem on a kernel configuration with 64-bit sector_t. But I'm 
> not sure if someone would ever want it.
> 
> >- you have a few comments, but you could have a lot more explanation,
> >  especially since not all of your names are all that self-explanatory.
> >
> >Ok, with that out of the way, let's say what I _like_ about it:
> >
> >- it's fairly small
> >
> >- the code, while having the above problems, looks generally fairly
> >  clean. The whitespace issues get partially cleared by just running
> >  "Lindent" on it, although that's not perfect either (it still indents
> >  the goto target labels too much, although it at least makes them
> >  _visible_. But it won't add empty lines to delineate sections, of
> >  course, and it doesn't add comments ;^)
> >
> >- I like a lot of the notions, and damn, small and simple are both
> >  virtues on their own.
> >
> >So if you could make the code easier to read, and were to do some
> >benchmarking to show what it's good at and what the problems are, I think
> >you'd find people looking at it. It doesn't look horrible to me.
> 
> I placed some benchmark on 
> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/benchmarks/

Why don't you test with Bonnie++?! I think we would get interesting results too
:)
something like
bonnie -u $USER -s 2048 -n 40:100k -d /path/to/mounted/test/

i think we would get interesting results!

And i think you got interesting results there!!! If 'we' have it working on
SMP it would be more interesting :)

Bruno

> 
> The main shortcoming: slow fsync. fsync on spadfs generally has to flush 
> all metadata buffers (it could be improved at least for case when file 
> size does not change --- for databases).
> 
> Mikulas
> 
> >		Linus
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
