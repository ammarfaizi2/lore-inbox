Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131752AbQLYQj3>; Mon, 25 Dec 2000 11:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131775AbQLYQjS>; Mon, 25 Dec 2000 11:39:18 -0500
Received: from mout0.freenet.de ([194.97.50.131]:24523 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S131752AbQLYQjI>;
	Mon, 25 Dec 2000 11:39:08 -0500
From: Andreas Franck <afranck@gmx.de>
Date: Mon, 25 Dec 2000 17:12:34 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.Linu.4.10.10012250531020.560-100000@mikeg.weiden.de>
In-Reply-To: <Pine.Linu.4.10.10012250531020.560-100000@mikeg.weiden.de>
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
Cc: Mike Galbraith <mikeg@wen-online.de>
MIME-Version: 1.0
Message-Id: <00122517123400.00573@dg1kfa.ampr.org>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike, hello linux-kernel hackers,

Mike Galbraith wrote:
> I wouldn't (not going to here;) spend a lot of time on it.  The compiler
> has problems.  It won't build glibc-2.2, and chokes horribly on ipchains.

Maybe, but you were lucky getting an ICE, and not silently failing code :-)

After having spent several hours debugging now, I think it was 
worth it (at least for my understanding of lower-level kernel issues and of 
the (rather nice and almost readable) assembly code gcc generates). There 
seems to be something going wrong in the down(sem) path after the 
kernel_thread call. 

I'm not sure if down() succeeds instantly when compiling the kernel with 
2.95.2, but it seems to fail for 2.97; I figured out by spilling some 
printk's around in bdflush_init, which made the bug magically disappear, due 
to the looser timing. This also might happen for compiling with frame 
pointers or with the static declaration variables, somehow.

Th bdflush_init function itself does not seem to be responsible, which 
corresponds with the assembly, which is fine and should get the same results 
for all compiled cases.

It seems that whyever, the cause for this failure is actually the down(sem) 
call on a not yet up()'ed semaphore, and this is where it starts to get ugly.

down() then calls __down_failed, which ends up in __down(); __down does some 
waitqueue handling, which I don't understand, and then calls __wake_up - up 
to then, everything seems fine, in __wake_up it is where my search ended up 
to now, but I think something is wrong in this context; however, the 
complexity of this code exceeds my knowledge by magnitudes, so I can't 
continue searching there without going mad :-)

It would be nice if someone else could look from there on, now I've narrowed 
the case down to rather low-level functions.

Greetings,
Andreas

-- 
->>>----------------------- Andreas Franck --------<<<-
---<<<---- Andreas.Franck@post.rwth-aachen.de --->>>---
->>>---- Keep smiling! ----------------------------<<<-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
