Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264750AbSJ3RvQ>; Wed, 30 Oct 2002 12:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264751AbSJ3RvQ>; Wed, 30 Oct 2002 12:51:16 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:3782 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264750AbSJ3RvP>;
	Wed, 30 Oct 2002 12:51:15 -0500
Message-ID: <3DC01D91.9020307@colorfullife.com>
Date: Wed, 30 Oct 2002 18:57:37 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernhard Kaindl <bk@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are right, there is a race in pipelined_send, but slightly different 
than in your description:
pipelined_send is carefull not to read the msr pointer after 
wake_up_process, but it does rely on the contents of the msr structure 
after setting msr->r_msg.

I.e. the description is

       CPU 1                    CPU 2

	sys_msgrcv()
	(sleeps for messsage)

				sys_msgsnd()
				pipelined_send()
	(woken up by a signal)
	Notices that a message is there,
	accepts the message and exists.
	stack trashed, perhaps even task structure gone.
	                        wake_up_process(msr->r_tsk)
				*oops - msr is not valid anymore.

Is that possible? Do you apps use signals?

Your fix solves the problem, but I'd prefer to keep the current, lockless receive path - it avoids 50% of the spinlock operations.
I'll write a patch that adds the missing memory barriers and copies the fields before setting msr->r_msg.

--
	Manfred


