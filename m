Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVAGP0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVAGP0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVAGP0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:26:41 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:61079 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261457AbVAGP0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:26:19 -0500
Message-Id: <200501071526.j07FQG2g018486@localhost.localdomain>
To: Christoph Hellwig <hch@infradead.org>
cc: Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 07 Jan 2005 14:47:18 GMT."
             <20050107144718.GB9606@infradead.org> 
Date: Fri, 07 Jan 2005 10:26:16 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.197.185.179] at Fri, 7 Jan 2005 09:26:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, Jan 07, 2005 at 09:38:38AM -0500, Paul Davis wrote:
>> Lee, Jack and I have been very willing to discuss the issue. Christoph
>> isn't willing to discuss it, he's just told us "its the wrong design,
>> and I'm not telling you why or what's better". If there is a better
>> design that will end up in the mainstream kernel, we'd love to see it
>> implemented, and will likely be involved in doing it, because its
>> really important to us.
>
>Calm down and read through the thread again.

Sure, lets. Distilling out the responses from kernel developers:

======================================================================

Christoph:
---------
This is far too specialized.  And option to the capability LSM to grant 
capabilities to certain uids/gids sounds like the better choise - and
would also allow to get rid of the magic hugetlb uid horrors.

Which still doesn't mean it's the right design.  And no, I don't need the
feature so I won't write it.  If you want a certain feature it's up to
you to implement it in a way that's considered mergeable.

Alan: 
-----
The problem with uid/gid based hacks is that they get really ugly to
administer really fast. Especially once you have users who need realtime
and hugetlb, and users who need one only.

It would be far cleaner to split CAP_SYS_NICE capability down - which
should cover the real time OS functions nicely. Right now it gives a few
too many rights but that could be fixed easily.

gid hacks are not a good long term plan.

Can we use capabilities, if not - why not and how do we fix it so we can
do the job right. Do we need some more capability bits that are
implicitly inherited and not touched by setuidness ?

Andrew:
-------

capabilities don't work :(

Herbert:
--------

well, maybe it is time to fix them ..

I already proposed some methods to extend them,
and I'm also willing to dig into the various things
required to allow to use the capability system for
what it was intended.

Matt:
-----

You can't fix them without changing the semantics for existing users
in ways they didn't expect. It could be done with a new personality flag,
but..

Alan:
-----
I disagree. At the most trivial you could just add another 32bits of
sticky capability that are never touched by setuid/non-setuidness and
represent additional "user" (or more rightly session) abilities to do
limited overrides

Olaf:
-----
Capabilities don't work, because of missing filesystem
capabilities. If you have them, it's a question of setting the
appropriate permitted, inheritable and effective capability sets.

I didn't follow the whole thread. But if you want to grant
capabilities on a per user/group basis, may I suggest accessfs user
based capabilities, for example? :-)

======================================================================

So, we have a few responses, some references to various potential
solutions all of which have problems just as deep if not deeper than
the uid/gid-based model that this particular LSM adopts. No proposal
for any system that would actually work and address anyone's real
needs in a useful way. Please recall that we developed a
capability-based solution for 2.4, but it was cumbersome because the
vanilla kernel doesn't have capabilities enabled and there are lots of
reasons to not enable them given their current status.

Meanwhile, Jack already provided a very detailed, cross-referenced and
clear explanatin of why various other ideas won't work very well from
a user-space perspective. And in this thread, both Lee and Jack have
attempted to deal with issues that have been raised about the uid/gid
approach. 

In summary, on the one hand, we have a working, defensible solution,
and on the other some misgivings and suggestions to try again at
implementing some more generic priviledge-granting system, something
that lkml has been arguing about for years, along with the rest of the
OS design community. Something that I suspect will never be properly 
resolved, merely "muddled towards". There is no right way to grant
priviledges - there are many ways, and the benefits and downfalls of
each depends on what you are trying to achieve. For years, POSIX based
systems have relied on uid/gid solutions and they continue to do
so. People understand how to manage them (as best as can be done), and
what the issues are. Capabilities were supposed to be solution to
this, and instead have essentially been a dead-end. So I trust that
you'll be understanding of any scepticism that I might have of the
suggestion that we go away and work on some other "more generic"
system. 

--p
