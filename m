Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSLFMtP>; Fri, 6 Dec 2002 07:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSLFMtP>; Fri, 6 Dec 2002 07:49:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:2006 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262420AbSLFMtO>;
	Fri, 6 Dec 2002 07:49:14 -0500
Date: Fri, 6 Dec 2002 15:15:30 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: NPT library mailing list <phil-list@redhat.com>
Cc: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: what's the relationship between tgid, tid and pid ?
In-Reply-To: <200212052047.gB5Kle620684@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0212061510270.6255-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Dec 2002, Roland McGrath wrote:

> "tgid" is the PID of the whole POSIX.1 process.
> "pid" is a per-thread PID-like number.

there's a "PID number space" under Linux, and "PID types". Each PID type
allocates from the same base number space, but they can also share the
same PID, ie. are overlayed:

enum pid_type
{
        PIDTYPE_PID,
        PIDTYPE_TGID,
        PIDTYPE_PGID,
        PIDTYPE_SID,

the 'TGID' is the "process PID" as in POSIX.1. The 'PID' is the same for
standalone processes and for leader threads, it's different for threads.  
Furthermore, the PID is also globally unique, and is recognized by the
sys_tkill() interface - ie. you can send signals between threads of
different "processes". The 'PGID' is the process group PID. The 'SID' is
the session ID.

the kernel guarantees reference counting, ie. only when the last type
detaches a given number is it allocatable again. This is partly required
by semantics for things like the PGID and the SID, and it's simply handy
for things like the thread identificator.

	Ingo

