Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271652AbRHQNUh>; Fri, 17 Aug 2001 09:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271651AbRHQNU1>; Fri, 17 Aug 2001 09:20:27 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:13325 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S271652AbRHQNUL>; Fri, 17 Aug 2001 09:20:11 -0400
Date: Fri, 17 Aug 2001 16:34:02 +0300 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM nuisance
In-Reply-To: <3B78E10A.E8772B79@idb.hist.no>
Message-ID: <Pine.LNX.4.30.0108171343290.2660-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Aug 2001, Helge Hafting wrote:
> dean gaudet wrote:
> > i would happily give up 10 to 20% system resources for checkpoint
> > overhead if it meant that i'd be that much closer to a crashproof
> > system.

It's not necessarily needed so much and not even checkpointing using
(optional) non-overcommiting. See e.g. the Solaris numbers for yourself,
http://www.google.com/search?q=cache:http://lists.openresources.com/NetBSD/tech-userlevel/msg00722.html
All big guys support this optionally, sometimes even in a finer graded
level, like per process settable by developer overjudgable (sp?) by
admin (AIX) or using virtual swap space where the degree of the memory
overcommitment controllable (IRIX), etc. Linux had the "quasi"
non-overcommiting [it didn't reserved the demanded memory, just checked
if there is enough free(able) in user space allocation time]
controllable by /proc/sys/vm/overcommit_memory in 2.2 but in 2.4
vm_enough_memory() overestimates freeable memory (in contrast to 2.2
kernels) so basically it's useless - this is one of the reasons why OOM
so trendy topic recently.

Although non-overcommit prevents running out of VM but when VM is full
then system can either livelock or start arbitrary process killing so
non-overcommit becomes useless. How others solved this? They reserve
some VM for root so he can act whatever he wants. Well written apps (I
could mention e.g. apache) don't really care about system is in an OOM
situation - they happily do their jobs just as before (proved in
practice ;)

When root reserved VM is also used up, welcome OOM killer - however with
the above two protection bar the chance for this is pretty around 0 if
admin don't prefer running stuffs as root.

Note, these are optional for those who are willing to sacrifice a couple
of percent system resources.

> > so why not just use the most simple OOM around:  shoot the first app which
> > can't get its page.  app writers won't like it, and users won't like it
> > until the app writers fix their bugs, but then nobody likes the current
> > situation, so what's the difference?
> It used to be like that.  Unfortunately, the first app unable to
> get its page might very well be init, and then the entire system goes
> down in flames.

Well, I ported the 2.4 OOM killer to 2.2.19 and added reserved root VM
	http://mlf.linux.rulez.org/mlf/ezaz/reserved_root_memory.html

It works like it kills the process chosen by OOM killer when the first
app can't get its page in page fault. OOM killing in 2.4 works
differently. Apps loop forever in __alloc_pages() until they can get a
page or out_of_memory() decides its time to kill somebody. So whenever
there is some VM tuning, out_of_memory() should be tuned. Of course it's
usually missed. Futhermore it's also a heuristic, not an "exact"
decision made by e.g. 2.2 kernels. So in short, IMHO it will never work.
I asked explanation for a couple of times for this 2.4 behavior but
nobody bothered. I think partly it's because of the aggressive caching.
One easy solution could be to drop out_of_memory() completely, put back
oom_kill() to page fault from kswapd() and make tunable the number of
looping in __alloc_pages().

> The real solution is to have enough memory for the task at hand.

Define to the user the "enough memory" when he wants to open different
kind of documents, run scientific applications with different size data
sets or whatever. What would you expect from your computer either "Hey,
your resources is not enough for this task" or just crash the
application?

> Failing that, get so much swap space that people will be happy when

The "buy more disk, buy more RAM!" kind of answers were one of the
reasons Linux user base growth so big as it is today escaping from
the old advisers ...

2.4 is killer if expertise is given [not to install Linux but to
carefully setup the box for its job] but it fails otherwise because of
its OOM handling.

	Szaka

