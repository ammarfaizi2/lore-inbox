Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWCaGBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWCaGBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWCaGBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:01:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3261 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750847AbWCaGBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:01:49 -0500
To: Chris Wright <chrisw@sous-sol.org>
Cc: Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] Virtualization steps
References: <20060328142639.GE14576@MAIL.13thfloor.at>
	<44294BE4.2030409@yahoo.com.au>
	<m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net>
	<20060329182027.GB14724@sorel.sous-sol.org>
	<442B0BFE.9080709@vilain.net>
	<20060329225241.GO15997@sorel.sous-sol.org>
	<m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
	<20060330013618.GS15997@sorel.sous-sol.org>
	<m164lwfy1c.fsf@ebiederm.dsl.xmission.com>
	<20060330192308.GZ15997@sorel.sous-sol.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 30 Mar 2006 23:00:32 -0700
In-Reply-To: <20060330192308.GZ15997@sorel.sous-sol.org> (Chris Wright's
 message of "Thu, 30 Mar 2006 11:23:08 -0800")
Message-ID: <m1hd5fb1bz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> writes:

> * Eric W. Biederman (ebiederm@xmission.com) wrote:
>> As I currently understand the problem everything goes along nicely
>> nothing really special needed until you start asking the question
>> how do I implement a root user with uid 0 who does not own the
>> machine.  When you start asking that question is when the creepy
>> crawlies come out.
>
> Hehe.  uid 0 _and_ full capabilities.  So reducing capabilities is one
> relatively easy way to handle that.

It comes close the but capabilities are not currently factored correctly.

> And, if you have a security module
> loaded it's going to use security labels, which can be richer than both
> uid and capabilites combined.

Exactly.  You can define the semantics with a security module,
but you cannot define the semantics in terms of uids.

>> On most virtual filesystems the default owner of files is uid 0.
>> Additional privilege checks are not applied.  Writing to those
>> files could potentially have global effect.
>
> Yes, many (albeit far from all) have a capable() check as well.

Nothing controlled by sysctl has a capable check, except
the capabilities sysctl.  The default if not the norm is not
to apply capability checks.

>> It is completely unclear how permissions checks should work
>> between two processes in different uid namespaces.  Especially
>> there are cases where you do want interactions.
>
> Are there?  Why put them in different containers then?  I'd think
> network sockets is the extent of the interaction you'd want.  Sharing
> filesystem does leave room for named pipes and unix domain sockets (also
> in the abstract namespace).  And considering the side channel in unix
> domain sockets, they become a potential hole.  So for solid isolation,
> I'd expect disallowing access to those when the object owner is in a
> different security context from context which is trying to attach.

Yes.  My current implementation has all of that visibility closed,
when you create a new network namespace.  But there are still
interactions.  For me it isn't a real problem though as I have
a single system administrator and synchronized user ids.  For
other use case it is a different story.

In a more normal use case, the container admin can't get out, but
the box admin can get in.  At least for simple things like monitoring
and possibly some debugging.

Or you get weird cases where you want to allow access to some of
the files in /proc to the container but not all.

If I am the machine admin and I have discovered a process in
a container it has a bug and is going wild, it is preferable
to kill that process, or possibly that container rather than
rebooting the box to solve the problem.

All of the normal every day interactions get handled fine and there
is simply no visibility.  But I don't ever expect perfect isolation,
from the machine admin.

I do still need to read up on the selinux mandatory access controls.
Although the comment from the NSA selinux FAQ about selinux being
just a proof-of-concept and no security bugs were discovered or
looked for during it's implementation scares me.  


Eric
