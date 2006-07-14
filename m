Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWGNPG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWGNPG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 11:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbWGNPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 11:06:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56299 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030453AbWGNPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 11:06:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<44B50088.1010103@fr.ibm.com>
	<m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<20060714141728.GE28436@sergelap.austin.ibm.com>
Date: Fri, 14 Jul 2006 09:05:41 -0600
In-Reply-To: <20060714141728.GE28436@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 14 Jul 2006 09:17:28 -0500")
Message-ID: <m1fyh4w7ju.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> Cedric Le Goater <clg@fr.ibm.com> writes:
>> 
>> > Eric W. Biederman wrote:
>> >> Cedric Le Goater <clg@fr.ibm.com> writes:
>> >> 
>> >>> This patch adds the user namespace.
>> >>>
>> >>> Basically, it allows a process to unshare its user_struct table,
>> >>> resetting at the same time its own user_struct and all the associated
>> >>> accounting.
>> >>>
>> >>> For the moment, the root_user is added to the new user namespace when
>> >>> it is cloned. An alternative behavior would be to let the system
>> >>> allocate a new user_struct(0) in each new user namespace. However,
>> >>> these 0 users would not have the privileges of the root_user and it
>> >>> would be necessary to work on the process capabilities to give them
>> >>> some permissions.
>> >> 
>> >> It is completely the wrong thing for a the root_user to span multiple
>> >> namespaces as you describe.  It is important for uid 0 in other namespaces
>> >> to not have the privileges of the root_user.  That is half the point.
>> >
>> > ok good. that's what i thought also.
>> >
>> >> Too many files in sysfs and proc don't require caps but instead simply
>> >> limit things to uid 0.  Having a separate uid 0 in the different namespaces
>> >> instantly makes all of these files inaccessible, and keeps processes from
>> >> doing something bad.
>> >
>> > but in order to be useful, the uid 0 in other namespaces will need to have
>> > some capabilities.
>> 
>> Yes.  It is useful for uid 0 in other namespaces to have some capabilities.
>> But that is just a matter of giving another user some additional
>> capabilities.  That mechanism may still work but it should not be
>> namespace specific magic there.  The trick I guess is which
>> capabilities a setuid binary for the other root user gets.
>
> Agreed.  Any ideas for how to specify this?  In a sane way?  I suppose
> it could be a part of forking off the user namespace.  No idea what
> interface we'd want to use.  Perhaps root user in the child namespace by
> default gets all the caps as the root user, and is expected to drop what
> it doesn't need?

Currently this is a security module policy, so it gets weird.
The default is:
> int cap_bprm_set_security (struct linux_binprm *bprm)
> {
> 	/* Copied from fs/exec.c:prepare_binprm. */
> 
> 	/* We don't have VFS support for capabilities yet */
> 	cap_clear (bprm->cap_inheritable);
> 	cap_clear (bprm->cap_permitted);
> 	cap_clear (bprm->cap_effective);
> 
> 	/*  To support inheritance of root-permissions and suid-root
> 	 *  executables under compatibility mode, we raise all three
> 	 *  capability sets for the file.
> 	 *
> 	 *  If only the real uid is 0, we only raise the inheritable
> 	 *  and permitted sets of the executable file.
> 	 */
> 
> 	if (!issecure (SECURE_NOROOT)) {
> 		if (bprm->e_uid == 0 || current->uid == 0) {
> 			cap_set_full (bprm->cap_inheritable);
> 			cap_set_full (bprm->cap_permitted);
> 		}
> 		if (bprm->e_uid == 0)
> 			cap_set_full (bprm->cap_effective);
> 	}
> 	return 0;
> }

My gut feel is that we put a cap_suid in struct user, and the
setup some kind of user interface to it.  And then just
have the above routine copy cap_suid from the struct user
and not special case uid == 0.

But only the root user would by default have any caps in his
struct user.

>> No.  The uids in a filesystem are interpreted in some user namespace
>> context.  We can discover that context at the first mount of the
>> filesystem.  Assuming the uids on a filesystem are the same set
>> of uids your process is using is just wrong.
>
> But, when I insert a usb keychain disk into my laptop, that fs assumes
> the uids on it's fs are the same as uids on my laptop...

I agree that setting the fs_user_namespace at mount time is fine.
However when we use a mount that a process in another user namespace
we need to not assume the uids are the same.

Do you see the difference?

> Solving that problem is interesting, but may be something to work with a
> much wider community on.  I.e. the cifs and nifs folks.  I haven't even
> googled to see what they say about it.

Yes.

>> Yes.  Your patch does lay some interesting foundation work.
>> But we must not merge it upstream until we have a complete patchset
>> that handles all of the user namespace issues.
>
> Don't think Cedric expected this to be merged  :)  Just to start
> discussion, which it certainly did...

If we could have [RFC] in front of these proof of concept patches
it would clear up a lot of confusion.

> If we're going to talk about keys (which I'd like to) I think we need to
> decide whether we are just using them as an easy wider-than-uid
> identifier, or if we actually need cryptographic keys to prevent
> "identity theft"  (heheh).  I don't know that we need the latter for
> anything, but of course if we're going to try for a more general
> solution, then we do.

Actually I was thinking something as mundane as a mapping table.  This
uid in this namespace equals that uid in that other namespace.

Eric
