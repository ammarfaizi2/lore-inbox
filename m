Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTKXXB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTKXXB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:01:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:40361 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261613AbTKXXBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:01:02 -0500
Date: Mon, 24 Nov 2003 15:00:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
In-Reply-To: <20031124224514.56242.qmail@web40908.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0311241452550.15101@home.osdl.org>
References: <20031124224514.56242.qmail@web40908.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Mon, 24 Nov 2003, Bradley Chapman wrote:
>
> Indeed. Do the same subsystems usually show the memory corruption issue with
> preempt active, or does it just pop up all over the place, unpredictably?

There are a few reports of "predictable" memory corruption, in the sense
that the same people tend to see the same kinds of oopses _without_ any
other signs of memory corruption (ie no random SIGSEGV's in user space
etc).

There's the magic slab corruption thing, there's a strange thread data
corruption (one person), and there's the sunrpc timer bug. All are
"impossible" bugs that would indicate a small amount of data corruption in
some core data structure.

They are hard to trigger, which makes me personally suspect some
user-after-free thing, where the bug happens only when somebody else
allocates (and uses) the entry immediately afterwards (so that the old
user overwrites stuff that just got initialized for the new user).

It's not likely to be a wild pointer: those tend to corrupt random memory,
and that in turn is a lot more likely to result in _user_ corruptions
(causing SIGSEGV's, corrupted files that magically become ok again when
re-read, etc), since 99% of all memory tends to be non-kernel data
structures.

The PAGEFREE debug option works well for page allocations, but the slab
cache is not very amenable to it. For slab debugging, it would be
wonderful if somebody made a _truly_ debugging slab allocator that didn't
use the slab cache at all, but used the page allocator (and screw the fact
that you use too much memory ;) instead.

(Sadly, some slab users actually use that stupid "initialize" crap. We
should rip it out: it's a disaster from a data cache standpoint too, since
it tends to do all the wrong things there, even though it's literally
meant to help).

		Linus
