Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTJHECH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 00:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTJHECH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 00:02:07 -0400
Received: from mail.inter-page.com ([12.5.23.93]:41482 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261294AbTJHECC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 00:02:02 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9? (SIGPIPE?)
Date: Tue, 7 Oct 2003 21:01:16 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAmH7Q7NFXTUi83xFeuIJyvQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0310071954520.32358-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I have two threads that are doing IO on a file descriptors with the
number 5, I get an unexpected EPIPE on "5", now what?  I kept track.  Who is
it for?

Yea, I know:

1) add the other flag to clone()
2) mask the signal off completely
3) wake everybody who has a 5 in their file descriptor table (except that I
can't see anybody elses' file descriptor table)
4) wake everybody
5) let the owner task notice the problem when it gets back around to using
"5"
5) Just die like a good little program

Since it doesn't do all the things I expect from the common definition of
"thread"; and it isn't documented anywhere I can find online or in the
kernel tree; what is the kernel actually promising me when I use
CLONE_THREAD anyway?  How is it more than (CLONE_VM|CLONE_SIGHAND)?

[I see a bit about exiting as a group and I assume that CPU usage statistics
are aggregated amongst the threads.  Is that it?]

And I'll bet two dollars I won't be the last to ask... 8-)

You've seen my other arguments about expectation and consistency so I'll
stop now, I promise. 8-)

Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Linus Torvalds
Sent: Tuesday, October 07, 2003 7:58 PM
To: Robert White
Cc: 'Albert Cahalan'; 'Ulrich Drepper'; 'Mikael Pettersson'; 'Kernel Mailing
List'
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9? (SIGPIPE?)


On Tue, 7 Oct 2003, Robert White wrote:
> 
> If all the CLONE_THREAD members of a process (automatically) have the same
> signal handling code/context but not the same list of file descriptors,
what
> happens when a file descriptor posts SIGPIPE or SIGIO (etc.) to a process?

You have to explicitly _ask_ for SIGIO. If you do so, and you don't share
file descriptors, that's _your_ problem.

But it does indeed have perfectly valid semantics - the signal may well
just wake up a thread: and in fact, as most IO is illegal in signal
handler context anyway, it usually has to. 

Clearly, if you have per-thread file descriptors, you have to keep track 
of which thread is doing what. 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


