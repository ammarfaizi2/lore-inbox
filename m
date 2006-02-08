Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWBHOk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWBHOk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 09:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030179AbWBHOk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 09:40:27 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:34734 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030380AbWBHOk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 09:40:27 -0500
Message-ID: <43EA02D6.30208@watson.ibm.com>
Date: Wed, 08 Feb 2006 09:40:22 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
References: <43E7C65F.3050609@openvz.org>	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>	<20060207201908.GJ6931@sergelap.austin.ibm.com>	<43E90716.4020208@watson.ibm.com>	<m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>	<43E92EDC.8040603@watson.ibm.com> <m1ek2ea0fw.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ek2ea0fw.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
> 
> 
>>Eric W. Biederman wrote:
>>

>>>2) What is the syscall interface to create these namespaces?
>>>   - Do we add clone flags?       (Plan 9 style)
>>
>>Like that approach .. flexible .. particular when one has well specified
>>namespaces.
>>
>>
>>>   - Do we add a syscall (similar to setsid) per namespace?
>>>     (Traditional unix style)?
>>
>>Where does that approach end .. what's wrong with doing it at clone() time ?
>>Mainly the naming issue. Just providing a flag does not give me name.
> 
> 
> It really is a fairly even toss up.  The usual argument for doing it
> this way is that you will get a endless stream of arguments added to
> fork+exec other wise.  Look of posix_spawn or the windows version if
> you want an example.  Bits to clone are skirting the edge of a slippery 
> slope.
> 

So it seems the clone( flags ) is a reasonable approach to create new
namespaces. Question is what is the initial state of each namespace?
In pidspace we know we should be creating an empty pidmap !
In network, someone suggested creating a loopback device
In uts, create "localhost"
Are there examples where we rather inherit ?  Filesystem ?
Can we iterate the assumption for each subsystem what people thing is right?

IMHO, there is only a need to refer to a namespace from the global context.
Since one will be moving into a new container, but getting out of one
could be prohibitive (e.g. after migration)
It does not make sense therefore to know the name of a namespace in
a different container.

The example you used below by using the pid comes natural, because
that already limits visibility.

I am still struggling with why we need new sys_calls.
sys_calls already exist for changing certain system parameters (e.g. utsname )
so to me it boils down to identifying a proper initial state when the
namespace is created.

> 
>>>3) How do we refer to namespaces and containers when we are not members?
>>>   - Do we refer to them indirectly by processes or other objects that
>>>     we can see and are members?
>>>   - Do we assign some kind of unique id to the containers?
>>
>>In containers I simply created an explicite name, which ofcourse colides with
>>the
>>clone() approach ..
>>One possibility is to allow associating a name with a namespace.
>>For instance
>>int set_namespace_name( long flags, const char *name ) /* the once we are using
>>in clone */
>>{
>>	if (!flag)
>>		set name of container associated with current.
>>	if (flag())
>>		set the name if only one container is associated with the
>>namespace(s)
>>		identified .. or some similar rule
>>}
>>
> 
> 
> What I have done which seems easier than creating new names is to refer
> to the process which has the namespace I want to manipulate.

Is then the idea to only allow the container->init to manipulate
or is there need to allow other priviliged processes to perform namespace
manipulation?
Also after thinking about it.. why is there a need to have an external name
for a namespace ?

> 
> 
>>>6) How do we do all of this efficiently without a noticeable impact on
>>>   performance?
>>>   - I have already heard concerns that I might be introducing cache
>>>     line bounces and thus increasing tasklist_lock hold time.
>>>     Which on big way systems can be a problem.
>>
>>Possible to split the lock up now.. one for each pidspace ?
> 
> 
> At the moment it is worth thinking about.  If the problem isn't
> so bad that people aren't actively working on it we don't have to
> solve the problem for a little while, just be aware of it.
> 

Agree, just need to be sure we can split it up. But you already keep
a task list per pid-namespace, so there should be no problem IMHO.
If so let's do it now and take it of the table it its as simple as

task_list_lock ::= pspace->task_list_lock

> 
>>>7) How do we allow a process inside a container to create containers
>>>   for it's children?
>>>   - In general this is trivial but there are a few ugly issues
>>>     here.
>>
>>Speaking of pids only here ...
>>Does it matter, you just hang all those containers hang of init.
>>What ever hierarchy they form is external ...
> 
> 
> In general it is simple.  For resource accounting, and for naming so
> you can migrate a container with a nested container it is a question
> you need to be slightly careful with.

Absolutely, that's why it is useful to have an "external" idea of how
containers are constructed of basic namespaces==subsystems.
The it "simply" becomes a policy. E.g. one can not migrate a container
that has shared subsystems.
Resource accounting I agree, that might required active aggregation
at request time.

-- Hubertus

