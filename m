Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267629AbUBTAvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUBTAsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:48:51 -0500
Received: from mail.shareable.org ([81.29.64.88]:30848 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267615AbUBTAqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:46:10 -0500
Date: Fri, 20 Feb 2004 00:46:05 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Tridge <tridge@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
Message-ID: <20040220004605.GD5590@mail.shareable.org>
References: <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org> <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org> <20040219204853.GA4619@mail.shareable.org> <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org> <20040220000054.GA5590@mail.shareable.org> <Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> I can't imagine that a file manager is all that interested in seeing
> the changes it itself does be reported back to it.

No, but any file manager that's made of libraries where one thread is
showing the window and another thread is doing operations will care -
unless they explicitly communicate.  Right now they might, or they
might not.

> (That said, clearly it's better to just have a new flag, since that way 
> there is no possibility of anything breaking).

Quite.

> And I don't really know of any other uses of dnotify.

High performance web template cache:
   dnotify is used to invalidate cached info about prerequisite files,
   so that quite a lot of files can be used to create a page, the
   output is cached, and validating the cache for each page request
   as actually zero cost (because dnotify is a signal, so validating is
   just checking that you didn't receive the signal).

Accelerated Make:
   dnotify is used to invalidate cached stat() results between runs.
   A daemon runs in the background to retain the information.
   (Communicating with the daemon is only faster than calling stat()
   if the retained information includes precomputed dependencies,
   pre-parsed Makefiles and such.

Java VM accelerator:
   Let the JVM precompile class files to a machine-specific code and
   keep that in a mmaped file between invocations.  When a new JVM
   process is started, it checks that all the class files for a
   particular program haven't changed; a daemon using dnotify can
   speed up this check, or even provide a stronger guarantee, if you
   don't trust stat() mtimes.

Fontconfig accelerator:
   When a program using fontconfig (e.g. any GNOME program and many
   others) starts, it calls stat() on every font file in ~/.fonts.
   This is lovely to use because you just drop font files in there,
   but the stat() calls are slow when you have a very large number.
   A daemon using dnotify can monitor this and allow a program to
   skip those calls.

Maildir accelerator:
   Similar to fontconfig, but on mail directories for validating
   the cached summary information about all mails in a folder.

Shared cache directory:
   A program stores files in a shared cache, e.g. like a web browser.
   dnotify can be used to monitor the cached files, to invalidate
   in-memory data structures parsed from them if other programs are
   modifying the same cached file data structures.

Shared database in a file (like Berkeley DB et al):
   dnotify is used to notice when another process modifies the file.
   You still need to lock and write updates, but you can avoid reading
   and parsing the database file between queries and use calculated
   in-memory data for the queries, if you know the file hasn't been
   changed by another process.

One thing you can't do is real-time updatedb+locate, because of the
need to have an open file descriptor for every directory that's monitored.

-- Jamie
