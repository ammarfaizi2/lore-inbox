Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSFMB3x>; Wed, 12 Jun 2002 21:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317391AbSFMB3w>; Wed, 12 Jun 2002 21:29:52 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:46250 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317387AbSFMB3v>; Wed, 12 Jun 2002 21:29:51 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        frankeh@watson.ibm.com
Subject: Re: [PATCH] Futex Asynchronous Interface 
In-Reply-To: Your message of "Wed, 12 Jun 2002 11:16:03 +0200."
             <3D071153.9020607@loewe-komp.de> 
Date: Thu, 13 Jun 2002 11:32:29 +1000
Message-Id: <E17IJTR-0002ws-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D071153.9020607@loewe-komp.de> you write:
> What are the plans on how to deal with a waiter when the lock holder
> dies abnormally?
> 
> What about sending a signal (SIGTRAP or SIGLOST), returning -1 and
> setting errno to a reasonable value (EIO?)

This is becoming an FAQ:

No, you can't.  These locks are fast because they don't go through the
kernel in the contented case -> the kernel doesn't know who has it.

You can deal with this in userspace, though, if you make certain
assumptions.  Have a daemon which say, polls the futexes every second
and when a futex is taken for two seconds in a row, tries to grab it
itself with a 1 second timeout: if it fails it assumes the lock is
stuck and take action (note: anyone can lock or unlock, there's no
lock "owner" except by convention).

This is not perfect, but neither is the fcntl lock case of "process
dies, lock vanishes, noone gets told".  And since the cleanup is
app-specific, making the whole thing app-specific is not so crazy.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
