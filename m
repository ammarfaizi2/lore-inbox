Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWGLNF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWGLNF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWGLNF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:05:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52696 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750778AbWGLNF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:05:58 -0400
Message-ID: <44B4F3AE.60607@fr.ibm.com>
Date: Wed, 12 Jul 2006 15:05:50 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain>	<m164i3gad1.fsf@ebiederm.dsl.xmission.com>	<44B41803.8040900@fr.ibm.com> <m1odvvec9s.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1odvvec9s.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

Hopefully, we will soon see each other at OLS. We need some synchronous
interaction !

Eric W. Biederman wrote:

>>> Is it not possible to ensure what you are trying to ensure with
>>> a good user space executable?
>> unshare() is unsafe for some namespaces because namespaces can reference
>> each other. For the ipc namespace, example are shm ids vs. vma, sem ids vs.
>> semundos, msq vs. netlink sockets. for the user namespace, open files. So
>> it seems reasonable to provide a way to unshare namespaces from a clean
>> process context.
> 
> It is perfectly legitimate to have a shared memory region memory mapped
> from another namespace. 

then after unshare, a process can be in ipc namespace B with a shared
memory segment from ipc namespace A without any id for this segment. this
is not very consistent. the same process will also be able to modify the
ipc namespace B without being in this namespace. ugly. It looks like an
issue that should be solved.

I think namespace should enforce strict isolation. nop ?

> Yes sem ids versus semunds is an issue but it just requires you to unshare
> one at the same time you unshare the other, or to simply clone a new
> namespace.

hmm, semids the from ipc namespace are stored in task->sysv_sem. i would
forbid the unshare/clone in that case or flush the semundos like in
exit_sem(). but it's easier not to have any, like in a clean process image.

> I'm not familiar with the msq vs netlink socket issue.  

mq_notify can use a netlink socket to send an event back user space.

> As for the user namespace vs open files.  If we have any issues with open
> files in any namespace that sounds like an implementation bug to me.

user_struct does accounting on process, open files, locked memory, signals,
etc. if you unshare such an object, you will need to unshare all others
namespaces to be consistent. again having a clean process image is easier ...

> I'm not convinced the problems you are seeing are not implementation bugs.
> For some things clone is still more general then unshare, and clone should
> be considered the primary user interface, not unshare.

agree on that, i might be focusing a bit too much on the unshare syscall.
we should work on clone to make sure it has the required restrictions. The
system is really interlinked and not all namespaces can be unshared standalone.

>> Now, if you try to do that from user space, you will call unshare() then
>> execve(), which leaves plenty of room and time for nasty things to happen
>> in between the 2 calls.
> 
> I will look more closely but I think there is an important point being missed
> somewhere.  Pieces of the kernel interact in all sorts of weird and unexpected
> ways.  If we rely on ourselves always being in the right magic namespace for
> things to work correctly we are setting ourselves up for trouble.  If we know
> a namespace implementation will work even when a process has access to entities
> in multiple instances of that namespace we are in much better shape.

having a clean process image is IMHO required for some namespaces :

http://marc.theaimsgroup.com/?l=linux-kernel&m=113881171017330&w=2

thanks,

C.
