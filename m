Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbVA2Gba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbVA2Gba (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 01:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVA2Gba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 01:31:30 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:34693 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262866AbVA2GbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 01:31:08 -0500
Message-ID: <41FB2DD2.1070405@comcast.net>
Date: Sat, 29 Jan 2005 01:31:46 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net>  <1106848051.5624.110.camel@laptopd505.fenrus.org>  <41F92D2B.4090302@comcast.net>  <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>  <41F95F79.6080904@comcast.net> <1106862801.5624.145.camel@laptopd505.fenrus.org> <41F96C7D.9000506@comcast.net> <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Rik van Riel wrote:
> On Thu, 27 Jan 2005, John Richard Moser wrote:
> 
>> Arjan van de Ven wrote:
> 
> 
>>>> Is this one any worse?
>>>
>>> yes.
>>>
>>> oracle, db2 and similar like to mmap 2Gb or more *in one chunk*.
>>
>>
>> Special case?
> 
> 
> Absolutely, but ...
> 
>> Can I get this put into perspective?  How much more important is "Good"
>> randomization versus "not breaking Oracle," which becomes "No
>> randomization"
> 
> 
> 1) quite a lot of Linux users do use Oracle, DB2 or do
>    scientific calculations - distributions cannot afford
>    to break those applications, the default has to work
>    for everybody
> 

So package oracle marked to not use the randomization.

> 2) "weaker" randomization (2MB) is still effective if the
>    stack is non-executable, so the "load a bunch of NOPs"
>    approach won't work - this is what Fedora and RHEL use
> 

"In some cases, this does nothing, so we'll leverage those cases as an
argument for why this should go in, even though we're effectively saying
'please add useless junk to the kernel'"

No dear, please, real ASLR has a point, try not to castrate it.

> 3) it is not as theoretically strong as what you propose,
>    but having the "weaker" scheme enabled is definitely
>    more secure than having the "stronger" scheme disabled
>    because it breaks applications
> 

*takes the glass pipe away*


Well, I'm going to give random constructive criticism on red hat as a
whole now, so try learning something from it instead of taking it as
flamebait.  I just ate and feel particularly like talking for no reason
about half-relavent topics.

I actually just tried to paxtest a fresh Fedora Core 3, unadultered,
that I installed, and it FAILED every test.  After a while, spender
reminded me about PT_GNU_STACK.  It failed everything but the Executable
Stack test after execstack -c *.  The randomization tests gave
13(heap-etexec), 16(heap-etdyn), 17(stack), and none for main exec
(etexec,et_dyn) or shared library randomization.

Also, before you say it, I read, comprehended, and anylized the source.
 This was PaXtest 0.9.6, and I did specific traces (after changing
body.c to prevent it from forking) to look for mprotect() and mmap()
calls and find out what they do (I saw probably glibc getting mmap()ed
in, there wasn't anything in the source doing the mmap() calls I saw).
There were no dirty tricks to mprotect() a high area of memory, which is
something Ingo called foul on in 0.9.5.

My point isn't that ES failed (the above discourse was to preempt Ingo
calling a technical foul on paxtest again); but that I forgot about
PT_GNU_STACK.  How many vendors are going to forget about PT_GNU_STACK
and its automatic markings and think they're protected?  Do they even
know/care?  "it works so we'll just keep doing what we're doing, if we
break the protection it'll adjust to let us" is pretty good strategy to
a lot of people who don't want to be assed with your security crap.

Another concern of mine, execstack gives X for PT_GNU_STACK and - for
cleared PT_GNU_STACK.  With many binaries i get shipped (flash and java
plug-ins), there's a ? when I check them, so I clear the flag and they
work.  Note that I'm referring to the Java PLUG-IN, not the JRE itself;
you can have full PaX restrictions on Firefox and have working Java in
Firefox, because java_vm is a separate process :) (you have to chpax
java itself).  Firefox happens to be a high-risk application too IMHO
(it's pointed at the net and exposes Gecko bugs for HTML and Javascript
parsing, libjpeg and libpng bugs, and God knows what else), and I don't
want it accidentally getting an executable stack.

Finally, although an NX stack is nice, you should probably take into
account IBM's stack smash protector, ProPolice.  Any attack that can
evade SSP reliably can evade an NX stack; but ProPolice protects from
other overflows.  Now I'm sure RH is over there inventing something that
detects buffer overflows at compile time and misses or warns about the
ones it can't identify:

if (strlen(a) > 4)
  a[5] = '\0';
foo(a);

void foo(char *a) {
   char b[5];
   strcpy(b,a);
}

This code is safe, but you can't tell from looking at foo().  You don't
get a look at every other object being compiled against this one that
may call foo() either.  So compile time buffer overflow detection is a
best-effort at best.

ProPolice protects local variables with 0 overhead; passed arguments
with a few instructions; and the return pointer and stack frame pointer
with a couple instructions.  At runtime.  Want to impress me?  Actually
deploy ProPolice instead of showing up 3 years from now waving around
your own patch that you wrote that half-impliments half of it.  If you
want "something better," it's GPL, so grab it and start hacking.

Anyway, that's my far-far-far offtopic rant for the day.
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+y3RhDd4aOud5P8RAofVAJ9ulaCZmV9rzQTkSNEgbjOG9VD7xACfXSfF
JJlZyXVYtwXTFMotQm3YrV0=
=hrWP
-----END PGP SIGNATURE-----
