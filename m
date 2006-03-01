Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWCAE7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWCAE7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWCAE7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:59:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7654 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750825AbWCAE7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:59:04 -0500
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>
	<20060228190535.41a8c697.pj@sgi.com>
	<m1wtfepzpu.fsf@ebiederm.dsl.xmission.com>
	<20060228202632.cba12ae7.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Feb 2006 21:57:34 -0700
In-Reply-To: <20060228202632.cba12ae7.pj@sgi.com> (Paul Jackson's message of
 "Tue, 28 Feb 2006 20:26:32 -0800")
Message-ID: <m1mzgapxs1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> Eric wrote:
>> The logic is can I access this file in some other way besides through
>> /proc.
>> 
>> When applied to /proc/<pid>/exe
>> When applied to /proc/<pid>/root
>> When applied to /proc/<pid>/cwd
>
> I can't make sense of the above.  Could you elaborate?

Sorry.  What I ment was when applied to the above files the
permission checks are not quite correct because I should check
to see if you share a fs_struct with them, checking for a shared
files_struct for exe,root,cwd is nonsense.

The permission check is not quite in the right place yet
in /proc.

The logical check which I have implemented imperfectly is:
Without going through /proc/fd can I see this file.

Part of the reason this happens now is the old check
unchanged since 2.2 was it only checked to see if the two
processes were in the same chroot.  I made the check test
the actual files that were returned.  Which is much more
correct, and much more likely to prevent information leaks.

> And explain how any of these permission checks fail for
> a root shell?

Because I probably need a check something like
if (capable(CAP_DAC_OVERRIDE))
	return 0;
To allow an appropriately privileged root user to do anything.

The short answer is that I bug fixed the permission checks into working
but that is not sufficient for the permission checks to be correct. :(

These checks were previously done so badly they were mistaken for
generic permission checks that all files in /proc should have.  Which
resulted in tons of useless cruft.

At this point the code is working as designed but it is clearly not
working as it needs to.

I am also beginning to think that readlink and followlink
should have different permissions.  Especially to keep fuser
and his friends happy.

I am glad I found this issue with permissions on /proc/<pid>/fd,
but it is clear there is still more todo.

Ok. Now back to hunting bugs that crash the kernel.


Eric
