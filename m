Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUH1PXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUH1PXU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUH1PUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:20:54 -0400
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:55395 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S267176AbUH1PUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:20:04 -0400
In-Reply-To: <412F7B6D.6010305@pobox.com>
To: Will Dyson <will_dyson@pobox.com>
Subject: Separating Indexing and Searching (was silent semantic changes with
 reiser4)
Cc: akpm@osdl.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com, reiser@namesys.com
X-Mailer: BeMail - Mail Daemon Replacement 2.3.1 Final
From: "Alexander G. M. Smith" <agmsmith@rogers.com>
Date: Sat, 28 Aug 2004 11:18:08 -0400 EDT
Message-Id: <584702172685-BeMail@cr593174-a>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Dyson wrote on Fri, 27 Aug 2004 14:20:29 -0400:
> Hans Reiser wrote:
> > Will Dyson wrote:
> >> In the original BeOS, they solved the problem by having the filesystem 
> >> driver itself take a text query string and parse it, returning a list 
> >> of inodes that match. The whole business of parsing a query string in 
> >> the kernel (let alone in the filesystem driver) has always seemed ugly 
> >> to me. 
> > 
> > Why?
> 
> Hmm. Trying to explain aesthetic judgments is always fun, but I'll try.
> 
> String parsing bloats the kernel with code that will be called rarely, 
> and doing it inside the filesystem module makes for duplicate code if 
> more than one filesystem does it. But a good common parser routine (or a 
> kernel api that takes a pre-compiled parse tree) would reduce the bad taste.

Not only bloat, but time wasted reinventing the wheel.  For my experimental file system (http://members.rogers.com/agmsbeos/AGMSRAMFileSystem.readme - see the Nifty Features chapter), I had to figure out the BFS query language (it was documented but didn't have every little detail explained - some experimentation was needed), then write a tokenizer and parser for it, to convert it down to a parse tree that could be used during the query's life.  Good exercise for the programmer, but duplication of effort.

I also added a few new things to the query language, but because the parsing is done by each file system separately, my "improvements" won't show up in other file systems.

> For the 99.9% of people who were not beos users back in the day, the 
> "live query" was a way to register a query string with the kernel, so 
> that you got notifications when the list of files matching the query 
> changed. It was pretty cool, but this is really just blue-skying since I 
> am not stepping up to write such a beast any time soon.

Kind of like that.  For performance, the query string is converted into a parse tree and then all file operations that touch any attribute mentioned in the query get evaluated against the parse tree to see if the result (in or out of the query result set) has changed.  If it changes, then a kernel facility is used to broadcast a message describing the change and file involved to all parties monitoring that query.  Of course, before becoming live, the existing files that match the query are found by iterating over an index (choosing the appropriate index is an optimization trick).

> >> However, the best alternative I've come up with is to simply export 
> >> the index data as a special file (perhaps in sysfs?) and have 
> >> userspace responsible for searching the index.
> > 
> > That is the best implementation suggestion I've heard for splitting the 
> > filesystem into two parts, one in user space and one in kernel, but I 
> > still don't trust it to work well.
> 
> Why not? And if it really splits the filesystem into two parts depends 
> on which of the two following statements you agree with more:
> 
> "Fast searching is a feature of the filesystem"
> "Maintaining indexes is a feature of the filesystem"

I like that.  Put the indexing and a related attribute change update notification mechanism into the kernel.  User land libraries can build on that to implement whatever query language you want, thus saving work and having a common language for all file system varieties that support indices.

However, one of my (unfinished) experiments was to have magic directories that show query results as their contents.  One attribute of the directory (or even its name) would be the query string.  That way even old software (like "ls") could use queries!  Implementing queries-as-directories might require moving some things back into the kernel, or at least into some plug-in level.

- Alex
