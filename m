Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVBBWLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVBBWLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVBBWLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:11:07 -0500
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:20689 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S262870AbVBBWIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:08:14 -0500
From: pageexec@freemail.hu
To: Ingo Molnar <mingo@elte.hu>
Date: Thu, 03 Feb 2005 08:08:07 +1000
MIME-Version: 1.0
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Reply-to: pageexec@freemail.hu
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Message-ID: <4201DBE7.30569.2F5D446@localhost>
In-reply-to: <20050202165151.GA1804@elte.hu>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and how do you force a program to call that function and then to execute
> your shellcode? In other words: i challenge you to show a working
> (simulated) exploit on Fedora (on the latest fc4 devel version, etc.) 
> that does that. 

i don't have any Fedora but i think i know roughly what you're doing,
if some of the stuff below wouldn't work, let me know.

> You can simulate the overflow itself so no need to find any real
> application vulnerability, but show me _working code_ (or a convincing
> description) that can call glibc's do_make_stack_executable() (or the
> 'many ways of doing this'), _and_ will end up executing your shell code
> as well.

ok, since i get to make it up, here's the exploitable application
then the exploit method (just the payload, i hope it's obvious
how it works).

------------------------------------------------------------------
int parse_something(char * field, char * user_input) {
...
    strcpy(field, user_input+maybe_some_offset);
...
}
------------------------------------------------------------------
int some_function(char * user_input, ...) {
    char field1[BUFLEN];
...
    parse_something(field1, user_input);
...
}
------------------------------------------------------------------

the stack just before the overflow looks like this:
[...]
[field1]
[other locals]
[saved EBP]
[saved EIP]
[user_input]
[...]

the overflow hits field1 and whatever is deemed necessary from
that point on. i'll do this:

[...]
[field1 and other locals replaced with shellcode]
[saved EBP replaced with anything in this case]
[saved EIP replaced with address of dl_make_stack_executable()]
[user_input left in place, i.e., overflow ends before this]
[...]

dl_make_stack_executable() will nicely return into user_input
(at which time the stack has already become executable).

as you can see in this particular case even a traditional strcpy()
based overflow can get around ascii-armor and FORTIFY_SOURCE. if the
overflow was of a different (more real-life, i'd say) nature, then
it could very well be based on memcpy() which can copy 0 bytes and has
no problems with ascii armor, or multiple overflows triggered from
the same function (think parse_something() getting called in a parser
loop) where you can compose more than one 0 byte on the stack, or
not be based on any particular C library function and then all bets
are off as to what one can/cannot do.

if there's an address pointing back into the overflowed buffer
somewhere deeper in the stack then i could have a payload like:

[...]
[shellcode]
[saved EIP replaced with the address of a suitable 'retn' insn]
[more addresses of 'retn']
[address of dl_make_stack_executable()]
[pointer (in)to the overflowed buffer (shellcode)]
[...]

(this is actually the stack layout that a recent paper analysing
ASLR used/assumed [1]). note that this particular exploit method
would be greatly mitigated by a stack layout created by SSP [2]
(meaning the local variable reordering, not the canary stuff).

i could have also replaced the saved EBP (which becomes ESP
eventually) with a suitable address (not necessarily on the stack
even) where i can find (create) the

[address of dl_make_stack_executable()]
[shellcode address]

pattern (during earlier interactions with the exploited application),
but it requires whole application memory analysis (which you can bet
any exploit writer worth his salt would do).

speaking of ASLR/randomization, all that they mean for the above is
a constant work factor (short of info leaking, of course), in the
ES case it's something like 12 bits, for PaX it's 15-16 bits (on i386).

[1] http://www.stanford.edu/~blp/papers/asrandom.pdf
[2] http://www.trl.ibm.com/projects/security/ssp/

