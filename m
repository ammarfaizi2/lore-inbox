Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWBIWaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWBIWaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 17:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWBIWaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 17:30:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48047 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750811AbWBIWaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 17:30:11 -0500
To: <linux-kernel@vger.kernel.org>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>, Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces
 implementation.
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<20060207201908.GJ6931@sergelap.austin.ibm.com>
	<43E90716.4020208@watson.ibm.com>
	<m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 09 Feb 2006 15:25:35 -0700
In-Reply-To: <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 07 Feb 2006 15:06:51 -0700")
Message-ID: <m11wyc5fvk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> I think I can boil the discussion down into some of the fundamental
> questions that we are facing.
>
> Currently everyone seems to agree that we need something like
> my namespace concept that isolates multiple resources.
>
> We need these for 
> PIDS
> UIDS
> SYSVIPC
> NETWORK
> UTSNAME
> FILESYSTEM
> etc.
>
> The questions seem to break down into:
> 1) Where do we put the references to the different namespaces?
>    - Do we put the references in a struct container that we reference from
> struct task_struct?
>    - Do we put the references directly in struct task_struct?

Answer in the task_struct.  It is the simplest and most flexible
route and the other implementations are still possible.

> 2) What is the syscall interface to create these namespaces?
>    - Do we add clone flags?  
>      (Plan 9 style)
>    - Do we add a syscall (similar to setsid) per namespace?
>      (Traditional unix style)?
>    - Do we in addition add syscalls to manipulate containers generically?

The answer seems to be we decide on a per namespace basis with
additional syscalls being mandatory if we have any additional data to
pass.

> 3) How do we refer to namespaces and containers when we are not members?

I have seen no arguments against referring to namespaces or containers
by global ids.  So it seems we do not need a container id.

> 4) How do we implement each of these namespaces?
>    Besides being maintainable are there other constraints?

Largely quite.  But I have not heard additional constraints.

> 5) How do we control the resource inside a namespace starting
>    from a process that is outside of that namespace?
>    - The filesystem mount namespace gave an interesting answer.
>      So it is quite possible other namespaces will give
>      equally interesting and surprising answers.

Not yet resolved, but a bit of speculation.

> 6) How do we do all of this efficiently without a noticeable impact on
>    performance?
>    - I have already heard concerns that I might be introducing cache
>      line bounces and thus increasing tasklist_lock hold time.
>      Which on big way systems can be a problem.

A little discussion.  At the level of the last few cache line I
think this needs to be addressed when we merge.  Simply not
messing up existing optimizations sounds like a good initial
target.  Basically at this stage trying hard would be a 
premature optimization.

> 7) How do we allow a process inside a container to create containers
>    for it's children?
>    - In general this is trivial but there are a few ugly issues
>      here.

This look mostly like something to be discussed when we merge
namespaces.  But as long as we keep it in mind it is easy.

Eric
