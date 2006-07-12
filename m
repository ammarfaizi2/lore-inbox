Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWGLMFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWGLMFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWGLMFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:05:09 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:42405 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751105AbWGLMFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:05:07 -0400
Date: Wed, 12 Jul 2006 14:05:05 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
Message-ID: <20060712120505.GA31709@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
	Andrey Savochkin <saw@sw.ru>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	Dave Hansen <haveblue@us.ibm.com>
References: <20060711075051.382004000@localhost.localdomain> <20060711075420.937831000@localhost.localdomain> <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 09:46:01PM -0600, Eric W. Biederman wrote:
> Cedric Le Goater <clg@fr.ibm.com> writes:
> 
> > This patch adds the user namespace.
> >
> > Basically, it allows a process to unshare its user_struct table,
> > resetting at the same time its own user_struct and all the
> > associated accounting.
> >
> > For the moment, the root_user is added to the new user namespace
> > when it is cloned. An alternative behavior would be to let the
> > system allocate a new user_struct(0) in each new user namespace.
> > However, these 0 users would not have the privileges of the
> > root_user and it would be necessary to work on the process
> > capabilities to give them some permissions.
> 
> It is completely the wrong thing for a the root_user to span multiple
> namespaces as you describe. It is important for uid 0 in other
> namespaces to not have the privileges of the root_user. That is half
> the point.
>
> Too many files in sysfs and proc don't require caps but instead simply
> limit things to uid 0. Having a separate uid 0 in the different
> namespaces instantly makes all of these files inaccessible, and keeps
> processes from doing something bad.

well, here I'd definitely prefer to fix up that 'broken'
entries by adding proper capability checks, and maybe
even a bunch of new capabilities (i.e. 64bit caps and
such) first, because IMHO the capability system is the
'proper' method to protect them in the first place

> To a filesystem a uid does not share a uid namespace with the
> only things that should be accessible are those things that are
> readable/writeable by everyone. Unless the filesystem has provisions
> for storing multiple uid namespaces not files should be able to be
> created. Think NFS root squash.

that's where file tagging as Linux-VServer does it can
be used to 'share' a partition between different guests
(and have separate disk limits and quotas)

best,
Herbert

> > Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> > Cc: Andrew Morton <akpm@osdl.org>
> > Cc: Kirill Korotaev <dev@openvz.org>
> > Cc: Andrey Savochkin <saw@sw.ru>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Herbert Poetzl <herbert@13thfloor.at>
> > Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
> > Cc: Serge E. Hallyn <serue@us.ibm.com>
> > Cc: Dave Hansen <haveblue@us.ibm.com>
> >
> > ---
> >  fs/ioprio.c               |    5 +
> >  include/linux/init_task.h |    2 
> >  include/linux/nsproxy.h   |    2 
> >  include/linux/sched.h     |    6 +-
> >  include/linux/user.h      |   45 +++++++++++++++
> >  init/Kconfig              |    8 ++
> >  kernel/nsproxy.c          |   15 ++++-
> >  kernel/sys.c              |    8 +-
> >  kernel/user.c | 135 ++++++++++++++++++++++++++++++++++++++++++----
> 
> This patch looks extremly incomplete.
> 
> Every comparison of a user id needs to compare the tuple
> (user namespace, user id) or it needs to compare struct users.
> 
> Ever comparison of a group id needs to compare the tuple
> (user namespace, group id) or it needs to compare struct users.
> 
> I think the key infrastructure needs to be looked at here as well.
> 
> There needs to be a user namespace association for mounted filesystems.
> 
> We need a discussion about how we handle map users from one user
> namespace to another, because without some form of mapping so many
> things become inaccessible that the system is almost useless.
> 
> I believe some of the key infrastructure which is roughly kerberos
> authentication tokens could be used for this purpose.
> 
> A user namespace is a big thing.  What I see here doesn't even
> seem to scratch the surface.
> 
> Eric
