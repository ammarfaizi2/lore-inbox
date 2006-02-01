Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWBAHQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWBAHQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWBAHQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:16:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52123 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751333AbWBAHQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:16:05 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>
	<20060117143326.283450000@sergelap>
	<1137511972.3005.33.camel@laptopd505.fenrus.org>
	<20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>
	<m13bj34spw.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0601312027450.7301@g5.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 01 Feb 2006 00:14:55 -0700
In-Reply-To: <Pine.LNX.4.64.0601312027450.7301@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 31 Jan 2006 20:39:19 -0800 (PST)")
Message-ID: <m1mzhb35zk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 31 Jan 2006, Eric W. Biederman wrote:
>> 
>> Yes.  Although there are a few container lifetimes problems with that
>> approach.  Do you want your container alive for a long time after every
>> process using it has exited just because someone has squirrelled away their
>> pid.  While container lifetime issues crop up elsewhere as well PIDs are
>> by far the worst, because it is current safe to store a PID indefinitely 
>> with nothing worse that PID wrap around.
>
> Are people really expecting to have a huge turn-over on containers? It 
> sounds like this shouldn't be a problem in any normal circumstance: 
> especially if you don't even do the "big hash-table per container" 
> approach, who really cares if a container lives on after the last process 
> exited?

Turn over rate is a good argument, for not worry about things too much.
I guess it only really becomes a problem if you have large amounts
of resources locked up.

> I'd have expected that the major user for this would end up being ISP's 
> and the like, and I would not expect the virtual machines to be brought up 
> all the time. 

People doing server consolidation are one of the big user bases.  The other
and possibly a bigger driver force right now are people dealing with large
high performance clusters.  There the interest is in encapsulating applications
so that you can checkpoint or migrate them.

One container per batch job might not be too high but if wound up being used
for short jobs as well as long ones you could get as high as one container
every couple of minutes.

The scary part with lifetime issues is that if you aren't careful you can
have lots of system resources used with no obvious source.

> If it's a problem, you can do the same thing that the "struct mm_struct" 
> does: it has life-time issues because a mm_struct actually has to live for 
> potentially a _long_ time (zombies) but at the same time we want to free 
> the data structures allocated to the mm_struct as soon as possible, 
> notably the VMA's and the page tables.
>
> So a mm_struct uses a two-level counter, with the "real" users (who need 
> the page tables etc) incrementing one ("mm_users"), and the "secondary" 
> ones (who just need to have an mm_struct pinned, but are ok with an empty 
> VM being attached) incrementing the other ("mm_count").

Neat.  I had not realized that was what was going on.  Having clean up a bunch
of cases there ages ago I was about to feel silly but I just realized mmdrop
is more recent than my comment explaining the difference between mmput and
mm_release.

One of the suggestions that has been floating around was to replace the
saved pids with references to task structures in places like fown_struct.
If we were to take that approach we would have nasty lifetime issues, because
we would continue to pin processes even after they were no longer zombies,
and we can potentially get a lot of fown_structs.

So I am considering introducing an intermediary (on very similar lines
to what you were suggesting) a struct task_ref that is just:
struct task_ref
{
	atomic_t count;
	enum pid_type type;
	struct task_struct *task;
};

That can be used to track tasks and process groups.  I posted fairly
complete patches for review a few days ago.  The interesting thing
with this case is that it can solve the pid wrap around issues as well
as container reference issues, by completely removing the need for
them.

The other technique that has served me well in my network
virtualization work was to setup of a notifier and have everyone who
cared register a notifier and drop their references when the notifier
was called.  For a low number of things that care as this works very
well.

> (for "mm_struct", the primary is dropped "mmput()" and the secondary is 
> dropped with "mmdrop()", which is absolutely horrid naming. Please name 
> things better than I did ;)

Well it is a challenge there aren't that many good names around and
it is hard work to find them. :)

Eric
