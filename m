Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWGLD0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWGLD0D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWGLD0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:26:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12465 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932141AbWGLD0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:26:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<m164i3gad1.fsf@ebiederm.dsl.xmission.com>
	<44B41803.8040900@fr.ibm.com>
Date: Tue, 11 Jul 2006 21:24:15 -0600
In-Reply-To: <44B41803.8040900@fr.ibm.com> (Cedric Le Goater's message of
	"Tue, 11 Jul 2006 23:28:35 +0200")
Message-ID: <m1odvvec9s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Hello eric,
>
> Eric W. Biederman wrote:
>
>>> The following patchset adds the user namespace and a new syscall execns.
>>>
>>> The user namespace will allow a process to unshare its user_struct table,
>>> resetting at the same time its own user_struct and all the associated
>>> accounting.
>>>
>>> The purpose of execns is to make sure that a process unsharing a namespace
>>> is free from any reference in the previous namespace. the execve() semantic
>>> seems to be the best candidate as it already flushes the previous process
>>> context.
>>>
>>> Thanks for reviewing, sharing, flaming !
>> 
>> 
>> I haven't had a chance to do a thorough review yet but why is
>> this needed?
>> 
>> What can be left shared by switching to a new namespace and then
>> execing an executable?
>> 
>> Is it not possible to ensure what you are trying to ensure with
>> a good user space executable?
>
> unshare() is unsafe for some namespaces because namespaces can reference
> each other. For the ipc namespace, example are shm ids vs. vma, sem ids vs.
> semundos, msq vs. netlink sockets. for the user namespace, open files. So
> it seems reasonable to provide a way to unshare namespaces from a clean
> process context.

It is perfectly legitimate to have a shared memory region memory mapped
from another namespace.  Yes sem ids versus semunds is an issue but it
just requires you to unshare one at the same time you unshare the other,
or to simply clone a new namespace.  I'm not familiar with the msq vs netlink
socket issue.  As for the user namespace vs open files.  If we have
any issues with open files in any namespace that sounds like an implementation
bug to me.

I'm not convinced the problems you are seeing are not implementation bugs.
For some things clone is still more general then unshare, and clone should
be considered the primary user interface, not unshare.

> Now, if you try to do that from user space, you will call unshare() then
> execve(), which leaves plenty of room and time for nasty things to happen
> in between the 2 calls.

I will look more closely but I think there is an important point being missed
somewhere.  Pieces of the kernel interact in all sorts of weird and unexpected
ways.  If we rely on ourselves always being in the right magic namespace for
things to work correctly we are setting ourselves up for trouble.  If we know
a namespace implementation will work even when a process has access to entities
in multiple instances of that namespace we are in much better shape.

Eric

