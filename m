Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbULVAgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbULVAgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbULVAgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:36:49 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:11361 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261914AbULVAgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:36:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NyEAKptOxC7Pl8GtmMqOtH18LZ5RiKaqA7VF1rxGQL0LiNq870oV72FvCYpdzxFHJ1OyjifElVM7ZfaGkJYe1qNgq7mkLsAywS+AKndvMzkDXnm2l9LjodqCUsz6PlKoIjo7UvycQeiyVNzbqtJevy73gVVNwbeIIEUbt84JjgM=
Message-ID: <7d92433304122116361c2933fb@mail.gmail.com>
Date: Tue, 21 Dec 2004 19:36:18 -0500
From: Dan Sturtevant <sturtx@gmail.com>
Reply-To: Dan Sturtevant <sturtx@gmail.com>
To: Pjotr Kourzanov <peter.kourzanov@xs4all.nl>
Subject: Re: fork/clone external to a process?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41C8B128.7010201@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <7d92433304122107491b8b624a@mail.gmail.com>
	 <41C8B128.7010201@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi,
> >
> > Is there any clean way to fork a process from outside the process itself?
> >
> > I'm running a commercial application that I only have a binary copy
> > of.  All the usual Posix fork stuff only works from inside the running
> > process.
> 
>    Have you tried playing with LD_PRELOAD (libc.so hack)?
> 

What I'm really looking to do is "checkpoint" the process.  If I were
inside the process, I'd fork off a child and call wait() in the
parent.  When I wanted to "revert" i'd kill off the child, which would
return from the parent's wait().  I'm trying to do this to VMware. 
Because a forked child shares all the open file descriptors with its
parent, they should be able to share the gui so long as only either
the parent or child are awake at the same time.

I have allready modified the Bochs emulator and gotten it to do this,
but I could just use fork the normal way inside the executable since
it's an open source project.

(Yes, I know VMware allready has checkpoint/revert stuff and I don't
need this crazy stuff to use it.  I'm trying to do wierd stuff under
VMware however.)

Ideally, i'd have some kind of wierd system call like:
childpid = wierd_external_fork(parentpid);

int wierd_external_fork(int parentpid)
{
  int childpid;
  wierd_sigstop_and_wait(parentpid);
  childpid = wierd_copy_process_state(parentpid);  //keep controling terminal?
  return childpid;
}

I think I understand what you're saying about using LD_PRELOAD to
hijack a function call in a shared object.  I could do this and try to
slip a call to fork() into the executable by substituting a function
and thus do this the normal way.

My problem is that I want this to happen on demand rather than
whenever the substituted shared library call is invoked inside the
executable.

I haven't messed around with LD_PRELOAD before.  Am I interpreting
everything correctly here or am I way off base?

Feel free to tell me that I'm smoking crack.

Thanks for the help.
