Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131734AbQKAXBB>; Wed, 1 Nov 2000 18:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131748AbQKAXAw>; Wed, 1 Nov 2000 18:00:52 -0500
Received: from hermes.mixx.net ([212.84.196.2]:37381 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131734AbQKAXAt>;
	Wed, 1 Nov 2000 18:00:49 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: fork in module?
Date: Thu, 02 Nov 2000 00:00:45 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A00A09D.53097823@innominate.de>
In-Reply-To: <27525795B28BD311B28D00500481B7601623A0@ftrs1.intranet.FTR.NL> <200011011750.eA1Ho8s06277@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 973119645 14270 10.0.0.90 (1 Nov 2000 23:00:45 GMT)
X-Complaints-To: news@innominate.de
To: Andreas Dilger <adilger@turbolinux.com>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test8 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> You write:
> > what would be the way of starting a sub-process in a module which then would
> > run in the background? I guess plain fork() won't work?
> 
> We did this in one of our filesystem modules to have our own async cache
> flush daemon.  One thing you need to watch out for is that the new thread
> is stopped before the module is unloaded.  You can't simply increase the
> module reference count, and decrease it when the thread exits, because
> you are never allowed to remove a module with a non-zero refcount.
> 
> What you need to do is have your module cleanup function stop the thread,
> and then wait to be sure it has exited before unloading.  This is a
> bit more tricky because you could send the thread a KILL signal and it is
> still doing work or is rescheduled before it has completed exiting.

I do this too, in Tux2.  The idea seems to have occured independently to
every filesystem group, or perhaps necessity is a better term for it. 
So, having observed that every filesystem already has such a background
thread associated with it (all the dumb filesystems are associated with
kflush+kupdate) why don't we think about how we can do this in a more
organized way?

Here's something that looks like a piece of the puzzle:

  http://boudicca.tux.org/hypermail/linux-kernel/2000week45/0266.html
  RE: Linux's implementation of poll() not scalable?

I'd like to have my filesystem thread get woken up on messages from the
VM, specifically to handle flush requests of the kind that are needed to
clean buffers so the VM can evict some pages.  There are other messages
I'd like to see to, for example: 'please clean up and unmount this
superblock'.  I need to wake periodically too, and a timer sleep is one
way to do that, but another is to receive a message from a timer - that
way I don't have to figure out why I've been woken up.  And I'd like to
receive messages from other threads that visit my own filesystem, for
example: 'transaction done, ok to change phases' - so the message queue
would have multiple writers, one reader.  In all these cases, the
superblock would be passed as part of the message so one thread would be
able to service multiple mounts.

Does any of this make sense?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
