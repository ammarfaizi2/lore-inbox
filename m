Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVBHM3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVBHM3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 07:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVBHM3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 07:29:19 -0500
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:53227 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S261524AbVBHM1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 07:27:41 -0500
From: pageexec@freemail.hu
To: Ingo Molnar <mingo@elte.hu>
Date: Tue, 08 Feb 2005 22:27:18 +1000
MIME-Version: 1.0
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Reply-to: pageexec@freemail.hu
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Message-ID: <42093CC6.19006.1FC83CD0@localhost>
In-reply-to: <20050207210809.GA9781@elte.hu>
References: <42080689.15768.1B0C5E5F@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yes, i agree with you, __libc_dlopen_mode() is an easier target (but not
> _that_ easy of a target, see further down), and your code looks right

actually, line 25 is crap (talk about 'coding while intoxicated' ;-),
it should be 'if (dlerror())' of course. also, you should really try
to run the code as it exposes a bug in your handling of PT_GNU_STACK
and RELRO and dlopen(), at least i ran into it on my system and a user
reported it under FC3 too (hint: '__stack_prot attribute_relro' is not
such a great idea).

> but what this discussion was about was the _dl_make_stack_executable()
> function.

the jury is still out on that one, i just don't have the time and beer
to do the full research that a real exploit writer would do. in security,
unless proven otherwise, we try to assume the worse case. and given how
there's no specific uncircumventable protection measure in that function
either, i wouldn't be surprised at all if it can be directly exploited.

second, __libc_dlopen_mode *does* make use of said function, albeit not
directly, but it's still the work horse (and the underyling (in)security
problem), so to speak.

> Similar 'protection' techniques can be used for __libc_dlopen_mode()
> too, and it's being fixed.

if you mean __check_caller() and others, i have my doubts, if a symbol
can be looked up by dlsym() then you can't assume that no real life app
does it already (and would break if you enforced libc-only callers).
yes, you can argue that this symbol should not have been visible to
everyone to begin with, but it's now after the fact.

the bigger problem is however that you're once again fixing the symptoms,
instead of the underlying problem - not the correct approach/mindset.

also consider that __check_caller() and the other 'security' techniques
you put into Fedora are all trivially breakable in an memcpy() or similar
overflow (this whole exercise here was about showing how even string
based overflows can still be exploited).

> (you'd be correct to point out that what cannot be 'fixed' even this way
> are libdl.so using applications and the dlopen() symbol - for them, if
> randomization is not enough, PaX or SELinux is the fix.)

for example apache links against libdl, so there are real life apps out
there affected by this technique. i don't see how SElinux enters this
picture though, it (and other access control mechanisms) serve a
different purpose, they don't stop exploits of memory corruption bugs,
they enforce least privilege (to whatever degree). the danger of relying
on access control under Exec-Shield is that once an attacker can execute
his own code on the target system (ESploit shows how), all it takes is
a single exploitable kernel bug and he's in for good. and as the past
months have shown, such bugs are not exactly unheard of in linux land.

> such an attack needs to get 2 or 3 random values right - which,
> considering 13-bits randomization per value is still 26-39 bits (minus
> the constant number of bits you can get away via replication).

the maths doesn't quite work that way. what matters is not how many
random values you have to get right, but how much entropy you have to
get right. the difference is that if two random values have the same
entropy (e.g., they have a constant difference or are derived from the
same randomness at least, something an attacker can observe on a test
system) then that's only one randomness to guess, not two. in my
example exploit payload we have one random value from libc and a few
on the stack - the latter share the entropy. this should also explain
why PaX doesn't bother with individual library randomization and why
your recent submission into -mm is missing the target (not to mention
implementation issues), it's just a waste of entropy when an exploit
doesn't need more than one library (and as ESploit shows, it doesn't).
i'd also add that all this number juggling becomes worthless if
information can be leaked from the attacked task.

so the maths under Exec-Shield would be 12+16 bits or so, if i'm not
mistaken. whether that actually means 12+16=28 or log2(2^12+2^16)~=16
depends on whether an attacker has to learn (guess) them together at
once, or can learn them individually.

the paper i linked to in my first post in this thread shows you a
technique that can find out the libc randomization without having to
learn the stack one.

that technique is neither new nor the only one that can do this. to your
defense, i'd held this belief 3 years ago too (i.e., that randomness
of different areas would have to be guessed at once) but for some time
i'm much less sure that it's a useful generic assumption.

> If the stack wasnt nonexec then the attack would need to get only
> 1 random value right. In that sense it still makes quite a difference
> in increasing the complexity of the attack, do you agree?

based on the above explanation of what i know, i don't agree *in general*,
it has to be rather a special case when one really has to guess different
randomizations at once (again, unless proven otherwise, i'll assume the
worse case).

on another note, increasing the complexity of exploits this way is not
a good idea if you want the slightest security guarantees for your
system. the problem is that without a crash monitoring/reaction
mechanism one can just happily keep trying and eventually get in - what
is the point then?

in the PaX strategy the reason for using randomization is that we can't
do much (yet) against the two other classes of exploit techniques plus
it's a cheap measure, so 'why not'. but it's not a security measure in
the sense that controlling runtime code generation is. in other words,
the security guarantee that PaX gives doesn't rely on randomization,
while you seem to be putting too much faith into it when discussing the
value provided by Exec-Shield.

even with crash monitoring/reaction one can only claim a 'probabilistic 
guarantee', something that's not always good enough (it's may be ok on
a client system where you protect say a web browser but it's less useful
on servers because of service level constraints).

> Yes, the drastic method is to disable the adding of code to a process
> image altogether (PaX did this first, and does a nice job in that, and
> SELinux is catching up as well), but that clearly was not a product
> option when PT_GNU_STACK was written. 

again, SElinux doesn't do memory protection per se, it has to be (and
is) a VM subsystem thing. what they did recently is rounding out the
memory protection facilites of the VM by adding access control for
executable mappings.

we've done all this in grsecurity for something like 4 years now and in 
Hardened Gentoo we've had SElinux working with PaX for a year, similar
for RSBAC.

> As you can see on lkml, people are resisting changes hard that
> affect 2-3 apps. What chances do changes have that break dozens of
> common applications?

i don't see your dilemma. having the ability to control runtime code
generation (making it a privilege, instead of a given) is orthogonal to
its deployment strategy (that mostly comes down to 'default on' or
'default off'). i don't think the kernel should have the policy for the
latter, it's better left for users/distros. the kernel should however
provide the means to implement policies that restrict runtime code
generation. in my opinion anyway.

as a distro, you can make it 'default off' and you're set for backwards
compatibility while giving users at least the option to begin using the
extra security measures. then work on your distro to be able to enable
the restrictions on more and more apps or to be able to run with
'default on' (and/or have a 'hardened' version that does the latter
from the beginning). in the PaX world we have Adamantix and Hardened
Gentoo that run with 'default on'. you also seem to have been following
this strategy with SElinux, i don't see why it wouldn't work with other
security measures then.

now if you try the 'default on' approach then you'll actually break apps.
in my experience, they come in these flavours:

- apps that need to generate code at runtime but do so without asking
  for the right memory permissions, e.g., libjvm.so having code in .data.
  as Linus also said in another thread lately, they're broken and should
  be fixed. problem is of course 3rd party/binary stuff that cannot be
  fixed just like that.

- apps that generate code at runtime but don't really need to. think of
  nested function trampolines, the XFree86 ELF loader, etc. these apps
  are arguably 'broken', from my point of view they're carelessly
  written as they need more privileges than what is really necessary.
  for the past few years i've tried to help various projects to
  eliminate these problems, but there's always more work to do...

- apps that by their nature want/need to generate code at runtime. think
  VMs/JIT engines, etc. they of course cannot be 'fixed' as they're not
  broken per se. rather, they have to be allowed to generate code at
  runtime, and in as secure a way as possible.

to solve all these problems one needs at least a system that can grant
this privilege on a per app basis. the PaX solution is the PT_PAX_FLAGS
ELF program header and the access control system hooks. PT_GNU_STACK
doesn't solve these problems, i explained in your bugzilla why that is.

now imagine if i had added support for PT_GNU_STACK in PaX, i would have
opened up a true backdoor that every exploit writer with half a brain
could have abused to break PaX a la ESploit.

> PT_GNU_STACK is not perfect,

that's quite an understatement Ingo, if you want my uncensored opinion,
it's utter crap. it would be nice if you guys actually responded to my
claims in your bugzilla instead of remaining silent or trying to explain
it away in generic terms as above. your work affects the whole linux
world and they deserve to know. and on a personal note, it's getting
really tiring to scan latest 2.6.x for patches i have to revert or work
around in PaX.

> but it was the maximum we could get away on the non-selinux side of
> the distribution, mapping many of the dependencies and assumptions
> of apps.

you weren't even trying to solve the right problem, no wonder you came
up with something as broken as PT_GNU_STACK. the problem, once again, for
those not bothering to read your bugzilla, is not whether an app wants
an executable stack or not, it's about the privilege of runtime code
generation. it affects the stack just as much as it does the heap, anon
mappings, .data/.bss, whatever.

now you can argue that this ability should not be a privilege, then it's
fine, we're just solving completely different security issues (which is
probably not the case as your work claims to protect against the same
exploits that PaX does).
 
> So PT_GNU_STACK is certainly a beginning, and as the end result
> (hopefully soon) we can do away with libraries having any RWE
> PT_GNU_STACK markings (so that only binaries can carry RWE) and can
> move make_stacks_executable() from libc.so.

i'd like to see how that will solve the problem when an app uses dlopen()
to open a library that uses nested function trampolines. i hope you're
not suggesting that you'll be able to rewrite the whole world and get
rid of such libraries (which, however a noble goal, is impossible). and
if it will take 5+ months for each such case, i see only bad news for
Fedora.

once again, you believe that by trying to handle the symptoms, the
underlying disease will go away. it won't, but for my part i'll stop
contributing more exploit techniques here, it apparently is a pointless
exercise.

> You seem to consider these steps of how Fedora 'morphs' into a
> productized version of SELinux as 'fully vulnerable' (and despise it),

you again bring up SElinux, i can't fathom how it has anything to do with
what i said about Exec-Shield, PT_GNU_STACK and related issues. if i have
a problem then it's about your (you and your colleagues) whole attitude
and approach to security. read again this response you gave me and tell
me where you addressed a *single* technical issue i raised here or in
your bugzilla. see the problem? do you understand that PT_GNU_STACK is
broken by *design* (or rather, its lack thereof)? is there noone among
the PT_GNU_STACK creators who has anything to say about my claims? all
agree? or disagree? have you got any arguments we can discuss?

> there's no way around walking that walk and persuading users to
> actually follow - which is the hardest part.

what's even harder is making you understand that what you are giving
your users and customers is false claims and sense of security. and i
still haven't heard from you guys on the paxtest 'sabotage'.

