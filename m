Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUFXJ3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUFXJ3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUFXJ3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:29:33 -0400
Received: from chnmfw01.eth.net ([202.9.145.21]:64517 "EHLO ETH.NET")
	by vger.kernel.org with ESMTP id S264048AbUFXJ30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:29:26 -0400
Message-ID: <001901c459cd$bc436e40$868209ca@home>
From: "Amit Gud" <gud@eth.net>
To: <linux-kernel@vger.kernel.org>
Cc: "Mark Watts" <mrwatts@fast24.co.uk>, "Mark Cooke" <mpc@jts.homeip.net>
References: <40d9ac40.674.0@eth.net> <200406231853.35201.mrwatts@fast24.co.uk> <1088016048.15211.10.camel@sage.kitchen>
Subject: Re: Elastic Quota File System (EQFS)
Date: Thu, 24 Jun 2004 14:58:30 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 24 Jun 2004 09:21:46.0468 (UTC) FILETIME=[ABDB1A40:01C459CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this is what I propose:

    Lets say there are just 2 users with 100 megs of individual quota, user
A is using 20 megs and user B is running out of his quota. Now what B could
do is delete some files himself and make some free space for storing other
files. Now what I say is instead of deleting the files, he declares those
files as elastic.

Now, moment he makes that files elastic, that much amount of space is added
to his quota. Here Mark Cooke's equation applies with some modifications:
N no. of users,
Qi allocated quota of ith user
Ui individual disk usage of ith user ( should be <= allocated quota of ith
user ),
D disk threshold; thats the amount of disk space admin wants to allow the
users to use (should be >= sum of all users' allocated quota, i.e. summation
Qi ; for i = 0 to N - 1).

Total usage of all the users (here A & B) should be at _anytime_ less than
D. i.e. summation Ui <= D; for i = 0 to N - 1.

The point to note here is that we are not bothering how much quota has been
allocated to an individual user by the admin, but we are more interested in
the usage pattern followed by the users. E.g. if user B wants additional
space of say 25 megs, he picks up 25 megs of his files and 'marks' them
elastic. Now his quota is increased to 125 megs and he can now add more 25
megs of files; at the same time allocated quota for user A is left
unaffected. Applying the above equation total usage now is A: 20 megs, B:
125 megs, now total 145 <= D, say 200 megs. Thus this should be ok for the
system, since the usage is within bounds.

Now what happens if Ui > D? This can happen when user A tries to recliam his
space. i.e. if user A adds say more 70 megs of files, so the total usage is
now - A: 90 megs, B: 125 megs; 215 ! <= D. The moment the total usage
crosses the value, 'action' will be taken on the elastic files. Here elastic
files are of user B so only those will be affected and users A's data will
be untouched, so in a way this will be completely transparent to user A.
What action should be taken can be specified by the user while making the
files elastic. He can either opt to delete the file, compress it or move it
to some place (backup) where he know he has write access. The corresponding
action will be taken until the threshold is met.

Will this work?? We are relying on the 'free' space ( i.e. D - Ui ) for the
users to benefit. The chances of having a greater value for D - Ui increases
with the increase in the number of users, i.e. N. Here we are talking about
2 users but think of 10000+ users where all the users will probably never
use up _all_ the allocated disk space. This user behavior can be well
exploited.

EQFS can be best fitted in the mail servers. Here e.g. I make whole
linux-kernel mailing list elastic. As long as Ui <= D I get to keep all the
messages, whenever Ui > D, messages with latest dates will be 'acted' upon.

For variable quota needs, admin can allocate different quotas for different
users, but this can get tiresome when N is large. With EQFS, he can allocate
fixed quota for each user ( old and new ) , set up a value for D and relax.
The users will automatically get the quota they need. One may ask that this
can be done by just setting up value of D, checking it against summation Ui
and not allocating individual quotas at all. But when summation Ui crosses D
value, whose file to act on? Moreover with both individual quotas and D, we
give users 'controlled' flexibility just like elastic - it can be stretched
but not beyond a certain range.

What happens when an user tries to eat up all the free ( D - Ui ) space?
This answer is implementation dependent because you need to make a decision:
should an user be allowed to make a file elastic when Ui == D . I think by
saying 'yes' we eliminate some users' mischief of eating up all free space.

Queries, comments, suggestions welcome.

regs,
AG

> On Wed, 2004-06-23 at 18:53, Mark Watts wrote:
> > > Greetings,
> > >
> > > I think I should discuss this in the list...
> > >
> > > Recently I'm into developing an Elastic Quota File System (EQFS). This
> > > file system works on a simple concept ... give it to others if you're
not
> > > using it, let others use it, but on the guarantee that you get it back
when
> > > you need it!!
> >
> > How do you intend to guarantee this?
> > Randomly deleting a users files to free up disk space is a Bad (tm)
idea, so
> > what other mechanism are you going to employ?
>
> Hi Mark, Amit,
>
> Simple example of a flexible quota scheme:
>
> N users with Q megabytes of guaranteed quota
> D total megs of disk storage
> The difference D - N*Q is the amount you can be flexible with.
>
>
> The above is a somewhat different scheme than the 'give your unused
> quota back to others' part of Amit's post though.
>
> If Amit does actually mean to have a situation where the remaining
> guaranteed quota is less than the actual remaining free space, there is
> *no way* to satisfy the guarantee.
>
> Imagine the worst case scenario if all users suddenly want their
> guaranteed quota.  The only way to free up space is deleting files from
> over-quota users - something which would be unacceptable operationally,
> IMHO.
>
>
> That said, I'll read your tech description with interest when it comes
> out,
>
> Mark
>


