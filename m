Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbVARBUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbVARBUC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVARBTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:19:53 -0500
Received: from mail.dif.dk ([193.138.115.101]:33975 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262879AbVARBSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:18:02 -0500
Date: Tue, 18 Jan 2005 02:20:50 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ian Molton <spyro@f2s.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>, Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       "David S. Miller" <davem@davemloft.net>,
       "William L. Irwin" <wli@holomorphy.com>,
       Richard Henderson <rth@twiddle.net>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Paul Mackerras <paulus@au.ibm.com>, Tony Luck <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH 00/11] Get rid of verify_area() - convert to access_ok() and
 deprecate.
Message-ID: <Pine.LNX.4.61.0501172342240.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a series of patches to convert all (or rather almost all) in-kernel 
users of verify_area() to access_ok(), and then deprecate verify_area().

Up front note: This is just a cleanup and not something that deserves high 
priority - don't let it steal your time away from more important stuff. 
(long CC lists make me nervous - can you tell? ;)


How are the patches/mails split?
-----
00 - this overview, no patch in this mail.
01 - most of i386 + misc bits that affect my own kernel (best tested).
02 - rest of i386 + misc part 2 from kernel/ etc.
03 - everything in sound/.
04 - drivers part 1, approximately first half of drivers/.
05 - drivers part 2, approximately second half of drivers/.
06 - arch/mips/.
07 - arch/sparc/ and arch/sparc64/.
08 - arch/x86_64/ and arch/ia64/.
09 - arch/ppc/, arch/ppc64/, arch/m68k/, arch/m68knommu/.
10 - the bits for the remaining archs.
11 - the changes needed in include/ to deprecate verify_area().


Why these patches?
-----
1) verify_area has been obsolete for quite a while. It was 
commented in the source as being obsolete 23 months ago. The replacement 
function is access_ok. It's about time it dies.
2) verify_area is just a wrapper around verify_area (or equivalent) on all 
archs - it's just a waste of space.


Why split in 11 chunks and not more or less?
-----
Andrew Morton commented on my first email which proposed to do this 
cleanup by deprecating first, and said that it would be preferred to 
submit first all the cleanups in something like 10 big patches, then 
deprecate. So that is the reason they are in fairly large chunks.


What has been tested and what is untested?
-----
I don't have hardware to test all archs, nor do I have hardware to test 
all drivers. I also don't have cross compilers to try and build different 
archs on my i386 (Athlon) box. So, all I can test on is a single x86 box.
To test as much as possible I have made the first patch in the series 
contain the files that are included in the kernel I normally build for my 
own workstation - so the changes in there are compile tested and boot 
tested. I've also done a full "allyesconfig" and "allmodconfig" build of a 
kernel with all the patches applied to weed out new warnings or errors 
that my patches might have introduced.
Anything outside of that is not tested except for the fact that I've tried 
to be very careful that whatever code I've replaced has identical 
functionality to the original - but, that's just visual inspection.
Luckily converting from verify_area() to access_ok() is pretty simple, so 
I hope there are no brown paper bag bugs in there, but I can't rule it 
out 100% so a review is certainly needed (and appreciated).


What's left to do?
-----
There are still some comments and other textual references to verify_area 
left. Those need to be changed, but that can happen after these patches 
are merged.
There is still at least one macro still using verify_area - I haven't 
changed that one yet, simply becourse the macro name should probably be 
changed at the same time and I didn't want to make that kind of changes 
intermixed with the plain conversions. I think I've otherwise caught all 
users of verify_area but it is possible I may have missed some.
There are several functions named something similar to 
foobar_verify_area() - such functions should probably be renamed 
foobar_access_ok() or similar, but again such changes will come in 
sepperate patches after these are merged to not mix things up.


Other notes:
-----
I've attempted to make the changes as readable as possible, and in a lot 
of cases I think the readability has improved, but there are a few odd 
corners where the changes are not the most pretty I could make them but 
where I chose to make them as similar to the original as possible for the 
sake of not breaking in-file style too much or to avoid having to make 
too many not "really related to the task at hand" changes.

The final patch deprecates verify_area() instead of removing it. The 
reasons for that is A) I may have missed some in-kernel user. B) there are 
probably out-of-tree modules using the function. So, let's deprecate it 
for a few releases (wouldn't one or two be enough for something as trivial 
as this?) to give external users a chance to move to access_ok() and clean 
up the last few in-tree bits still left to do - /then/ it can be killed 
off completely.

To try and not mailbomb too many people with changes they are not 
interrested in (since these patches cover a large part of the tree) I'm 
not CC'ing all the patches to the various maintainers and special-purpose 
lists. I've tried to include the relevant maintainers in CC on this 
initial mail, but the mails with the actual patches will go only to LKML 
and CC Andrew (in the hope that they can get into -mm). If somebody wants 
me to mail them a copy of one or more of the patches directly, then please 
just let me know and I'll send it.

A lot of people have commented on my first initial attempts at this 
cleanup. I want to thank all of you for that, your feedback has been 
valuable and has hopefully led to these patches being free of the 
embarrassing bugs that plagued the first versions. Thank you!

As always, comments are very welcome.


-- 
Jesper Juhl


