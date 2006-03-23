Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWCWRNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWCWRNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWCWRNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:13:17 -0500
Received: from box.punkt.pl ([217.8.180.66]:62189 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S1751074AbWCWRNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:13:16 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: llh-announce@lists.pld-linux.org
Subject: State of userland headers
Date: Thu, 23 Mar 2006 18:11:26 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, dank@kegel.com, gcoady@gmail.com,
       nkukard@lbsd.net, vmiklos@frugalware.org, rseretny@paypc.com,
       lkml@dervishd.net, rob@landley.net, jbailey@ubuntu.com,
       llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl>
In-Reply-To: <200603141619.36609.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200603231811.26546.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm CCing everyone who mailed me during the past week and a half)

When I first created llh, it was a couple of weeks before 2.6.0 came out. I
had a need for those headers, since a new version of PLD distro was supposed
to be based on 2.6 kernels and one couldn't even build glibc with the
internal headers of the last 2.5 kernels (I assume the breakage occurred a
lot earlier, though).

And just because I quit, doesn't make the problem go away for my distro.
Worse, currently also a couple of other projects depend on llh (LFS and
uclibc are the first to come to my mind), so one way or the other, someone's
eventually got to do something about it. And I did get a couple of offers to
take over.

So here's how it goes.

LLH as it is is not and never will be mergable into mainline kernel. For a
simple reason -- it's a piece of total crap (poetically called a hack). There
are some nicely polished parts, mostly the core 'infrastructure' (endianness
support, basic data types, etc.), but the rest are mostly my best guesses at
'whether this looks like a userland header', and I can't even call them
educated guesses, since I simply have no clue about kernel internals. Plus
count in the various bad calls I've made during those two years.

So on one side we've got a barely working hack, that is not mergable, a royal
pita to maintain and gets harder to update with each kernel version. If
anyone wants to take a stab at it, then be my guest, I can tell you how I've
done it, but since we've got at least a couple of people directly interested
in this thing, I do believe it'd be a good idea to try to do it The Right
Way.

There was a thread on lkml on this topic about a year ago. IIRC I've
suggested, that the best option would be to get a new set of dirs somewhere
inside the kernel, and gradually export the userland usable stuff from the
kernel headers, so to (a) achieve full separation and (b) avoid duplication
of definitions (meaning that kernel headers would simply include the userland
ones where required). Linus said, that it would break stuff and so is
unacceptable.

Unfortunately I must agree with him -- I don't think it is possible to
completely avoid duplication of definitions and all tries would lead to
breakage of some obscure configurations -- kernel headers sometimes
require various magic that should be avoided inside the userland headers
at all cost. This means that initially the llh-ng project would need to
start as a completely separate entity that would not require the
original kernel headers for anything, and only later, after achieving
some level of maturity and getting merged into the kernel, would come
the time for removing some duplication. Of course that means that kernel
hackers would (a) need to keep in mind that they have two places to
update, (b) once llh-ng got merged, figure out where duplication can be
avoided and do something about it and (c) even when that'd get done,
still remember about double updates for places where duplication
couldn't have been avoided.

I won't be loosing any sleep about it, though. Those mean kernel hackers
never cared about us poor userland folks, so there's no reason we should
feel sorry for them. Payback time.

And now for some technical details on how I see it. I'd appreciate any input.

First thing, is that we'd probably need to use a distributed rcs, since it's
more flexible, and, well, distributed. Never used any, so git sounds as good
an option, as anything else.

Now, what I propose we do initially, is get a bunch of headers from current
llh for the most popular archs and figure out how to build all the various
*libcs against them. And of course update them to the newest kernel by the
way.

It'd probably be best if I did it. PLD has support for x86, x86_64, sparc, ppc
and alpha, so that's what I'd take care of first. It might sound like a good
idea to start with all available archs, but in reality we wouldn't even be
able to test them most of the times, so it's best to stick with the
archs we're directly interested in. They should be enough to get the
'design' of the thing right. And should anyone come by with a new arch
he's interested in, he'd have a quick time adding it, since the
foundations would already be there.

And here's where the first problem arises -- llh were so great
initially, because they removed a lot of conflicts with glibc, by simply
removing 'offending' linux headers and including the glibc counterparts
(eg. linux/socket.h would do nothing else, than include sys/socket.h).
Glibc's known for having lots of stuff simply 'hardcoded' into it's own
set of headers, and more often than not, people do need to include
headers from both places. I don't know about uclibc, but klibc afaik
expects a lot more of the linux headers to be present, than glibc does.
Hell, if llh-ng is supposed to be a full set of apis, we can't expect any of
the headers to come from other places, so if any other app (libcs included)
has duplicates, that's too bad for the app, since it's in need of some
patching. Unfortunately the glibc's build system is one hell of a scary
place to lurk around.

Ok, assuming we've got the libcs covered for the most popular archs, we're in
for supporting the rest of the apps. I can just throw whatever headers
we come up with at my distro and wait for the bug reports (along with
colorful descriptions of how slow and painful my death is going to be),
and I believe LFS guys can more or less do the same.  So after some
time, we'd hopefully have a bunch of mostly working headers, that are
clean and rather easy to maintain (although probably require a lot of
patches for various apps; but those would eventually get merged
upstream; at least most of the times, I hope; keep in mind my comment
about glibc being a scary and evil place).  *But* in the meantime we'd
be stuck with the old llh 2.6.13, so, like I've said before, if
anybody's still interested in doing an update with the old llh, mail me
(again) and I'll give you the details on how I've done it in the past.

And one other thing -- the assumption is that kernel<->userland apis/abis
(mostly the latter) shouldn't change in an incompatible way and if they do,
that's considered a bug. But until llh-ng got merged into the kernel,
we'd have to figure out a way to cope with new kernel releases. Eg. what
about netfilter headers, are they backwards compatible (yeah, I know
iptables have their own set of netfilter headers, but apps not needing
such hacks is kind of the point of the whole exercise)? And what about
different paces of updates for various archs. Eg. most people are happy
with the most popular archs, so it'd be a bad idea not to do a release
just because we're waiting for one of the more exotic archs. How does
one version such a project? Not like the old llh (x.y.z.t, where x.y.z
corresponds to the kernel version), since not all releases would be
always fully up to date with a given kernel. So maybe just automatic
snapshots every day (assuming a change has been made). But if so, who's
tree gets to be treated as the main one? (Distributed rcs, remember).
And should we choose such a person, what is the chance he'll end up just
like I did (a lazy schmuck that is)?

Ok, I'm getting too detailed here. One thing at a time.

So, waiting for any insights, counterproposals and/or declarations who's
willing to work on old llh, llh-ng or both. Shoot away.

I'm CCing this to llh-discuss@lists.pld-linux.org
(http://lists.pld-linux.org and click away; mailman over there, so you
know the drill). I've created that list about a month ago, when I
figured that when people mail me, they never get to see each other's
posts. I thought of deleting it a week ago, but, well, looks like it
might come in handy after all.


-- 
Judge others by their intentions and yourself by your results.
                                                                 Guy Kawasaki
Education is an admirable thing, but it is well to remember from
time to time that nothing that is worth knowing can be taught.
                                                                  Oscar Wilde
