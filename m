Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKBTU5>; Thu, 2 Nov 2000 14:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKBTUr>; Thu, 2 Nov 2000 14:20:47 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:58123 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129208AbQKBTUg>;
	Thu, 2 Nov 2000 14:20:36 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Mansfield <lkml@dm.ultramaster.com>
Date: Thu, 2 Nov 2000 20:18:21 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: mmap_sem (and generic) semaphore fairness question
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <BBA8C940BB2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Nov 00 at 13:51, David Mansfield wrote:
> Is it possible for the following to happen repeatedly, keeping B from
> ever aquiring S.
> 
> 1) Resource becomes available.
> 2) A is 'runnable' and is given an entire timeslice.
> 3) schedule() to A
> 4) A releases S
> 5) A returns to userspace
> 6) A uses much less than entire timeslice doing calculation
> 7) A needs some resource again
> 7) A enters kernel and aquires S
> 8) A sleeps on resource, rest of timeslice not used, A's 'goodness'
> isn't messed up.
> 9) goto 1.
> 
> In this scenario, as long as A never uses it's full timeslice, B will
> never get to aquire S.

Yes, it can happens. It for sure happens in ncpfs - as ncpfs uses
ping-pong protocol, and I'm lazy to use different thing than semaphore,
connection to server is guarded by semaphore.

If one task does long read/write, nobody else can perform any operation 
on mountpoint (these processes are listed in "D", as usual). As soon as 
copying task pauses (writting readed data to another FS, pagefault), other
of competing tasks starts... If you'll start two copies in parallel, each
task usually copies each file without any progress on other task. After
copying one file, other task starts copying...

For now I solved it by adding second processor into the box ;-)
But if anybody has easy (or nice) implementation of fair semaphore,
or an idea how to fix it, I'd like to put it into ncpfs...

Probably creating safe_semaphore by moving sem->count++ from up() 
(when up does __up_wakup) to __down_failed could work. But it is not
nice, as implementation of this idea requires spinlock in safe_up() 
fastpath...
                                       Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
