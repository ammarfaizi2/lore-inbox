Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262169AbSJJTzw>; Thu, 10 Oct 2002 15:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262191AbSJJTyx>; Thu, 10 Oct 2002 15:54:53 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:57834 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262150AbSJJTxn>; Thu, 10 Oct 2002 15:53:43 -0400
Date: Thu, 10 Oct 2002 14:59:07 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Fork timing numbers for shared page tables
Message-ID: <175360000.1034279947@baldur.austin.ibm.com>
In-Reply-To: <3DA5D893.CDD2407C@digeo.com>
References: <167610000.1034278338@baldur.austin.ibm.com>
 <3DA5D893.CDD2407C@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, October 10, 2002 12:44:19 -0700 Andrew Morton
<akpm@digeo.com> wrote:

> Be nice to get some compelling benchmark figures onto the
> mailing lists to help push these.  They're pretty late...

I've done some basic timing tests for shared page tables using a simple
fork test I wrote.  It has three modes:

The first mode forks as fast as it can, then calculates how long each fork
took.  This measures the time the fork() system call took.

The second mode adds a wait() for the child after the fork.  The child just
calls exit(0).  This measures how long the child ran.

The third mode adds an exec() in the child of a very small executable,
which just exits.  This adds the exec() time to the mix.

The program also optionally allocates a shared memory object and touches
all the pages in it before the start of the test.  This adds extra pages to
be dealt with by fork/exec/exit.  None of the pages are touched after the
test starts.

I ran this test in three cases, 2.5.41, 2.5.41-mm2 without share, and
2.5.41-mm2 with share.

Now for the results (all times are in ms):

		2.5.41	mm2-unshared	mm2-shared
		------	------------	----------
fork
----

400K		 1.7	 1.6		 0.5
4M		 5.0	 5.0		 3.4
40M		28.4	29.5		 3.4

fork/exit
---------

400K		 1.7	 1.6		 1.6
4M		 4.9	 5.3		 4.1
40M		44.2	45.1		 4.1

fork/exec/exit
--------------

400K		 6.5	 7.5		 7.7
4M		10.3	11.9		10.7
40M		49.3	51.4		10.7


I don't know why exec introduces a small penalty for small tasks. I'm
working on some optimizations that might help.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

