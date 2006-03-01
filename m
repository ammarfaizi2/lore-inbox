Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWCAUqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWCAUqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWCAUqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:46:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36993 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932443AbWCAUqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:46:03 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com, Paul Jackson <pj@sgi.com>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr> <20060301023235.735c8c47.akpm@osdl.org>
	<1141221511.7775.10.camel@homer> <4405B4AA.7090207@free.fr>
	<1141227199.10460.2.camel@homer>
	<20060301121218.68fb3f76.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 01 Mar 2006 13:43:53 -0700
In-Reply-To: <20060301121218.68fb3f76.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 1 Mar 2006 12:12:18 -0800")
Message-ID: <m1wtfdnbee.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Mike Galbraith <efault@gmx.de> wrote:
>>
>> On Wed, 2006-03-01 at 15:50 +0100, Laurent Riffard wrote:
>> >  
>> > 
>
> OK, thanks guys.  Eric, could you please cook up something to make the
> permissions appear-to-work as expected?

I'm thinking about it. Implementing it is easy.  Figuring out what the
check for the /proc/<pid>/fd/<#> files should be is trickier.

What disturbs me is that by my current reading of the code all of the
cool file descriptor passing of unix domain sockets is unnecessary.
You can just walk up to any process and open any file it has open.

This includes sockets and pipes and the like, as well as files.

We don't bypass individual file permission checks as far as I can
tell but we do bypass all directory permission checks.

This seems to defeat the concept of using file descriptors as
capabilities.  Heck even plan9 makes you bind your file descriptor
to your filesystem namespace before it was exported.

In the presence of chroot jails and multiple namespaces this is also
possible.

Now maybe this is all fine, and since this is what we have been doing
for years maybe it isn't a security bug, and I can just kill the
check altogether.

My gut says this is an ancient permission checking bug, and I have
started closing the hole.

So if anyone can help me wrap my head around what is expected and why.
I would greatly appreciate it.

The fuser and lsof cases seem to one aspect of it, that I had
not looked at.

Eric
