Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbTD1RGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbTD1RGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:06:42 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:7067 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261181AbTD1RGj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:06:39 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Apr 2003 10:19:25 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Grosberg <mark@nolab.conman.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <Pine.BSO.4.44.0304281219420.22115-100000@kwalitee.nolab.conman.org>
Message-ID: <Pine.LNX.4.50.0304280954000.1629-100000@blue1.dev.mcafeelabs.com>
References: <Pine.BSO.4.44.0304281219420.22115-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Apr 2003, Mark Grosberg wrote:

> The point of my system call is:
>
>   (1) Save the extra overhead of vfork() and exec(). A single system
>       call would still be faster.
>
>   (2) Avoid the resulting file descriptor manipulations for setting
>       up pipelines (dup's and closes).
>
>   (3) Avoid having to do any execution of the child. vfork() shares the
>       address space but there is still overhead in doing the setup of
>       vfork().

You still have to do a fork inside the kernel. For sure you don't want to
call do_execve() in the parent task context ;) So there's no save there.
Saving a few syscalls gives you almost nothing compared to the cost of
spawning a new process and to the machine resource consumption of the task
itself. The only place where this might have a measurable impact is when
you have the parent process with 100K fds open and still you have to have
a pretty short lived child process to have a measurable impact. Supposed
that this will be considered as worth, for sure you don't want to
introduce another syscall not respecting the POSIX one. That, if I did
read it correctly, sucks from that point of view. It suck because it is my
understanding that you have to explicitly drop close actions inside the
file actions list. So, suppose you have N fds and you want to close N-2
fds and dup 2 of them, you need N-2 close actions and 2 dup actions. So
you'll end up having an O(N) in user space to build the action list, and
at least an O(N) in kernel space to walk through it again. Actually, since
it is my understanding that the posix_spawn() interface assume an
all-fds-open by default, you have a few options to setup the child file
list :

1) You have an std clone() to copy all files to the new task struct
	( at *least* O(N) ) and you walk through the POSIX file action
	list to apply close/dup ( O(N) )

2) You have a special clone that starts with a brand new file table ( cost == 0 )
	and you walk though the old files array ( O(N) ) by seeking if the
	current file has actions passed by the caller. This is very bad
	since the action list is not indexed, so going in this direction
	w/out building some kind of index might be as O(N^2). Suppose you
	build an index that it'll give you an O(1), you still have to
	spend *at least* O(N) to build the index itself.

3) Other ways are possible but the minimum cost is at least O(2*N).


What would give the POSIX interface a boost would be to have a
default-all-closed option. In this case, in our example, we will have the
new process created with a blank file table ( cost == 0 ) plus 2 dups done
on the parent file table.




- Davide

