Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318303AbSG3P5H>; Tue, 30 Jul 2002 11:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318307AbSG3P5H>; Tue, 30 Jul 2002 11:57:07 -0400
Received: from deming-os.org ([63.229.178.1]:26377 "EHLO deming-os.org")
	by vger.kernel.org with ESMTP id <S318303AbSG3P5G>;
	Tue, 30 Jul 2002 11:57:06 -0400
Message-ID: <3D46B7C2.2010905@deming-os.org>
Date: Tue, 30 Jul 2002 08:58:58 -0700
From: Russell Lewis <spamhole-2001-07-16@deming-os.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: "'linux-ia64@linuxia64.org'" <linux-ia64@linuxia64.org>
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
References: <3FAD1088D4556046AEC48D80B47B478C0101F3AE@usslc-exch-4.slc.unisys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDEA: Implement a read/write "bias" field that can show if a lock has 
been gained many  times in succession for either read or write.  When 
locks of the opposite type are attempting (and failing) to get the lock, 
back off the other users until starvation is relieved.

* You would add an unsigned integer field.  When you gain a read lock, 
you check the field.  If it had previously been positive, then just 
increment it.  If it had previously been negative, set it to 1 
(equivalent to setting to 0 and incrementing).  Likewise, if you gain a 
write lock and it had been negative, you DEcrement it, while if it had 
been positive, you set it to -1.  The general idea here is that the bias 
field gives a non-precise view of how many locks of a given type have 
been assigned in a row.
* When you attempt to grab a lock but fail, you set a bit to indicate 
that your are waiting; there is one bit for waiting reads and another 
for waiting writes.
* Before grabbing either a read or write lock, you check the bits and 
the bias field.  If you are grabbing a read AND the bias is positive AND 
the "write waiting" bit is set, then you do NOPs for min(bias,MAX_NOPS) 
cycles BEFORE you attempt to grab the lock.  Likewise, if you are 
grabbing a write AND the bias is negative AND the "read waiting" bit is 
set, then you do NOPs before attempting the grab the lock.
* When you gain either a read or write lock, you clear the "waiting" 
bit.  If there are other waiters that still remain, they will re-set 
that bit soon.

The general idea here is that if there is any lock that is granting an 
excessive amount of either reads or writes, you give preference to the 
other type of lock.  As soon as one of the "other" type of lock is 
granted, the bias field is reset and the whole process starts over. 
 Since the bias field doesn't have to be precise, you can increment it 
non-atomically.

Thoughts?

