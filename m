Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTIOXht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbTIOXhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:37:47 -0400
Received: from mail.inter-page.com ([12.5.23.93]:27663 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261678AbTIOXhB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:37:01 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Iker'" <iker@computer.org>, <linux-kernel@vger.kernel.org>
Subject: RE: self piping and context switching
Date: Mon, 15 Sep 2003 16:36:45 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAaZPqB1ZpB0WfHjUfcrDlYwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: <039401c37995$0f30cbd0$3203a8c0@duke>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not to knarf at you, and not to pollute this list, but depending on what
*else* you might be expecting on that pipe, this kind of code could deadlock
with itself rather easily on the write() to the pipe.  If nothing else is
can write to the pipe, then the pipe has no use that could not be better
served by a more local data item.  A thread should "never" (trademark, all
rights reserved 8-) control *itself* through this kind of mechanism.

It is far better, (and cheaper, and less likely to lose the CPU, etc.) to
have a non-local thread-specific (managed, etc) data item that you check
"just before" the poll.

(from a pure performance perspective) Because *any* kernel call is an
opportunity to lose you your timslice, the sequence you mention is a write()
a poll() and presumably a read() to clear the state.  That is three chances
to get "anti-scheduled" (8-) between your decision to "wake yourself" and
the actual desired processing.

Consider the truth of each of the following:

1) If you can "find" the file descriptor for "this thread" then you could
set up and "find" a simple boolean/integer flag that you could test before
even calling the poll().  [This is a self-wake right? So why poll() if you
can avoid it.]

2) If the pipe-special device/file is private to the thread, the same thing
can be accomplished by a simple queue/stack data structure.  You don't even
need locking because it is private so there is no possibility of contention.

2a) In this private case, the thread can never wake itself inside the poll
anyway, because it is waiting inside the poll() [if you catch my meaning.]

3) If the pipe-special device/file is *NOT* private, but this thread is its
only reader, then it is possible that the pipe could be full, in which case
the write() would block waiting for a read that, by definition, will never
happen.

3a) see item 2a.

4) If the pipe-special device/file is *NOT* private AND there are multiple
readers, then you don't know which thread you would be waking (so the
loss-of-timeslice issue is insoluble) and it is *STILL* possible (though
less likely) for all the threads to form a completely deadlocked dependency
graph with blocking write() semantics.

5) If you do the write() in non-blocking mode, and it would block, you have
no means to communicate what you wanted to communicate, so you would have to
discard the event.  This leads to an unstable model, or it leads to writing
the queue/stack mentioned above to solve this case.

The short version is: If a thread is writing to itself using a pipe, you
almost certainly have a semantic problem that could be solved better and
faster using local data or something.

I can't get more specific without seeing your code.

Rob White.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Iker
Sent: Friday, September 12, 2003 6:19 PM
To: linux-kernel@vger.kernel.org
Subject: self piping and context switching

Assume a thread is monitoring a set of fd's which include both ends of
a pipe (using poll, for example). If the thread writes to the pipe (in
order to notify itself for whatever reason) is it reasonable to expect
that it will be able to return to its poll loop and get the event
without a context switch? (provided it quickly returns to the poll
loop).

Regards,
Iker


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



