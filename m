Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSKIOKO>; Sat, 9 Nov 2002 09:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265562AbSKIOKO>; Sat, 9 Nov 2002 09:10:14 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:23199 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265517AbSKIOKM>;
	Sat, 9 Nov 2002 09:10:12 -0500
Message-ID: <3DCD18D4.90609@colorfullife.com>
Date: Sat, 09 Nov 2002 15:16:52 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: bk@suse.de
Subject: [RFC,PATCH] remove lockless receive from ipc/msg.c
Content-Type: multipart/mixed;
 boundary="------------000302020001000601030106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000302020001000601030106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Bernhard Kaindl noticed a race in the lockless receive path of msgrcv():
If a signal wakes up the thread that sleeps in msgrcv(), then 
pipelined_send() can access an already invalid structure. This can cause 
oopses during wake_up_process().

http://marc.theaimsgroup.com/?l=linux-kernel&m=103599896511067&w=2

The simplest solution is to remove the lockless receive, and always 
acquire the spinlock during receive.
Unfortunately this would increase the number of spinlock operations for 
ipc/msg.c by up to 50%. (from 2 to 3 spinlock calls for msgrcv()+msgsnd())

Any other ideas? Are there workloads that heavily rely on sysv msg?

Patch against 2.5.46 is attached.
--
    Manfred

--------------000302020001000601030106
Content-Type: text/plain;
 name="patch-ipc-race"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ipc-race"

--- 2.5/ipc/msg.c	2002-11-09 00:45:37.000000000 +0100
+++ build-2.5/ipc/msg.c	2002-11-09 15:01:13.000000000 +0100
@@ -799,10 +799,6 @@
 		schedule();
 		current->state = TASK_RUNNING;
 
-		msg = (struct msg_msg*) msr_d.r_msg;
-		if(!IS_ERR(msg)) 
-			goto out_success;
-
 		msq = msg_lock(msqid);
 		msg = (struct msg_msg*)msr_d.r_msg;
 		if(!IS_ERR(msg)) {

--------------000302020001000601030106--

