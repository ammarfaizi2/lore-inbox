Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbTCKT0e>; Tue, 11 Mar 2003 14:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbTCKT0e>; Tue, 11 Mar 2003 14:26:34 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:59149 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261553AbTCKT0d>; Tue, 11 Mar 2003 14:26:33 -0500
Date: Tue, 11 Mar 2003 20:39:03 +0100
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Improved inode number allocation for HTree
Message-ID: <20030311193903.GA15327@hh.idb.hist.no>
References: <11490000.1046367063@[10.10.2.4]> <3E6DBE3B.8030007@namesys.com> <3E6DDDD2.3050709@aitel.hist.no> <20030311133705.2157A102100@mx12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311133705.2157A102100@mx12.arcor-online.net>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 02:41:06PM +0100, Daniel Phillips wrote:
> On Tue 11 Mar 03 14:00, Helge Hafting wrote:
> > I'm happy nobody _can_ lock a directory like that.  Think of it - unable
> > to create or delete files while some slow-moving program is traversing
> > the directory?  Ouch.  Plenty of options for DOS attacks too.
> > And how to do "rm *.bak" if rm locks the dir for traversal?
> 
> <wishful thinking>
> Now that you mention it, just locking out create and rename during directory 
> traversal would eliminate the pain.  Delete is easy enough to handle during 
> traversal.  For a B-Tree, coalescing could simply be deferred until the 
> traversal is finished, so reading the directory in physical storage order 
> would be fine.  Way, way cleaner than what we have to do now.
> </wishful thinking>

Ok, so "rm" works.  Then you have things like "mv *.c /usr/src" to worry
about.  Lock for traversal, get stuck unable to work on the files.

A "dream" solution for this might involve something like:
Directory is traversed in some well defined order (defined by the fs)
Removing a file (or moving it out of the directory) leaves
a "empty" directory entry that isn't reclaimed until no more
traversals is in progress in that directory.

New files can be created, and will be created further out than
any traversal in progress so nothing will be missed.

This approach don't lock anything out, but I guess someone evil still
could cause trouble by keeping a traversal going forever, creating one dummy
file and deleting one whenever it makes progress.  The directory would
get big, filled up with placeholders until some ulimit kicks in.

Helge Hafting
