Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVBHVZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVBHVZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 16:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVBHVZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 16:25:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20684 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261642AbVBHVYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 16:24:17 -0500
Date: Tue, 8 Feb 2005 22:23:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050208212340.GA20800@elte.hu>
References: <42080689.15768.1B0C5E5F@localhost> <42093CC6.19006.1FC83CD0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42093CC6.19006.1FC83CD0@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* pageexec@freemail.hu <pageexec@freemail.hu> wrote:

> > but what this discussion was about was the _dl_make_stack_executable()
> > function.
> 
> the jury is still out on that one, i just don't have the time and beer
> to do the full research that a real exploit writer would do. in
> security, unless proven otherwise, we try to assume the worse case.
> and given how there's no specific uncircumventable protection measure
> in that function either, i wouldn't be surprised at all if it can be
> directly exploited.

well. It's at least not as trivial as you made it sound ;-)

> second, __libc_dlopen_mode *does* make use of said function, albeit
> not directly, but it's still the work horse (and the underyling
> (in)security problem), so to speak.

that's correct.

> > Similar 'protection' techniques can be used for __libc_dlopen_mode()
> > too, and it's being fixed.
> 
> if you mean __check_caller() and others, i have my doubts, if a symbol
> can be looked up by dlsym() then you can't assume that no real life
> app does it already (and would break if you enforced libc-only
> callers). yes, you can argue that this symbol should not have been
> visible to everyone to begin with, but it's now after the fact.

relying on internal glibc symbols has always been frowned upon. The name
can change anytime, the API can change. So no, this is not an issue.

> the bigger problem is however that you're once again fixing the
> symptoms, instead of the underlying problem - not the correct
> approach/mindset.

my position is that there is _no_ 100% solution (given the
circumstances), hence it's all a probabilistic game and about balancing
between tradeoffs.

> > (you'd be correct to point out that what cannot be 'fixed' even this way
> > are libdl.so using applications and the dlopen() symbol - for them, if
> > randomization is not enough, PaX or SELinux is the fix.)
> 
> for example apache links against libdl, so there are real life apps
> out there affected by this technique. [...]

yes. But not all hope is lost, there's a linker feature that avoids the
dlopen()ing of RWE DSOs. We've activated this and this will solve at
least the libbeecrypt-alike problems.

> [...] i don't see how SElinux entersthis picture though, it (and other
> access control mechanisms) serve a different purpose, they don't stop
> exploits of memory corruption bugs, they enforce least privilege (to
> whatever degree). [...]

well, SELinux can be helpful in limiting dlopen() access - and if a
context can do no valid dlopen() (due to SELinux restrictions) then the
stacks dont need to be made executable either.

> [...] the danger of relying on access control under Exec-Shield is
> that once an attacker can execute his own code on the target system
> (ESploit shows how), all it takes is a single exploitable kernel bug
> and he's in for good. and as the past months have shown, such bugs are
> not exactly unheard of in linux land.

so ... in what way does PaX protect against all possible types of
'arbitrary code execution', via the exploit techniques i outlined in the
previous mail?

> > such an attack needs to get 2 or 3 random values right - which,
> > considering 13-bits randomization per value is still 26-39 bits (minus
> > the constant number of bits you can get away via replication).
> 
> the maths doesn't quite work that way. what matters is not how many
> random values you have to get right, but how much entropy you have to
> get right. [...]

the example in that case was libc,heap,stack, which are independent
random variables and hence their entropy adds up. Once there's any
coupling between two addresses, only the independent bits (if any) add
up.

> i'd also add that all this number juggling becomes worthless if
> information can be leaked from the attacked task.

yes, information leaks can defeat ASLR, and it obviously affects PaX
just as much.

> so the maths under Exec-Shield would be 12+16 bits or so, if i'm not
> mistaken. [...]

that's what i said too: 13+13 [to stay simple], or 13+13+13 if the heap
is involved too.

> the paper i linked to in my first post in this thread shows you a
> technique that can find out the libc randomization without having to
> learn the stack one.
> 
> that technique is neither new nor the only one that can do this. to
> your defense, i'd held this belief 3 years ago too (i.e., that
> randomness of different areas would have to be guessed at once) but
> for some time i'm much less sure that it's a useful generic
> assumption.

if you have a fork() based daemon (e.g. httpd) that will tolerate
brute-force attacks then indeed you can 'probe' individual address
components and reduce an N*M attack to N+M.

and there are techniques against this: e.g. sshd already re-execs itself
periodically. (i'm not sure about httpd, if it doesnt then it should
too.)

> > If the stack wasnt nonexec then the attack would need to get only
> > 1 random value right. In that sense it still makes quite a difference
> > in increasing the complexity of the attack, do you agree?
> 
> based on the above explanation of what i know, i don't agree *in
> general*, it has to be rather a special case when one really has to
> guess different randomizations at once (again, unless proven
> otherwise, i'll assume the worse case).

well in the worst-case you have a big fat information leak that gives
you all the address-space details. According to this logic it makes no
sense to even think about ASLR, right? ;)

> on another note, increasing the complexity of exploits this way is not
> a good idea if you want the slightest security guarantees for your
> system. the problem is that without a crash monitoring/reaction
> mechanism one can just happily keep trying and eventually get in -
> what is the point then?

there are no guarantees whatsoever, if a C-style application gets
overflown on the stack! (except some rare, very degenerate cases)

> in the PaX strategy the reason for using randomization is that we
> can't do much (yet) against the two other classes of exploit
> techniques [...]

they are not 'two other classes of exploit techniques'. Your
categorization is a lowlevel one centered around machine code:

   (1) introduce/execute arbitrary code
   (2) execute existing code out of original program order
   (3) execute existing code in original program order with arbitrary
       data

these are variations of one and the same thing: injecting code into a
Turing machine. I'm not sure why you are handling the execution of
arbitrary code (which in your case, wants to mean 'arbitrary machine
code') in any way different from 'execute existing code out of original
program order'. A chain of libc functions put on the stack _is_ new code
for all practical purposes. And as you've mentioned it earier too, there
are 'suitable' byte patterns in alot of common binaries, which you can
slice & dice together to build something useful.

trying to put some artificial barrier between 'arbitrary machine code'
and 'arbitrary interpreted code' is just semantics, it doesnt change the
fundamental fact that all of that is arbitrary program logic, caused by
arbitrary bytes being passed in to the function stack. Attackers will
pick whichever method is easier, not whichever method is 'more native'!

> [...] plus it's a cheap measure, so 'why not'. [...]

(btw., wasting 128 MB of the x86 stack on average is all but 'cheap')

> [...] but it's not a security measure in the sense that controlling
> runtime code generation is. in other words, the security guarantee
> that PaX gives doesn't rely on randomization, [...]

the data passed into a stack overflow is, by itself, without compiler
help, 'arbitrary runtime code' in a form. You only have to find or
construct the right interpreter for it. So to talk about any 'security
guarantee' in such a scenario is pointless.

> even with crash monitoring/reaction one can only claim a
> 'probabilistic guarantee', something that's not always good enough

i claim that 'arbitrary stack overflows', without compiler help, can
only be protected against in a probabilistic way.

> > As you can see on lkml, people are resisting changes hard that
> > affect 2-3 apps. What chances do changes have that break dozens of
> > common applications?
> 
> i don't see your dilemma. having the ability to control runtime code
> generation (making it a privilege, instead of a given) [...]

so ... how do you define 'runtime code generation', and why do you
exclude non-native execution methods, precisely? I still claim it cannot
be deterministically controlled as a whole so it is of no significance
to the security guarantees of the system whether the native portion is
controlled deterministically or not. (because there are no guarantees
for this one.)

The rest of your mail centers around this contention that 'code
generation' is equivalent to 'binary machine code injection' and can
thus be controlled; so until this fundamental issue is cleared it makes
little sense to answer the other 'when did you stop beating your wife'
questions :-)

	Ingo
