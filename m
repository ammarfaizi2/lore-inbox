Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318706AbSHEQRO>; Mon, 5 Aug 2002 12:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318671AbSHEQRO>; Mon, 5 Aug 2002 12:17:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25092 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318706AbSHEQQO>; Mon, 5 Aug 2002 12:16:14 -0400
Date: Mon, 5 Aug 2002 09:19:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user
 mode linux]
In-Reply-To: <p73ado1k8ef.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0208050910420.1753-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Aug 2002, Andi Kleen wrote:
> 
> I think the possibility at least for memcpy is rather remote. Any sane
> SSE memcpy would only kick in for really big arguments (for small
> memcpys it doesn't make any sense at all because of the context save/possible
> reformatting penalty overhead). So only people doing really
> big memcpys could be possibly hurt, and that is rather unlikely.

And this is why the kernel _has_ to save the FP state.

It's the "only happens in a blue moon" bugs that are the absolute _worst_ 
bugs. I want to optimize the kernel until I'm blue in the face, but the 
kernel must NEVER EVER have a "non-stable" interface.

Signal handlers that don't restore state are hard as _hell_ to debug. Most 
of the time it doesn't really matter (unless the lack of restore is 
something really major like one of the most common integer registers), but 
then depending on what libraries you use, and just _exactly_ when the 
signal comes in, you get subtle data corruption that may not show up until 
much later.

At which point your programmer wonders if he mistakenly wandered into 
MS-Windows land.

No thank you. I'll take slow signal handlers over ones that _sometimes_ 
don't work.

> After all Linux should give you enough rope to shot yourself in the foot ;)

On purpose, yes. It's ok to take careful aim, and say "I'm now shooting 
myself in the foot".

And yes, it's also ok to say "I don't know what I'm doing, so I may be
shooting myself in the foot" (this is obviously the most common
foot-shooter).

And if you come to me and complain about how drunk you were, and how you 
shot yourself in the foot by mistake due to that, I'll just ignore you.

BUT - and this is a big BUT - if you are doing everything right, and you 
actually know what you're doing, and you end up shooting yourself in the 
foot because the kernel was taking a shortcut, then I think the kernel is 
_wrong_.

And I'd rather have a slow kernel that does things right, than a fast 
kernel which screws with people.

> In theory you could do a superhack: put the FP context into an unmapped
> page on the stack and only save with lazy FPU or access to the unmapped
> page. 

That would be extremely interesting especially with signal handlers that 
do a longjmp() thing.

The real fix for a lot of programs on x86 would be for them to never ever 
use FP in the first place, in which case the kernel would be able to just 
not save and restore it at all.

However, glibc fiddles with the fpu at startup, even for non-FP programs. 
Dunno what to do about that.

		Linus

