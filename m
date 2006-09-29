Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWI2Blu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWI2Blu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 21:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWI2Blu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 21:41:50 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:63941 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751238AbWI2Blt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 21:41:49 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC MAP_PRIVATE mmaps
Date: Fri, 29 Sep 2006 01:41:34 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <efhtke$h5d$2@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <Pine.LNX.4.64.0609272045560.24191@blonde.wat.veritas.com> <451B5096.6020205@aknet.ru> <Pine.LNX.4.64.0609281707190.27484@blonde.wat.veritas.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159494094 17581 128.32.168.222 (29 Sep 2006 01:41:34 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Fri, 29 Sep 2006 01:41:34 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've had a chance to look into this in a little more detail, and
I have now come to a different view.  Although I think Stas's proposal
is well-motivated, I'm now more skeptical about some of the details of
his proposal.  Here is my current thinking on this issue:

1) It is important that when ld.so has some way to ensure that executing
a program off of a noexec partition will fail.  The details of how it
does that don't matter, from a security point of view, though they do
matter from a maintenance perspective.  If Stas's proposal requires
changes to ld.so, Stas should implement and test those changes before
any changes are made to the kernel.

2) Currently, ld.so uses mmap(PROT_EXEC, MAP_PRIVATE) to load the text
of the programs it executes.  Consequently, if we want to avoid changing
ld.so, then we need mmap(PROT_EXEC, MAP_PRIVATE) to fail with an error
if the text lives on a noexec partition.

3) I think it's a requirement that any change to Linux mmap() semantics
will not break ld.so's noexec check.

4) Everything else about the way the Linux kernel handles mmap(PROT_EXEC)
is not security-critical.  As long as ld.so will refuse to execute
a program that lives on a noexec partition, you can choose the rest
of mmap()'s semantics any way you want without fear of introducing a
security loophole.

5) There are already a million-and-one loopholes that allow one to
indirectly execute code that lives on a noexec partition.  For instance,
one can run 'perl ld-linux.ignore-noexec.so'.  As another example, one
can use mmap(PROT_EXEC, MAP_ANONYMOUS) to create an executable region
of memory, then use read() to read the text in from a noexec partition
and copy it into the executable region, and then jump to the executable
region of memory.  It would be trivial to write a replacement for ld.so's
mmap(PROT_EXEC, MAP_PRIVATE) that has the same effect except that it
ignores the noexec flag.  There is no way to close all of these loopholes.

6) In general, it's easy to see that as long as a program can create any
region of memory that is both executable and writeable, there will always
be a loophole.  There's no way we are going to write a prohibition into
the kernel saying that no program can ever have a region of memory that
is simultaneously executable and writeable.  Given that there are already
zillions of loopholes, adding one more loophole just doesn't matter.
Consequently, as long as we preserve the behavior of ld.so, the rest of
the semantics of mmap() can be freely changed without fear of introducing
a new security hole.

7) For instance, you could imagine adding a MAP_IREALLYMEANIT flag which
tells mmap() to ignore the noexec prohibition.  This would be safe to add,
from a security point of view (it wouldn't create any new vulnerabilities,
as long as the user code knows what it is doing when it sets this flag).
If Stas has a small set of userlevel programs (wine, UML, etc.) that need
the ability to link in libraries that live on noexec partitions, then this
would provide a safe way to meet this need in a backwards-compatible way.
Of course, Stas would have to go patch those userlevel programs himself
to add the MAP_IREALLYMEANIT flag, but that's his problem.

8) The value of noexec is proportional to the number of partitions that
you can mount with the noexec flag enabled.  If the noexec semantics are
tightened down so strictly that you can't enable noexec on any mount
(because otherwise too many userlevel programs break), then the value
of noexec is nil.  If loosening the noexec restrictions slightly allows
you to mark more partitions as noexec, then this is a net win (assuming
that ld.so continues to reject programs that live on noexec partitions).

9) Stas's request is a request for a change to Linux kernel semantics.
The current mmap() semantics have been there for years.  We're not talking
about some recent change to mmap() semantics that have broken existing
userspace tools.  Rather, we have a longstanding set of semantics; Stas
wants to be able to mark more partitions as noexec, and he is requesting
a change to the semantics to do so.  (I have to apologize; I see that
this was obvious to everyone else, but I somehow failed to understand
this part.)  Stas's proposed change is well-motivated and I'm inclined
to be sympathetic to the motivation behind it.  Nonetheless, there is
an philosophy that changes to existing kernel semantics have to be well
justified, and in borderline cases, it is perfectly reasonable for the
maintainers to reject such a patch.  The burden is on the proposer of
the change to make a compelling case for the change.

10) At a minimum, if Stas wants to propose a change, he should test his
proposed change to make sure that they don't break ld.so's noexec check.
I can't tell whether Stas has done that.  I don't see any evidence that
he has.  Based on my description of ld.so in point 2) above, I would
expect Stas's patches to break ld.so.  If this is correct, then I think
the current patch is unacceptable and needs to be re-thought.

11) Given all of this, I've changed my mind.  I think it may be premature
to accept this patch, and the negative reactions from others seem entirely
reasonable to me.  I think Stas probably has some more work to do if he
wants to push this patch.
