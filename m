Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVBHQt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVBHQt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVBHQt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:49:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51356 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261561AbVBHQsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:48:53 -0500
Date: Tue, 8 Feb 2005 17:48:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: the "Turing Attack" (was: Sabotaged PaXtest)
Message-ID: <20050208164815.GA9903@elte.hu>
References: <42080689.15768.1B0C5E5F@localhost> <42093CC7.5086.1FC83D3E@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42093CC7.5086.1FC83D3E@localhost>
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

> > btw., do you consider PaX as a 100% sure solution against 'code
> > injection' attacks (meaning that the attacker wants to execute an
> > arbitrary piece of code, and assuming the attacked application has a
> > stack overflow)? I.e. does PaX avoid all such attacks in a guaranteed
> > way?
> 
> your question is answered in http://pax.grsecurity.net/docs/pax.txt

the problem is - your answer in that document is i believe wrong, in
subtle and less subtle ways as well. In particular, lets take a look at
the more detailed PaX description in:

 http://pax.grsecurity.net/docs/pax-future.txt

   To understand the future direction of PaX, let's summarize what we 
   achieve currently. The goal is to prevent/detect exploiting of
   software bugs that allow arbitrary read/write access to the attacked
   process. Exploiting such bugs gives the attacker three different
   levels of access into the life of the attacked process:

   (1) introduce/execute arbitrary code
   (2) execute existing code out of original program order
   (3) execute existing code in original program order with arbitrary 
       data

   Non-executable pages (NOEXEC) and mmap/mprotect restrictions 
   (MPROTECT) prevent (1) with one exception: if the attacker is able to
   create/write to a file on the target system then mmap() it into the
   attacked process then he will have effectively introduced and
   executed arbitrary code.
   [...]

the blanket statement in this last paragraph is simply wrong, as it
omits to mention a number of other ways in which "code" can be injected.

( there is no formal threat model ( == structured document defining 
  types of attacks and conditions under which they occur) described on 
  those webpages, but the above quote comes closest as a summary, wrt. 
  the topic of code injection via overflows. )

firstly, let me outline what i believe the correct threat model is that
covers all overflow-based code injection threats, in a very simplified
sentence:

  -----------------------------------------------------------------
  " the attacker wants to inject arbitrary code into a sufficiently
    capable (finite) Turing Machine on the attacked system, via
    overflows. "
  -----------------------------------------------------------------

as you can see from the formulation, this is a pretty generic model,
that covers all conceivable forms of 'code injection' attacks - which
makes it a natural choice to use. (A finite Turing Machine here is a
"state machine with memory attached and code pre-defined". I.e. a simple
CPU, memory and code.)

a number of different types of Turing Machines may exist on any given
target system:

   (1) Native Turing Machines
   (2) Intentional Turing Machines
   (3) Accidental Turing Machines
   (4) Malicious Turing Machines

each type of machine can be attacked, and the end result is always the
same: the attacker uses the capabilities of the attacked application for
his own purposes. (==injects code)

i'll first go through them one by one, in more detail. After that i'll
talk about what i see as the consequences of this threat model and how
it applies to the subject at hand, to PaX and to exec-shield.


1) Native Turing Machines
-------------------------

this is the most commonly used and attacked (but by no means exclusive)
type: machine code interpreted by a CPU.

Note: 'CPU' does not necessarily mean the _host CPU_, it could easily
mean code interpretation done by a graphics CPU or a firmware CPU.

( Note: 'machine code' does not necessarily mean that the typical
  operation mode of the host CPU is attacked: there are many CPUs that
  support multiple instruction set architectures. E.g. x86 CPUs support
  16-bit and 32-bit code as well, and x64 supports 3 modes in fact:
  64-bit, 32-bit and 16-bit code too. Depending on the type of 
  application vulnerability, an attack may want to utilize a different
  type of ISA than the most common one, to minimize the complexity
  needed to utilize the Turing Machine. )

2) Intentional Turing Machines
------------------------------

these are pretty commonly used too: "software CPUs" in essence, e.g. 
script interpreters, virtual machines and CPU emulators. There are also
forms of code which one might not recognize as a Turing Machine: parsers
of some of the more capable configuration files.

in no case must these Turing Machines be handled in any way different
from 'native binary code' - all that matters is the capabilities and
attackability of the Turing Machine, not it's implementation! (E.g. an
attack might go against a system that itself is running on an emulated
CPU - in that case the attacker is up against an 'interpreter', not a
real native CPU.)

Note that such interpreters/machines, since implemented within a binary
or library, can very often be used from within the process image via
ret2libc methods, so they are not controllable via 'access control'
means.

( Note that e.g. the sendmail.cf configuration language is a
  Turing-complete script language, with the interpreter code included in
  the sendmail binary. Someone once wrote a game of Hanoi in the
  sendmail.cf language ... )

3) Accidental Turing Machines
-----------------------------

the simplest form of Accidental Turing Machines seems purely
theoretical:

 " what if the binary code of an application happens to include a byte
   sequence in its executable code section, that if jumped to implements 
   a Turing Machine that the application writer did not intend to put
   there, that an attacker can pass arbitrary instructions to. "

This, on the face of it, seems like a ridiculous possibility as the
chances of that are reverse proportional to the number of bits necessary
to implement the simplest Turing Machine. (which for anything even
closely usable are on the order of 2^10000, less likely than the
likelyhood of us all living to the end of the Universe.)

but that chance calculation assumes that the Turing Machine is
implemented as one block of native code. What happens if the Turing
Machine is 'pieced together', from very small 'building blocks of code'?

this may still seem unlikely, but depending on the instruction format of
the native machine code, it can become possible. In particular: on CISC
CPUs with variable length instructions, the number of 'possible
instructions' is larger (and much more varied) than the number, type and
combination of actual instructions in the libraries/binaries, and the
type of instructions is very rich as well - giving more chance to the
attacker to find the right 'building blocks' for a "sufficiently capable
Turing Machine".

The most extreme modern example of CISC is x86, where 99% of all byte
values can be the beginning of a valid instruction and more than 95% of
every byte position within binary code is interpretable by the CPU
without faulting. (This means that e.g. in an 1.5 MB Linux kernel image,
there are over 800 thousand instructions - but the number of possible
instruction addresses is nearly 1.5 million.)

Furthermore, on x86, a key instruction, 'ret' is encoded via a single
byte (0xc3). This means that if a stack overflow allow arbitrary jump to
an arbitrary code address, all you have to do to 'build' a Turing
Machine is to find the right type of instruction followed by a
single-byte 'ret' instruction. A handful of operations will do to
construct one. I'm not aware of anyone having done such a machine as
proof-of-concept, but fudnamentally the 'chain of functions called'
techniques used in ret2libc exploits (also used in your example) are
amongst the basic building blocks of a 'Stack Based Turing Machine'.

Note that time works in favor of Accidental Turing Machines: the size of
application code and library code grows, so the chance to find the basic
building blocks increases as well.

also note that it's impossible to prove for a typical application that
_no_ Accidental Turing Machine can be built out of a stack overflow on
x86. So no protection measure can claim to _100%_ protect against
Accidental Turing Machines, without analysing each and every application
and making it sure that _no_ Turing Machine could ever be built out of
it!

lets go back to the PaX categorization briefly, and check it out how
they relate to Accidental Turing Machines:

   (1) introduce/execute arbitrary code
   (2) execute existing code out of original program order
   (3) execute existing code in original program order with arbitrary 
       data

#2 (or #3) can be used as the basic building for an Accidental Turing
Machine, and can be thus be turned back into #1. So #1 overlaps with 
#2, #3 and thus makes little sense in isolation - only if you restrict
the categories to cover 'native, binary machine code' - but such a
restriction would make little sense as the format and encoding of code
doesnt matter, it's the 'arbitrary programming' that must be prevented!

in fact, #2, #3 are just limited aspects of "Accidental Turing
Machines": trying to use existing code sequences in a way to form the
functionality the attacker wants.

4) Malicious Turing Machines
----------------------------

given the complexity of the x86 instruction format, a malicious attacker
could conceivably inject Turing Machine building blocks into seemingly
unrelated functions as well, hidden in innocious-looking patches. E.g.
this innocous looking code:

  #define MAGIC 0xdeadc300

  assert(data->field == MAGIC);

injects a hidden 'ret' into the code - while the application uses that
byte as a constant! Chosing the right kind of code you can inject
arbitrary building blocks without them ever having any functionality in
the original (intended) instruction stream! Since most x86-ish CPUs do
not enforce 'intended instruction boundaries', attacks like this are
possible.


Threat Analysis
---------------

the current techniques of PaX protect against the injection of code into
Native Turing Machines of the Host CPU, but PaX does not prevent code
injection into the other types of Turing Machines.

A number of common examples for Intentional Turing Machines in commonly
attacked applications: the Apache modules PHP, perl, fastcgi, python,
etc, or sendmail's sendmail.cf interpreter. Another, less known examples
of Turing Machines are interpreters within the kernel: e.g. the ACPI
interpreter. (In fact there have been a number of patches/ideas that
introduce Universal Turing Machines into the kernel, so the trend is
that the kernel will get _multiple_ Turing Machines.)

Furthermore, if there's _any_ DSO on the system that has any
implementation of a Turing Machine (either a sufficiently capable
interpreter, or any virtual machine), that is dlopen()-able by the
attacked application, then that may be used for the attack too. (Yes,
you could avoid this via access control means, but that really flouts
the problem at hand.)

Plus, even if all intentional Turing Machines are removed from the
system (try that in practice!), and an application can dlopen() random,
unrelated DSO's, it can thus still increase the chances of finding the
building blocks for an Accidental (or Malicious) Turing Machine by
dlopen()-ing them.

PaX does nothing (simply because it cannot) against most types of
Intentional, Accidental or Malicious Turing Machines. (interesting
detail: PaX doesnt fully cover all types of Native Turing Machines.)

a more benign detail: while the above techniques are all concentrated on
'process-internal' execution strategies, i consider this exclusion of
process-external execution as an arbitrary restriction of the PaX threat
model as well. 'excluding' external interpreters from the threat model
is impractically restrictive. It may be a less dangerous attack for some
threats (because it most likely wont run under the same high privileges
as the attacked app), but it's still a dangerous category that should be
considered in companion to "process internal" attacks.


Conclusion
----------

arbitrary-write attacks against the native function stack, on x86,
cannot be protected against in a sure way, after the fact. Neither PaX,
nor exec-shield can do it - and in that sense PaX's "we solved this
problem" stance is more dangerous because it creates a false sense of
security. With exec-shield you at least know that there are limitations
and tradeoffs.

some of the overflows can be protected against 'before the fact' - in
gcc and glibc in particular. You've too mentioned FORTIFY_SOURCE before
(an upcoming feature of Fedora Core 4), and much more can be done. Also,
type-safe languages are much more robust against such types of bugs.

So i consider PaX and exec-shield conceptually equivalent in the grand
scheme of code injection attacks: none of them 'solves' the (unsolvable)
problem in a 100% way, none of them 'guarantees' anything about security
(other than irrelevant special cases), but both try to implement
defenses, with a different achieved threshold of 'required minimum
complexity of an attack to succeed'. To repeat: 100% protection against
code injection cannot be achieved.

The intentional tradeoffs exec-shield has have been discussed in great
detail, and while i give you the benefit of doubt (and myself the
possibility of flawed thinking), it might now as well be the right time
for you to double-check your own thinking wrt. PaX? And you should at
minimum accurately document that PaX is only trying to deal with
injection of native binary code, and that there are a number of other
ways to inject external code into an application.

	Ingo
