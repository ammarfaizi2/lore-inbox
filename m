Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTKFNer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 08:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTKFNer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:34:47 -0500
Received: from thunk.org ([140.239.227.29]:60570 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263587AbTKFNeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:34:44 -0500
Date: Thu, 6 Nov 2003 08:34:42 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Robert Gyazig <juliarobertz_fan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: undo an mke2fs !!
Message-ID: <20031106133442.GB23624@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Robert Gyazig <juliarobertz_fan@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20031106055601.75420.qmail@web21505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106055601.75420.qmail@web21505.mail.yahoo.com>
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

On Wed, Nov 05, 2003 at 09:56:01PM -0800, Robert Gyazig wrote:
> Hi Ted and others,
> 
> I created a new partition on my disk, and without
> noticing the change in the hdaX of the partition i did
> an  mke2fs /dev/hdaX. :(
> 
> Unfortunately it was my /home partition and was an
> ext3 partition earlier. Can anyone please advice on
> how to retrieve the old data.
> 
> I read that mke2fs nukes all the meta information, so
> does that mean all inodes are destroyed and there is
> no hope for me ?!?!?

Unfortunately, you're correct.  The location of which blocks were
associated with which inodes are irretrievably lost.

If you had backed up the metadata using an e2image command, you would
have been fine, but that command takes a while to run, so most people
don't bother to do this.  (Not a bad idea for the absolute paranoids
in the house would be to run e2image out of a cron script and save the
image file on some *other* filesystem.)

I've thought about making mke2fs run e2image and saving the result
somewhere else, but that takes a long time, and people would get
annoyed if I did that.  Still, enough people have gotten screwed by
this that I've been tempted to add this as an option.  Another
possibility is for mke2fs to notice when the filesystem is already
formatted using ext2/3, and then printing a warning message and
waiting 10 seconds before continueing, so the user has a chance to
type control-C.  This would probably be the least annoying as far as
already existing scripts that use mke2fs, although of course there
would be an option to turn this behaviour off.

> i did a cat /dev/hdaX > /dev/hdaY, which was an empty
> partition earlier so that I can play around a bit. I
> tried couple of things with debugfs but coudn't go
> much far.

You can use a disk editor to find the text strings of critical files
that you wish to rescue, and hope they were contiguously allocated,
but that's probably the best you can do....

Sorry, but that's the current Unix design philosophy, which is to
assume that the system administrator knows what he/she is doing.  I
never, ever type the mke2fs command without a certain amount of fear
and trepidition, and always check and triple check before doing so.
Still, as Linux becomes more mainstream, we do need to think about
adding safety checks so that to avoid accidents by less careful system
administrators.  The challenge is to figure out ways of doing so in
the least obstrusive way as possible, to avoid annoying the existing
population.

						- Ted

P.S.  The other approach, which might also be the right one, is to use
a front-end program --- call it newfs --- which does many more safety
checks and which could do things like use e2image to backup the inode
blocks before doing an mke2fs.  That way, administrators can choose
whether they want the additional safety checks or not.


