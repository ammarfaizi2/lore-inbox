Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131040AbRCFRde>; Tue, 6 Mar 2001 12:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131041AbRCFRdZ>; Tue, 6 Mar 2001 12:33:25 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:62844 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131040AbRCFRdG>; Tue, 6 Mar 2001 12:33:06 -0500
To: dank@alumni.caltech.edu
Cc: jorge_ortiz@hp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Process vs. Threads
In-Reply-To: <3AA517DB.A5963C9F@alumni.caltech.edu>
From: Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Date: 06 Mar 2001 09:32:00 -0800
In-Reply-To: Dan Kegel's message of "Tue, 06 Mar 2001 09:01:15 -0800"
Message-ID: <6ovg0gq952n.fsf@calypso.engr.sgi.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Can someone summarize the state of the thread changes in 2.4?  
> A lot seemed to happen, but from what I gather, nothing user-visible yet.

We have the concept of thread group now.  A thread group will be
created if you use the CLONE_THREAD flag from userspace.  The task
structures for the threads cloned with CLONE_THREAD will be on a list
for that thread group list and the tgid field will also be copied from
the parent process.  The tgid is returned to the user by getpid(), so
all the threads will seem to have the same pid from within the process
although they will show up with different pids in /proc.  The tgid
implementation is IMHO braindead.

A problem seems to be that we don't check for the tgid field in
getpid(), so theoretically when you do for example raise() from a
thread the signal could be sent to a process that you didn't intend to
send a signal to.

Also if you send a signal to a process it will be delivered to the
thread with that pid and it will remain pending if that thread is
blocking the signal, which doesn't comply with pthreads.  I am
currently working on a patch for this.

I have a list of other issues, but most of them can actually be solved
within glibc.

Ulf
