Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSHBTGj>; Fri, 2 Aug 2002 15:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSHBTGj>; Fri, 2 Aug 2002 15:06:39 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14053 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S316788AbSHBTGi>;
	Fri, 2 Aug 2002 15:06:38 -0400
Message-ID: <3D4AD8F5.1090107@us.ibm.com>
Date: Fri, 02 Aug 2002 12:09:41 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: Kasper Dupont <kasperd@daimi.au.dk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Race condition?
References: <3D4A8D45.49226E2B@daimi.au.dk> <200208021700.g72H0bm02654@fachschaft.cup.uni-muenchen.de> <3D4AC352.70702@us.ibm.com> <200208021858.g72Iwam03030@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
>>The root of the problem is that the reference count is being relied on
>>for the wrong thing.  There is a race on p->user between the
>>dup_task_struct() and whenever the atomic_inc(&p->user->__count)
>>occcurs.   The user reference count needs to be incremented in
>>dup_task_struct(), before the copy occurs.
> 
> I don't get you. The user_struct can hardly go away while we are
> forking.

Good point.  I was figuring that it could disappear when the task 
clearly can't be exiting or setuid'ing while forking.

> IMHO you should add a spinlock to user_struct and take it.
> A clear solution that doesn't hurt the common case.

That _is_ a pretty clear solution.  It looks like there are grand 
plans for struct user, so it might come in handy in the future.  But, 
a spinlock _will_ hurt the common case.  With the atomic incs, we have 
2 of them in the common case and, at most, 4 in the failure case. 
Adding a spinlock will require more lock instructions, which are the 
most costly operations in either a spinlock or atomic op.

Either of these are _incredibly_ small prices to pay in any case. 
Forks are slow anyway.  A spinlock would be just fine with me.
-- 
Dave Hansen
haveblue@us.ibm.com

