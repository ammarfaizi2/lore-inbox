Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265363AbSJaV50>; Thu, 31 Oct 2002 16:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSJaV50>; Thu, 31 Oct 2002 16:57:26 -0500
Received: from thunk.org ([140.239.227.29]:4231 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265363AbSJaV5Y>;
	Thu, 31 Oct 2002 16:57:24 -0500
Date: Thu, 31 Oct 2002 17:03:36 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Duncan Sands <baldrick@wanadoo.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, adilger@clusterfs.com
Subject: Re: [Ext2-devel] Re: Htree ate my hard drive, was: post-halloween 0.2
Message-ID: <20021031220335.GA9237@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Duncan Sands <baldrick@wanadoo.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, adilger@clusterfs.com
References: <62C20ED5AAC@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62C20ED5AAC@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 01:19:23PM +0200, Petr Vandrovec wrote:
>     
> Nobody answered it at that time, and it happened at least 5 times
> again to me - until I modified initscripts to do unconditional
> reboot if "fsck /" did ANY modifications to filesystem.
> 

In fact, e2fsck should return an exit code which indicates that the
systme should be rebooted if an fsck the root filesystem makes any
changes to the filesystem.  See the man page to fsck(8) for a
definition of fsck's exit codes, but if (exit_status & 2) is non-zero,
the init scripts **should** reboot.  

Unfortunately, not all distributions get this right.  However, your
analysis is right.  If fsck needs to make any modifications to the
root filesystem, which is mounted read-only, it is possible for the
corrupted filesystem elements to still be cached in memory, and then
written back out to disk when the filesystem is remounted read/write.  

This is one reason why I normally recommend that / be a small
filesystem of approximately 128 megs, with separate partitions for
/usr, and either using a separate partition for /var, or using a
symlink from /usr/var to /var.  (And doing something similar for /home
and and /opt, as necessary.)  It minimizes the chances that the root
filesystem will get corrupted, and makes running fsck on the root
filesystem take much less time (obviously, since the root filesystem
becomes quite small.)

						- Ted
