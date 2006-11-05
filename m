Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965769AbWKEAxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965769AbWKEAxH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 19:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965768AbWKEAxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 19:53:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44265 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965766AbWKEAxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 19:53:03 -0500
Date: Sat, 4 Nov 2006 16:52:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.64.0611041633110.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Nov 2006, Mikulas Patocka wrote:
> 
> As my PhD thesis, I am designing and writing a filesystem, and it's now in a
> state that it can be released. You can download it from
> http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/

Ok, not having actually tested any of this, I only have a few comments on 
the source code:

 - the source tree layout is very confusing. Can you please separate the 
   mkfs/fsck parts more clearly from the kernel driver parts?

 - you have a _very_ confusing usage of upper-case. Not only are a lot of 
   functions upper-case, some filenames are also upper-case. What would 
   otherwise be more readable just ends up being hard to read because it's 
   so odd and unexpected.

   I'm sure there is some logic to it, but it escapes me.

 - your whitespace usage needs some work: please put empty lines between 
   the declarations and the code in a function, and since you use a fair 
   amount of "goto"s, please do NOT indent them into the code (it's almost 
   impossible to pick out the target labels because you hide them with the 
   code).

 - your whitespace, part 2: you have a fair number of one-liner 
   if-statements, where again there is no indentation, and thus the flow 
   is almost impossible to see. Don't wrote

	if (somecomplexconditional) return;

   but please instead write

	if (somecomplexcondifional)
		return;

   and perhaps use a few more empty lines to separate out the "paragraphs" 
   of code (the same way you write email - nobody wants to see one solid 
   block of code, you'd prefer to see "logical sections"). 

   Here's a prime example of what NOT to do:

	if (__likely(!(((*c)[1] - 1) & (*c)[1]))) (*c)[0] = key;

   I dare anybody to be able to read that. That wasn't even the worst one: 
   some of those if-statements were so long that you couldn't even _see_ 
   what the statement inside the if-statement even was (and I don't use a 
   80-column wide terminal, this was in a 112-column xterm)

 - why use "__d_off" etc hard-to-read types? You seem to have typedef'ed 
   it from sector_t, but you use a harder-to-read name than the original 
   type was. Hmm? 

 - you have a few comments, but you could have a lot more explanation, 
   especially since not all of your names are all that self-explanatory.

Ok, with that out of the way, let's say what I _like_ about it:

 - it's fairly small

 - the code, while having the above problems, looks generally fairly 
   clean. The whitespace issues get partially cleared by just running 
   "Lindent" on it, although that's not perfect either (it still indents 
   the goto target labels too much, although it at least makes them 
   _visible_. But it won't add empty lines to delineate sections, of 
   course, and it doesn't add comments ;^)

 - I like a lot of the notions, and damn, small and simple are both 
   virtues on their own.

So if you could make the code easier to read, and were to do some 
benchmarking to show what it's good at and what the problems are, I think 
you'd find people looking at it. It doesn't look horrible to me.

		Linus
