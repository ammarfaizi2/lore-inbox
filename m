Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSKTFA1>; Wed, 20 Nov 2002 00:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbSKTFA1>; Wed, 20 Nov 2002 00:00:27 -0500
Received: from ir.com.au ([203.202.109.33]:12732 "EHLO
	ir-exchange-srv.ir.com.au") by vger.kernel.org with ESMTP
	id <S265767AbSKTFA0>; Wed, 20 Nov 2002 00:00:26 -0500
Message-ID: <694BB7191495D51183A9005004C0B05482D50E@ir-exchange-srv.ir.com.au>
From: Rebecca.Callan@ir.com
To: linux-kernel@vger.kernel.org
Subject: decrement of inodes_stat.nr_inodes in inode.c not SMP safe?
Date: Wed, 20 Nov 2002 16:07:29 +1100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The value for nr_inodes in /proc/sys/fs/inode-state appears to be wrong.

I think this is probably a bug in all 2.4 smp kernels. I've seen it in
2.4.8-26mdksmp and 2.4.18-3smp.

I first noticed the bug when sar -v reported inode-sz to be 4294966776. 
I check the sar source code and the documentation and found the value 
of nr_free_inodes (second value in the /proc/sys/fs/inode-state file) is
larger than nr_inodes (the number of allocated inodes - first value in
file). 

I think I have tracked the bug down to an unsafe decrement of 
inodes_stat.nr_inodes in fs/inode.c. This variable is changed in a 
number of places in inode.c and it is locked everywhere except in 
dispose_list(). The comment above dispose_list says:
	 
 * Dispose-list gets a local list with local inodes in it, so it doesn't
 * need to worry about list corruption and SMP locks. 

But inodes_stat.nr_inodes is not local and I think it requires locking.

I am not a kernel developer and don't know exactly how to fix this problem.
I suppose there is a reason why the dispose_list function was designed to 
not use locking so I guess it's not a good idea to put a lock in there. The
only other option I can think of is to use atomic decrement, but I don't
know whether it is safe to atomicaly decrement something that is decremented

elsewhere using locking not an atomic decrement. Is it a good idea to change

all accesses  of this variable to atomic? Would this add unnecessary
overhead? 

Thanks,
Rebecca

