Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbTEGTdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbTEGTbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:31:44 -0400
Received: from stratnet.net ([12.162.17.40]:9774 "EHLO umhlanga.STRATNET.NET")
	by vger.kernel.org with ESMTP id S264257AbTEGTaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:30:02 -0400
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305070933450.11740@chaos>
	<20030507135657.GC18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305071008080.11871@chaos>
	<p05210601badeeb31916c@[207.213.214.37]>
	<Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
	<Pine.LNX.4.53.0305071424290.13499@chaos> <52bryeppb3.fsf@topspin.com>
	<Pine.LNX.4.53.0305071523010.13724@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 07 May 2003 12:42:34 -0700
In-Reply-To: <Pine.LNX.4.53.0305071523010.13724@chaos>
Message-ID: <52n0hyo85x.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 May 2003 19:42:36.0514 (UTC) FILETIME=[CF988C20:01C314D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> Right.  Now think about where the kernel stack for the
    Roland> process that is sleeping in the kernel is kept.

    Richard> It's the kernel, of course. The scheduler runs in the
    Richard> kernel under the kernel stack, with the kernel data. It
    Richard> has nothing to do with the original user once the user
    Richard> sleeps. The user's context was saved, the kernel was set
    Richard> up, and the kernel will schedule other tasks until the
    Richard> sleep time or the sleep_on even is complete.  At that
    Richard> time, (or thereafter), the kernel will schedule the
    Richard> previously sleeping task, its context will be restored,
    Richard> and it continues execution.

    Richard> The context of a task (see entry.S) is completely defined
    Richard> by its registers, including the hidden part of the
    Richard> segments (selectors) that define priviledge.

I'll try one more time.  Let's say a user process makes a system call
and enters the kernel.  That system call goes through a few function
calls in the kernel (which each push something on the kernel stack for
that process).  Finally, the kernel has to sleep to sleep to service
the system call (let's say it's a blocking read() waiting for some
data to arrive on a socket).

OK, now the scheduler runs, and another user process starts and makes
its own system call, which also goes to sleep.

Now say the data the original process was waiting for arrives.  The
scheduler wakes up that process, which is in the kernel, and it
finishes servicing the read.  This means it now returns through the
chain of kernel function calls before returing to user space.  Each
return in kernel space has to pop some stuff off the stack, and it
better not get mixed up with the second process's kernel stack.

That's (one reason) why each process needs its own kernel stack.

 - Roland
