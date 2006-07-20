Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWGTUkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWGTUkw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 16:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWGTUkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 16:40:52 -0400
Received: from waha.wetafx.co.nz ([210.55.0.200]:55424 "EHLO waha.wetafx.co.nz")
	by vger.kernel.org with ESMTP id S1750798AbWGTUkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 16:40:51 -0400
Message-ID: <44BFEA4C.6050602@wetafx.co.nz>
Date: Fri, 21 Jul 2006 08:40:44 +1200
From: Bill Ryder <bryder@wetafx.co.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 Thunderbird/1.5.0.4 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc1]  Make group sorting optional in the 2.6.x
 kernels
References: <44B32888.6050406@wetafx.co.nz> <20060719080213.GA22925@janus> <44BE936B.3080107@wetafx.co.nz> <20060720093557.GA1796@janus>
In-Reply-To: <20060720093557.GA1796@janus>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all a reminder.

We have proprietary UNIX here.

All I need from linux is that it obeys the setgroups(2) POSIX call - at
least  in the first 16 groups.


Frank van Maarseveen wrote:
> On Thu, Jul 20, 2006 at 08:17:47AM +1200, Bill Ryder wrote: [...]
>> As an aside Frank - can you point at a paper which provides a
>> walkthrough of how your patch  works and what the caveats are?
>
> http://www.frankvm.com/nfs-ngroups/README

I  read that when I was first researching this. But I couldn't see how
it works based on the description. Bearing in mind I do not spend hours
understanding how the kernel walks permissions and paths.

By walkthrough I mean a walkthrough of permissions checking for the
paths I outlined below. The test case being where every file is in a
different group (and of course the groups are outside fo the first 16
groups in the grouplist). You can not assume their parent directory
belongs to the same group as the file.

This isn't a walkthrough:

<quote>

It is fairly simple to predict the group id's which might make a difference
in an operation on NFS on the client system, assuming the NFS server does
permission checking conform UNIX. This is not a bad assumption when NFS
uses RPC with AUTH_UNIX authentication. Pathnames at system call time
are not handled in one NFS operation (NFS != WebNFS) but by a series
of NFS lookups. Therefor the maximum number of groups required at any
specific point in time is 3 at most: see nfs_rename().

</quote>

Nor is this:

<quote>
Patch 4.x

Group id cache is gone. At the top NFS layer the group ids of
"interesting" file-system objects are collected (max 3, mostly 1) and
passed downwards. When an RPC credential is created the new AUTH_UNIX
specific unx_add_groups() function will add all the necessary group
information. When the number of groups is 16 or lower then it reverts
to old behavior. When there is no group id information passed downwards
then it reverts to old behavior too. Otherwise, only groups present in
_both_ group information passed downwards and the secondary group list
will be used for the AUTH_UNIX rpc credential (i.e. group lists are
intersected).
</quote>

There are a number of  'assumptions' that I do not have the knowledge to
know if they are reasonable or not.

This phrase is worrying:

When there is no group id information passed downwards
then it reverts to old behavior too.

Why would no group id information be passed?

For someone of my level of knowledge of the kernel the README does not
convince me it will work in all situations. One of my colleagues coined
the phrase  "You can't predict the worse case at Weta DIgital". This is
definitely a true statement for us!

In other words the README assumes a lot of implied knowledge which I
don't have. Hence I don't understand why it doesn't work in the above
case. Which is why I asked for a presentation/paper which would
walkthrough the case below (extending it to > 16 groups of course).


But I will say again just to be sure you understand it's not your patch
that is the problem (or the solution). I need a solution that will work
with *nixs for which I do not have kernel source.

The 'right' way to do this is to use posix calls and/or provides OS
calls to solve the problem in a transparent easy to explain and
understand way to all levels of reasonable IT people.

>
>> For example
>>
>> /top(0)/p1(2)/p3(2)/p4(2)/p5(6)/file1(6)
>> /top(0)/p1(2)/p3(2)/p4(2)/p6(7)/file2(7)
>> /top(0)/p1(2)/p3(2)/p4(2)/p7(8)/file3(6)
>> /top(0)/p1(2)/p3(2)/p4(2)/p7(8)/file4(8)
>>
>> And so on - where the (n) indicated the (gid) for that
>> directory/file. So most of our directories are in the same group.
>> But as you get further down the tree the groups start to change.
>>
>> The process will belong to > 16 groups.
>
> setgroups() require privilege. I don't understand how the above is
> supposed to work for non-root users needing >16 groups. And when
> you're root it is silly to play these group games for getting access.
>

It's no sillier than sg or SCO's sgs. There are clearly defined posix
ways to get this information and to use it. OSx of course has a slightly
different way to handle > 16 groups but it still is sensible and
setgroups still works.

I need to solve the problem of NFS only allowing 16 groups when we have
around 32 groups here.

It needs to work on multiple OSs. At the moment Linux is the only OS
this does not work for (unless we stick to 2.4.x kernels - which is not
acceptable).

Any solution needs to use standard methods (ie using APIs shipped with
the box/OS and using a standard kernel - ie not patched).

At the moment linux 2.6.x breaks the semantics of setgroups,  That needs
to be fixed. I will write a patch for that (at least in the first 16
groups)  It will be small and hopefully easy enought to understand so
that it will be a standard part of the kernel.

That way linux will behave in the same way with respect to the first 16
groups as all the other *nixs we run.

---
Bill Ryder
System Engineer
Weta Digital  - land of virtual  hobbits, Gandalf, Big Monkeys, robots,
mutants and anything else you can imagine that can be rendered, shaded,
modelled, animated, motion captured, tracked, simulated, comped or painted.









