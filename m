Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTJLHOz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 03:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTJLHOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 03:14:55 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:19729 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263427AbTJLHOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 03:14:52 -0400
Date: Sun, 12 Oct 2003 00:14:48 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS patch for updating ctimes of renamed files
Message-ID: <20031012071447.GJ8724@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause sleeplessness, irritability, loss of appetite, anxiety, depression, or other psychological disorders.  Consult your doctor if these symptoms persist.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 01:05:19AM -0500, Alex Adriaanse wrote:
> Hi,
> 
> I ran into some trouble trying to do incremental backups with GNU tar
> (using --listed-incremental) where renaming a file in between backups would
> cause the file to disappear upon restoration.  When investigating the issue
> I discovered that this doesn't happen on ext2, ext3, and tmpfs filesystems
> but only on ReiserFS filesystems.  I also noticed that for example ext3
> updates the affected file's ctime upon rename whereas ReiserFS doesn't, so
> I'm thinking this causes tar to believe that the file existed before the
> first backup was taking under the new name, and as a result it doesn't back
> it up during the second backup.  So I believe ReiserFS needs to update
> ctimes for renamed files in order for incremental GNU tar backups to work
> reliably.
> 
> I made some changes to the reiserfs_rename function that I *think* should
> fix the problem.  However, I don't know much about ReiserFS's internals, and
> I haven't been able to test them out to see if things work now since I can't
> afford to deal with potential FS corruption with my current Linux box.
> 
> I included a patch below against the 2.4.22 kernel with my changes.  Would
> somebody mind taking a look at this to see if I did things right here (and
> perhaps wouldn't mind testing it out either)?  If it works then I (and I'm
> sure others who've experienced the same problem) would like to see the
> changes applied to the next 2.4.x (and 2.6.x?) release.

Hmm.  I'm conflicted.

rename(2) manpage:
	Any other hard links to the file (as created using
	link(2)) are unaffected.

A change to ctime would affect the other links.

stat(2) manpage:
	The field st_ctime is changed by writing or by
	setting inode information (i.e., owner, group, link
	count, mode, etc.).

I am not aware of any field in the inode structure that must
be changed by an atomic rename.  Per documentation the only
reason rename should update st_ctime is if it does a
link+unlink sequence which would alter st_nlink briefly.

On the other hand it does seem to me there ought to be some
record that something about the inode changed.  st_ctime would
be the only appropriate indicator.

rename() SUSv3:
	Some implementations mark for update the st_ctime
	field of renamed files and some do not. Applications
	which make use of the st_ctime field may behave
	differently with respect to renamed files unless
	they are designed to allow for either behavior.

So reiserfs is on this point definitely standards conformant
already.  A change could at best be seen as an enhancement.




-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
