Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286402AbRLTVw5>; Thu, 20 Dec 2001 16:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286404AbRLTVwr>; Thu, 20 Dec 2001 16:52:47 -0500
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:35797 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S286402AbRLTVwj>; Thu, 20 Dec 2001 16:52:39 -0500
Message-Id: <4.3.2.7.2.20011220133542.02c03ef0@171.69.24.15>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 20 Dec 2001 13:45:57 -0800
To: Dan Kegel <dank@kegel.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: aio
Cc: mingo@elte.hu, "David S. Miller" <davem@redhat.com>,
        bcrl <bcrl@redhat.com>, billh <billh@tierra.ucsd.edu>,
        torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
In-Reply-To: <3C22129C.4A4E2269@kegel.com>
In-Reply-To: <Pine.LNX.4.33.0112201127400.2656-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:32 AM 20/12/2001 -0800, Dan Kegel wrote:
>Proper wrapper code can make them (almost) easy to program with.
>See http://www.kegel.com/dkftpbench/doc/Poller_sigio.html for an example
>of a wrapper that automatically handles the fallback to poll() on overflow.
>Using this wrapper I wrote ftp clients and servers which use a thin wrapper
>api that lets the user choose from select, poll, /dev/poll, kqueue/kevent, 
>and RT signals
>at runtime.

SIGIO sucks in the real-world for a few reasons right now, most of them 
unrelated to 'sigio' itself:

  1. SIGIO uses signals.
         look at how signals are handled on multiprocessor (SMP) boxes.
         can you say "cache ping-pong", not to mention the locking and 
task_struct
         loop lookups?
         every signal to user-space results in 512-bytes of memory-copy 
from kernel-to-user-space.

  2. SIGIO is very heavy
         userspace only gets back one-event-per-system-call, thus you end 
up with tens-of-
         thousands of user<->kernel transitions per second eating up 
valuable cpu resources.
         there is neither: (a) aggregation of SIGIO events on a per-socket 
basis, nor
         (b) aggregating multiple SIGIO events from multiple sockets onto a 
single system call.

  3. enabling SIGIO is racy at socket-accept
         multiple system calls are required to accept a connection on a 
socket and then
         enable SIGIO on it.  packets can arrive in the meantime.
         one can workaround this with a poll() but its bad.

  4. in practical terms, SIGIO-based I/O isn't very good at expressing a 
"no POLL_OUT" signal.

  5. SIGIO is only a _notification_ mechanism.  it does NOTHING for 
zero-copy-i/o from/to-disk
    from/to-userspace from/to-network.


cheers,

lincoln.

