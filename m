Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131071AbQL1AxF>; Wed, 27 Dec 2000 19:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132061AbQL1Awz>; Wed, 27 Dec 2000 19:52:55 -0500
Received: from mout0.freenet.de ([194.97.50.131]:21391 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S131071AbQL1Awr>;
	Wed, 27 Dec 2000 19:52:47 -0500
From: Andreas Franck <afranck@gmx.de>
Date: Thu, 28 Dec 2000 01:26:19 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: Mike Galbraith <mikeg@wen-online.de>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.Linu.4.10.10012271823370.471-100000@mikeg.weiden.de> <00122801060000.00534@dg1kfa.ampr.org>
In-Reply-To: <00122801060000.00534@dg1kfa.ampr.org>
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00122801261900.00466@dg1kfa.ampr.org>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike, hello Linus,

Some minutes ago, I wrote:
> I think I have found the reason for our bugs. It seems GCC really
> miscompiles buffer.c:bdflush_init without frame pointers. I'll try harder
> now to understand what excactly is going on, but it seems it is smashing
> its local stack space by decrementing its stack pointer too early, then
> calling an assembler function (__down_failed). It might be that GCC is
> confused by this.

[...]

> Any comments on this? I'll now try to split up the stack space operation in
> two parts, the first after call kernel_thread: addl $12, %esp (as in the
> first call), and an additional addl $64, %esp just before leaving (before
> popl %ebx). And I'll report what happened, later - but I have a good
> feeling that I have caught the bug.

... and my good feeling was right. Changing the bogus assembly code made the 
bug go away. I'll try to prepare a simpler testcase for the GCC maintainers 
tomorrow. For short, this is what happens: GCC tries to free its stack frame 
for the local variables far too early. It then calls __down_failed(), which 
pushes some things on the stack - thereby corrupting the semaphore pointer! 
So __down() works on a random memory location instead of the semaphore, which 
is guaranteed to fail badly. 

I've added linux-kernel as CC again, so everybody can now hear that this is 
definitely a GCC bug, and not a kernel issue.

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
