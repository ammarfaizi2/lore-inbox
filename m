Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbRCLT3X>; Mon, 12 Mar 2001 14:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRCLT3N>; Mon, 12 Mar 2001 14:29:13 -0500
Received: from [24.92.149.190] ([24.92.149.190]:53409 "EHLO primefactor.com")
	by vger.kernel.org with ESMTP id <S129694AbRCLT2x>;
	Mon, 12 Mar 2001 14:28:53 -0500
Date: Mon, 12 Mar 2001 14:27:02 -0500
From: Mark Shewmaker <mark@primefactor.com>
To: Brian Dushaw <dushaw@munk.apl.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel - and regular sync'ing?
Message-ID: <20010312142702.A28863@primefactor.com>
In-Reply-To: <20010308223319.A25679@flint.arm.linux.org.uk> <Pine.LNX.4.30.0103081439400.18253-100000@munk.apl.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0103081439400.18253-100000@munk.apl.washington.edu>; from dushaw@munk.apl.washington.edu on Thu, Mar 08, 2001 at 02:50:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 02:50:46PM -0800, Brian Dushaw wrote:
> - the problem is fixed by adding the "noatime" option when mounting the
>     root filesystem (I use /etc/fstab to do this)
> - there appears to be no harm in not updating the inode access times with
>     this option.

As an aside, you may want to keep in mind the fact that you've edited
the /etc/fstab in this way, in case random oddities show up in the future.

Short story:

Once after a system upgrade, some of the user accounts developed a problem
in which the message "You have new mail" would be printed on the screen
at every login.  The message would be printed whether or not the user
actually had new mail.  The problem was independent of the login shell
used, but it would only happen for some users.

It turned out that the "problem" was a few lines in the login program
itself.  login was comparing the atime and mtime timestamps of $MAIL.
If mtime>atime, then it figured you had new mail and would print that
message.

That makes sense--if your mailbox had been written to (modified) since
it was last read (accessed), then that's as as good a definition as any
of having new mail.  But, I had put "noatime" in /etc/fstab during the
upgrade for the line for the filesystem that /var/spool/mail was in,
and no one's mail spool had had its atime updated since the upgrade, hence
"You have new mail" messages were printed during some users' logins.

(It turned out that the folks who were not getting the message at all
were sorting all their mail into separate folders, leaving $MAIL
empty all the time.)

We decided that the slight performance advantages of the noatime option
weren't worth it and quickly removed the option.  (-o remount is great!)

It's probably very much worth it for you to keep your /etc/fstab as you've
edited it, but I did want to warn you that the noatime option can
still unexpectedly break programs that make quite reasonable assumptions.

 -Mark Shewmaker
  mark@primefactor.com
