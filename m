Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTD1BQF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTD1BQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:16:04 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:64697 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S262680AbTD1BQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:16:03 -0400
Date: Sun, 27 Apr 2003 21:28:18 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.LNX.4.50.0304271814410.7601-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.BSO.4.44.0304272120150.23296-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Apr 2003, Davide Libenzi wrote:

> This is very much library stuff. I don't think that saving a couple of
> system calls will give you an edge, expecially when we're talking of

I guess it depends on what is considered saving. To be honest, my area of
interest is embedded systems. uClinux might benefit from such a syscall
(not that I have much experience with Linux on mmu-less hardware).

The idea would be to avoid the syscalls needed. I looked at the typical
fork-exec code I write and it does something similar to:

   if (fork() == 0)
   {
     for(i = 3; i < NFILES; i++)
      close(i);

     sigaction(...);
     sigaction(...);

     exec();
   }

The system call I was proposing would have a few benefits:

  (1) Because of the file mapping array that can be provided, the
      closing of the file descriptors isn't necessary (close-on-exec
      isn't always convenient to use). Neither is the dup()ing of
      file descriptors for things like pipelines.

  (2) There is always the difficulty of finding out in the parent
      if the exec() fails. Sure you can stat the path, sure you can send
      a signal or do this countless other ways. But the single syscall
      would make this a no-brainer.

  (3) We would eliminate the page faults for the new stack as the child
      runs to setup the environment. I guess this could save a a few free
      pages for a millisecond. Yeah, minor... but if you have a large
      system with 1000's of users it may matter.

Of course, a new system call is intrusive in the kernel. One option is to
prototype this as a library function first, see how much use it gets and
then decide later on to move it to the kernel.

L8r,
Mark G.


