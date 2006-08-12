Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWHLVrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWHLVrc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422709AbWHLVrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:47:31 -0400
Received: from thunk.org ([69.25.196.29]:3012 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1422707AbWHLVrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:47:31 -0400
Date: Sat, 12 Aug 2006 17:47:20 -0400
From: Theodore Tso <tytso@mit.edu>
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: linux-kernel@vger.kernel.org, Duane Griffin <duaneg@dghda.com>
Subject: Re: ext3 corruption
Message-ID: <20060812214719.GA19156@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Molle Bestefich <molle.bestefich@gmail.com>,
	linux-kernel@vger.kernel.org, Duane Griffin <duaneg@dghda.com>
References: <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com> <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com> <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com> <62b0912f0608091347u8b86d40q3679991e9e16526f@mail.gmail.com> <e9e943910608091527t3b88da7eo837f6adc1e1e6f98@mail.gmail.com> <62b0912f0608091609q6b3c6c4ev2d287060fa209@mail.gmail.com> <e9e943910608091708p4914930ct1ee031a1201bfd2f@mail.gmail.com> <62b0912f0608101400t607cf9b7t5c2324f39cc2eed@mail.gmail.com> <20060812163834.GA11497@thunk.org> <62b0912f0608121024y1dde66aavcbf4df04631772c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b0912f0608121024y1dde66aavcbf4df04631772c4@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 07:24:06PM +0200, Molle Bestefich wrote:
> 
> Good to have backups.  It would be very useful to know whether e2fsck
> contemplates writing those back as primary BGDs when it's done, but I
> couldn't find that in the documentation.  Will it?

Yes, it will.

> (Would be good to have the above information in the docs.  Perhaps in
> a "what does this message mean?" section.)

Well, if someone would like to volunteer to be a technical writer,
that would be great......

> (Such a section would also help a lot when confronted with the first
> message: "Entry blah is a link to directory bluh. Clear? y/n".
> Obviously I don't want to "clear" my data.  But why is e2fsck
> confronting me with that question?  Is something wrong with it that it
> should be cleared?)

Basically, there are two modes that e2fsck can run in.  What the boot
scripts use is called "preen" mode, which will automatically fix
"safe" things, and stop if there are anything where the user
administrator might need to need to exercise discretion, or where the
system administrator should know that there might be something that he
or she needs to clean up (like orphaned inodes getting linked into the
lost+found directory, for example).

In the normal mode, e2fsck asks permission before it does anything.
In general, the default answer is "safe", but there are times when a=
filesystem expert can do better by declining to fix a problem and then
using debugfs afterwards to try to recover data before running e2fsck
a second time to completely clear out all of the problems.

If you don't like that, you can always run with e2fsck -y, which wil
clause e2fsck to never ask permission before going ahead and trying
its best to fix the problem.

> >The summary information in the backup block group
> >descriptors is not backed up, for speed/performance reasons.  This is
> >not a problem, since that information can always be regenerated
> >trivially from the pass 5 information.
> 
> Thanks for the information!
> (Would be very helpful to have a copy/paste of the above in the docs too...)

Well, the e2fsck man page isn't intended to be a tutorial.  If someone
wants to volunteer to write an extended introduction to how e2fsck
works and what all of the messages mean, I'd certainly be willing to
work with that person...  So if you're willing to volunteer or willing
to chip in to pay for a technical writer, let me know....

> I'm wondering why it even tries to use the corrupt information, instead of 
> just:
> * reconstructing it from scratch
> * not asking the user?

It did reconstruct it from scratch; that's what pass 5 is all about.
It just didn't store it in the block group descriptors, because of the
-n option.  

> >I can imagine accepting a patch which sets a flag if any discrepancies
> >found in pass 5 are not fixed, and then if the summary information is
> >requested,
> 
> Huh?  The user didn't request anything, it always prints.

The summary information is only printed when the -v option is given,
and that's about all the -v option does.  The summary information is
not the primary raison d'etre for e2fsck, so I'm not going to waste a
lot of time trying to keep two copies of the information so that the
information can be correct in the -nv case.  That's just soooooo
unimportant, and most users don't use the -v option anyway.

> >with the filesystem.  Is it 100% accurate?  No, but that was never the
> >goal of e2fsck -n.  If you want that, then use a dm-snapshot, and run
> >e2fsck on the snapshot....
> 
> Agreed.  Running a r/w e2fsck on some kind of overlay would be the way
> to implement a more useful (for me anyway) version of -n.
> 
> But I think dm-snapshot is useless in this case because....

Well, I have the following project listed in the TODO file for
e2fsprogs:

   4) Create a new I/O manager (i.e., test_io.c, unix_io.c, et.al.) which
   layers on top of an existing I/O manager which provides copy-on-write
   functionality.  This COW I/O manager takes will take two open I/O
   managers, call them "base" and "changed".  The "base" I/O manager is
   opened read/only, so any changes are written instead to the "changed"
   I/O manager, in a compact, non-sparse format containing the intended
   modification to the "base" filesystem.

   This will allow resize2fs to figure out what changes need to made to
   extend a filesystem, or expand the size of inodes in the inode table,
   and the changes can be pushed the filesystem in one fell swoop.  (If
   the system crashes; the program which runs the "changed" file can be
   re-run, much like a journal replay.  My assumption is that the COW
   file will contain the filesystem UUID in a the COW superblock, and the
   COW file will be stored in some place such as /var/state/e2fsprogs,
   with an init.d file to automate the replay so we can recover cleanly
   from a crash during the resize2fs process.)

           Difficulty: Medium      Priority: Medium

Patches to implement this would be gratefully accepted....

(This is open source, which means if people who have the bad manners
to kvetch that volunteers have done all of this free work for them
haven't done $FOO will be gently reminded that patches to implement
$FOO are always welcome.  :-)

						- Ted
