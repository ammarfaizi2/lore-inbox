Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSHCLDy>; Sat, 3 Aug 2002 07:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSHCLDy>; Sat, 3 Aug 2002 07:03:54 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:49668 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317512AbSHCLDx>;
	Sat, 3 Aug 2002 07:03:53 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kasper Dupont <kasperd@daimi.au.dk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Race condition? 
In-reply-to: Your message of "Sat, 03 Aug 2002 12:08:28 +0200."
             <17aw0S-0U7gB7C@fmrl00.sul.t-online.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Aug 2002 21:07:11 +1000
Message-ID: <2020.1028372831@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2002 12:08:28 +0200, 
Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de> wrote:
>Hi,
>
>> >I don't see any locking in the call chain leading to this function, so
>> >I think you're right.  The attached patch fixes this.  It costs an
>> >extra 2 atomic ops in the failure case, but otherwise just makes the
>> >processes++ operation earlier.
>>
>> Does this race really justify extra locks?  AFAICT the worst case is
>> that a user can go slightly over their RLIMIT_NPROC, and that will only
>> occur if they fork on multiple cpus "at the same time".  Given the
>
>Only if preempt is not enabled.

Preempt is irrelevant here.  To make any difference, there would have
to be an interrupt in the window between reading and updating
p->user->processes _and_ another process would have to be waiting to
enter fork().  Even if that occurred, the result is the user is one
process over their limit, big deal.

>> timing constraints on that small window, I would be surprised if this
>> race could be exploited to gain more than a couple of extra processes.
>> This looks like a case where close enough is good enough.
>
>There's no such thing as a tolerable race :-)

The result is just a slightly elevated process count in rare cases.
Even then it is self correcting.  It is not a significant race, just a
bit of fuzzy counting.

>Anyway this code can corrupt the global variable nr_threads.
>Without the BKL it is buggy, so it has to be fixed anyway and we
>can do it right.

nr_threads is protected by tasklist_lock.  How on earth can fuzzy
counting on user->processes corrupt nr_threads?

