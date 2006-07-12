Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWGLR0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWGLR0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGLR0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:26:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59010 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932103AbWGLR0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:26:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<44B50088.1010103@fr.ibm.com>
Date: Wed, 12 Jul 2006 11:24:49 -0600
In-Reply-To: <44B50088.1010103@fr.ibm.com> (Cedric Le Goater's message of
	"Wed, 12 Jul 2006 16:00:40 +0200")
Message-ID: <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Eric W. Biederman wrote:
>> Cedric Le Goater <clg@fr.ibm.com> writes:
>> 
>>> This patch adds the user namespace.
>>>
>>> Basically, it allows a process to unshare its user_struct table,
>>> resetting at the same time its own user_struct and all the associated
>>> accounting.
>>>
>>> For the moment, the root_user is added to the new user namespace when
>>> it is cloned. An alternative behavior would be to let the system
>>> allocate a new user_struct(0) in each new user namespace. However,
>>> these 0 users would not have the privileges of the root_user and it
>>> would be necessary to work on the process capabilities to give them
>>> some permissions.
>> 
>> It is completely the wrong thing for a the root_user to span multiple
>> namespaces as you describe.  It is important for uid 0 in other namespaces
>> to not have the privileges of the root_user.  That is half the point.
>
> ok good. that's what i thought also.
>
>> Too many files in sysfs and proc don't require caps but instead simply
>> limit things to uid 0.  Having a separate uid 0 in the different namespaces
>> instantly makes all of these files inaccessible, and keeps processes from
>> doing something bad.
>
> but in order to be useful, the uid 0 in other namespaces will need to have
> some capabilities.

Yes.  It is useful for uid 0 in other namespaces to have some capabilities.
But that is just a matter of giving another user some additional
capabilities.  That mechanism may still work but it should not be
namespace specific magic there.  The trick I guess is which
capabilities a setuid binary for the other root user gets.

One thing to be careful about here is that, at least as I 
envision it until setresuid is called your user does not change
even when you unshare your user namespace.

>> To a filesystem a uid does not share a uid namespace with the only things
>> that should be accessible are those things that are readable/writeable
>> by everyone.   Unless the filesystem has provisions for storing multiple
>> uid namespaces not files should be able to be created.  Think NFS root
>> squash.
>
> I think user namespace should be unshared with filesystem. if not, the
> user/admin should know what is doing.

No.  The uids in a filesystem are interpreted in some user namespace
context.  We can discover that context at the first mount of the
filesystem.  Assuming the uids on a filesystem are the same set
of uids your process is using is just wrong.

>> Every comparison of a user id needs to compare the tuple
>> (user namespace, user id) or it needs to compare struct users.
>>
>> Ever comparison of a group id needs to compare the tuple
>> (user namespace, group id) or it needs to compare struct users.
>
> yes, that would be the ultimate user namespace.
>
> I think that this first patchset lays some infrastructure that is already
> quite usable in a container which already isolates file, pids, etc and not
> only users.
>
> now, we could work on extending it to support fine grain user namespace
> which i think can done on top of this first patch.

Yes.  Your patch does lay some interesting foundation work.
But we must not merge it upstream until we have a complete patchset
that handles all of the user namespace issues.

>> I think the key infrastructure needs to be looked at here as well.
>>
>> There needs to be a user namespace association for mounted filesystems.
>
> yes you could expect that to check the i_uid against fsuid but should we
> enforce it completely ?
>
> we already have an issue today with a simple NFS mount on 2 hosts with
> different user mapping. namespace can't fix all issues.

Yes.  This is an existing problem, which we have just escalated the
frequency of immensely if we are doing user namespaces.  The normal
solution is to put everyone on the network in a single user id
administration domain with ldap or NIS.

However that is avoiding the problem, and having multiple user id
domains is the point of a user id namespace.  If we escalate the
problem we should solve it.

>> We need a discussion about how we handle map users from one user
>> namespace to another, because without some form of mapping so many
>> things become inaccessible that the system is almost useless.
>> 
>> I believe some of the key infrastructure which is roughly kerberos
>> authentication tokens could be used for this purpose.
>
> please elaborate ? i'm not sure to understand why you want to use the keys
> to map users.

keys are essentially security credentials for something besides the
local kernel.  Think kerberos tickets.  That makes the keys the
obvious place to say what uid you are in a different user namespace
and similar things.

>> A user namespace is a big thing.  What I see here doesn't even
>> seem to scratch the surface.
>
> good let's start digging !

One piece at a time :)

Eric
