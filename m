Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268081AbUBRU51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUBRU51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:57:27 -0500
Received: from mail.inter-page.com ([12.5.23.93]:36361 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S268082AbUBRU47 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:56:59 -0500
From: "Robert White" <rwhite@casabyte.com>
To: <tridge@samba.org>
Cc: <linux-kernel@vger.kernel.org>, "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Al Viro'" <viro@parcelfarce.linux.theplanet.co.uk>,
       "'Neil Brown'" <neilb@cse.unsw.edu.au>
Subject: RE: UTF-8 and case-insensitivity
Date: Wed, 18 Feb 2004 12:56:33 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAY2oLyNc+2kSGYHzhq2igkwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <16434.53912.10089.216436@samba.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess I don't get it...

tridge@samba.org [mailto:tridge@samba.org] said:

> NTFS is case insensitive at the filesystem level. In fact, its
> selectable whether its case sensitive or case insensitive per-process
> (a process can switch between the two models). The case mapping table
> is built into the filesystem itself. That mapping has absolutely
> *zero* to do with US Latin or any other legacy multi-byte encoding.

If the process selects whether it wants to be case insensitive or not how is
NTFS case insensitive "at the file-system level"?  Let me guess, they have
two complete paths through the logic?  Lots of DLLs?  Redundant conflicting
access semantics^Wfeatures?

> you are *way* out of date here. All recent windows apps use the UCS-2
> interfaces which provides a single charset encoding across all locales.

Which kind of directly supports where I said that to amortize the expense
Linux would have to set up its *own* cannon about all file systems using the
same encoding.  The fact that I kept bringing up 8.3 was out of date.  Point
to you.  The point that picking an arbitrary encoding will lead Linux
getting out of date, or at least require a catastrophic realignment of every
program that deigns to open() any file anywhere, remains germane.

> Have you read *any* of what I've been saying about how expensive this is??

Yes, I understand the expense.  I have *paid* that expense in excruciating
detail on several occasions.  You want to have the kernel pay that expense
(in place of the application) as a fixed (amortized) cost or you want to
codify the file names with a standard encoding which would penalize the
entire system uniformly by raising the base cost to localize.

I appreciate the unbounded regex-like expense of iteratively applying
case/encoding insensitivity to a list of files.  I really don't want to pay
that cost in every application when I only need it at the front end.  Sue
me.

I also understand the pain of having to load any/each entire directory into
memory one blasted dirent at a time, and appreciate that since the kernel is
bulk loading them at the filesystem interface it seems (is) wasteful to have
to spoon them across the kernel/user-space interface.  I really do
understand.  (ASIDE: a bulk-fetch-directory-into-buffer call might be nice,
I havn't looked lately, but I presume none such exists.)

Your proposed "single locale storage" would penalize all us embedded systems
types with our space sensitive embedded file systems and low-powered CPUs so
that the larger system that _can_ afford to pay the cost only when necessary
don't have to.  Two-bytes for one in every file name isn't a good trade off
when you are dealing with a 32k file system image.

I kind of tried (and apparently utterly failed) to make the points about how
the Windows model worked and what it would cost by describing the basis for
the model, not the current implementation.  That is kind of why I *started*
the message with "(ok in point of "technically abstract truth")" and
mentioned later that what I was saying may have changed, but if so, it
changed in a way consistent with the model as described.

Windows has been digging themselves steadily out of the deep hole of
case-insensitive file name handling for years; which does nothing to entice
me to jump in and join them.  So bully for windows that they have, iteration
after iteration, managed to reduce the cost of their mistake.

Even *with* a standardized file name character set/encoding case
insensitivity would still be very bad-off in some important areas.  Consider
a simple security log.  "[date] user command xx satisfied with executive
Xx." etc.  I can think of *lots* of times when I would have to open a file
and then have to ask what the real name of the file I opened actually was.
"I asked for 'Bob', what did I get?" isn't a fun question to have to answer
*after* an open.  Yes, all this *can* be addressed by scrubbing paths, but
history suggests that this doesn't happen and the more the system does for
you, the more likely you are to miss something.

At the application level, since I have to sort file names for a picklist
anyway, I'd rather pay the case insensitivity cost while I was sorting.
It's actually cleaner and I am already paying to sort.

I used to write SMB based applications (yes, I'm still way out of date) and
I appreciate the painful tit-for-tat non-streaming ugliness.  I feel your
pain at having to read a whole directory and doing the sort/search.  I
understand the race condition that occurs between the directory read and the
actual open where the file could be renamed or replaced.  I really do.

But "fixing" Linux so that it can share Window's pain doesn't seem wise.

I can imagine a mod/module that would graft a localized and/or
case-insensitive companion hash onto the dirent(s) as the central facility
was doing its work.  I can imagine an alternate open that traversed this
alternate tree.  Creating sort of a giant look-aside into the current file
information tree. But I can't imagine any winning scenario that came from
making that alternate hash the normal access method.  Too many people and
projects would suddenly break.

{And I try not to troll, but I apparently have a knack for getting peoples
dander in a bunch when I write.  I think it is because I write as I speak,
and the loss of tone and inflection in writing makes my turn-of-phrase come
off very priggish.  I'm not sure how to fix that.  /sigh 8-)

Rob.


