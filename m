Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWCAGNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWCAGNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 01:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWCAGNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 01:13:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60902 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932449AbWCAGNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 01:13:17 -0500
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Feb 2006 23:11:59 -0700
In-Reply-To: <20060228212501.25464659.pj@sgi.com> (Paul Jackson's message of
 "Tue, 28 Feb 2006 21:25:01 -0800")
Message-ID: <m18xrupuc0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> Eric wrote:
>> I can kill a kernel this way as well.  Thanks this looks like
>> a good reproducer I will see if  I can figure out why.
>
> I suspect two problems, one with your patches that the fuser provokes,
> and a separate bug earlier in *-mm that the DEBUG options noted below
> provoke.
>
> Details:
>
> In addition to the problem that shows up with the three patches
>>     proc-dont-lock-task_structs-indefinitely.patch
>>     proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
>>     proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
>
> when running the fuser command:
>>     /bin/fuser -n tcp 5553
>
> I am seeing as a separate bug the crash during boot that I reported
> last, when I turned on some DEBUG options.  That crash occurs even with
> none of your proc patches.

Ok.  I think I have found the big bug in my task_ref patches.

I had missed that __unhash_process got moved outside of the
tasklist_lock.  Which messed up my serialization with detach_pid.

My gut feel says modifying doubly linked lists without a lock isn't 
even safe.  Which is probably why I never considered the possibility.

Now to think through what this means in terms of locking.

Eric
