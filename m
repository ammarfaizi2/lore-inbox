Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbTBPS0w>; Sun, 16 Feb 2003 13:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbTBPS0w>; Sun, 16 Feb 2003 13:26:52 -0500
Received: from franka.aracnet.com ([216.99.193.44]:9398 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267320AbTBPS0v>; Sun, 16 Feb 2003 13:26:51 -0500
Date: Sun, 16 Feb 2003 10:36:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.5.61 oops running SDET
Message-ID: <25340000.1045420594@[10.10.2.4]>
In-Reply-To: <24190000.1045419985@[10.10.2.4]>
References: <Pine.LNX.4.44.0302160952280.2619-100000@home.transmeta.com> <24190000.1045419985@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The reason I'd _like_ to see the task lock held over _all_ of the fields
>> in the exit() path is:
>> 
>>  - right now we actually take it and drop it multiple times in exit. See 
>>    __exit_files(), __exit_fs(), __exit_mm(). Which all take it just to 
>>    serialize setting ot "mm/files/fs" to NULL.
>> 
>>  - task_lock is a nice local lock, no global scalability impact.
> 
> Don't we have to take tasklist_lock anyway for when task_state reads
> p->real_parent->pid and p->parent->pid? Or should we have to grab
> the task_lock for those too? If so, it sounds like it could get into 
> rather horrible ordering dependencies to me. 
> 
> If we move exit under task_lock ... then tasklist_lock doesn't help us
> any more there either (presumably we're trying to stop them exiting 
> whilst we look at them) ... I've coded up the stupid approach for now, 
> and will check that works first. Should have results very soon.

Hmmmm ... I guess we could keep real_parent->pid and parent->pid inside
the child's task_struct ... I can't see those change unless we're changing
real_parent / parent task pointers anyway. Not sure how much that idea 
will make people vomit, but it would seem to make it easier to get rid
of the global locking, and it's probably nicer than trying to order the
aquistion of other people's task locks ...

M.

