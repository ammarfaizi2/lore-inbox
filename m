Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbWGNOSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbWGNOSa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWGNOSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:18:30 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45210 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161105AbWGNOS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:18:29 -0400
Date: Fri, 14 Jul 2006 09:17:28 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
Message-ID: <20060714141728.GE28436@sergelap.austin.ibm.com>
References: <20060711075051.382004000@localhost.localdomain> <20060711075420.937831000@localhost.localdomain> <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com> <44B50088.1010103@fr.ibm.com> <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> Cedric Le Goater <clg@fr.ibm.com> writes:
> 
> > Eric W. Biederman wrote:
> >> Cedric Le Goater <clg@fr.ibm.com> writes:
> >> 
> >>> This patch adds the user namespace.
> >>>
> >>> Basically, it allows a process to unshare its user_struct table,
> >>> resetting at the same time its own user_struct and all the associated
> >>> accounting.
> >>>
> >>> For the moment, the root_user is added to the new user namespace when
> >>> it is cloned. An alternative behavior would be to let the system
> >>> allocate a new user_struct(0) in each new user namespace. However,
> >>> these 0 users would not have the privileges of the root_user and it
> >>> would be necessary to work on the process capabilities to give them
> >>> some permissions.
> >> 
> >> It is completely the wrong thing for a the root_user to span multiple
> >> namespaces as you describe.  It is important for uid 0 in other namespaces
> >> to not have the privileges of the root_user.  That is half the point.
> >
> > ok good. that's what i thought also.
> >
> >> Too many files in sysfs and proc don't require caps but instead simply
> >> limit things to uid 0.  Having a separate uid 0 in the different namespaces
> >> instantly makes all of these files inaccessible, and keeps processes from
> >> doing something bad.
> >
> > but in order to be useful, the uid 0 in other namespaces will need to have
> > some capabilities.
> 
> Yes.  It is useful for uid 0 in other namespaces to have some capabilities.
> But that is just a matter of giving another user some additional
> capabilities.  That mechanism may still work but it should not be
> namespace specific magic there.  The trick I guess is which
> capabilities a setuid binary for the other root user gets.

Agreed.  Any ideas for how to specify this?  In a sane way?  I suppose
it could be a part of forking off the user namespace.  No idea what
interface we'd want to use.  Perhaps root user in the child namespace by
default gets all the caps as the root user, and is expected to drop what
it doesn't need?

> One thing to be careful about here is that, at least as I 
> envision it until setresuid is called your user does not change
> even when you unshare your user namespace.
> 
> >> To a filesystem a uid does not share a uid namespace with the only things
> >> that should be accessible are those things that are readable/writeable
> >> by everyone.   Unless the filesystem has provisions for storing multiple
> >> uid namespaces not files should be able to be created.  Think NFS root
> >> squash.
> >
> > I think user namespace should be unshared with filesystem. if not, the
> > user/admin should know what is doing.
> 
> No.  The uids in a filesystem are interpreted in some user namespace
> context.  We can discover that context at the first mount of the
> filesystem.  Assuming the uids on a filesystem are the same set
> of uids your process is using is just wrong.

But, when I insert a usb keychain disk into my laptop, that fs assumes
the uids on it's fs are the same as uids on my laptop...

Solving that problem is interesting, but may be something to work with a
much wider community on.  I.e. the cifs and nifs folks.  I haven't even
googled to see what they say about it.

> > now, we could work on extending it to support fine grain user namespace
> > which i think can done on top of this first patch.
> 
> Yes.  Your patch does lay some interesting foundation work.
> But we must not merge it upstream until we have a complete patchset
> that handles all of the user namespace issues.

Don't think Cedric expected this to be merged  :)  Just to start
discussion, which it certainly did...

> >> I think the key infrastructure needs to be looked at here as well.
> >>
> >> There needs to be a user namespace association for mounted filesystems.
> >
> > yes you could expect that to check the i_uid against fsuid but should we
> > enforce it completely ?
> >
> > we already have an issue today with a simple NFS mount on 2 hosts with
> > different user mapping. namespace can't fix all issues.
> 
> Yes.  This is an existing problem, which we have just escalated the
> frequency of immensely if we are doing user namespaces.  The normal
> solution is to put everyone on the network in a single user id
> administration domain with ldap or NIS.
> 
> However that is avoiding the problem, and having multiple user id
> domains is the point of a user id namespace.  If we escalate the
> problem we should solve it.

Of course if we solve it in that way, then we may not need user
namespaces any more  :)  Only the root user ends up still shared, and
even that could be solved if we're doing something that drastic.

> keys are essentially security credentials for something besides the
> local kernel.  Think kerberos tickets.  That makes the keys the
> obvious place to say what uid you are in a different user namespace
> and similar things.

If we're going to talk about keys (which I'd like to) I think we need to
decide whether we are just using them as an easy wider-than-uid
identifier, or if we actually need cryptographic keys to prevent
"identity theft"  (heheh).  I don't know that we need the latter for
anything, but of course if we're going to try for a more general
solution, then we do.

-serge
