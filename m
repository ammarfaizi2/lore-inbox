Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTJGXJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbTJGXJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:09:23 -0400
Received: from mail.inter-page.com ([12.5.23.93]:41990 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S262994AbTJGXJN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:09:13 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Albert Cahalan'" <albert@users.sourceforge.net>
Cc: "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: Tue, 7 Oct 2003 16:08:27 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAS8Bo1alFyEeioqtYx4I/JwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0310021720510.7833-100000@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

All threads within the same process must have the same (single) list of open
files or bad things will happen.  I understand that CLONE_FILES makes this
true at the time of the clone but I don't know if that keeps this true
thereafter (e.g I don't know if this is a copy-that or a share-that
operation).  If it doesn't, the some mechanism that does needs to be added.

If all the co-joined threads of a process share the same file descriptor
list then /proc/self/fd/* will have unity for the overall process and the
bulk of the argument disappears completely.

The reason the threads must share the file descriptor table involves the
fact that data may, and likely will, flow between the threads.  After the
open(2) call the file descriptor is just data and it will get shared.

For instance, I have a seriously multi-threaded server application.  The
listen() operation for new clients happens in one thread.  When a connection
is accept()ed I take the request (first bit of data) and match it to the
service (and therefore thread) that it should be attached too.  Then I had
that socket over to that thread.

Without the shared file descriptors this would break very badly.

Conversely, there is virtually no sane model where having a disjoint file
descriptor list but otherwise conjoined data space makes sense.  The file
descriptors are going to be "tarnishing" the data space if you do this, and
that is just begging for exploits and "surprises".  That is, you will end up
with little tidbits of data that are conditionally meaningful scattered
throughout your data space.

Where you need to have the initial data shared but differing descriptor
tables you *should* be "stuck" with a classic fork() operation.

What possible win could you have in having a variable contain a particular
integral quantity that is a data file open for reading in one thread, a
mapped segment of memory in another, and invalid in the rest?  If you don't
constrain that behavior now the resulting code that "depends" on this
behavior will plague this platform for years (see Windows Dynamic Data
Exchange) and lots of existing expectations for thread behavior will be
violated day-1 of the release.

IMHO of course 8-)

Rob.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Linus Torvalds
Sent: Thursday, October 02, 2003 5:41 PM
To: Albert Cahalan
Cc: Ulrich Drepper; Mikael Pettersson; Kernel Mailing List
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?


On 2 Oct 2003, Albert Cahalan wrote:
> 
> No. I mean "ban" like we ban CLONE_THREAD w/o CLONE_DETACHED.

No. Let's not do that.

We ban only things that do not make sense. That was true of trying to 
share signal handlers with different address spaces. But it is _not_ true 
of having separate file descriptors for different threads.

I don't imagine anybody cares _that_ deeply about fuser that it can't 
afford to recurse into thread directories.

And it may or may not make sense to not have a "/proc/<nn>/task/<yy>/fd"
directory at all if the thread shares file descriptors with the thread 
group leader. That would be a fairly easy optimization.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


