Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261311AbSIZOBM>; Thu, 26 Sep 2002 10:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSIZOBM>; Thu, 26 Sep 2002 10:01:12 -0400
Received: from thunk.org ([140.239.227.29]:17312 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261311AbSIZOBK>;
	Thu, 26 Sep 2002 10:01:10 -0400
Date: Thu, 26 Sep 2002 10:05:26 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020926140526.GB9400@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209252223.13758.ryan@completely.kicks-ass.org> <20020926055755.GA5612@think.thunk.org> <200209252322.44389.ryan@completely.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209252322.44389.ryan@completely.kicks-ass.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 11:22:41PM -0700, Ryan Cumming wrote:
> > > 8) I rebooted, and fsck said:
> > > "Directory inode 131073,block3,offset 528: Directory corrupted"
> > > I wasn't so lucky this time, and a good portion of my home directory got
> > > eaten.
> >
> > Against, what was the pathnmae to the inode #131073?
> /home/ryan (ugh)

One more thought.  The files in your directory weren't gone; they were
just moved to the lost+found directory, and you just lost their
name->inode numbers mapping.  This is recoverable, however, if you had
saved that information first.  

If you must test on filesystems with precious data (as opposed to
using scratch disks or loopback mounts), something which is really
useful to do in advance is to run the command:

	e2image -r /dev/hdXX /var/e2image/XXX.e2img

This will create a dump of all of the critical filesystem metadata,
including the directory blocks.  I sometimes ask people to send me
compressed e2image dump files when I need to debug a filesystem, since
it allows me to see all of the metadata, which is what I care about,
without getting need to send all of the data in the filesystem, which
(a) might be a privacy problem, and (b) makes the image file
significantly bigger to send over the network.

It's also useful for recovery purposes.  For example, you can run
debugfs on the e2image file, and use the ls command to see the
original directory, which would have allowed you to relatively easily
reconstruct the filenames of the files left in the lost+found
directory.

Actually, the easiest way to do it would be to write a quick perl or
python script to gether up all of the inode numbers of the files in
lost+found, and pass it to the debugfs's "ncheck" command, which will
map inode numbers to pathnames.  You can specify all of the inodes
ncheck at once:

	debugfs -R "ncheck ino1 ino2 ino3 ..." /var/e2image/XXX.e2img

Then just parse the output, and move the files from lost+found back to
their original location in your home directory.

In fact, what e2image can be so helpful that a wise distribution might
want to consider automatically running it at boot time, to save
critical filesystem metadata.  This could be used to reconstruct
filesystems and recover critical data in the case of various sorts of
hardware failure and/or kernel bugs.

							- Ted
