Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280251AbRKFS5S>; Tue, 6 Nov 2001 13:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280051AbRKFS47>; Tue, 6 Nov 2001 13:56:59 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:41006 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S280015AbRKFS4u> convert rfc822-to-8bit; Tue, 6 Nov 2001 13:56:50 -0500
Message-Id: <4.3.2.7.2.20011106093248.00bea990@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 06 Nov 2001 10:56:29 -0800
To: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org,
        Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
From: Stephen Satchell <satch@concentric.net>
Subject: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
  stuff])
In-Reply-To: <20011106082501.B1588@unthought.net>
In-Reply-To: <20011105144112.Q11619@pasky.ji.cz>
 <E15zF9H-0000NL-00@wagner>
 <160MMf-1ptGtMC@fmrl05.sul.t-online.com>
 <20011104143631.B1162@pelks01.extern.uni-tuebingen.de>
 <160Nyq-2ACgt6C@fmrl07.sul.t-online.com>
 <20011104163354.C14001@unthought.net>
 <20011105144112.Q11619@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:25 AM 11/6/01 +0100, Jakob Østergaard wrote:
>It seems to me that the sysctl interface does not have any type checking,
>so if for example I want to read the jiffies counter and supply a 32-bit
>field, sysctl will happily give me the first/last 32 bits of a field that
>could as well be 64 bits (bit widths do sometimes change, even on 
>architectures
>that do not change).   How am I to know ?

This fault isn't isolated to the sysctl interface.  Look sometime at the 
ioctl and fcntl interfaces and you will see that they have the same 
problem.  The issue is that the original Unix implementation of the 
special-function interface assumed that only "ints" would be passed around, 
and the need for special interfaces outgrew that assumption.

These functions have been so abused that POSIX refuses to "standardize" 
them; instead, special APIs such as TERMIOS have been devised to put a 
fairly-well defined shell around the most needed of these interfaces.  (How 
the implementer decides to bridge the userland/kernel barrier is not part 
of the specification -- and doesn't need to be.)

The /proc API was developed to solve a specific problem.  Now, people have 
proposed and The Powers That Be have accepted extensions to the /proc 
interface as a superior way to tune the kernel, particularly from shell 
scripts, and to monitor the kernel, again from shell scripts.  It's a good 
thing, actually, in that it preserves the best of the Unix 
mentality:  don't re-invent, reuse.

What this whole discussion boils down to is people who want to tackle the 
symptoms instead of the disease.  The PROBLEM is that we have inadequate 
standards and documentation of the /proc interface in its original ASCII 
form.  The proposed solution does NOTHING to address the real problem -- 
and I understand that because too many people here are so used to using a 
hammer (code) that all problems start looking like nails.

The RIGHT tool to fix the problem is the pen, not the coding pad.  I hereby 
pick up that pen and put forth version 0.0.0.0.0.0.0.0.1 of the Rules of /Proc:

1)  IT SHOULD NOT BE PRETTY.  No tabs to line up columns.  No "progress 
bars."  No labels except as "proc comments" (see later).  No in-line labelling.

2)  All signed decimal values shall be preceded by the "+" or "-" character 
-- no exceptions.  Implementers:  this is available with *printf formats 
with the + modifier, so the cost of this rule is one character per signed 
value.

3)  All integral decimal values shall be assumed by both programs and 
humans to consist of any number of bits.  [C'mon, people, dealing with 
64-bit or 128-bit numbers is NOT HARD.  If you don't know how, 
LEARN.  bc(1) can provide hints on how to do this -- use the Source, 
Luke.]  Numbers shall contain decimal digits [0-9] only.  Zero-padding is 
allowed.

4)  All floating-point values shall contain a leading sign ("+" or "-") and 
a decimal point (US) or comma (Europe).  This rule assumes that the locale 
for the kernel can be set; if this isn't true, then a period shall be used 
to separate the integral part and the fractional part.  Floating point 
values may also contain exponents (using the *printf format %E or %G, NOT 
%e -- the exponent must be preceded by the letter "e" or "E").  The 
specification of a zero precision (which suppresses the output of the 
decimal point or comma) is prohibited.

5)  All string values matching the regular expression [!"$-+--~]* shall be 
output as they are.  Strings that do not match the above regular expression 
shall be escaped in a standard manner, using a single routine provided in 
the kernel's /proc interface to provide the proper escape sequences.  The 
output of that routine shall output standard backslash-character 
representation of standard C-language control characters, and 3-digit octal 
representation of any other character encountered.  Output of the octal 
representation may be truncated when such truncation would not cause 
confusion -- see strace(1) for examples.

6)  If you are wanting to display octal data, display it byte at a time 
with a backslash.  If you want to display hexadecimal data, use the "\x" 
introduction, but include all bits so that the using program knows how long 
the damn element is supposed to be -- NO leading -zero suppression should 
be done.  (Use the %x.xX format item in *printf, where "x" is the number of 
hexadecimal digits.)

7)  The /proc data may include comments.  Comments start when an  unescaped 
hash character "#" is seen, and end at the next newline \n.  Comments may 
appear on a line of data, and the unescaped # shall be treated as end of 
data for that line.

8)  The regular expression ^#!([A-Za-z0-9_.-]+ )*[A-Za-z0-9_.-]$ defines a 
special form of comment, which may be used to introduce header labels to an 
application.  As shown in the regular expression, each label is defined by 
the regular subexpression [A-Za-z0-9_.-]+ and are separated by a single 
space.  The final (or only) label is terminated by a newline \n.  No data 
may appear on the header comment line.  This line may only appear at the 
beginning of the /proc pseudo file, and appears only ONCE.

9) The regular expression ^#=[0-9]+$ shall be used to output a optional 
"version number" comment line  If this appears in the /proc output, it 
precedes the header comment line, and appears only ONCE.

10)  Network addresses are defined as strings, either in their name form, 
in dot quad notation for IPV4 numeric addresses, or in the numeric 
equivalent for IPV6.  Parsers can recognize the difference between a 
dot-quad IP address and a floating-point number by the presence of the 
second dot in the number.  Network information output on /proc shall not 
use the base/mask notation (123.456.789.012/255.255.255.0) and instead use 
the bit-length notation (123.456.789.012/24).

11)  IPX network addresses are a problem.  In their normal form, they are 
indistinguishable from a %F-format floating-point number with leading zeros 
(which is allowed).  Therefore the dot that usually appears in an IPX 
network number must be replaced with the hyphen or dash "-" 
character.  Parsers can then differentiate an IPX network address from a 
floating point number by noticing the embedded dash without the leading "e" 
or "E" character.  Flex handles this just fine.

-end-

This represents my first cut into a specification for the /proc interface 
to deal with some of the issues that have come up in this thread.  It's not 
going to satisfy the "performance for me at all costs, DAMMIT" people and 
it's not going to satisfy the "I like it PRETTY, DAMMIT" crowd either, but 
it would provide a means for coming up with some standard tools to deal 
with /proc, and a way to reign in the madness.

In particular, it means that a single tool could be developed to take a 
/proc file and, in userland, make it a little more pretty.  Those that 
don't like table presentations can use the source of the tool to make a 
display more to their liking.

The spec has a number of things missing.  One issue missing is how to make 
a predictable /proc subtree, so that people can find the goodies more 
easily.  Another issue is specifying how /proc can be used to set 
parameters.  (We seem to have less confusion in this area, so I didn't want 
to spend any time on this aspect of the specification.)

OK, I'm clear of the firing range, start shooting holes in it.

Stephen Satchell

