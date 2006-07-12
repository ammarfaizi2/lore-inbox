Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWGLRLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWGLRLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWGLRLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:11:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26604 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751466AbWGLRLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:11:03 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<20060712120505.GA31709@MAIL.13thfloor.at>
Date: Wed, 12 Jul 2006 11:09:30 -0600
In-Reply-To: <20060712120505.GA31709@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Wed, 12 Jul 2006 14:05:05 +0200")
Message-ID: <m1u05magxh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Tue, Jul 11, 2006 at 09:46:01PM -0600, Eric W. Biederman wrote:
>> Cedric Le Goater <clg@fr.ibm.com> writes:
>> 
>> > This patch adds the user namespace.
>> >
>> > Basically, it allows a process to unshare its user_struct table,
>> > resetting at the same time its own user_struct and all the
>> > associated accounting.
>> >
>> > For the moment, the root_user is added to the new user namespace
>> > when it is cloned. An alternative behavior would be to let the
>> > system allocate a new user_struct(0) in each new user namespace.
>> > However, these 0 users would not have the privileges of the
>> > root_user and it would be necessary to work on the process
>> > capabilities to give them some permissions.
>> 
>> It is completely the wrong thing for a the root_user to span multiple
>> namespaces as you describe. It is important for uid 0 in other
>> namespaces to not have the privileges of the root_user. That is half
>> the point.
>>
>> Too many files in sysfs and proc don't require caps but instead simply
>> limit things to uid 0. Having a separate uid 0 in the different
>> namespaces instantly makes all of these files inaccessible, and keeps
>> processes from doing something bad.
>
> well, here I'd definitely prefer to fix up that 'broken'
> entries by adding proper capability checks, and maybe
> even a bunch of new capabilities (i.e. 64bit caps and
> such) first, because IMHO the capability system is the
> 'proper' method to protect them in the first place

I guess the good way to think of some of this is not as broken files.
But rather in the plan9 model.  Initially everything on the machine is
owned by one user (in our case root).  That user then controls who
else gets access to files by calling chown etc.

If you want access to those files in a different uid namespace someone
needs to call chown or at least chmod on them, and I'm not
at all certain this as a problem is limited to special files on
a filesystem.

Really when you do a proper user namespace this all comes for free.

>> To a filesystem a uid does not share a uid namespace with the
>> only things that should be accessible are those things that are
>> readable/writeable by everyone. Unless the filesystem has provisions
>> for storing multiple uid namespaces not files should be able to be
>> created. Think NFS root squash.
>
> that's where file tagging as Linux-VServer does it can
> be used to 'share' a partition between different guests
> (and have separate disk limits and quotas)

I completely agree we need a capability like that.  I disagree on the
implementation because it is not general.  What we have really hit is
the classic uid mapping problem that shows up occasionally with
network filesystems.  That is the problem we need to solve.

I'm pretty certain the current kernel key infrastructure gives us the
infrastructure we need to do that in a general way.  At which point
it would be a policy decision which uid to map to which other uid
and we could easily match the current 

Eric
