Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWBHRsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWBHRsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 12:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWBHRsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 12:48:42 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14494 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030376AbWBHRsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 12:48:41 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces
 implementation.
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<20060207201908.GJ6931@sergelap.austin.ibm.com>
	<43E90716.4020208@watson.ibm.com>
	<m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>
	<43E92EDC.8040603@watson.ibm.com>
	<m1ek2ea0fw.fsf@ebiederm.dsl.xmission.com>
	<43EA02D6.30208@watson.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 10:46:14 -0700
In-Reply-To: <43EA02D6.30208@watson.ibm.com> (Hubertus Franke's message of
 "Wed, 08 Feb 2006 09:40:22 -0500")
Message-ID: <m17j857nh5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

>
> So it seems the clone( flags ) is a reasonable approach to create new
> namespaces. Question is what is the initial state of each namespace?
> In pidspace we know we should be creating an empty pidmap !
> In network, someone suggested creating a loopback device
> In uts, create "localhost"
"localhost" is wrong.  Either copy or set it to the value from
system initialization time.

> Are there examples where we rather inherit ?  Filesystem ?
> Can we iterate the assumption for each subsystem what people thing is right?

I think this needs to happen on a pure subsystem basis as we merge the
patches.

> IMHO, there is only a need to refer to a namespace from the global context.
> Since one will be moving into a new container, but getting out of one
> could be prohibitive (e.g. after migration)
> It does not make sense therefore to know the name of a namespace in
> a different container.
>
> The example you used below by using the pid comes natural, because
> that already limits visibility.
>
> I am still struggling with why we need new sys_calls.
> sys_calls already exist for changing certain system parameters (e.g. utsname )
> so to me it boils down to identifying a proper initial state when the
> namespace is created.

Agreed.  But we can't always count on everything having a useful state
that we can modify from the inside.  So it is important to leave the
option open at least for those case.

And again there is always the idea that by adding flags we will
transform fork or fork+exec into a spaghetti system call.  I think
that is a reasonable concern.

Also there is always the danger that we run out of clone flags.

>> What I have done which seems easier than creating new names is to refer
>> to the process which has the namespace I want to manipulate.
>
> Is then the idea to only allow the container->init to manipulate
> or is there need to allow other priviliged processes to perform namespace
> manipulation?
> Also after thinking about it.. why is there a need to have an external name
> for a namespace ?

Largely it connects to the super chroot usage where you have one
sysadmin he has multiple daemons each running in their own environment
for isolation purposes.  Nothing is installed in the chroot so an
attacker that gets in cannot do anything.

>>>>6) How do we do all of this efficiently without a noticeable impact on
>>>>   performance?
>>>>   - I have already heard concerns that I might be introducing cache
>>>>     line bounces and thus increasing tasklist_lock hold time.
>>>>     Which on big way systems can be a problem.
>>>
>>>Possible to split the lock up now.. one for each pidspace ?
>> At the moment it is worth thinking about.  If the problem isn't
>> so bad that people aren't actively working on it we don't have to
>> solve the problem for a little while, just be aware of it.
>>
>
> Agree, just need to be sure we can split it up. But you already keep
> a task list per pid-namespace, so there should be no problem IMHO.
> If so let's do it now and take it of the table it its as simple as
>
> task_list_lock ::= pspace->task_list_lock

Actually I don't although that could be trivial.  But it is the
wrong split.  The problem is that it is a lock with global effect.

Eric
