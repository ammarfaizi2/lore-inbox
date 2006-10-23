Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWJWPS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWJWPS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWJWPS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:18:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55491 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964926AbWJWPSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:18:25 -0400
Date: Mon, 23 Oct 2006 08:17:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: teunis <teunis@wintersgift.com>, xboom <art@usfltd.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc2-git7 shutdown problem
In-Reply-To: <453C2903.1060906@wintersgift.com>
Message-ID: <Pine.LNX.4.64.0610230755010.3962@g5.osdl.org>
References: <20061022145210.n736g78k42e8ggkg@69.222.0.225>
 <Pine.LNX.4.64.0610221356440.3962@g5.osdl.org> <453C2903.1060906@wintersgift.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Oct 2006, teunis wrote:
> Hash: SHA1
> 
> Linus Torvalds wrote:
> > 
> > On Sun, 22 Oct 2006, art@usfltd.com wrote:
> >> 2.6.19-rc2-git7 shutdown problem
> >>
> >> below are last shutdown messages - system is hunging forever !
> >> hda was mounted, hdb not
> >> any clue ?
> > 
> > Noting springs to mind immediately.
> > 
> > Can you narrow this down more specifically? Did you test 2.6.19-rc2-git6, 
> > and that was fine? Or did you just happen to test -git7, and the previous 
> > kernel you did this on was some much older one?
> 
> I'm seeing the same thing here between rc2-git6 and rc2-mm2 on intel
> 945-based hardware and similar.   (rc2-git6 WORKS, rc2-mm2 FAILS)
> rc2-git6: for the most part works fine.
> rc2-mm2: Restart works - shutdown freezes.

Ok, it would be nice if you can verify that -git7 breaks for you too, but 
considering the identical symptoms, I think we can take it for granted 
that the breakage happened between 2.6.19-rc2-git6 and -git7.

In git terms, according to the snapshot ID translations, that would be:

	-git6: 7b7fc708b568a258595e1fa911b930a75ac07b48
	-git7: 5cfc35cf79d46af998346e3d5cc66fa344d1af0e

and indeed, looking at "gitk 7b7fc708..5cfc35cf", that includes both the 
x86 and IDE merges.

I would expect that it's the IDE code updates (based on the fact that it 
_apparetly_ freezes at or just after flushing the second IDE device), but 
it could certainly be some of the x86 architecture changes too.

Now, if somebody who sees this has git installed, or just wants to try it 
out and never had the reason to do so before, you can help narrow it down 
with "git bisect" if you want to. I'm betting just one or two reboots 
would narrow it down to IDE or arch changes, and since there are just 75 
commits total in that range, six or seven reboots will show exactly which 
commit it is.

So to bisect, do

	git bisect start
	git bisect good 7b7fc708b568a258595e1fa911b930a75ac07b48
	git bisect bad 5cfc35cf79d46af998346e3d5cc66fa344d1af0e

and off you go, marking things "good" or "bad" depending on whether the 
thing had problems at shutdown (at all points, "git bisect visualize" will 
show you what is left to be considered..).

Sadly, because the problem happens at shutdown, you'd need to reboot twice 
for each kernel: first to boot into it, then shutdown to test, and then 
mark it good/bad based on that.

But maybe Jeff or Andi can make a guess for a single patch already to try 
to revert..

Jeff, Andi: the symptom as reported by xboom <art@usfltd.com> is that the 
system locks up at shutdown after this:

	...
	Unmounting pipe file systems:
	Unmounting file systems:
	Halting system...
	md: stopping all md devices.
	Shutdown: hdb
	Shutdown: hda

Any ideas?

Final note: it doesn't _have_ to be x86/IDE changes. There are other 
things there that just sound less likely: the wireless networking merge, 
and a small patch-series through Andrew. So if somebody doesn't 
immediately step up, a few reboots with the "git bisect" thing really 
would help.

			Linus
