Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSJ0Qtp>; Sun, 27 Oct 2002 11:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbSJ0Qtp>; Sun, 27 Oct 2002 11:49:45 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:44728 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262464AbSJ0Qtp>;
	Sun, 27 Oct 2002 11:49:45 -0500
Message-ID: <3DBC1A6B.7020108@colorfullife.com>
Date: Sun, 27 Oct 2002 17:55:07 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Waechtler <pwaechtler@mac.com>
CC: linux-kernel@vger.kernel.org
Subject: Re:  [PATCH] unified SysV and Posix mqueues as FS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > - notification not tested
 > - still linear search in queues

Is that a problem? Receive does one linear search of the queued 
messages, send does one linear search of the waiting receivers. Both 
lists should be short.

Could you split your patch into the functional changes and cleanup? 
(const, size_t, you move a few definitions around, whitespace cleanups)

I don't like the deep integration of the mqueues into the sysv code - is 
that really needed?
For example, you add the mqueue messages into the sysv array, and then 
add lots of code to separate both again - IPC_RMID cannot remove posix 
queues, etc.

Have you tried to separate both further? Create a ramfs like filesystem, 
store msg_queue in the inode structure?
The ids array is only for sysv, only the actual message handling is 
shared between sysv msg and posix mqueues

> +  msq->q_flags |= MSG_UNLK;
Is a "unlinked" flag needed for sysv msg? When a message queue is 
deleted, all pending writes and reads are cancleled.
Copy and paste from shm? shm needs unlinked handling, msg doesn't.

> +  msq->q_perm.key = IPC_PRIVATE; /* Do not find it any more */
Does that work? The key is only needed for msgget(), not for msgsnd() or 
msgrcv()
> +  msg_unlock (inode->i_ino);

--
	Manfred


