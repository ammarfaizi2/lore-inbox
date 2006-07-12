Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWGLOAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWGLOAw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWGLOAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:00:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:28632 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751372AbWGLOAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:00:51 -0400
Message-ID: <44B50088.1010103@fr.ibm.com>
Date: Wed, 12 Jul 2006 16:00:40 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>	<20060711075420.937831000@localhost.localdomain> <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Cedric Le Goater <clg@fr.ibm.com> writes:
> 
>> This patch adds the user namespace.
>>
>> Basically, it allows a process to unshare its user_struct table,
>> resetting at the same time its own user_struct and all the associated
>> accounting.
>>
>> For the moment, the root_user is added to the new user namespace when
>> it is cloned. An alternative behavior would be to let the system
>> allocate a new user_struct(0) in each new user namespace. However,
>> these 0 users would not have the privileges of the root_user and it
>> would be necessary to work on the process capabilities to give them
>> some permissions.
> 
> It is completely the wrong thing for a the root_user to span multiple
> namespaces as you describe.  It is important for uid 0 in other namespaces
> to not have the privileges of the root_user.  That is half the point.

ok good. that's what i thought also.

> Too many files in sysfs and proc don't require caps but instead simply
> limit things to uid 0.  Having a separate uid 0 in the different namespaces
> instantly makes all of these files inaccessible, and keeps processes from
> doing something bad.

but in order to be useful, the uid 0 in other namespaces will need to have
some capabilities.

> To a filesystem a uid does not share a uid namespace with the only things
> that should be accessible are those things that are readable/writeable
> by everyone.   Unless the filesystem has provisions for storing multiple
> uid namespaces not files should be able to be created.  Think NFS root
> squash.

I think user namespace should be unshared with filesystem. if not, the
user/admin should know what is doing.

> Every comparison of a user id needs to compare the tuple
> (user namespace, user id) or it needs to compare struct users.
>
> Ever comparison of a group id needs to compare the tuple
> (user namespace, group id) or it needs to compare struct users.

yes, that would be the ultimate user namespace.

I think that this first patchset lays some infrastructure that is already
quite usable in a container which already isolates file, pids, etc and not
only users.

now, we could work on extending it to support fine grain user namespace
which i think can done on top of this first patch.

> I think the key infrastructure needs to be looked at here as well.
>
> There needs to be a user namespace association for mounted filesystems.

yes you could expect that to check the i_uid against fsuid but should we
enforce it completely ?

we already have an issue today with a simple NFS mount on 2 hosts with
different user mapping. namespace can't fix all issues.

> We need a discussion about how we handle map users from one user
> namespace to another, because without some form of mapping so many
> things become inaccessible that the system is almost useless.
> 
> I believe some of the key infrastructure which is roughly kerberos
> authentication tokens could be used for this purpose.

please elaborate ? i'm not sure to understand why you want to use the keys
to map users.

> A user namespace is a big thing.  What I see here doesn't even
> seem to scratch the surface.

good let's start digging !

thanks,

C.
