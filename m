Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422723AbWBIA0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWBIA0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 19:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWBIA0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 19:26:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32418 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422723AbWBIA0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 19:26:45 -0500
To: Kirill Korotaev <dev@openvz.org>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, riel@redhat.com,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       "Dmitry Mishin" <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 17:24:16 -0700
In-Reply-To: <43E7C65F.3050609@openvz.org> (Kirill Korotaev's message of
 "Tue, 07 Feb 2006 00:57:51 +0300")
Message-ID: <m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@openvz.org> writes:

> Hello,
>
> I tried to take into account all the comments from you guys (thanks a lot for
> them!) and prepared a new version of virtualization patches. I will send only 4
> patches today, just not to overflow everyone and keep it clear/tidy/possible to
> review.
>
> This patch introduces some abstract container kernel structure and a number of
> operations on it.
>
> The important properties of the proposed container implementation:
> - each container has unique ID in the system
> - each process in the kernel can belong to one container only
> - effective container pointer (econtainer()) is used on the task to avoid
> insertion of additional argument "container" to all functions where it is
> required.
> - kernel compilation with disabled virtualization should result in old good
> linux kernel
>
> Patches following this one will be used for virtualization of the kernel
> resources based on this container infrastructure, including those VPID patches I
> sent before. Every virtualized resource can be given separate config option if
> needed (just give me to know if it is desired).

After having digested this I think there is something sane with regard to
this container idea.  I still think the implementation is totally wrong but
there is a potential problem the basic idea solves.

In the traditional linux/plan9 style of namespaces the question is
which resources different tasks share, and we pass clone bits to determine
what we want to share and what we don't want to share.  Semantically this
is very clean and allows for a great deal of flexibility.  However
as the flexibility increases we get more code in do_fork more
reference counts and ultimately the performance decreases.  In addition
it is not common for us to change which resources we share.

So our traditional route is flexible but it does not optimize the common
case where we share all of the same things.  Containers can potentially
optimize that case.  So long as anyone can create a new container even
someone inside a container we do not loose flexibility.

To deal with networking there are currently a significant number of
variables with static storage duration.  Making those variables global
and placing them in structures is neither as efficient as it could be
nor is it as maintainable as it should be.  Other subsystems have
similar problems.

So if we put econtainer in struct thread_info and optimize it like we
do current, create an interface to variables similar to
DEFINE_PER_CPU, create a syscall interface similar to clone, and
show that by doing this we don't loose flexibility, then it looks like
a good idea.

If we can't do better than the current clone model of shared resources
then this model feels like gratuitous change.

Eric
