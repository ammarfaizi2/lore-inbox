Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbTJ3Rsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 12:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTJ3Rsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 12:48:35 -0500
Received: from thunk.org ([140.239.227.29]:17809 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262712AbTJ3Rsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 12:48:32 -0500
Date: Thu, 30 Oct 2003 12:48:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hans Reiser <reiser@namesys.com>
Cc: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-ID: <20031030174809.GA10209@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>,
	Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org> <3FA0C631.6030905@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA0C631.6030905@namesys.com>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 30, 2003 at 11:05:05AM +0300, Hans Reiser wrote:
> What a performance nightmare.  Updating a user space database every time 
> a file changes --- let's move to a micro-kernel architecture for all of 
> the kernel the same day.....;-)

Nope, the user space database only needs to change when the file
metadata changes.

> Not to mention that SQL is utterly unsuited for semi-structured data 
> queries (what people store in filesystems is semi-structured data), and 
> would only be effective for those fields that you require every file to 
> have.

Your assumption here is that the only thing that people search and
index on is semi-structed data.  While this might be interesting for
text-based data, in fact, the problem space which WinFS has been
addressing isn't necessarily text files.  For example, one of the
examples given in the WinFS paper is the scenario where the user has a
large number of digital photographs, where some of the metadata might
be extracted from the EXIF headers, and some might be inserted by the
user him/herself (for example, the list of names of the people in the
picture, or the subject matter of the photograph: flowers, mountains,
etc --- the latter being very important for professional or
semi-professional stock photographers).  Such information is in fact
very structured, and is much more likely to stay constant even when
the file is modified.

In addition, even for text-based files, in the future, files will very
likely not be straight ASCII, but some kind of rich text based format
with formatting, unicode, etc.  And even general, unstructured
text-based indexing is hard enough that putting that into the kernel
is just as bad as putting an SQL optimizer into the kernel.  That I
would claim would have to be done in userspace, as part of the
overhead when OpenOffice saves the file.  (Note that some of the
Linux-based office suites store files as gzip'ed XML files, which
again argues that putting it in the kernel is insane --- why should we
compress the file, only to have the kernel uncompress it and then
re-parse the XML just so they can index it?  Much better to have
OpenOffice do the indexing while it has the uncompressed, parsed out
text tree in memory.  And if the indexes need to be updated in
userspace, then life is much, much, much simpler if the lookups are
also done in userspace --- especially when complex SQL query
optimizations may be required.)

> How about you send him a patch that removes all of that networking stuff 
> from the kernel and puts it into user space where it belongs.;-)  There 
> was this Windows user on Slashdot some time ago who claimed that it 
> wasn't just the browser that should be unbundled from the kernel, the 
> whole networking stack was unfairly bundled and locked out the companies 
> that used to provide DOS with networking stacks (the user didn't have in 
> mind patching the windows kernel and recompiling, he really thought it 
> should all be in user space).  Your kind of fellow.....

Networking has definite performance requirements on a per-packet basis
which requires that it be in the kernel.  Given that indexing happens
rarely (i.e., only when a file is saved), the same arguments simply
don't apply.  If you consider how often a user is going to ask the
question, "Give me a list of all photographs taken between June 10,
1993 and July 24, 1996 which contains Mary Schmidt as a subject and
whose resolution is at least 150 dpi", it definitely demonstrates why
this doesn't need to be in the kernel.

If you consider the amount of data that needs to be shovelled back and
forth between the kernel's network device driver to a userspace
networking stack and then back down into the kernel to the socket
layer when processing a TCP connection over a 10 gigabyte Ethernet
link, it's clear why it has to be in the kernel.  When you consider
how much data needs to be referenced when doing indexing, and in fact
that it may exist in uncompressed form only in the userspace
application, you'll see why it indeed it's better to do it in userspace.

The bottom line is that if a case can be made that some portion of the
functionality required by WinFS needs to be in the kernel, and in the
filesystem layer specifically, I'm all in favor of it.  But it has to
be justified.  To date, I haven't seen a justification for why the
database processing aspect of things needs to be in the kernel.

						- Ted
