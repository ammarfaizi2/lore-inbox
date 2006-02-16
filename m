Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWBPRDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWBPRDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWBPRDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:03:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13986 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751093AbWBPRDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:03:32 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: (pspace,pid) vs true pid virtualization
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
	<m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
	<20060216143030.GA27585@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 16 Feb 2006 09:59:50 -0700
In-Reply-To: <20060216143030.GA27585@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Thu, 16 Feb 2006 15:30:30 +0100")
Message-ID: <m11wy3qlx5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

>> - Should the first pid in a pid space have pid 1?
>
> depends, usually either one process has pid==1 (the init)
> or no process should use that pid (still handled special)
> nevertheless, the latter case requires a 'fake' pid==1
> to make some userspace processes happy (e.g. pstree)

Ok.  So we always need a pid == 1 to show up.

>> - Should pid == 1 ignore signals, it doesn't have a handler for?
>
> the 'init' process must be protected in a similar fashion
> than the real init is, otherwise guests will end up dying
> in certain situations, of course, it would be nice to have
> some kind of flag to turn this on and off

That is an interesting thought... Have a flag that sets
if you get to ignore unhandled signals :)

>> - Should any children of pid 1 be allowed to live 
>>   when pid == 1 is killed?
>
> agan that's a feature which would be nice, especially
> for the lightweight contexts, which do not have an init
> process running inside the guest

But if init is killed you want to still see init and have
children reaped?

>> - Should a process have some sort of global (on the machine identifier)?
>
> this is mandatory, as it is required to kill any process
> from the host (admin) context, without entering the pid
> space (which would lead to all kind of security issues)

Ok.  Would it be sufficient to simply stomp the entire pid
space?  I.e. do you need fine grained control, or is this merely
a matter of keeping the machine usable for everyone else?

>> - Should the pids in a pid space be visible from the outside?
>
> yes, while not strictly required, folks really like to
> view the overall system state. this can be done with the
> help of special tools, but again it should be done
> without entering each guest pid space ...

Ok. I didn't ask quite what I thought I had asked :)
I agree that monitoring seems important.

>> - Should the parent of pid 1 be able to wait for it for it's 
>>   children?
>
> definitely, we (Linux-VServer) added this some time ago
> and it helps to maintain/restart a guest.

That is how I expected that to get used. :)

>> - Is a completely disjoin pid space acceptable to anyone?
>
> yes, as long as the beforementioned access, management
> and control mechanisms are in place ...

Good answer.

>> - What should the parent of pid == 1 see?
>
> doesn't really matter, but I see three options there:
>  
>  - the parent space
>  - the child space
>  - both

An answer from a totally different perspective :)

>> - Should a process not in the default pid space be able to create 
>>   another pid space?
>
> that would be a requirement for hierarchical spaces

Well if the spaces were completely disjoin it would not be very
much of a hierarchy...

>> - Should we be able to monitor a pid space from the outside?
>
> yes, definitely, but it could happen via some special
> interfaces, i.e. no need to make it compatible


>> - Should we be able to have processes enter a pid space?
>
> definitely, without that, the entire VPS concept will
> not work, folks use the 'admin' backdoors 90% of the
> time ...

A good inducement to get this part right :)

To give a little more context when you are using this
functionality to make a super chroot you and you only have
one sysadmin, or when your talented sysadmin is assisting 
other sysadmins of guests is when this comes up.

>> - Do we need to be able to be able to ptrace/kill individual 
>> processes in a pid space, from the outside, and why?
>
> ptrace: no not really, if there are issues which want
>   to be investigated, you can always enter the space and
>   attach the strace there. IMHO there is not much info
>   in ptracing the space creation/transition
>
> kill: yes, once you identified an evil guest process,
>   you want to get rid of it, without entering the space
>
>> - After migration what identifiers should the tasks have?
>
> doesn't matter, as long as they are unique, so
>  ppid1/ppid2/ppid3/pid would work ...
>
>> If we can answer these kinds of questions we can likely focus in on
>> what the implementation should look like. So far I have not seen a
>> question that could not be implemented with a (pspace, pid)/pid or a
>> vpid/pid implementation.
>
> best,
> Herbert

Thanks.

Eric


