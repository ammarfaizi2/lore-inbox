Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbTCKSLE>; Tue, 11 Mar 2003 13:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbTCKSLE>; Tue, 11 Mar 2003 13:11:04 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:46077 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S261529AbTCKSLD>; Tue, 11 Mar 2003 13:11:03 -0500
Date: Tue, 11 Mar 2003 10:16:25 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improved inode number allocation for HTree
Message-ID: <20030311101625.Q12806@schatzie.adilger.int>
Mail-Followup-To: Daniel Phillips <phillips@arcor.de>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Hans Reiser <reiser@namesys.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <11490000.1046367063@[10.10.2.4]> <3E6DBE3B.8030007@namesys.com> <3E6DDDD2.3050709@aitel.hist.no> <20030311133705.2157A102100@mx12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030311133705.2157A102100@mx12.arcor-online.net>; from phillips@arcor.de on Tue, Mar 11, 2003 at 02:41:06PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 11, 2003  14:41 +0100, Daniel Phillips wrote:
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

The other problem, of course, is that this would essentially mean that a
user-space application has a lock that prevents other processes (even the
kernel) from doing anything.  At best we have to worry about an application
going sour, and at worst it is a DOS hole as Helge says.

How about something like:

	death:
		for each directory
			while readdir(directory, large_buffer)
				if (directory)
					run death(directory)
			readdir(directory, small_buffer)

		sleep forever

The first getdents walks recursively down to the leaves, and then does a
single getdents with enough space to hold a single dirent, locking the
directory, but then never progressing.  It also does the single-dirent
getdents on the way up the tree.  Now, everything is locked out of the
entire directory tree.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

