Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290908AbSASEU7>; Fri, 18 Jan 2002 23:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290909AbSASEUt>; Fri, 18 Jan 2002 23:20:49 -0500
Received: from [194.195.64.32] ([194.195.64.32]:53317 "EHLO mail.netsurf.de")
	by vger.kernel.org with ESMTP id <S290908AbSASEUk>;
	Fri, 18 Jan 2002 23:20:40 -0500
Date: Sat, 19 Jan 2002 05:18:57 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: Doug Alcorn <lathi@seapine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020119041857.GA10795@storm.local>
Mail-Followup-To: Doug Alcorn <lathi@seapine.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 04:11:26PM -0500, Doug Alcorn wrote:
> 
> I had a weird situation with my application where the user deleted all
> the database files while the app was still reading and writing to the
> opened file descriptor.  What was weird to me was that the app didn't
> complain.  It just went merrily about it's business as if nothing were
> wrong.  Of course, after the app shut down all it's data was lost.

Others already wrote that this is standard behaviour, but I'm in
lecturing mood right now.

You have to understand that under Unix, the user can not delete files.
Simple as that.  Deleting files happens only at the kernel's discretion
(or in fsck after an unclean reboot).

In Unix style filesystems, files (inodes) and directory entries (links)
are separate things.  Files as in inodes are just an entry in the
filesystem referenced by number.  Directory entries aka file names aka
links are just a name associated with an inode number (try "ls -i"
sometime).

One inode can have multiple links pointing to it, they can be created
with ln (hardlinks, not "ln -s" symlinks).  There is a syscall to deal
with removal of those links, but none that deal with file removal.

If a program does open("xyz") or something, the directory entry "xyz" is
consulted to find the inode, which is then opened.  Now there is a
connection file descriptor <=> inode, the directory entries are totally
out of the loop now.  It doesn't matter whether you move or remove the
links now.

Inodes have a reference count and they are automatically deleted when it
goes to zero.  The reference count is the sum of link count and open
count.  After you remove all links to the opened file it is still
referenced by the open and continues to exist.  Only after the program
having the file open terminates does the ref count go to zero and cause
the file to be really deleted.


Whether that was an intended or accidental feature only someone with
more insight into Unix history can answer.  It's that feature that lets
us do live upgrades of distributions without rebooting (executables and
libraries can be replaced without affecting the currently running
processes), at the very least much easier than it would be without this
behaviour.

It just may not be the most intuitive thing (like file name == file is),
but that is more than made up by its possibilities.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
