Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbSJMHoO>; Sun, 13 Oct 2002 03:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbSJMHoO>; Sun, 13 Oct 2002 03:44:14 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:14870 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S261450AbSJMHoN>; Sun, 13 Oct 2002 03:44:13 -0400
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'David S. Miller'" <davem@redhat.com>
Cc: <robm@fastmail.fm>, <hahn@physics.mcmaster.ca>,
       <linux-kernel@vger.kernel.org>, <jhoward@fastmail.fm>
Subject: RE: Strange load spikes on 2.4.19 kernel
Date: Sun, 13 Oct 2002 02:49:55 -0500
Message-ID: <000c01c2728d$263c0ca0$7443f4d1@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20021013.000127.43007739.davem@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'll let you in on a dirty little secret.  The Linux file
>> system does not utilize SMP.  That's right.  All file
>> processes go through one and only one processor.  It has
>> to do with the fact that the Linux kernel is a non-preemptive
>> kernel.

> Not true, page cache accesses (translation: read and write)
> go through the page cache which is fully multi-threaded.

> Allocating blocks and inodes, yes that is currently single
> threaded on SMP.

Now wait a minute!  Allocating blocks and inodes is an integral part of
a write.  Oh sure the actual writing of file data is SMP, but that
process is bottlenecked by single threaded allocation of blocks and
inodes.  Perhaps I could phrase what I said to be more technically
accurate by saying, "Writing makes such poor use of multi-threading on
SMP that in terms of performance it's as if it was single threaded."

> But there is no fundamental reason for that, we just haven't
> gotten around to threading that bit yet.

Oh yes there is.  What if an allocation of blocks and/or inodes is
preempted?  Another thread could attempt to allocate the same set of
blocks and/or inodes.

This isn't a problem on a uniprocessor system because only one processor
can access any data structure at any given time.

However, on SMP two kernel control paths running on different CPUs could
concurrently access the same data structure.  There's two ways to deal
with this error: 1) the lazy way and the way Linus decided to go was to
run block and inode allocation through one single thread, or 2) the
better way is to preempt the other process which would require a) a
preemptive kernel and b) synchronization (and as a programmer I can tell
you that synchronization gets messy if not thoroughly designed and
implemented).

Rather than go through all the work of rewriting the kernel to be
preemptive and significantly improving synchronization routines (a lot
of work), Linus chose to solve the problem by avoiding it, rather than
dealing with it as he should have.

If you don't believe me, prove me wrong.  Write the code.  If you ever
got your @$$ around to it, you'd see that I'm right.

