Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbTDKL1a (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 07:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTDKL1a (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 07:27:30 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:38919 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264333AbTDKL12 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 07:27:28 -0400
Message-ID: <3E96A9B5.3050807@aitel.hist.no>
Date: Fri, 11 Apr 2003 13:40:37 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-english user messages
References: <200304102036.h3AKa837025670@81-2-122-30.bradfords.org.uk>            <1050013215.23204.8.camel@zaphod> <200304110419.h3B4JeBm004315@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> 1) What happens when *multiple* programs have a file open at the same time?
> If you only handle one level of versioning, somebody is going to lose.  Handling
Sure -which is why this isn't so useful.

> multiple levels is of course more "fun".  And you get to worry about race
> conditions - does your code DTRT if multiple processes do an open() on alternate
> CPUs at the same time.  Does it DTRT if a process open()s a file, and then fork()s,
> and both parent and child start scribbling on the file descriptor?
> 
> 2) For that matter, should new versions be created at open() or at the first write()?
> Doing it at write() allows not creating a new version if no changes have
> actually happened - but this has its own issues.  
> 
Simple solution - duplicate at open() but remove on close() if unchanged.

> 3) Version a 500 megabyte file.  Change one block.  Do it a few more times.
> Are you better off copying the whole file (which bloats your disk usage and
> kills your I/O bandwidth), or keeping deltas (the list of allocated blocks could be
> almost identical except for the replaced/rewritten blocks).  However, this DOES
> make doing an fsck() a *lot* more interesting - is a block allocated to multiple
> files in error or not?
> 
If you want this, you want a copy-on-write fs.  Of course it needs a
different fsck.

> 4) What happens if you rename() a file?  
It is renamed - nothing special there.  Renaming onto an existing file
makes the renamed file the most recent version of that file.
"mv foo;2 foo" turns foo;2 into the current version - this is one
way of restoring an old version without deleting the newer ones.

> Can you open() a previous version for
> writing?  If so, does it get versioned?  How does a backup program restore a
> previous version?

VMS let you open() any previous version for writing. I don't remember 
exactly,
but I believe this creates a new version with a version number higher 
than the
highest existing version of the file.  Either that, or you modify the 
old file.

Backup is not a problem.  You don't want to create new versions while 
restoring,
so either remove existing files before recreating from backup (You
can then explicitly create "file.txt;45") or implement some open flag
that means "use exactly this filename - no messing with versioning" I 
think the
first approach is better  it keeps the interface smaller.

> 5) Let's say we use VMS-style filenames to version.  foo, foo;2, foo;3, etc.
> Now, is open("foo;2",...) a reference to the previous version of foo or to a new
> file that happens to be called foo;2?  What happens if some other file happens
> to be called foo;2 and you create a version  of foo?
> 
I remember trying this. If foo;3 exists (but not foo;2 and lower) then
the numbering of new versions go upwards and simply skips the existing ones.

> 6) OK, since anything besides \0 and / is legal in a filename, we can't use ;N to
> version.  
We can if we want to - by redefining whats legal.  This isn't a problem 
at all
if we take the approach that opening "foo" does the versioning automatically
while explicitly opening "foo;x" opens that particular version.  Users 
creating
a "fake" version of a file isn't a problem - they simply created a new 
version
that happened to not be based on the contents of the previous one.

Helge Hafting

