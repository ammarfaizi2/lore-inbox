Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264841AbSJaKxC>; Thu, 31 Oct 2002 05:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264845AbSJaKxC>; Thu, 31 Oct 2002 05:53:02 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:3616 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S264841AbSJaKw7>; Thu, 31 Oct 2002 05:52:59 -0500
Subject: The ACL debate (was: Re: What's left over.)
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1036061965.2425.20.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 31 Oct 2002 05:59:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2002-10-30 at 21:31, Linus Torvalds wrote:
> > > ext2/ext3 ACLs and Extended Attributes
> > 
> > I don't know why people still want ACL's. There were noises about them for 
> > samba, but I'v not heard anything since. Are vendors using this?
> > 
> 
> I am sure I don't count (not being a vendor), but Intermezzo offers
> support for this (they are waiting on feature freeze to redo it to 2.5
> according to an email I have).  I want this stuff.  Yes, u+g+w is nice,
> but good ACLs are even better.  Please, if this is technically correct
> in implementation, do put it in.
> 
> Thank you,
> Trever
> 

I know, bad form and all following up to myself.  Everyone keeps
mentioning how bad ACLs are and how they need user-space regulation. 
Let me explain what I see, what I believe Windows NT/XP does, and
hopefully we can reach some consensus among those who really know.

Problems with normal Unix permissions:
1) You only have three categories (user/owner, group, world/other).

2) Owner can't offer (transfer) ownership to someone else (NT does this
right by making it belong to the owner until the potential new owner
accepts).

3) Limited number of groups.

4) Only root can add groups

5) Only root can change group ownership of a file

What I see NT doing:
1) Owner can allow read, write, delete, execute to anyone or any group
(this is great, though delete and write might as well be the same thing
I think)

2) NT Kernel + fs dictates rights, not the user-land

3) Non-owner user cannot give rights to anyone else (though, I believe
they can remove rights from themselves, though it has been a LONG time
and I am not sure)

4) Owner can offer transfer of ownership (though this may be dumb in
Linux)

5) No need for groups for small numbers of additional users with rwx
abilities

6) On copy the ACL is reset to the owner only.

7) On move, it copies the ACL (see problems with ACLs below)

Where does user-land fit in:
Right now it fits in with chown.  I believe everything else is done in
kernel for permissions now.  Why are we blaming everything on user-land
now with more powerful ACLs/permissions?  You need a tool that can
request that the kernel do xyz update on the ACL for file abc.  The
kernel then says done, you are the owner of the file, or heck no, go
away you aren't the owner even if you have rwx privileges.

Why ACLs are needed:
I know many people who would love to move to Linux for all sorts of
things, but they need ACLs.  Sysadmins can't always be running around
chowning things for different groups, adding users to groups, removing
users to groups, removing dead groups, etc.  ACLs allows the owner of
the file to do things as they really should be done.  ACLs do need at
least a concept of additional users (not owners) of a file.  It would be
nice if it would work with groups too, even if root intervention was
still required for creating groups.

Why are ACLs bad:
1) It takes some brains so that you totally don't screw yourself over
with your data... however this still can happen with the current Unix
permissions.  It just becomes more complex.

2) More complex kernel code... well every feature does.  I believe this
one is worth it.

3) Different file systems have different ACL sets... OK, so what. 
User-space just needs to be able to know what they are on each fs, as
does the kernel.  I don't really think there needs to be a huge issue,
other than on a move.  Copy would reset the ACL to the owner's default
(the new owner, not the original file owner).  Move needs to be able to
copy the ACLs with the file.  Within the same fs type (even if different
volumes), this should be easy.  Between fs types, this may be a problem.

4) New/update user space tools required.  All new features do.  Heck,
networking needs new versions all the time.

5) Disk/kernel bloat.  Make it a compile time option I guess.  Those who
need/want can have, those who don't, good too.

Does POSIX ACLs do all this:
I have no clue.  I don't know if they are sane or not.  I see a proper
ACL definition just extending and working with standard permissions
including the rules of inheritance and priority.

Am I crazy:
I may very well be.  I may have no clue what I am talking about. 
However, I wrote this because I really don't see all the arguments about
how horrible it is because of user-land.

Can most of the positives be emulated via setuid apps:
Maybe.  However, you still are limited to three fields of authorization,
verses the many more of the other.  Also, it would require more
user-land updates to do this than to do it with ACLs IMHO.

Thank you for your time and corrections where I am wrong.  Please,
direct flames to your /dev/null mine is full :)

Trever Adams

