Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274464AbRITMkc>; Thu, 20 Sep 2001 08:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274463AbRITMkM>; Thu, 20 Sep 2001 08:40:12 -0400
Received: from t2.redhat.com ([199.183.24.243]:8181 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S274461AbRITMkG>; Thu, 20 Sep 2001 08:40:06 -0400
To: manfred@colorfullife.com, andrea@suse.de
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from Studierende der Universitaet des Saarlandes <masp0008@stud.uni-sb.de> 
   of "Thu, 20 Sep 2001 10:57:08 -0000." <3BA9CB84.16616163@stud.uni-saarland.de> 
Date: Thu, 20 Sep 2001 13:40:29 +0100
Message-ID: <16291.1000989629@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David, coredump is the only difficult recursive user of mmap_sem.  ptrace &
> /proc/pid/mem double buffer into kernel buffers, fork just doesn't lock the
> new mm_struct - it's new, noone can get a pointer to it before it's linked
> into the various lists.

Yes, you're right. So what you and Andrea are proposing is to have a field in
the task struct that counts the number of active readlocks you hold on your
own mm_struct. If this is >0, then you can add another readlock to it. If this
is the case, then you can add an extra asm-rwsem operation that simply
increments the semaphore counter. BUT you can only use this operation if you
_know_ you already have a readlock. And as you know that some function higher
up the stack holds the lock, you can guarantee that the lock isn't going to go
away.

Give me a few minutes, and I can handle this:-)

David
